Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] DRBD8: incorrect state transition Connected
	->WFBitMapS and UpToDate->Inconsistent
Date: Mon, 26 Nov 2007 15:31:53 +0100
References: <793061.80135.qm@web30507.mail.mud.yahoo.com>
In-Reply-To: <793061.80135.qm@web30507.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_ZjtSHsBoW9PrI4E"
Message-Id: <200711261531.53793.philipp.reisner@linbit.com>
Cc: "Montrose, Ernest" <Ernest.Montrose@stratus.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

--Boundary-00=_ZjtSHsBoW9PrI4E
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Friday 16 November 2007 03:36:19 Ernest Montrose wrote:
> Phil,
> I tested the patch and unfortunately it does not fix the race condition
> though I believe it fixes the ASSERT issues.
> Essentially, when the resync is done and we are in drbd_resync_finished()
> if we pause the device then we send the state to the peer.  The peer is
> done syncing at that point.  He does a sync_hanshake() that sends its state
> to WBItMapS and Pdsk=Inconsistent (since the target has not changed its
> state to connected and UptoDate yet. When resync_finished is done we go
> Uptodate and connected and we're stuck.
>
> I tested yet another idea which seems to close the racy window.  I turned
> drbd_resync_finished into two parts.  A cleanup part that the worker can
> schedule to do the clean up and a done part that
> changes the state right away when the resync is done.  I include an
> untested patch to illustrate that idea.
>

Hi Ernest,

Finally the attached patch made it into the GIT repository
(see 3a57119417c46c51dd4bc720ab7dbf14228f05bb.git.txt)
It is slightly different from the patch I suggested at first

As you could not confirm that the bugs is closed for you I tried
to reproduce it here now (with the attached patch) and some
instrumentation code to make the call to drbd_resync_finished()
to last 10 seconds.

I tested pausing and continuing on the SyncTarget and on the
Sync Source side. I could not find any issues:

[42949590.920000] drbd0: conn( StartingSyncT -> WFSyncUUID )
[42949590.920000] drbd0: conn( WFSyncUUID -> SyncTarget )
[42949590.920000] drbd0: Began resync as SyncTarget (will sync 262244 KB [65561 bits set]).
[42949590.920000] drbd0: Writing meta data super block now.
[42949669.270000] drbd0: Warn long sleep start
[42949672.120000] drbd0: conn( SyncTarget -> PausedSyncT ) user_isp( 0 -> 1 )
[42949672.120000] drbd0: Resync suspended
[42949678.610000] drbd0: conn( PausedSyncT -> SyncTarget ) user_isp( 1 -> 0 )
[42949678.610000] drbd0: Syncer continues.
[42949679.280000] drbd0: Warn long sleep stop
[42949679.280000] drbd0: Resync done (total 87 sec; paused 6 sec; 3236 K/sec)
[42949679.280000] drbd0: conn( SyncTarget -> Connected ) disk( Inconsistent -> UpToDate )
[42949679.280000] drbd0: Writing meta data super block now.

Ernest, can you please confirm that this issue is solved for you with that
patch, or provide logfile output of an failing test ?

Thanks!

-phil
-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Vivenotgasse 48, 1120 Vienna, Austria        http://www.linbit.com :

--Boundary-00=_ZjtSHsBoW9PrI4E
Content-Type: text/plain; charset="iso-8859-15";
	name="3a57119417c46c51dd4bc720ab7dbf14228f05bb.git.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="3a57119417c46c51dd4bc720ab7dbf14228f05bb.git.txt"

commit 3a57119417c46c51dd4bc720ab7dbf14228f05bb
Author: Philipp Reisner <philipp.reisner@linbit.com>
Date:   Sun Nov 18 22:19:42 2007 +0100

    make resync more robust, don't reset find bit offset too early.
    
    by the sync group serialisation code,
    a resync timer of a device may be rescheduled.
    
    if it had already sent all requests (find reached the end of the bitmap),
    but did not yet receive all the answers (some bits are still set),
    it would re-request all those bits
    if the start offset of the find gets reset too early.

diff --git a/drbd/drbd_bitmap.c b/drbd/drbd_bitmap.c
index dda2a29..68decd2 100644
--- a/drbd/drbd_bitmap.c
+++ b/drbd/drbd_bitmap.c
@@ -874,7 +874,7 @@ unsigned long drbd_bm_find_next(drbd_dev *mdev)
 	}
 	if (i >= b->bm_bits) {
 		i = -1UL;
-		b->bm_fo = 0;
+		/* leave b->bm_fo unchanged. */
 	} else {
 		b->bm_fo = i+1;
 	}
@@ -898,7 +898,7 @@ void drbd_bm_set_find(drbd_dev *mdev, unsigned long i)
 
 int drbd_bm_rs_done(drbd_dev *mdev)
 {
-	return mdev->bitmap->bm_fo == 0;
+	return (mdev->bitmap->bm_fo >= mdev->bitmap->bm_bits);
 }
 
 /* returns number of bits actually changed.
diff --git a/drbd/drbd_main.c b/drbd/drbd_main.c
index dec523a..7d0d024 100644
--- a/drbd/drbd_main.c
+++ b/drbd/drbd_main.c
@@ -787,10 +787,14 @@ int _drbd_set_state(drbd_dev* mdev, drbd_state_t ns,enum chg_state_flags flags)
 	    (ns.conn == SyncTarget  || ns.conn == SyncSource) ) {
 		INFO("Syncer continues.\n");
 		mdev->rs_paused += (long)jiffies-(long)mdev->rs_mark_time;
-		if( ns.conn == SyncTarget ) {
-			D_ASSERT(!test_bit(STOP_SYNC_TIMER,&mdev->flags));
-			clear_bit(STOP_SYNC_TIMER,&mdev->flags);
-			mod_timer(&mdev->resync_timer,jiffies);
+		if (ns.conn == SyncTarget) {
+			if (!test_bit(STOP_SYNC_TIMER,&mdev->flags)) {
+				mod_timer(&mdev->resync_timer,jiffies);
+			}
+			/* This if (!test_bit) is only needed for the case
+			   that a device that has ceased to used its timer,
+			   i.e. it is already in drbd_resync_finished() gets
+			   paused and resumed. */
 		}
 	}
 

--Boundary-00=_ZjtSHsBoW9PrI4E
Content-Type: text/x-diff; charset="iso-8859-15";
	name="resync_finished_10_seconds.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="resync_finished_10_seconds.diff"

diff --git a/drbd/drbd_worker.c b/drbd/drbd_worker.c
index 227b024..ad9dbbe 100644
--- a/drbd/drbd_worker.c
+++ b/drbd/drbd_worker.c
@@ -481,6 +481,10 @@ int drbd_resync_finished(drbd_dev* mdev)
 		}
 		ERR("Warn failed to drbd_rs_del_all() and to kmalloc(w).\n");
 	}
+	ERR("Warn long sleep start\n");
+	set_current_state(TASK_INTERRUPTIBLE);
+	schedule_timeout(10 * HZ);
+	ERR("Warn long sleep stop\n");
 
 	dt = (jiffies - mdev->rs_start - mdev->rs_paused) / HZ;
 	if (dt <= 0) dt=1;

--Boundary-00=_ZjtSHsBoW9PrI4E--
