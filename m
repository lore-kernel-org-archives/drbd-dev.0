Return-Path: <ct246@yahoo.com>
Date: Thu, 15 Nov 2007 18:36:19 -0800 (PST)
From: Ernest Montrose <ct246@yahoo.com>
Subject: Re: [Drbd-dev] DRBD8: incorrect state transition Connected
	->WFBitMapS and UpToDate->Inconsistent
To: Philipp Reisner <philipp.reisner@linbit.com>,
	drbd-dev@lists.linbit.com
In-Reply-To: <200711151727.05736.philipp.reisner@linbit.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-2087804223-1195180579=:80135"
Content-Transfer-Encoding: 8bit
Message-ID: <793061.80135.qm@web30507.mail.mud.yahoo.com>
Cc: "Montrose, Ernest" <Ernest.Montrose@stratus.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

--0-2087804223-1195180579=:80135
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Phil,
I tested the patch and unfortunately it does not fix the race condition though I believe it fixes
the ASSERT issues.  
Essentially, when the resync is done and we are in drbd_resync_finished() if we pause the device
then we send the state to the peer.  The peer is done syncing at that point.  He does a
sync_hanshake() that sends its state to WBItMapS and Pdsk=Inconsistent (since the target
has not changed its state to connected and UptoDate yet. When resync_finished is done we go 
Uptodate and connected and we're stuck.

I tested yet another idea which seems to close the racy window.  I turned drbd_resync_finished
into two parts.  A cleanup part that the worker can schedule to do the clean up and a done part
that
changes the state right away when the resync is done.  I include an untested patch to illustrate
that idea.

Thanks.

EM--
--- Philipp Reisner <philipp.reisner@linbit.com> wrote:

> On Monday 12 November 2007 14:41:10 Montrose, Ernest wrote:
> > Hi,
> > We have been struggling with a problem where one side gets stuck in
> > WFBitMapS and Inconsistent State. Consider two nodes (Node0 and node1).
> >
> >
> > * Device r5 on node0 starts syncing as the synctarget.
> > * Device r5 is done syncing and on node0 we call drbd_resync_finished()
> > this gets delayed for a bit in drbd_rs_del_all()
> > * During this delay, device R0   wants to resync.  So the lower priority
> > devices like R5 gets paused.  This is were the trouble starts.
> 
> Right. But Something else happens...
> 
> [...]
> > Oct  4 14:56:01 node0 kernel: drbd60: Syncer continues.
> > Oct  4 14:56:01 node0 kernel: drbd60: ASSERT(
> > !test_bit(STOP_SYNC_TIMER,&mdev->flags) ) in
> > /sandbox/sgraham/sn/trunk/platform/drbd/src/drbd/drbd_main.c:786
> 
> That assert caught my attention, and this is my understanding what
> went wrong...
> 
> r5 was already finished with its resync timer and calling 
> w_make_resync_request(), but due to the continue event after the
> pause the timer got restarted...
> 
> Unfortunately the drbd_bm_find_next() searched through all the
> bitmap and found those bits near the end that where not yet 
> cleared, and so resync requests where resent...
> 
> Therefore...
> 
> [...]
> > Oct  4 14:56:09 node0 kernel: drbd60: Resync done (total 2 sec; paused 0
> > sec; 384 K/sec)
> [...]
> > Oct  4 14:56:09 node0 kernel: drbd60: Resync done (total 2 sec; paused 0
> > sec; 0 K/sec)
> > Oct  4 14:56:09 node0 kernel: drbd60: Resync done (total 2 sec; paused 0
> > sec; 0 K/sec)
> > Oct  4 14:56:09 node0 kernel: drbd60: Connected in w_make_resync_request
> > Oct  4 14:56:09 node0 kernel: drbd60: Resync done (total 2 sec; paused 0
> > sec; 0 K/sec)
> 
> ... we got multiple calls to drbd_resync_finished().
> 
> Here is my suggestion to fix that.
> 
> 1) Do not restart the timer after a syncpause, when the timer is no 
>    longer needed.
> 
> 2) To make the whole thing more robust against such bugs, 
>    drbd_bm_find_next() should not reset the find_offset back to 0
>    after it hit the end of the bitmap once.
> 
> I have not tested it.... but I think this should do...
> 
> -Phil
> -- 
> : Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
> : LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
> : Vivenotgasse 48, 1120 Vienna, Austria        http://www.linbit.com :
> > diff --git a/drbd/drbd_bitmap.c b/drbd/drbd_bitmap.c
> index 015421a..7e118a6 100644
> --- a/drbd/drbd_bitmap.c
> +++ b/drbd/drbd_bitmap.c
> @@ -954,7 +954,7 @@ unsigned long drbd_bm_find_next(drbd_dev *mdev)
>  	}
>  	if (i >= b->bm_bits) {
>  		i = -1UL;
> -		b->bm_fo = 0;
> +		/* leave b->bm_fo unchanged. */
>  	} else {
>  		b->bm_fo = i+1;
>  	}
> diff --git a/drbd/drbd_main.c b/drbd/drbd_main.c
> index fe8f66d..e25bb3a 100644
> --- a/drbd/drbd_main.c
> +++ b/drbd/drbd_main.c
> @@ -786,9 +786,13 @@ int _drbd_set_state(drbd_dev* mdev, drbd_state_t ns,enum chg_state_flags
> flags)
>  		INFO("Syncer continues.\n");
>  		mdev->rs_paused += (long)jiffies-(long)mdev->rs_mark_time;
>  		if( ns.conn == SyncTarget ) {
> -			D_ASSERT(!test_bit(STOP_SYNC_TIMER,&mdev->flags));
> -			clear_bit(STOP_SYNC_TIMER,&mdev->flags);
> -			mod_timer(&mdev->resync_timer,jiffies);
> +			if (!test_bit(STOP_SYNC_TIMER,&mdev->flags)) {
> +				mod_timer(&mdev->resync_timer,jiffies);
> +			}
> +			/* This if (!test_bit is only needed for the case
> +			   that a device that has ceased to used its timer,
> +			   i.e. it is already in drbd_resync_finished() gets
> +			   paused and resumed. */
>  		}
>  	}
>  
> > _______________________________________________
> drbd-dev mailing list
> drbd-dev@lists.linbit.com
> http://lists.linbit.com/mailman/listinfo/drbd-dev
> 


      ____________________________________________________________________________________
