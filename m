Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id C0C39105644A
	for <drbd-dev@lists.linbit.com>; Tue, 26 Apr 2016 14:36:05 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id BCA183E9716
	for <drbd-dev@lists.linbit.com>; Tue, 26 Apr 2016 14:36:05 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id VF4pVW5KrLkn for <drbd-dev@lists.linbit.com>;
	Tue, 26 Apr 2016 14:36:05 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 39D2F3EFFDD
	for <drbd-dev@lists.linbit.com>; Tue, 26 Apr 2016 14:36:05 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id YQyHe3yWO5ld for <drbd-dev@lists.linbit.com>;
	Tue, 26 Apr 2016 14:36:05 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 4E08E3EFFFB
	for <drbd-dev@lists.linbit.com>; Tue, 26 Apr 2016 14:36:04 +0200 (CEST)
Resent-Message-ID: <20160426123603.GG20950@soda.linbit>
Received: from proxy.6wind.com (host.76.145.23.62.rev.coltfrance.com
	[62.23.145.76])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id E6E921056447
	for <drbd-dev@lists.linbit.com>; Tue, 26 Apr 2016 10:12:12 +0200 (CEST)
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
To: netdev@vger.kernel.org
Date: Tue, 26 Apr 2016 10:06:13 +0200
Message-Id: <1461657978-13360-4-git-send-email-nicolas.dichtel@6wind.com>
In-Reply-To: <1461657978-13360-1-git-send-email-nicolas.dichtel@6wind.com>
References: <1461657978-13360-1-git-send-email-nicolas.dichtel@6wind.com>
Cc: dev@openvswitch.org, Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	sd@queasysnail.net, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, jhs@mojatatu.com,
	pshelar@nicira.com, lars.ellenberg@linbit.com, jack@suse.com,
	johannes@sipsolutions.net, philipp.reisner@linbit.com,
	davem@davemloft.net, kvalo@codeaurora.org, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH net-next 3/8] fs/quota: use nla_put_u64_64bit()
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

Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
---
 fs/quota/netlink.c         | 12 +++++++-----
 include/uapi/linux/quota.h |  1 +
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/fs/quota/netlink.c b/fs/quota/netlink.c
index d07a2f91d858..8b252673d454 100644
--- a/fs/quota/netlink.c
+++ b/fs/quota/netlink.c
@@ -47,7 +47,7 @@ void quota_send_warning(struct kqid qid, dev_t dev,
 	void *msg_head;
 	int ret;
 	int msg_size = 4 * nla_total_size(sizeof(u32)) +
-		       2 * nla_total_size(sizeof(u64));
+		       2 * nla_total_size_64bit(sizeof(u64));
 
 	/* We have to allocate using GFP_NOFS as we are called from a
 	 * filesystem performing write and thus further recursion into
@@ -68,8 +68,9 @@ void quota_send_warning(struct kqid qid, dev_t dev,
 	ret = nla_put_u32(skb, QUOTA_NL_A_QTYPE, qid.type);
 	if (ret)
 		goto attr_err_out;
-	ret = nla_put_u64(skb, QUOTA_NL_A_EXCESS_ID,
-			  from_kqid_munged(&init_user_ns, qid));
+	ret = nla_put_u64_64bit(skb, QUOTA_NL_A_EXCESS_ID,
+				from_kqid_munged(&init_user_ns, qid),
+				QUOTA_NL_A_PAD);
 	if (ret)
 		goto attr_err_out;
 	ret = nla_put_u32(skb, QUOTA_NL_A_WARNING, warntype);
@@ -81,8 +82,9 @@ void quota_send_warning(struct kqid qid, dev_t dev,
 	ret = nla_put_u32(skb, QUOTA_NL_A_DEV_MINOR, MINOR(dev));
 	if (ret)
 		goto attr_err_out;
-	ret = nla_put_u64(skb, QUOTA_NL_A_CAUSED_ID,
-			  from_kuid_munged(&init_user_ns, current_uid()));
+	ret = nla_put_u64_64bit(skb, QUOTA_NL_A_CAUSED_ID,
+				from_kuid_munged(&init_user_ns, current_uid()),
+				QUOTA_NL_A_PAD);
 	if (ret)
 		goto attr_err_out;
 	genlmsg_end(skb, msg_head);
diff --git a/include/uapi/linux/quota.h b/include/uapi/linux/quota.h
index 38baddb807f5..4d2489ef6f10 100644
--- a/include/uapi/linux/quota.h
+++ b/include/uapi/linux/quota.h
@@ -191,6 +191,7 @@ enum {
 	QUOTA_NL_A_DEV_MAJOR,
 	QUOTA_NL_A_DEV_MINOR,
 	QUOTA_NL_A_CAUSED_ID,
+	QUOTA_NL_A_PAD,
 	__QUOTA_NL_A_MAX,
 };
 #define QUOTA_NL_A_MAX (__QUOTA_NL_A_MAX - 1)
-- 
2.8.1

