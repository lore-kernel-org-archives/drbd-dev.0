Return-Path: <Lars.Ellenberg@linbit.com>
Received: from soda (office.linbit [213.229.1.138])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 900BE2D99B6B
	for <drbd-dev@lists.linbit.com>; Tue, 15 Aug 2006 23:29:44 +0200 (CEST)
Date: Tue, 15 Aug 2006 23:29:45 +0200
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] DRBD-8 - crash due to NULL page* in drbd_send_page
Message-ID: <20060815212945.GC7565@soda.linbit>
References: <342BAC0A5467384983B586A6B0B3767103625314@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <342BAC0A5467384983B586A6B0B3767103625314@EXNA.corp.stratus.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

/ 2006-08-15 16:30:31 -0400
\ Graham, Simon:
> Well, FWIW, I think my theory is correct -- I added an assert to
> got_BlockAck that the ON_WIRE flag is set and it hit:
> 
> drbd1: data >>> Data (sector 12470, size ffffffe8, id e822dbe0, seq
> 10ea, f 0)
> drbd1: meta <<< WriteAck (sector 12470, size 1000, id e822dbe0, seq
> 10ea)
> drbd1: ASSERT( req->rq_status & RQ_DRBD_ON_WIRE ) in
> /sandbox/sgraham/sn/trunk/platform/drbd/8.0/drbd/drbd_receiver.c:2785
> drbd1: in got_BlockAck:2799: ap_pending_cnt = -1 < 0 !
> drbd1: Sector 12470, id e822dbe0, seq 10ea
> 
> For example -- no crash in this case, but that's just dumb luck I think;

Yes we seemingly have race there. I already stumbled upon it myself but
got distracted by other problems.  We had a similar race there long ago,
and fixed it.  But probably it got reintroduced when we switched to
"send from worker context", where we also introduce this dubious
"on wire" flag.

But I don't really think that is the problem for that NULL pointer.
There is something else going on here, see below.
Just for debugging: could you try switching that zero copy off,
and use the copy-on-send?

or define our DRBD_MAX_SEGMENT_SIZE to be 4k instead of 32k,
to see if that makes a difference.
 (either HT_SHIFT 3, or assign PAGE_SIZE to q->max_segment_size and
other where appropriate. looking at that code, I think we might
have some corner case bugs stacking q parameters, still; brrgs)

> I know you guys are busy, but do you have any suggestions for the right
> way to have got_BlockAck wait for the send thread to complete?

in fact, we have had a public holiday today here...

but I don't get it.
the WriteAck is sent by the peer after it successfully received the
data, read it into some pages attached to some bio, submitted this bio,
and got a completion event from disk...
this WriteAck simply _cannot_ be received before the data is
successfully transmitted, so the _drbd_send_zc_bio has long finished.

so if you see NULL pages there, we have an invalid bio.

how is your test setup this time?

in my test setup, during "normal operation", i.e. no resync running,
network link stable etc., just application requests, I can write
gigabytes in a loop for hours and not trigger anything unusual.
this is on dual opteron preemtible smp with not-too-slow disk and
gigabit ethernet.

the problems I see are broken cleanup during connection loss,
some lately (re)introduced (probably harmless but annoying) races
during resync with concurrent application writes, and unpleasant
suprises when we try to handle disk failures.

-- 
: Lars Ellenberg                                  Tel +43-1-8178292-55 :
: LINBIT Information Technologies GmbH            Fax +43-1-8178292-82 :
: Schoenbrunner Str. 244, A-1120 Vienna/Europe   http://www.linbit.com :
