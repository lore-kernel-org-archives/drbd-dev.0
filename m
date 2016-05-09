Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 4DB7A1056332
	for <drbd-dev@lists.linbit.com>; Mon,  9 May 2016 15:21:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 3DBCE2B99D8
	for <drbd-dev@lists.linbit.com>; Mon,  9 May 2016 15:21:31 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id WYPLWoCDZYy9 for <drbd-dev@lists.linbit.com>;
	Mon,  9 May 2016 15:21:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 1666E2A12AA
	for <drbd-dev@lists.linbit.com>; Mon,  9 May 2016 15:21:31 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id g5LCp8kfHrwW for <drbd-dev@lists.linbit.com>;
	Mon,  9 May 2016 15:21:31 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id E26012B99D8
	for <drbd-dev@lists.linbit.com>; Mon,  9 May 2016 15:21:30 +0200 (CEST)
Resent-Message-ID: <20160509132130.GY16459@soda.linbit>
Received: from proxy.6wind.com (host.76.145.23.62.rev.coltfrance.com
	[62.23.145.76])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id C5AB41056445
	for <drbd-dev@lists.linbit.com>; Mon,  9 May 2016 11:40:45 +0200 (CEST)
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
To: davem@davemloft.net,
	lars.ellenberg@linbit.com
Date: Mon,  9 May 2016 11:40:20 +0200
Message-Id: <1462786820-15519-1-git-send-email-nicolas.dichtel@6wind.com>
In-Reply-To: <20160503100644.GE16459@soda.linbit>
References: <20160503100644.GE16459@soda.linbit>
Cc: netdev@vger.kernel.org, Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	philipp.reisner@linbit.com, linux-kernel@vger.kernel.org,
	drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH net-next v3] block/drbd: align properly u64 in nl
	messages
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

The attribute 0 is never used in drbd, so let's use it as pad attribute
in netlink messages. This minimizes the patch.

Note that this patch is only compile-tested.

Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---

v2 -> v3:
  use 0 as padattr instead of adding new attributes

v1 -> v2:
 rework the patch to handle all cases

Maybe prefixing genl_magic_func.h and genl_magic_struct.h by 'drbd_'
could be interesting so that new module won't use it. What is your
opinion?

 drivers/block/drbd/drbd_nl.c      | 28 ++++++++++++++++------------
 include/linux/genl_magic_struct.h |  7 ++++++-
 2 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index 1fd1dccebb6b..0bac9c8246bc 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -3633,14 +3633,15 @@ static int nla_put_status_info(struct sk_buff *skb, struct drbd_device *device,
 		goto nla_put_failure;
 	if (nla_put_u32(skb, T_sib_reason, sib ? sib->sib_reason : SIB_GET_STATUS_REPLY) ||
 	    nla_put_u32(skb, T_current_state, device->state.i) ||
-	    nla_put_u64(skb, T_ed_uuid, device->ed_uuid) ||
-	    nla_put_u64(skb, T_capacity, drbd_get_capacity(device->this_bdev)) ||
-	    nla_put_u64(skb, T_send_cnt, device->send_cnt) ||
-	    nla_put_u64(skb, T_recv_cnt, device->recv_cnt) ||
-	    nla_put_u64(skb, T_read_cnt, device->read_cnt) ||
-	    nla_put_u64(skb, T_writ_cnt, device->writ_cnt) ||
-	    nla_put_u64(skb, T_al_writ_cnt, device->al_writ_cnt) ||
-	    nla_put_u64(skb, T_bm_writ_cnt, device->bm_writ_cnt) ||
+	    nla_put_u64_0pad(skb, T_ed_uuid, device->ed_uuid) ||
+	    nla_put_u64_0pad(skb, T_capacity,
+			     drbd_get_capacity(device->this_bdev)) ||
+	    nla_put_u64_0pad(skb, T_send_cnt, device->send_cnt) ||
+	    nla_put_u64_0pad(skb, T_recv_cnt, device->recv_cnt) ||
+	    nla_put_u64_0pad(skb, T_read_cnt, device->read_cnt) ||
+	    nla_put_u64_0pad(skb, T_writ_cnt, device->writ_cnt) ||
+	    nla_put_u64_0pad(skb, T_al_writ_cnt, device->al_writ_cnt) ||
+	    nla_put_u64_0pad(skb, T_bm_writ_cnt, device->bm_writ_cnt) ||
 	    nla_put_u32(skb, T_ap_bio_cnt, atomic_read(&device->ap_bio_cnt)) ||
 	    nla_put_u32(skb, T_ap_pending_cnt, atomic_read(&device->ap_pending_cnt)) ||
 	    nla_put_u32(skb, T_rs_pending_cnt, atomic_read(&device->rs_pending_cnt)))
@@ -3657,13 +3658,16 @@ static int nla_put_status_info(struct sk_buff *skb, struct drbd_device *device,
 			goto nla_put_failure;
 
 		if (nla_put_u32(skb, T_disk_flags, device->ldev->md.flags) ||
-		    nla_put_u64(skb, T_bits_total, drbd_bm_bits(device)) ||
-		    nla_put_u64(skb, T_bits_oos, drbd_bm_total_weight(device)))
+		    nla_put_u64_0pad(skb, T_bits_total, drbd_bm_bits(device)) ||
+		    nla_put_u64_0pad(skb, T_bits_oos,
+				     drbd_bm_total_weight(device)))
 			goto nla_put_failure;
 		if (C_SYNC_SOURCE <= device->state.conn &&
 		    C_PAUSED_SYNC_T >= device->state.conn) {
-			if (nla_put_u64(skb, T_bits_rs_total, device->rs_total) ||
-			    nla_put_u64(skb, T_bits_rs_failed, device->rs_failed))
+			if (nla_put_u64_0pad(skb, T_bits_rs_total,
+					     device->rs_total) ||
+			    nla_put_u64_0pad(skb, T_bits_rs_failed,
+					     device->rs_failed))
 				goto nla_put_failure;
 		}
 	}
diff --git a/include/linux/genl_magic_struct.h b/include/linux/genl_magic_struct.h
index eecd19b37001..6270a56e5edc 100644
--- a/include/linux/genl_magic_struct.h
+++ b/include/linux/genl_magic_struct.h
@@ -62,6 +62,11 @@ extern void CONCAT_(GENL_MAGIC_FAMILY, _genl_unregister)(void);
 
 /* MAGIC helpers							{{{2 */
 
+static inline int nla_put_u64_0pad(struct sk_buff *skb, int attrtype, u64 value)
+{
+	return nla_put_64bit(skb, attrtype, sizeof(u64), &value, 0);
+}
+
 /* possible field types */
 #define __flg_field(attr_nr, attr_flag, name) \
 	__field(attr_nr, attr_flag, name, NLA_U8, char, \
@@ -80,7 +85,7 @@ extern void CONCAT_(GENL_MAGIC_FAMILY, _genl_unregister)(void);
 			nla_get_u32, nla_put_u32, true)
 #define __u64_field(attr_nr, attr_flag, name)	\
 	__field(attr_nr, attr_flag, name, NLA_U64, __u64, \
-			nla_get_u64, nla_put_u64, false)
+			nla_get_u64, nla_put_u64_0pad, false)
 #define __str_field(attr_nr, attr_flag, name, maxlen) \
 	__array(attr_nr, attr_flag, name, NLA_NUL_STRING, char, maxlen, \
 			nla_strlcpy, nla_put, false)
-- 
2.8.1

