Return-Path: <lars.ellenberg@linbit.com>
Received: from racke.linbit (chello080108047253.34.11.vie.surfer.at
	[80.108.47.253])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id BBAC72E0BDBC
	for <drbd-dev@lists.linbit.com>; Sun, 25 Nov 2007 22:22:05 +0100 (CET)
Date: Sun, 25 Nov 2007 22:22:02 +0100
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] Supporting barriers in DRBD, part 1
Message-ID: <20071125212202.GA12737@racke.local>
References: <342BAC0A5467384983B586A6B0B37671072830A7@EXNA.corp.stratus.com>
	<342BAC0A5467384983B586A6B0B37671072830A9@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <342BAC0A5467384983B586A6B0B37671072830A9@EXNA.corp.stratus.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Sun, Nov 25, 2007 at 03:30:42PM -0500, Graham, Simon wrote:
> Thanks for the comments Lars,
> 
> To answer questions/comments:
> 
> > since you say "part 1", what will the next part be?
> > defer "_req_is_done" until the corresponding barrier ack,
> > even for protocol C?
> > 
> 
> Well, Part 2 will be integrating the TL into recovery when we lose
> contact with the secondary - not sure I want to add this feature as
> well.

I'll do that part, then.

> > 	or, preferably, we finally allocate local and remote error flag
> > 	members in struct drbd_request, and properly deal with it :)
> > 
> > 	meaning we could (at least for protocol C) notice, distinguish,
> > 	and recover from both local and remote ENOTSUPP, for a barrier
> > 	request.
> 
> I thought about something like this but it gets (more) complicated --
> what we should really do in the case where a barrier request results in
> -EOPNOTSUPP from either side is return -EOPNOTSUPP to the master bio (so
> that we tell the DRBD user that barriers don't work) - I don't think,
> for example, that we should retry the request without the barrier bit on
> behalf of our user.

right.
we should fail with EOPNOTSUPP if one of the nodes fails with EOPNOTSUPP.
which makes it even easier, I think.

for protocol != C, and EOPNOTSUPP on the receiving side:
since we cannot take back a successful completion event,
we have to retry on the receiving side,
report both success (data written) and failure (barrier not supported)
at the same time, so the sending node can fail any new barrier request
early with EOPNOTSUPP.

> As far as protocol goes - I think we need to make sure this failure is
> reported in all protocols which means more protocol changes.

I wanted to have a NegAck with error code for ages :)
this is only possible in 8.2, however.

> > > 4.       Forced a meta data write when a disk is attached so that we
> > > determine early on whether or not barriers are supported.
> > 
> > remains the problem of storage area device != meta data area device.
> > 
> 
> Rats! I always forget that -- I guess that means we really have to
> implement per-I/O checking until we know barriers are not supported on
> one or both sides _and_ save a separate bit for metadata and storage
> area devices in case they are different...

interessingly whether or not barriers are supported could change over
time, since the backing store could change.

e.g. when on top of lvm, and the underlying pvs are not behaving the
same, or when on top of barrier supporting md raid1,
and the newly hot-added disk is different then the failed one it replaces.
there is some fun ahead here.

> > > 5.       Extended the tracing of BIO's to include internally
> > > generated BIOs as well as the ones from above
> > 
> > would you agree if we changed that to no longer use printk,
> > but to netlink-broadcast to userspace,
> > so you'd be able to see them with "drbdsetup events"?
> > 
> > I did that already for some other reasons,
> > so the code is basically there.
> > 
> 
> I think that would be fine.
> 
> > > 3.       I think we can remove the #ifdef BIO_RW_XXX - certainly
> > > they are not present everywhere these macros are referenced...
> > 
> > I'll have to check that. we still try to support even 2.6.5-something.
> 
> So, there are some places where you unconditionally checked
> BIO_RW_BARRIER previously (I either fixed these or used bio_barrier(bio)
> instead, but that shouldn't change whether or not this thing builds on
> older releases.

afaics, BIO_RW_BARRIER is present since 2.6.0,
so, yes, cleanup is due.

BIO_RW_SYNC is present only since 2.6.6,
so we need to keep those ifdefs.

-- 
: Lars Ellenberg                            Tel +43-1-8178292-55 :
: LINBIT Information Technologies GmbH      Fax +43-1-8178292-82 :
: Vivenotgasse 48, A-1120 Vienna/Europe    http://www.linbit.com :
