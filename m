Return-Path: <lars.ellenberg@linbit.com>
Received: from johann.somewhere (chello080108047253.34.11.vie.surfer.at
	[80.108.47.253])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 1F1B22E08BE3
	for <drbd-dev@lists.linbit.com>; Sun, 13 Jan 2008 04:15:00 +0100 (CET)
Date: Sun, 13 Jan 2008 04:14:59 +0100
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Crash in lru_cache.c
Message-ID: <20080113031459.GA30312@debian-etc-mailname>
References: <342BAC0A5467384983B586A6B0B3767107C5B0B7@EXNA.corp.stratus.com>
	<342BAC0A5467384983B586A6B0B3767107C5B0C0@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <342BAC0A5467384983B586A6B0B3767107C5B0C0@EXNA.corp.stratus.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Sat, Jan 12, 2008 at 06:37:47PM -0500, Graham, Simon wrote:
> > sure I can have requests there, but they are not yet completed to
> upper
> > layers.  if they are, their correponding barrier will have been send
> > out
> > already.
> > 
> > for attach, we would then do
> >   block new incomming request
> >   wait for ap count to reach zero
> >   [in current code, send out a barrier now;
> >    with the idea outline above, there is no need for that]
> >   wait for the lates barrier ack
> >       (tl now empty)
> >   attach
> >   unblock
> > 
> > am I still missing something?
> 
> I think that works. 
> 
> What's the appropriate mechanism for blocking new requests? There are
> existing mechanisms based on locking the AL cache entry, but since there
> is no AL at this time, we cant use that...

there is an other one, examining the drbd state,
right as the first statement in

	drbd_make_request_common
	  inc_ap_bio
	    __inc_ap_bio_cond

 :-)

I have to think about whether we need yet an other itermediate state.
probably blocking anything for Diskless < state < Inconsistent
would be enough.

-- 
: Lars Ellenberg                            Tel +43-1-8178292-55 :
: LINBIT Information Technologies GmbH      Fax +43-1-8178292-82 :
: Vivenotgasse 48, A-1120 Vienna/Europe    http://www.linbit.com :
