Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 92F431058E80
	for <drbd-dev@lists.linbit.com>; Wed, 17 Nov 2010 21:27:41 +0100 (CET)
Date: Wed, 17 Nov 2010 21:27:41 +0100
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20101117202741.GE9868@barkeeper1-xen.linbit>
References: <AANLkTikZaR_GPaDO=zjq_DyWD0C5-_6DtBHjgbevGwUL@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AANLkTikZaR_GPaDO=zjq_DyWD0C5-_6DtBHjgbevGwUL@mail.gmail.com>
Subject: Re: [Drbd-dev] Protocol A,B & submit ee failure
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Wed, Nov 17, 2010 at 11:00:03AM -0800, Shriram Rajagopalan wrote:
> [I apologize if this is a double post]

It's not.
drbd-dev just happens to be moderated somewhat ;-)

> Hi all,
> I have recently started hacking into drbd kernel code

Just curious: Why?
What are you up to?

> and I am bit of a newbie to the concept of "bio"s.
> 
> my question: (all concerning IO at secondary, for Protocol A/B)
>  In drbd_receiver.c, esp in function receive_Data(..),
> the backup disconnects from primary when drbd_submit_ee(..) call fails.
> The comments indicate
>         /* drbd_submit_ee currently fails for one reason only:
>          * not being able to allocate enough bios.
>          * Is dropping the connection going to help? */
> 
> So, the code just finishes the activity log io, releases the ee and returns
> false,
> which causes the main loop to disconnect from primary.
> 
> Why was this choice made?

It grew that way.

It does not happen, I am not aware of that code path having ever been
taken. If it should be taken some day, we'll likely fix it so it won't
happen again.

But as long as drbd_submit_ee can fail (in theory) there needs to be an
error handling branch (that is at least "correct").

Disconnecting/reconnecting was the easiest possible error path here.

But see my comment about biosets below.

> Please correct me if I am wrong:
> Isnt failure to allocate a bio a temporary issue? I mean the kernel ran out
> of bio's to allocate out of its slabs (or short of memory currently)
> and thus retrying again after a while might work.
> 
> I understand that for protocol C, one cannot buffer the IO on
> secondary. But for Protocol A/B, they can certainly be buffered and
> retried. Isnt that better than just disconnecting from primary and
> causing reconnects?
> ==========


> On the same note,
> function "w_e_reissue" callback is used to resubmit a failed IO , if the IO
> had REQ_HARDBARRIER flag.

Which is obsolete, btw, and will go away.  Recent kernels have REQ_FUA |
REQ_FLUSH, which will not fail but for real IO error.

> Looking at this function, it tries to reissue the IO and
>  (a) when drbd_submit_ee fails,
>     it installs itself as the callback handler and re queues the work. This
> contradicts with the receive_Data(..)

So what.
It does not happen anyways, it just needed to be "correct".
And, in this case we know that there just now had been enough bios for
this ee, we just gave them back to the system, it is highly likely that
we get enough bios back again.

> error handling, where drbd_submit_ee call failure leads to connection
> termination.
> 
>    Also, this could cause potential looping (probably infinite) when the
> submit_ee call keeps failing due to ENOMEM.

Did not you yourself suggest retrying, stating that not being able to
allocate bios was only a temporary problem? ;-)

>    shouldnt there be some sort of "num_attempts" counter that limits number
> of IO retries?

No.

There should probably be a dedicated drbd bioset where we allocate bios from.
It has not been an issue, so we did not implement it yet.
If you want to do that, it was quite easy,
would change drbd internal bio_alloc to bio_alloc_bioset from that drbd
bioset, could make drbd_submit_ee void (won't fail), etc.
Send patch to this list, or PM, whatever you prefer.

> the comments in this function
> "@cancel  The connection will be closed anyways (unused in this callback)"
> I cannot find a control path that causes a connection close, before reaching
> this function.

Those are asynchronous, and may happen any time, whenever drbd detects
that we have a problem with our replication link.
The worker then calls all callbacks with this "cancel" flag set, so they
know early on that there is no point in trying to send anything over (in
case they wanted to).

> On the other hand,
>  drbd_endio_sec --> drbd_endio_sec_final

which both are void...

>    where this ee is simply requeued, with its callback changed to
> w_e_reissue which always returns 1.

Yes. We don't want the worker to die.

Again, this "grew that way".
I think in the long run, the cancel parameter to our work callbacks
may be dropped, and they may become void. But that's not particularly
urgent.

>    (unlike e_end_block which returns 0 causing the worker thread to force
> connection to go down)

No, that causes the _asender_ thread (not the worker) to _notice_
that the connection was lost (it has not been able to send an ACK).
But this again is probably not necessary anymore as we already called
into the state handling from where the send actually failed,
and possibly could become void.

hth,

-- 
: Lars Ellenberg
: LINBIT | Your Way to High Availability
: DRBD/HA support and consulting http://www.linbit.com

DRBD® and LINBIT® are registered trademarks of LINBIT, Austria.
