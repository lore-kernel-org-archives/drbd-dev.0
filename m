Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Fri,  2 Sep 2011 12:00:36 +0200
Message-Id: <1314957648-13242-5-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1314957648-13242-1-git-send-email-philipp.reisner@linbit.com>
References: <1314957648-13242-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 04/16] drbd: Do not modify the connection state
	with something else that conn_request_state()
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_actlog.c   |    2 +-
 drivers/block/drbd/drbd_receiver.c |   16 ++++++++--------
 drivers/block/drbd/drbd_worker.c   |   10 ++--------
 3 files changed, 11 insertions(+), 17 deletions(-)

diff --git a/drivers/block/drbd/drbd_actlog.c b/drivers/block/drbd/drbd_actlog.c
index 6d1e892..92a16ea 100644
--- a/drivers/block/drbd/drbd_actlog.c
+++ b/drivers/block/drbd/drbd_actlog.c
@@ -759,7 +759,7 @@ static void drbd_try_clear_on_disk_bm(struct drbd_conf *mdev, sector_t sector,
 				dump_stack();
 
 				lc_put(mdev->resync, &ext->lce);
-				drbd_force_state(mdev, NS(conn, C_DISCONNECTING));
+				conn_request_state(mdev->tconn, NS(conn, C_DISCONNECTING), CS_HARD);
 				return;
 			}
 		} else {
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 4eeba8f..f239902 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -2925,7 +2925,7 @@ static int receive_protocol(struct drbd_conf *mdev, enum drbd_packet cmd,
 	return true;
 
 disconnect:
-	drbd_force_state(mdev, NS(conn, C_DISCONNECTING));
+	conn_request_state(mdev->tconn, NS(conn, C_DISCONNECTING), CS_HARD);
 	return false;
 }
 
@@ -3104,7 +3104,7 @@ disconnect:
 	crypto_free_hash(csums_tfm);
 	/* but free the verify_tfm again, if csums_tfm did not work out */
 	crypto_free_hash(verify_tfm);
-	drbd_force_state(mdev, NS(conn, C_DISCONNECTING));
+	conn_request_state(mdev->tconn, NS(conn, C_DISCONNECTING), CS_HARD);
 	return false;
 }
 
@@ -3164,7 +3164,7 @@ static int receive_sizes(struct drbd_conf *mdev, enum drbd_packet cmd,
 		   mdev->state.disk >= D_OUTDATED &&
 		   mdev->state.conn < C_CONNECTED) {
 			dev_err(DEV, "The peer's disk size is too small!\n");
-			drbd_force_state(mdev, NS(conn, C_DISCONNECTING));
+			conn_request_state(mdev->tconn, NS(conn, C_DISCONNECTING), CS_HARD);
 			mdev->ldev->dc.disk_size = my_usize;
 			put_ldev(mdev);
 			return false;
@@ -3240,7 +3240,7 @@ static int receive_uuids(struct drbd_conf *mdev, enum drbd_packet cmd,
 	    (mdev->ed_uuid & ~((u64)1)) != (p_uuid[UI_CURRENT] & ~((u64)1))) {
 		dev_err(DEV, "Can only connect to data with current UUID=%016llX\n",
 		    (unsigned long long)mdev->ed_uuid);
-		drbd_force_state(mdev, NS(conn, C_DISCONNECTING));
+		conn_request_state(mdev->tconn, NS(conn, C_DISCONNECTING), CS_HARD);
 		return false;
 	}
 
@@ -3445,7 +3445,7 @@ static int receive_state(struct drbd_conf *mdev, enum drbd_packet cmd,
 				if (test_and_clear_bit(CONN_DRY_RUN, &mdev->flags))
 					return false;
 				D_ASSERT(os.conn == C_WF_REPORT_PARAMS);
-				drbd_force_state(mdev, NS(conn, C_DISCONNECTING));
+				conn_request_state(mdev->tconn, NS(conn, C_DISCONNECTING), CS_HARD);
 				return false;
 			}
 		}
@@ -3470,7 +3470,7 @@ static int receive_state(struct drbd_conf *mdev, enum drbd_packet cmd,
 		tl_clear(mdev->tconn);
 		drbd_uuid_new_current(mdev);
 		clear_bit(NEW_CUR_UUID, &mdev->flags);
-		drbd_force_state(mdev, NS2(conn, C_PROTOCOL_ERROR, susp, 0));
+		conn_request_state(mdev->tconn, NS2(conn, C_PROTOCOL_ERROR, susp, 0), CS_HARD);
 		return false;
 	}
 	rv = _drbd_set_state(mdev, ns, cs_flags, NULL);
@@ -3478,7 +3478,7 @@ static int receive_state(struct drbd_conf *mdev, enum drbd_packet cmd,
 	spin_unlock_irq(&mdev->tconn->req_lock);
 
 	if (rv < SS_SUCCESS) {
-		drbd_force_state(mdev, NS(conn, C_DISCONNECTING));
+		conn_request_state(mdev->tconn, NS(conn, C_DISCONNECTING), CS_HARD);
 		return false;
 	}
 
@@ -3651,7 +3651,7 @@ decode_bitmap_c(struct drbd_conf *mdev,
 	 * during all our tests. */
 
 	dev_err(DEV, "receive_bitmap_c: unknown encoding %u\n", p->encoding);
-	drbd_force_state(mdev, NS(conn, C_PROTOCOL_ERROR));
+	conn_request_state(mdev->tconn, NS(conn, C_PROTOCOL_ERROR), CS_HARD);
 	return -EIO;
 }
 
diff --git a/drivers/block/drbd/drbd_worker.c b/drivers/block/drbd/drbd_worker.c
index e459cb2..a730520 100644
--- a/drivers/block/drbd/drbd_worker.c
+++ b/drivers/block/drbd/drbd_worker.c
@@ -1290,12 +1290,6 @@ int w_send_read_req(struct drbd_work *w, int cancel)
 	ok = drbd_send_drequest(mdev, P_DATA_REQUEST, req->i.sector, req->i.size,
 				(unsigned long)req);
 
-	if (!ok) {
-		/* ?? we set C_TIMEOUT or C_BROKEN_PIPE in drbd_send();
-		 * so this is probably redundant */
-		if (mdev->state.conn >= C_CONNECTED)
-			drbd_force_state(mdev, NS(conn, C_NETWORK_FAILURE));
-	}
 	req_mod(req, ok ? HANDED_OVER_TO_NETWORK : SEND_FAILED);
 
 	return ok;
@@ -1510,7 +1504,7 @@ void drbd_start_resync(struct drbd_conf *mdev, enum drbd_conns side)
 			if (r > 0) {
 				dev_info(DEV, "before-resync-target handler returned %d, "
 					 "dropping connection.\n", r);
-				drbd_force_state(mdev, NS(conn, C_DISCONNECTING));
+				conn_request_state(mdev->tconn, NS(conn, C_DISCONNECTING), CS_HARD);
 				return;
 			}
 		} else /* C_SYNC_SOURCE */ {
@@ -1523,7 +1517,7 @@ void drbd_start_resync(struct drbd_conf *mdev, enum drbd_conns side)
 				} else {
 					dev_info(DEV, "before-resync-source handler returned %d, "
 						 "dropping connection.\n", r);
-					drbd_force_state(mdev, NS(conn, C_DISCONNECTING));
+					conn_request_state(mdev->tconn, NS(conn, C_DISCONNECTING), CS_HARD);
 					return;
 				}
 			}
-- 
1.7.4.1

