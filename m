Return-Path: <lars.ellenberg@linbit.com>
Received: from racke.linbit (chello080108047253.34.11.vie.surfer.at
	[80.108.47.253])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id B4A0F2E0BDBC
	for <drbd-dev@lists.linbit.com>; Sun, 25 Nov 2007 22:36:49 +0100 (CET)
Date: Sun, 25 Nov 2007 22:36:46 +0100
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Possible synchronization problems in 8.0.6
Message-ID: <20071125213646.GA12868@racke.local>
References: <342BAC0A5467384983B586A6B0B37671072830AA@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <342BAC0A5467384983B586A6B0B37671072830AA@EXNA.corp.stratus.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Sun, Nov 25, 2007 at 04:03:29PM -0500, Graham, Simon wrote:
> We've been seeing some odd problems lately with the syncer not being
> resumed and netlink state change events being delivered out of order and
> I think I've tracked this down to the following synchronization issues:
> 
> 1. When suspending/resuming sync for other devices, the code currently
> does NOT acquire the lock 
>    for the target device whose aftr_isp is being modified - instead, the
> code acquires the 
>    'drbd_global_lock' which is just the DRBD0 lock plus disabling
> interrupts

this is not true.

STATIC void drbd_global_lock(void)
{
	drbd_dev *mdev;
	int i;

	local_irq_disable();
	for (i=0; i < minor_count; i++) {
		if(!(mdev = minor_to_mdev(i))) continue;
		spin_lock(&mdev->req_lock);
	}
}

this disables irq,
then aquires _all_ reqest locks of all (allocated) devices _in order_.

ugly assignment inside the if condition.
should be cleaned up.

> - this is fine on a 
>    UP system but not on SMP where another processor might be executing
>    _drbd_set_state() for the target device at the same time. I think
>    this can cause two problems:
>    a. First, when setting/clearing bit fields in mdev->flags, you might
>       corrupt the value if both processor access flags at the same time
>    b. Second, the order that after_state_ch worker items are put on the
>       queue can be inverted resulting in out of order netlink events

> 2. The way the resync timer is handled when pausing and resuming sync
> has a hole I think IF you get pause followed immediately by resume
> (which seems to happen occasionally) as follows:
>    a. The pause code sets the STOP_SYNC_TIMER bit and updates the
>       timer so that the resync_timer_fn should run immediately
>    b. The resume code updates the timer so that the function runs
>       immediately UNLESS the STOP_SYNC_TIMER bit is set
>    c. When the resync_timer_fn runs, it clears the flag if set and
>       terminates.
> 
>    So if we pause and immediately resume, it's possible that the flag
>    is still set and we end up never scheduling the timer to run again,
>    leading to stalled resync - this was a recent change added by Phil
>    I think - previously it would just clear the bit and call mod_timer
>    in the resume case.

hm. so this needs to be revised.

> I think the key thing about problem 1 above is that there is an
> unwritten rule that when calling _drbd_set_state() you MUST first
> qcquire the mdev lock for the device being modified. I've looked at this
> a little and would propose:
> 
> 1. Do away with drbd_global_lock
> 2. Change _drbd_pause_after and _dbd_resume_next to acquire the target
> device lock before checking may_sync_now and calling _drbd_set_state.
> 3. Change drbd_start_sync to acquire the tartget devices lock before
> calling _drbd_set_state and releasing it before checking that the sync
> will go ahead.

hm...  still thinking.

> Lastly, I'd like to propose doing the netlink broadcast inside
> _drbd_set_state instead of delaying it to the after_state_ch processing
> - this will ensure that netlink events wont get reordered. I originally
> thought that simply ensuring we always call _drbd_set_state with the
> device lock held would be enough, but that doesn't handle the cases
> where we do the after_state_change inline instead of from the worker
> thread.

I don't think we can do netlink broadcasts
from what is potentially irq context.

phil has some thoughts about this already,
aparently we need to always queue the after_state_change to the worker.

-- 
: Lars Ellenberg                            Tel +43-1-8178292-55 :
: LINBIT Information Technologies GmbH      Fax +43-1-8178292-82 :
: Vivenotgasse 48, A-1120 Vienna/Europe    http://www.linbit.com :
