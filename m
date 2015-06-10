Return-Path: <nwang@suse.com>
Received: from prv3-mh.provo.novell.com (victor.provo.novell.com
	[137.65.250.26])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 4329610518BE
	for <drbd-dev@lists.linbit.com>; Wed, 10 Jun 2015 09:49:20 +0200 (CEST)
From: Nick Wang <nwang@suse.com>
To: philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
	drbd-dev@lists.linbit.com
Date: Wed, 10 Jun 2015 15:48:25 +0800
Message-Id: <1433922509-10280-7-git-send-email-nwang@suse.com>
In-Reply-To: <1433922509-10280-1-git-send-email-nwang@suse.com>
References: <1433922509-10280-1-git-send-email-nwang@suse.com>
Cc: linux-kernel@vger.kernel.org
Subject: [Drbd-dev] [PATCH 06/10] New packet P_ZERO_OUT to get the status of
	zeroing out device from peer node.
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

New packet P_ZERO_OUT for zero out device.

Signed-off-by: Nick Wang <nwang@suse.com>
CC: Philipp Reisner <philipp.reisner@linbit.com>
CC: Lars Ellenberg <lars.ellenberg@linbit.com>
CC: drbd-dev@lists.linbit.com
CC: linux-kernel@vger.kernel.org

---
 drbd/drbd_protocol.h |  1 +
 drbd/drbd_receiver.c | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/drbd/drbd_protocol.h b/drbd/drbd_protocol.h
index 405b181..3a82442 100644
--- a/drbd/drbd_protocol.h
+++ b/drbd/drbd_protocol.h
@@ -59,6 +59,7 @@ enum drbd_packet {
 	/* REQ_DISCARD. We used "discard" in different contexts before,
 	 * which is why I chose TRIM here, to disambiguate. */
 	P_TRIM                = 0x31,
+	P_ZERO_OUT            = 0x32,
 
 	P_MAY_IGNORE	      = 0x100, /* Flag to test if (cmd > P_MAY_IGNORE) ... */
 	P_MAX_OPT_CMD	      = 0x101,
diff --git a/drbd/drbd_receiver.c b/drbd/drbd_receiver.c
index 47b8fe5..41c958a 100644
--- a/drbd/drbd_receiver.c
+++ b/drbd/drbd_receiver.c
@@ -4404,6 +4404,39 @@ static union drbd_state convert_state(union drbd_state ps)
 	return ms;
 }
 
+static int receive_zero_out_state(struct drbd_connection *connection, struct packet_info *pi)
+{
+	struct drbd_peer_device *peer_device;
+	struct drbd_device *device;
+	struct p_state *p = pi->data;
+	unsigned int isfail;
+
+	peer_device = conn_peer_device(connection, pi->vnr);
+	if (!peer_device)
+		return -EIO;
+	device = peer_device->device;
+
+	isfail = be32_to_cpu(p->state);
+
+	if (isfail) {
+		drbd_info(device, "Failed to zero out peer device\n");
+		set_bit(ZERO_FAIL, &device->flags);
+	} else {
+		drbd_info(device, "Finished zero out peer device\n");
+		if (test_and_clear_bit(ZERO_DONE, &device->flags)) {
+			spin_lock_irq(&device->resource->req_lock);
+			_drbd_set_state(_NS2(device, disk, D_UP_TO_DATE,
+				pdsk, D_UP_TO_DATE), CS_VERBOSE, NULL);
+			spin_unlock_irq(&device->resource->req_lock);
+		} else {
+			/* waiting for local device finished */
+			set_bit(ZERO_DONE, &device->flags);
+		}
+	}
+
+	return 0;
+}
+
 static int receive_req_state(struct drbd_connection *connection, struct packet_info *pi)
 {
 	struct drbd_peer_device *peer_device;
@@ -5029,6 +5062,7 @@ static struct data_cmd drbd_cmd_handler[] = {
 	[P_CONN_ST_CHG_REQ] = { 0, sizeof(struct p_req_state), receive_req_conn_state },
 	[P_PROTOCOL_UPDATE] = { 1, sizeof(struct p_protocol), receive_protocol },
 	[P_TRIM]	    = { 0, sizeof(struct p_trim), receive_Data },
+	[P_ZERO_OUT]	    = { 0, sizeof(struct p_state), receive_zero_out_state },
 };
 
 static void drbdd(struct drbd_connection *connection)
-- 
1.8.4.5