Be a better pen pal. 
Text or chat with friends inside Yahoo! Mail. See how.  http://overview.mail.yahoo.com/
--0-2087804223-1195180579=:80135
Content-Type: text/x-patch; name="my_3230.patch"
Content-Description: 552174691-my_3230.patch
Content-Disposition: inline; filename="my_3230.patch"

Index: drbd/drbd_actlog.c
===================================================================
--- drbd/drbd_actlog.c	(revision 20723)
+++ drbd/drbd_actlog.c	(working copy)
@@ -800,7 +800,8 @@
 	   ( mdev->state.conn == SyncSource || mdev->state.conn == SyncTarget ||
 	     mdev->state.conn == PausedSyncS || mdev->state.conn == PausedSyncT ) ) {
 		drbd_bm_lock(mdev);
-		drbd_resync_finished(mdev);
+              drbd_resync_done(mdev);
+		drbd_resync_cleanup(mdev);
 		drbd_bm_unlock(mdev);
 	}
 	drbd_bcast_sync_progress(mdev);
Index: drbd/drbd_worker.c
===================================================================
--- drbd/drbd_worker.c	(revision 20723)
+++ drbd/drbd_worker.c	(working copy)
@@ -450,16 +450,14 @@
 	kfree(w);
 
 	drbd_bm_lock(mdev);
-	drbd_resync_finished(mdev);
+	drbd_resync_cleanup(mdev);
 	drbd_bm_unlock(mdev);
 
 	return 1;
 }
 
-int drbd_resync_finished(drbd_dev* mdev)
+int drbd_resync_cleanup(drbd_dev* mdev)
 {
-	unsigned long db,dt,dbdt;
-	int dstate, pdstate;
 	struct drbd_work *w;
 
 	// Remove all elements from the resync LRU. Since future actions
@@ -483,6 +481,14 @@
 		ERR("Warn failed to drbd_rs_del_all() and to kmalloc(w).\n");
 	}
 
+	return 1;
+}
+
+int drbd_resync_done(drbd_dev* mdev)
+{
+	unsigned long db,dt,dbdt;
+	int dstate, pdstate;
+	
 	dt = (jiffies - mdev->rs_start - mdev->rs_paused) / HZ;
 	if (dt <= 0) dt=1;
 	db = mdev->rs_total;
@@ -933,7 +939,8 @@
 		     (unsigned long) mdev->rs_total);
 
 		if ( mdev->rs_total == 0 ) {
-			drbd_resync_finished(mdev);
+                     drbd_resync_done(mdev);
+			drbd_resync_cleanup(mdev);
 			return;
 		}
 
Index: drbd/drbd_int.h
===================================================================
--- drbd/drbd_int.h	(revision 20723)
+++ drbd/drbd_int.h	(working copy)
@@ -1302,7 +1302,8 @@
 extern void drbd_start_resync(drbd_dev *mdev, drbd_conns_t side);
 extern void resume_next_sg(drbd_dev* mdev);
 extern void suspend_other_sg(drbd_dev* mdev);
-extern int drbd_resync_finished(drbd_dev *mdev);
+extern int drbd_resync_done(drbd_dev *mdev);
+extern int drbd_resync_cleanup(drbd_dev *mdev);
 // maybe rather drbd_main.c ?
 extern int drbd_md_sync_page_io(drbd_dev *mdev, struct drbd_backing_dev *bdev,
 				sector_t sector, int rw);

--0-2087804223-1195180579=:80135--
