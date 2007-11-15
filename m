Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] DRBD8: incorrect state transition Connected
	->WFBitMapS and UpToDate->Inconsistent
Date: Thu, 15 Nov 2007 17:27:05 +0100
References: <342BAC0A5467384983B586A6B0B376710707496D@EXNA.corp.stratus.com>
	<BD7042533C2F8943A6A4257A9E31C454F47A31@EXNA.corp.stratus.com>
In-Reply-To: <BD7042533C2F8943A6A4257A9E31C454F47A31@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_ZNHPHZriQ55NCRt"
Message-Id: <200711151727.05736.philipp.reisner@linbit.com>
Cc: "Montrose, Ernest" <Ernest.Montrose@stratus.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

--Boundary-00=_ZNHPHZriQ55NCRt
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday 12 November 2007 14:41:10 Montrose, Ernest wrote:
> Hi,
> We have been struggling with a problem where one side gets stuck in
> WFBitMapS and Inconsistent State. Consider two nodes (Node0 and node1).
>
>
> * Device r5 on node0 starts syncing as the synctarget.
> * Device r5 is done syncing and on node0 we call drbd_resync_finished()
> this gets delayed for a bit in drbd_rs_del_all()
> * During this delay, device R0   wants to resync.  So the lower priority
> devices like R5 gets paused.  This is were the trouble starts.

Right. But Something else happens...

[...]
> Oct  4 14:56:01 node0 kernel: drbd60: Syncer continues.
> Oct  4 14:56:01 node0 kernel: drbd60: ASSERT(
> !test_bit(STOP_SYNC_TIMER,&mdev->flags) ) in
> /sandbox/sgraham/sn/trunk/platform/drbd/src/drbd/drbd_main.c:786

That assert caught my attention, and this is my understanding what
went wrong...

r5 was already finished with its resync timer and calling 
w_make_resync_request(), but due to the continue event after the
pause the timer got restarted...

Unfortunately the drbd_bm_find_next() searched through all the
bitmap and found those bits near the end that where not yet 
cleared, and so resync requests where resent...

Therefore...

[...]
> Oct  4 14:56:09 node0 kernel: drbd60: Resync done (total 2 sec; paused 0
> sec; 384 K/sec)
[...]
> Oct  4 14:56:09 node0 kernel: drbd60: Resync done (total 2 sec; paused 0
> sec; 0 K/sec)
> Oct  4 14:56:09 node0 kernel: drbd60: Resync done (total 2 sec; paused 0
> sec; 0 K/sec)
> Oct  4 14:56:09 node0 kernel: drbd60: Connected in w_make_resync_request
> Oct  4 14:56:09 node0 kernel: drbd60: Resync done (total 2 sec; paused 0
> sec; 0 K/sec)

... we got multiple calls to drbd_resync_finished().

Here is my suggestion to fix that.

1) Do not restart the timer after a syncpause, when the timer is no 
   longer needed.

2) To make the whole thing more robust against such bugs, 
   drbd_bm_find_next() should not reset the find_offset back to 0
   after it hit the end of the bitmap once.

I have not tested it.... but I think this should do...

-Phil
-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Vivenotgasse 48, 1120 Vienna, Austria        http://www.linbit.com :

--Boundary-00=_ZNHPHZriQ55NCRt
Content-Type: text/x-diff; charset="iso-8859-15";
	name="Wbimaps_stuck_phil.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="Wbimaps_stuck_phil.patch"

diff --git a/drbd/drbd_bitmap.c b/drbd/drbd_bitmap.c
index 015421a..7e118a6 100644
--- a/drbd/drbd_bitmap.c
+++ b/drbd/drbd_bitmap.c
@@ -954,7 +954,7 @@ unsigned long drbd_bm_find_next(drbd_dev *mdev)
 	}
 	if (i >= b->bm_bits) {
 		i = -1UL;
-		b->bm_fo = 0;
+		/* leave b->bm_fo unchanged. */
 	} else {
 		b->bm_fo = i+1;
 	}
diff --git a/drbd/drbd_main.c b/drbd/drbd_main.c
index fe8f66d..e25bb3a 100644
--- a/drbd/drbd_main.c
+++ b/drbd/drbd_main.c
@@ -786,9 +786,13 @@ int _drbd_set_state(drbd_dev* mdev, drbd_state_t ns,enum chg_state_flags flags)
 		INFO("Syncer continues.\n");
 		mdev->rs_paused += (long)jiffies-(long)mdev->rs_mark_time;
 		if( ns.conn == SyncTarget ) {
-			D_ASSERT(!test_bit(STOP_SYNC_TIMER,&mdev->flags));
-			clear_bit(STOP_SYNC_TIMER,&mdev->flags);
-			mod_timer(&mdev->resync_timer,jiffies);
+			if (!test_bit(STOP_SYNC_TIMER,&mdev->flags)) {
+				mod_timer(&mdev->resync_timer,jiffies);
+			}
+			/* This if (!test_bit is only needed for the case
+			   that a device that has ceased to used its timer,
+			   i.e. it is already in drbd_resync_finished() gets
+			   paused and resumed. */
 		}
 	}
 

--Boundary-00=_ZNHPHZriQ55NCRt--
