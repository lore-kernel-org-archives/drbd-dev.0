Return-Path: <lars.ellenberg@linbit.com>
Received: from johann.somewhere (chello080108047253.34.11.vie.surfer.at
	[80.108.47.253])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 1D65E2E10D06
	for <drbd-dev@lists.linbit.com>; Sat, 12 Jan 2008 14:51:37 +0100 (CET)
Date: Sat, 12 Jan 2008 14:51:36 +0100
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Crash in lru_cache.c
Message-ID: <20080112135136.GA23622@debian-etc-mailname>
References: <342BAC0A5467384983B586A6B0B3767107C5AE45@EXNA.corp.stratus.com>
	<342BAC0A5467384983B586A6B0B3767107C5AE95@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <342BAC0A5467384983B586A6B0B3767107C5AE95@EXNA.corp.stratus.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Thu, Jan 10, 2008 at 03:31:02PM -0500, Graham, Simon wrote:
> > > Dec  5 05:57:09 ------------[ cut here ]------------
> > > Dec  5 05:57:09 kernel BUG at
> > > /test_logs/builds/SuperNova/trunk/20071205-
> > r21536/src/platform/drbd/src/
> > > drbd/lru_cache.c:312!
> > 
> > in what exact codebase do you see this?
> > up to which point have you merged upstream drbd-8.0.git?
> > what local patches are applied?
> > 
> 
> Yes - sorry... this is 8.0.4 plus a bunch of the fixes that are in 8.0.8
> (but not all) plus a few more than T haven't submitted yet (but I will
> once I wrestle git into submission); the specific change that exposes
> this that I have pulled is the one to use the TL for Protocol C as well
> as A and B -- however, I think this bug exists IF you are using A or B
> without this fix.
> 
> > that would be in this code path:
> > if (s & RQ_LOCAL_MASK) {
> >         if (inc_local_if_state(mdev,Failed)) {
> >                 drbd_al_complete_io(mdev, req->sector);
> >                 dec_local(mdev);
> >         } else {
> >                 WARN("Should have called drbd_al_complete_io(, %llu), "
> >                      "but my Disk seems to have failed:(\n",
> >                      (unsigned long long) req->sector);
> >         }
> > }
> > 
> 
> Exactly.
> 
> > I don't see why there could possibly be requests in the tl
> > that have (s & RQ_LOCAL_MASK) when there is no disk.
> 
> Because there WAS a disk when the request was issued - in fact, the
> local write to disk completed successfully, but the request is still
> sitting in the TL waiting for the next barrier to complete. Subsequent
> to that but while the request is still in the TL, the local disk is
> detached.

AND it is re-attached so fast,
that we have a new (uhm; well, probably the same?) disk again,
while still the very same request is sitting there
waiting for that very barrier ack?

now, how unlikely is THAT to happen in real life.

but I think I understand your scenario.

but how do you test this, actually?
inject io failures, and trigger a re-attach
as soon as you see the detach event?

is that to implement a "hot-spare" feature?

> > other than that, what about
> > 
> > 3. when attaching a disk,
> >    suspend incoming requests and wait for the tl to become empty.
> >    then attach, and resume.
> > 
> 
> I think this might work but only as a side effect -- if you look back to
> the sequence I documented, you will see that there has to be a write
> request to the same AL area after the disk is reattached - this is
> because drbd_al_complete_io quietly ignores the case where no active AL
> extent is found for the request being completed.

huh?
I simply disallow re-attaching while there are still requests pending
from before the detach.
no more (s & RQ_LOCAL_MASK), no more un-accounted for references.

if I understand correctly,
you can reproduce this easily.
to underline my point,
does it still trigger when you do
 "dd if=/dev/drbdX of=/dev/null bs=1b count=1 iflag=direct ; sleep 5"
before the re-attach?
(the dd, even if it only reads, due to using directio,
 and drbd being diskless,
 will trigger any pending barrier to be sent)

> You would also need to trigger a barrier op in this case to force the
> TL to be flushed.

for other reasons, I think we need to rewrite the barrier code anyways
to send out the barrier as soon as possible, and not wait until the next
io request comes in.

-- 
: Lars Ellenberg                            Tel +43-1-8178292-55 :
: LINBIT Information Technologies GmbH      Fax +43-1-8178292-82 :
: Vivenotgasse 48, A-1120 Vienna/Europe    http://www.linbit.com :
