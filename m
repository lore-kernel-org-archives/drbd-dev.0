Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Nov 2007 16:03:29 -0500
Message-ID: <342BAC0A5467384983B586A6B0B37671072830AA@EXNA.corp.stratus.com>
From: "Graham, Simon" <Simon.Graham@stratus.com>
To: <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] Possible synchronization problems in 8.0.6
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

We've been seeing some odd problems lately with the syncer not being
resumed and netlink state change events being delivered out of order and
I think I've tracked this down to the following synchronization issues:

1. When suspending/resuming sync for other devices, the code currently
does NOT acquire the lock=20
   for the target device whose aftr_isp is being modified - instead, the
code acquires the=20
   'drbd_global_lock' which is just the DRBD0 lock plus disabling
interrupts - this is fine on a=20
   UP system but not on SMP where another processor might be executing
_drbd_set_state() for the=20
   target device at the same time. I think this can cause two problems:
   a. First, when setting/clearing bit fields in mdev->flags, you might
corrupt the value if both=20
      processor access flags at the same time
   b. Second, the order that after_state_ch worker items are put on the
queue can be inverted=20
      resulting in out of order netlink events

2. The way the resync timer is handled when pausing and resuming sync
has a hole I think IF you=20
   get pause followed immediately by resume (which seems to happen
occasionally) as follows:
   a. The pause code sets the STOP_SYNC_TIMER bit and updates the timer
so that the=20
      resync_timer_fn should run immediately
   b. The resume code updates the timer so that the function runs
immediately UNLESS the=20
      STOP_SYNC_TIMER bit is set
   c. When the resync_timer_fn runs, it clears the flag if set and
terminates.

   So if we pause and immediately resume, it's possible that the flag is
still set and we end up=20
   never scheduling the timer to run again, leading to stalled resync -
this was a recent change=20
   added by Phil I think - previously it would just clear the bit and
call mod_timer in the=20
   resume case.

I think the key thing about problem 1 above is that there is an
unwritten rule that when calling _drbd_set_state() you MUST first
qcquire the mdev lock for the device being modified. I've looked at this
a little and would propose:

1. Do away with drbd_global_lock
2. Change _drbd_pause_after and _dbd_resume_next to acquire the target
device lock before=20
   checking may_sync_now and calling _drbd_set_state.
3. Change drbd_start_sync to acquire the tartget devices lock before
calling _drbd_set_state
   and releasing it before checking that the sync will go ahead.

Lastly, I'd like to propose doing the netlink broadcast inside
_drbd_set_state instead of delaying it to the after_state_ch processing
- this will ensure that netlink events wont get reordered. I originally
thought that simply ensuring we always call _drbd_set_state with the
device lock held would be enough, but that doesn't handle the cases
where we do the after_state_change inline instead of from the worker
thread.

Thoughts/comments?
/simgr
