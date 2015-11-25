Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id BED09105619F
	for <drbd-dev@lists.linbit.com>; Wed, 25 Nov 2015 11:54:30 +0100 (CET)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jens Axboe <axboe@fb.com>,
	linux-kernel@vger.kernel.org
Date: Wed, 25 Nov 2015 11:53:44 +0100
Message-Id: <1448448851-10343-12-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1448448851-10343-1-git-send-email-philipp.reisner@linbit.com>
References: <1448448851-10343-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 11/38] drbd: Replace 0 with the more meaningful
	GFP_NOWAIT
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

GFP_NOWAIT has a value of 0. I.e. functionality not changed.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_nl.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index b87fb31..af78f09 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -4289,7 +4289,7 @@ void drbd_bcast_event(struct drbd_device *device, const struct sib_info *sib)
 	if (nla_put_status_info(msg, device, sib))
 		goto nla_put_failure;
 	genlmsg_end(msg, d_out);
-	err = drbd_genl_multicast_events(msg, 0);
+	err = drbd_genl_multicast_events(msg, GFP_NOWAIT);
 	/* msg has been consumed or freed in netlink_broadcast() */
 	if (err && err != -ESRCH)
 		goto failed;
@@ -4351,7 +4351,7 @@ void notify_resource_state(struct sk_buff *skb,
 		goto nla_put_failure;
 	genlmsg_end(skb, dh);
 	if (multicast) {
-		err = drbd_genl_multicast_events(skb, 0);
+		err = drbd_genl_multicast_events(skb, GFP_NOWAIT);
 		/* skb has been consumed or freed in netlink_broadcast() */
 		if (err && err != -ESRCH)
 			goto failed;
@@ -4400,7 +4400,7 @@ void notify_device_state(struct sk_buff *skb,
 	device_statistics_to_skb(skb, &device_statistics, !capable(CAP_SYS_ADMIN));
 	genlmsg_end(skb, dh);
 	if (multicast) {
-		err = drbd_genl_multicast_events(skb, 0);
+		err = drbd_genl_multicast_events(skb, GFP_NOWAIT);
 		/* skb has been consumed or freed in netlink_broadcast() */
 		if (err && err != -ESRCH)
 			goto failed;
@@ -4449,7 +4449,7 @@ void notify_connection_state(struct sk_buff *skb,
 	connection_statistics_to_skb(skb, &connection_statistics, !capable(CAP_SYS_ADMIN));
 	genlmsg_end(skb, dh);
 	if (multicast) {
-		err = drbd_genl_multicast_events(skb, 0);
+		err = drbd_genl_multicast_events(skb, GFP_NOWAIT);
 		/* skb has been consumed or freed in netlink_broadcast() */
 		if (err && err != -ESRCH)
 			goto failed;
@@ -4499,7 +4499,7 @@ void notify_peer_device_state(struct sk_buff *skb,
 	peer_device_statistics_to_skb(skb, &peer_device_statistics, !capable(CAP_SYS_ADMIN));
 	genlmsg_end(skb, dh);
 	if (multicast) {
-		err = drbd_genl_multicast_events(skb, 0);
+		err = drbd_genl_multicast_events(skb, GFP_NOWAIT);
 		/* skb has been consumed or freed in netlink_broadcast() */
 		if (err && err != -ESRCH)
 			goto failed;
@@ -4545,7 +4545,7 @@ void notify_helper(enum drbd_notification_type type,
 	    drbd_helper_info_to_skb(skb, &helper_info, true))
 		goto unlock_fail;
 	genlmsg_end(skb, dh);
-	err = drbd_genl_multicast_events(skb, 0);
+	err = drbd_genl_multicast_events(skb, GFP_NOWAIT);
 	skb = NULL;
 	/* skb has been consumed or freed in netlink_broadcast() */
 	if (err && err != -ESRCH)
-- 
1.9.1

