Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Thu, 13 Oct 2011 12:32:15 +0200
Message-Id: <1318501936-11689-10-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1318501936-11689-1-git-send-email-philipp.reisner@linbit.com>
References: <1318501936-11689-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 09/10] drbd: Fixed removal of volumes/devices
	from connected resources
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

When removing a volume/device we need to switch the connection
status of the peer back into WFReportParams.

  Before this fix it was left in Connected state. That means that
  the peer device continued to inform us about state changes, etc...
  But we deleted that minor -> protocol error.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_nl.c       |    2 ++
 drivers/block/drbd/drbd_receiver.c |    1 +
 drivers/block/drbd/drbd_state.c    |    6 ++++--
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index 463029a..79397b6 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -3107,6 +3107,8 @@ static enum drbd_ret_code adm_delete_minor(struct drbd_conf *mdev)
 	     * we may want to delete a minor from a live replication group.
 	     */
 	    mdev->state.role == R_SECONDARY) {
+		_drbd_request_state(mdev, NS(conn, C_WF_REPORT_PARAMS),
+				    CS_VERBOSE + CS_WAIT_COMPLETE);
 		idr_remove(&mdev->tconn->volumes, mdev->vnr);
 		idr_remove(&minors, mdev_to_minor(mdev));
 		del_gendisk(mdev->vdisk);
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 3a7e54b..d4e677c 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -3628,6 +3628,7 @@ static union drbd_state convert_state(union drbd_state ps)
 	union drbd_state ms;
 
 	static enum drbd_conns c_tab[] = {
+		[C_WF_REPORT_PARAMS] = C_WF_REPORT_PARAMS,
 		[C_CONNECTED] = C_CONNECTED,
 
 		[C_STARTING_SYNC_S] = C_STARTING_SYNC_T,
diff --git a/drivers/block/drbd/drbd_state.c b/drivers/block/drbd/drbd_state.c
index 65d22f3..fe46a8b 100644
--- a/drivers/block/drbd/drbd_state.c
+++ b/drivers/block/drbd/drbd_state.c
@@ -201,7 +201,8 @@ static int cl_wide_st_chg(struct drbd_conf *mdev,
 		  (os.conn != C_STARTING_SYNC_S && ns.conn == C_STARTING_SYNC_S) ||
 		  (os.disk != D_DISKLESS && ns.disk == D_DISKLESS))) ||
 		(os.conn >= C_CONNECTED && ns.conn == C_DISCONNECTING) ||
-		(os.conn == C_CONNECTED && ns.conn == C_VERIFY_S);
+		(os.conn == C_CONNECTED && ns.conn == C_VERIFY_S) ||
+		(os.conn == C_CONNECTED && ns.conn == C_WF_REPORT_PARAMS);
 }
 
 static union drbd_state
@@ -1202,7 +1203,8 @@ static void after_state_ch(struct drbd_conf *mdev, union drbd_state os,
 	}
 
 	/* Do not change the order of the if above and the two below... */
-	if (os.pdsk == D_DISKLESS && ns.pdsk > D_DISKLESS) {      /* attach on the peer */
+	if (os.pdsk == D_DISKLESS &&
+	    ns.pdsk > D_DISKLESS && ns.pdsk != D_UNKNOWN) {      /* attach on the peer */
 		drbd_send_uuids(mdev);
 		drbd_send_state(mdev);
 	}
-- 
1.7.4.1

