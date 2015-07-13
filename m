Return-Path: <nwang@suse.com>
Received: from prv3-mh.provo.novell.com (victor.provo.novell.com
	[137.65.250.26])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 6F7131055707
	for <drbd-dev@lists.linbit.com>; Mon, 13 Jul 2015 10:39:55 +0200 (CEST)
From: Nick Wang <nwang@suse.com>
To: nwang@suse.com
Date: Mon, 13 Jul 2015 16:39:02 +0800
Message-Id: <1436776744-3135-9-git-send-email-nwang@suse.com>
In-Reply-To: <1436776744-3135-1-git-send-email-nwang@suse.com>
References: <1436776744-3135-1-git-send-email-nwang@suse.com>
Cc: linux-kernel@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>,
	philipp.reisner@linbit.com, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [Patch v2 08/10] drbd: Function to work with packet
	P_ZERO_OUT
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

Using packet P_ZERO_OUT to update zero out
status of peer node.

Signed-off-by: Nick Wang <nwang@suse.com>
CC: Philipp Reisner <philipp.reisner@linbit.com>
CC: Lars Ellenberg <lars.ellenberg@linbit.com>
CC: drbd-dev@lists.linbit.com
CC: linux-kernel@vger.kernel.org
---
 drbd/drbd_receiver.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drbd/drbd_receiver.c b/drbd/drbd_receiver.c
index 5e6b149..6eae84f 100644
--- a/drbd/drbd_receiver.c
+++ b/drbd/drbd_receiver.c
@@ -4383,6 +4383,41 @@ static union drbd_state convert_state(union drbd_state ps)
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
+			drbd_info(device, "Both side finished zeroing.\n");
+			spin_lock_irq(&device->resource->req_lock);
+			_drbd_set_state(_NS2(device, disk, D_UP_TO_DATE,
+				pdsk, D_UP_TO_DATE), CS_VERBOSE, NULL);
+			spin_unlock_irq(&device->resource->req_lock);
+			drbd_send_zero_out_finish(peer_device);
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
@@ -5008,6 +5043,7 @@ static struct data_cmd drbd_cmd_handler[] = {
 	[P_CONN_ST_CHG_REQ] = { 0, sizeof(struct p_req_state), receive_req_conn_state },
 	[P_PROTOCOL_UPDATE] = { 1, sizeof(struct p_protocol), receive_protocol },
 	[P_TRIM]	    = { 0, sizeof(struct p_trim), receive_Data },
+	[P_ZERO_OUT]	    = { 0, sizeof(struct p_state), receive_zero_out_state },
 };
 
 static void drbdd(struct drbd_connection *connection)
-- 
1.8.4.5

