Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 03513105645F
	for <drbd-dev@lists.linbit.com>; Mon, 25 Apr 2016 14:08:30 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jens Axboe <axboe@fb.com>,
	linux-kernel@vger.kernel.org
Date: Mon, 25 Apr 2016 14:07:50 +0200
Message-Id: <1461586077-11581-24-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1461586077-11581-1-git-send-email-philipp.reisner@linbit.com>
References: <1461586077-11581-1-git-send-email-philipp.reisner@linbit.com>
Cc: Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 23/30] drbd: sync_handshake: handle identical
	uuids with current (frozen) Primary
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

From: Lars Ellenberg <lars.ellenberg@linbit.com>

If in a two-primary scenario, we lost our peer, freeze IO,
and are still frozen (no UUID rotation) when the peer comes back
as Secondary after a hard crash, we will see identical UUIDs.

The "rule_nr = 40" chose to use the "CRASHED_PRIMARY" bit as
arbitration, but that would cause the still running (but frozen) Primary
to become SyncTarget (which it typically refuses), and the handshake is
declined.

Fix: check current roles.
If we have *one* current primary, the Primary wins.
(rule_nr = 41)

Since that is a protocol change, use the newly introduced DRBD_FF_WSAME
to determine if rule_nr = 41 can be applied.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_receiver.c | 47 +++++++++++++++++++++++++++++++++++---
 1 file changed, 44 insertions(+), 3 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 1320bb8..8e7afa3 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -3181,7 +3181,8 @@ static void drbd_uuid_dump(struct drbd_device *device, char *text, u64 *uuid,
 -1091   requires proto 91
 -1096   requires proto 96
  */
-static int drbd_uuid_compare(struct drbd_device *const device, int *rule_nr) __must_hold(local)
+
+static int drbd_uuid_compare(struct drbd_device *const device, enum drbd_role const peer_role, int *rule_nr) __must_hold(local)
 {
 	struct drbd_peer_device *const peer_device = first_peer_device(device);
 	struct drbd_connection *const connection = peer_device ? peer_device->connection : NULL;
@@ -3261,8 +3262,39 @@ static int drbd_uuid_compare(struct drbd_device *const device, int *rule_nr) __m
 		 * next bit (weight 2) is set when peer was primary */
 		*rule_nr = 40;
 
+		/* Neither has the "crashed primary" flag set,
+		 * only a replication link hickup. */
+		if (rct == 0)
+			return 0;
+
+		/* Current UUID equal and no bitmap uuid; does not necessarily
+		 * mean this was a "simultaneous hard crash", maybe IO was
+		 * frozen, so no UUID-bump happened.
+		 * This is a protocol change, overload DRBD_FF_WSAME as flag
+		 * for "new-enough" peer DRBD version. */
+		if (device->state.role == R_PRIMARY || peer_role == R_PRIMARY) {
+			*rule_nr = 41;
+			if (!(connection->agreed_features & DRBD_FF_WSAME)) {
+				drbd_warn(peer_device, "Equivalent unrotated UUIDs, but current primary present.\n");
+				return -(0x10000 | PRO_VERSION_MAX | (DRBD_FF_WSAME << 8));
+			}
+			if (device->state.role == R_PRIMARY && peer_role == R_PRIMARY) {
+				/* At least one has the "crashed primary" bit set,
+				 * both are primary now, but neither has rotated its UUIDs?
+				 * "Can not happen." */
+				drbd_err(peer_device, "Equivalent unrotated UUIDs, but both are primary. Can not resolve this.\n");
+				return -100;
+			}
+			if (device->state.role == R_PRIMARY)
+				return 1;
+			return -1;
+		}
+
+		/* Both are secondary.
+		 * Really looks like recovery from simultaneous hard crash.
+		 * Check which had been primary before, and arbitrate. */
 		switch (rct) {
-		case 0: /* !self_pri && !peer_pri */ return 0;
+		case 0: /* !self_pri && !peer_pri */ return 0; /* already handled */
 		case 1: /*  self_pri && !peer_pri */ return 1;
 		case 2: /* !self_pri &&  peer_pri */ return -1;
 		case 3: /*  self_pri &&  peer_pri */
@@ -3389,7 +3421,7 @@ static enum drbd_conns drbd_sync_handshake(struct drbd_peer_device *peer_device,
 	drbd_uuid_dump(device, "peer", device->p_uuid,
 		       device->p_uuid[UI_SIZE], device->p_uuid[UI_FLAGS]);
 
-	hg = drbd_uuid_compare(device, &rule_nr);
+	hg = drbd_uuid_compare(device, peer_role, &rule_nr);
 	spin_unlock_irq(&device->ldev->md.uuid_lock);
 
 	drbd_info(device, "uuid_compare()=%d by rule %d\n", hg, rule_nr);
@@ -3398,6 +3430,15 @@ static enum drbd_conns drbd_sync_handshake(struct drbd_peer_device *peer_device,
 		drbd_alert(device, "Unrelated data, aborting!\n");
 		return C_MASK;
 	}
+	if (hg < -0x10000) {
+		int proto, fflags;
+		hg = -hg;
+		proto = hg & 0xff;
+		fflags = (hg >> 8) & 0xff;
+		drbd_alert(device, "To resolve this both sides have to support at least protocol %d and feature flags 0x%x\n",
+					proto, fflags);
+		return C_MASK;
+	}
 	if (hg < -1000) {
 		drbd_alert(device, "To resolve this both sides have to support at least protocol %d\n", -hg - 1000);
 		return C_MASK;
-- 
1.9.1

