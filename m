Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: "Graham, Simon" <Simon.Graham@stratus.com>
Date: Fri, 12 Jun 2009 11:38:55 +0200
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_vIiMK/MTxfVJ0L4"
Message-Id: <200906121138.55945.philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com, Valentin Vidic <Valentin.Vidic@carnet.hr>
Subject: [Drbd-dev] Xen - DRBD issue / panic in skb_copy_bits
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

--Boundary-00=_vIiMK/MTxfVJ0L4
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Simon,

As we are currently preparing the next DRBD release, we try to
fix known issues...

I tried to reproduce, trigger the issue you described in that post:
http://lists.linbit.com/pipermail/drbd-user/2009-March/011645.html
I failed to reproduce it, probably because I tried with 
instrumented DRBD code on a recent vanilla kernel.

Howerver, attached is the patch that is intended to fix the issue.
Can you verify that it really fixes the issue?

  I thought, you have the right test environment (with Xen) around, 
  and it is probably only a little effort for you to do so.) 
  Currently I do not have Xen boxes in our testing environment 

Thanks!
 Philipp
-- 
: Dipl-Ing Philipp Reisner
: LINBIT | Your Way to High Availability
: Tel: +43-1-8178292-50, Fax: +43-1-8178292-82
: http://www.linbit.com

DRBD(R) and LINBIT(R) are registered trademarks of LINBIT, Austria.


--Boundary-00=_vIiMK/MTxfVJ0L4
Content-Type: text/x-patch;
  charset="UTF-8";
  name="xen-issue-fix.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="xen-issue-fix.diff"

diff --git a/drbd/drbd_main.c b/drbd/drbd_main.c
index 1a1c4f6..719a5fe 100644
--- a/drbd/drbd_receiver.c
+++ b/drbd/drbd_receiver.c
@@ -357,7 +357,7 @@ int drbd_release_ee(struct drbd_conf *mdev, struct list_head *list)
 }
 
 
-STATIC void reclaim_net_ee(struct drbd_conf *mdev)
+STATIC enum { RN_EMPTY, RN_NOT_EMPTY } reclaim_net_ee(struct drbd_conf *mdev)
 {
 	struct drbd_epoch_entry *e;
 	struct list_head *le, *tle;
@@ -370,10 +370,12 @@ STATIC void reclaim_net_ee(struct drbd_conf *mdev)
 	list_for_each_safe(le, tle, &mdev->net_ee) {
 		e = list_entry(le, struct drbd_epoch_entry, w.list);
 		if (drbd_bio_has_active_page(e->private_bio))
-			break;
+			return RN_NOT_EMPTY;
 		list_del(le);
 		drbd_free_ee(mdev, e);
 	}
+
+	return RN_EMPTY;
 }
 
 
@@ -3552,7 +3554,13 @@ STATIC void drbd_disconnect(struct drbd_conf *mdev)
 	_drbd_wait_ee_list_empty(mdev, &mdev->sync_ee);
 	_drbd_clear_done_ee(mdev);
 	_drbd_wait_ee_list_empty(mdev, &mdev->read_ee);
-	reclaim_net_ee(mdev);
+	while (reclaim_net_ee(mdev) == RN_NOT_EMPTY) {
+		spin_unlock_irq(&mdev->req_lock);
+		dev_info(DEV, "Waiting for TCP to finally give up all page references\n");
+		__set_current_state(TASK_INTERRUPTIBLE);
+		schedule_timeout(HZ / 10);
+		spin_lock_irq(&mdev->req_lock);
+	}
 	spin_unlock_irq(&mdev->req_lock);
 
 	/* We do not have data structures that would allow us to

--Boundary-00=_vIiMK/MTxfVJ0L4--
