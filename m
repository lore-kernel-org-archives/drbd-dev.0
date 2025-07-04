Return-Path: <eslam.medhat1993@gmail.com>
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
	[209.85.221.50])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id E6EC1160645
	for <drbd-dev@lists.linbit.com>; Fri,  4 Jul 2025 19:50:42 +0200 (CEST)
Received: by mail-wr1-f50.google.com with SMTP id
	ffacd0b85a97d-3a5123c1533so539677f8f.2
	for <drbd-dev@lists.linbit.com>; Fri, 04 Jul 2025 10:50:42 -0700 (PDT)
From: Eslam Khafagy <eslam.medhat1993@gmail.com>
To: 
Subject: [PATCH] DRBD: replace strcpy with strscpy
Date: Fri,  4 Jul 2025 20:50:15 +0300
Message-ID: <20250704175018.333165-1-eslam.medhat1993@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Jens Axboe <axboe@kernel.dk>, Eslam Khafagy <eslam.medhat1993@gmail.com>,
	skhan@linuxfoundation.com, Philipp Reisner <philipp.reisner@linbit.com>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>, drbd-dev@lists.linbit.com
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <https://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <https://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

strcpy is deprecated due to lack of bounds checking. This patch replaces
strcpy with strscpy, the recommended alternative for null terminated
strings, to follow best practices.

I had to do a small refactor for __drbd_send_protocol since it uses
strlen anyways. so why not use that for strscpy.

Signed-off-by: Eslam Khafagy <eslam.medhat1993@gmail.com>
---
 drivers/block/drbd/drbd_main.c     | 17 +++++++++--------
 drivers/block/drbd/drbd_receiver.c |  4 ++--
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 52724b79be30..4e5bd74be90a 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -742,9 +742,9 @@ int drbd_send_sync_param(struct drbd_peer_device *peer_device)
 	}
 
 	if (apv >= 88)
-		strcpy(p->verify_alg, nc->verify_alg);
+		strscpy(p->verify_alg, nc->verify_alg);
 	if (apv >= 89)
-		strcpy(p->csums_alg, nc->csums_alg);
+		strscpy(p->csums_alg, nc->csums_alg);
 	rcu_read_unlock();
 
 	return drbd_send_command(peer_device, sock, cmd, size, NULL, 0);
@@ -771,10 +771,6 @@ int __drbd_send_protocol(struct drbd_connection *connection, enum drbd_packet cm
 		return -EOPNOTSUPP;
 	}
 
-	size = sizeof(*p);
-	if (connection->agreed_pro_version >= 87)
-		size += strlen(nc->integrity_alg) + 1;
-
 	p->protocol      = cpu_to_be32(nc->wire_protocol);
 	p->after_sb_0p   = cpu_to_be32(nc->after_sb_0p);
 	p->after_sb_1p   = cpu_to_be32(nc->after_sb_1p);
@@ -787,8 +783,13 @@ int __drbd_send_protocol(struct drbd_connection *connection, enum drbd_packet cm
 		cf |= CF_DRY_RUN;
 	p->conn_flags    = cpu_to_be32(cf);
 
-	if (connection->agreed_pro_version >= 87)
-		strcpy(p->integrity_alg, nc->integrity_alg);
+	size = sizeof(*p);
+	if (connection->agreed_pro_version >= 87) {
+		int integrity_len = strlen(nc->integrity_alg);
+		size += integrity_len + 1;
+		strscpy(p->integrity_alg, nc->integrity_alg, integrity_len);
+	}
+
 	rcu_read_unlock();
 
 	return __conn_send_command(connection, sock, cmd, size, NULL, 0);
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index e5a2e5f7887b..9c2d439f26e8 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -3985,14 +3985,14 @@ static int receive_SyncParam(struct drbd_connection *connection, struct packet_i
 			*new_net_conf = *old_net_conf;
 
 			if (verify_tfm) {
-				strcpy(new_net_conf->verify_alg, p->verify_alg);
+				strscpy(new_net_conf->verify_alg, p->verify_alg);
 				new_net_conf->verify_alg_len = strlen(p->verify_alg) + 1;
 				crypto_free_shash(peer_device->connection->verify_tfm);
 				peer_device->connection->verify_tfm = verify_tfm;
 				drbd_info(device, "using verify-alg: \"%s\"\n", p->verify_alg);
 			}
 			if (csums_tfm) {
-				strcpy(new_net_conf->csums_alg, p->csums_alg);
+				strscpy(new_net_conf->csums_alg, p->csums_alg);
 				new_net_conf->csums_alg_len = strlen(p->csums_alg) + 1;
 				crypto_free_shash(peer_device->connection->csums_tfm);
 				peer_device->connection->csums_tfm = csums_tfm;
-- 
2.43.0

