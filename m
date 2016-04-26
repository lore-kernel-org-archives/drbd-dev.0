Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 2BA991056448
	for <drbd-dev@lists.linbit.com>; Tue, 26 Apr 2016 14:36:05 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 0AE053E9716
	for <drbd-dev@lists.linbit.com>; Tue, 26 Apr 2016 14:36:04 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id Fq3X2ljWrUxs for <drbd-dev@lists.linbit.com>;
	Tue, 26 Apr 2016 14:36:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id DDDF03F79B5
	for <drbd-dev@lists.linbit.com>; Tue, 26 Apr 2016 14:36:03 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id oKaD7aDyic9V for <drbd-dev@lists.linbit.com>;
	Tue, 26 Apr 2016 14:36:03 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id A899C3EFFFB
	for <drbd-dev@lists.linbit.com>; Tue, 26 Apr 2016 14:36:03 +0200 (CEST)
Resent-Message-ID: <20160426123603.GF20950@soda.linbit>
Received: from proxy.6wind.com (host.76.145.23.62.rev.coltfrance.com
	[62.23.145.76])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 7C2041056446
	for <drbd-dev@lists.linbit.com>; Tue, 26 Apr 2016 10:12:12 +0200 (CEST)
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
To: netdev@vger.kernel.org
Date: Tue, 26 Apr 2016 10:06:18 +0200
Message-Id: <1461657978-13360-9-git-send-email-nicolas.dichtel@6wind.com>
In-Reply-To: <1461657978-13360-1-git-send-email-nicolas.dichtel@6wind.com>
References: <1461657978-13360-1-git-send-email-nicolas.dichtel@6wind.com>
Cc: dev@openvswitch.org, Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	sd@queasysnail.net, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, jhs@mojatatu.com,
	pshelar@nicira.com, lars.ellenberg@linbit.com, jack@suse.com,
	johannes@sipsolutions.net, philipp.reisner@linbit.com,
	davem@davemloft.net, kvalo@codeaurora.org, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH net-next 8/8] sched: align nlattr properly when
	needed
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
 Documentation/networking/gen_stats.txt  |  6 ++++--
 include/net/gen_stats.h                 |  6 ++++--
 include/uapi/linux/gen_stats.h          |  1 +
 include/uapi/linux/pkt_cls.h            |  2 ++
 include/uapi/linux/rtnetlink.h          |  1 +
 include/uapi/linux/tc_act/tc_bpf.h      |  1 +
 include/uapi/linux/tc_act/tc_connmark.h |  1 +
 include/uapi/linux/tc_act/tc_csum.h     |  1 +
 include/uapi/linux/tc_act/tc_defact.h   |  1 +
 include/uapi/linux/tc_act/tc_gact.h     |  1 +
 include/uapi/linux/tc_act/tc_ife.h      |  1 +
 include/uapi/linux/tc_act/tc_ipt.h      |  1 +
 include/uapi/linux/tc_act/tc_mirred.h   |  1 +
 include/uapi/linux/tc_act/tc_nat.h      |  1 +
 include/uapi/linux/tc_act/tc_pedit.h    |  1 +
 include/uapi/linux/tc_act/tc_skbedit.h  |  1 +
 include/uapi/linux/tc_act/tc_vlan.h     |  1 +
 net/core/gen_stats.c                    | 35 ++++++++++++++++++++-------------
 net/sched/act_api.c                     |  7 +++++--
 net/sched/act_bpf.c                     |  3 ++-
 net/sched/act_connmark.c                |  3 ++-
 net/sched/act_csum.c                    |  2 +-
 net/sched/act_gact.c                    |  2 +-
 net/sched/act_ife.c                     |  2 +-
 net/sched/act_ipt.c                     |  2 +-
 net/sched/act_mirred.c                  |  2 +-
 net/sched/act_nat.c                     |  2 +-
 net/sched/act_pedit.c                   |  2 +-
 net/sched/act_simple.c                  |  2 +-
 net/sched/act_skbedit.c                 |  2 +-
 net/sched/act_vlan.c                    |  2 +-
 net/sched/cls_u32.c                     |  7 ++++---
 net/sched/sch_api.c                     |  6 ++++--
 33 files changed, 72 insertions(+), 37 deletions(-)

diff --git a/Documentation/networking/gen_stats.txt b/Documentation/networking/gen_stats.txt
index 70e6275b757a..ff630a87b511 100644
--- a/Documentation/networking/gen_stats.txt
+++ b/Documentation/networking/gen_stats.txt
@@ -33,7 +33,8 @@ my_dumping_routine(struct sk_buff *skb, ...)
 {
 	struct gnet_dump dump;
 
-	if (gnet_stats_start_copy(skb, TCA_STATS2, &mystruct->lock, &dump) < 0)
+	if (gnet_stats_start_copy(skb, TCA_STATS2, &mystruct->lock, &dump,
+				  TCA_PAD) < 0)
 		goto rtattr_failure;
 
 	if (gnet_stats_copy_basic(&dump, &mystruct->bstats) < 0 ||
@@ -56,7 +57,8 @@ existing TLV types.
 my_dumping_routine(struct sk_buff *skb, ...)
 {
     if (gnet_stats_start_copy_compat(skb, TCA_STATS2, TCA_STATS,
-		TCA_XSTATS, &mystruct->lock, &dump) < 0)
+				     TCA_XSTATS, &mystruct->lock, &dump,
+				     TCA_PAD) < 0)
 		goto rtattr_failure;
 	...
 }
diff --git a/include/net/gen_stats.h b/include/net/gen_stats.h
index cbafa3768d48..610cd397890e 100644
--- a/include/net/gen_stats.h
+++ b/include/net/gen_stats.h
@@ -19,17 +19,19 @@ struct gnet_dump {
 	/* Backward compatibility */
 	int               compat_tc_stats;
 	int               compat_xstats;
+	int               padattr;
 	void *            xstats;
 	int               xstats_len;
 	struct tc_stats   tc_stats;
 };
 
 int gnet_stats_start_copy(struct sk_buff *skb, int type, spinlock_t *lock,
-			  struct gnet_dump *d);
+			  struct gnet_dump *d, int padattr);
 
 int gnet_stats_start_copy_compat(struct sk_buff *skb, int type,
 				 int tc_stats_type, int xstats_type,
-				 spinlock_t *lock, struct gnet_dump *d);
+				 spinlock_t *lock, struct gnet_dump *d,
+				 int padattr);
 
 int gnet_stats_copy_basic(struct gnet_dump *d,
 			  struct gnet_stats_basic_cpu __percpu *cpu,
diff --git a/include/uapi/linux/gen_stats.h b/include/uapi/linux/gen_stats.h
index 6487317ea619..52deccc2128e 100644
--- a/include/uapi/linux/gen_stats.h
+++ b/include/uapi/linux/gen_stats.h
@@ -10,6 +10,7 @@ enum {
 	TCA_STATS_QUEUE,
 	TCA_STATS_APP,
 	TCA_STATS_RATE_EST64,
+	TCA_STATS_PAD,
 	__TCA_STATS_MAX,
 };
 #define TCA_STATS_MAX (__TCA_STATS_MAX - 1)
diff --git a/include/uapi/linux/pkt_cls.h b/include/uapi/linux/pkt_cls.h
index c43c5f78b9c4..84660905fedf 100644
--- a/include/uapi/linux/pkt_cls.h
+++ b/include/uapi/linux/pkt_cls.h
@@ -66,6 +66,7 @@ enum {
 	TCA_ACT_OPTIONS,
 	TCA_ACT_INDEX,
 	TCA_ACT_STATS,
+	TCA_ACT_PAD,
 	__TCA_ACT_MAX
 };
 
@@ -173,6 +174,7 @@ enum {
 	TCA_U32_PCNT,
 	TCA_U32_MARK,
 	TCA_U32_FLAGS,
+	TCA_U32_PAD,
 	__TCA_U32_MAX
 };
 
diff --git a/include/uapi/linux/rtnetlink.h b/include/uapi/linux/rtnetlink.h
index a94e0b69c769..262f0379d83a 100644
--- a/include/uapi/linux/rtnetlink.h
+++ b/include/uapi/linux/rtnetlink.h
@@ -542,6 +542,7 @@ enum {
 	TCA_FCNT,
 	TCA_STATS2,
 	TCA_STAB,
+	TCA_PAD,
 	__TCA_MAX
 };
 
diff --git a/include/uapi/linux/tc_act/tc_bpf.h b/include/uapi/linux/tc_act/tc_bpf.h
index 07f17cc70bb3..063d9d465119 100644
--- a/include/uapi/linux/tc_act/tc_bpf.h
+++ b/include/uapi/linux/tc_act/tc_bpf.h
@@ -26,6 +26,7 @@ enum {
 	TCA_ACT_BPF_OPS,
 	TCA_ACT_BPF_FD,
 	TCA_ACT_BPF_NAME,
+	TCA_ACT_BPF_PAD,
 	__TCA_ACT_BPF_MAX,
 };
 #define TCA_ACT_BPF_MAX (__TCA_ACT_BPF_MAX - 1)
diff --git a/include/uapi/linux/tc_act/tc_connmark.h b/include/uapi/linux/tc_act/tc_connmark.h
index 994b0971bce2..62a5e944c554 100644
--- a/include/uapi/linux/tc_act/tc_connmark.h
+++ b/include/uapi/linux/tc_act/tc_connmark.h
@@ -15,6 +15,7 @@ enum {
 	TCA_CONNMARK_UNSPEC,
 	TCA_CONNMARK_PARMS,
 	TCA_CONNMARK_TM,
+	TCA_CONNMARK_PAD,
 	__TCA_CONNMARK_MAX
 };
 #define TCA_CONNMARK_MAX (__TCA_CONNMARK_MAX - 1)
diff --git a/include/uapi/linux/tc_act/tc_csum.h b/include/uapi/linux/tc_act/tc_csum.h
index a047c49a3153..8ac8041ab5f1 100644
--- a/include/uapi/linux/tc_act/tc_csum.h
+++ b/include/uapi/linux/tc_act/tc_csum.h
@@ -10,6 +10,7 @@ enum {
 	TCA_CSUM_UNSPEC,
 	TCA_CSUM_PARMS,
 	TCA_CSUM_TM,
+	TCA_CSUM_PAD,
 	__TCA_CSUM_MAX
 };
 #define TCA_CSUM_MAX (__TCA_CSUM_MAX - 1)
diff --git a/include/uapi/linux/tc_act/tc_defact.h b/include/uapi/linux/tc_act/tc_defact.h
index 17dddb40f740..d2a3abb77aeb 100644
--- a/include/uapi/linux/tc_act/tc_defact.h
+++ b/include/uapi/linux/tc_act/tc_defact.h
@@ -12,6 +12,7 @@ enum {
 	TCA_DEF_TM,
 	TCA_DEF_PARMS,
 	TCA_DEF_DATA,
+	TCA_DEF_PAD,
 	__TCA_DEF_MAX
 };
 #define TCA_DEF_MAX (__TCA_DEF_MAX - 1)
diff --git a/include/uapi/linux/tc_act/tc_gact.h b/include/uapi/linux/tc_act/tc_gact.h
index f7bf94eed510..70b536a8f8b2 100644
--- a/include/uapi/linux/tc_act/tc_gact.h
+++ b/include/uapi/linux/tc_act/tc_gact.h
@@ -25,6 +25,7 @@ enum {
 	TCA_GACT_TM,
 	TCA_GACT_PARMS,
 	TCA_GACT_PROB,
+	TCA_GACT_PAD,
 	__TCA_GACT_MAX
 };
 #define TCA_GACT_MAX (__TCA_GACT_MAX - 1)
diff --git a/include/uapi/linux/tc_act/tc_ife.h b/include/uapi/linux/tc_act/tc_ife.h
index d648ff66586f..4ece02a77b9a 100644
--- a/include/uapi/linux/tc_act/tc_ife.h
+++ b/include/uapi/linux/tc_act/tc_ife.h
@@ -23,6 +23,7 @@ enum {
 	TCA_IFE_SMAC,
 	TCA_IFE_TYPE,
 	TCA_IFE_METALST,
+	TCA_IFE_PAD,
 	__TCA_IFE_MAX
 };
 #define TCA_IFE_MAX (__TCA_IFE_MAX - 1)
diff --git a/include/uapi/linux/tc_act/tc_ipt.h b/include/uapi/linux/tc_act/tc_ipt.h
index 130aaadf6fac..7c6e155dd981 100644
--- a/include/uapi/linux/tc_act/tc_ipt.h
+++ b/include/uapi/linux/tc_act/tc_ipt.h
@@ -14,6 +14,7 @@ enum {
 	TCA_IPT_CNT,
 	TCA_IPT_TM,
 	TCA_IPT_TARG,
+	TCA_IPT_PAD,
 	__TCA_IPT_MAX
 };
 #define TCA_IPT_MAX (__TCA_IPT_MAX - 1)
diff --git a/include/uapi/linux/tc_act/tc_mirred.h b/include/uapi/linux/tc_act/tc_mirred.h
index 7561750e8fd6..3d7a2b352a62 100644
--- a/include/uapi/linux/tc_act/tc_mirred.h
+++ b/include/uapi/linux/tc_act/tc_mirred.h
@@ -20,6 +20,7 @@ enum {
 	TCA_MIRRED_UNSPEC,
 	TCA_MIRRED_TM,
 	TCA_MIRRED_PARMS,
+	TCA_MIRRED_PAD,
 	__TCA_MIRRED_MAX
 };
 #define TCA_MIRRED_MAX (__TCA_MIRRED_MAX - 1)
diff --git a/include/uapi/linux/tc_act/tc_nat.h b/include/uapi/linux/tc_act/tc_nat.h
index 6663aeba0b9a..923457c9ebf0 100644
--- a/include/uapi/linux/tc_act/tc_nat.h
+++ b/include/uapi/linux/tc_act/tc_nat.h
@@ -10,6 +10,7 @@ enum {
 	TCA_NAT_UNSPEC,
 	TCA_NAT_PARMS,
 	TCA_NAT_TM,
+	TCA_NAT_PAD,
 	__TCA_NAT_MAX
 };
 #define TCA_NAT_MAX (__TCA_NAT_MAX - 1)
diff --git a/include/uapi/linux/tc_act/tc_pedit.h b/include/uapi/linux/tc_act/tc_pedit.h
index 716cfabcd5b2..6389959a5157 100644
--- a/include/uapi/linux/tc_act/tc_pedit.h
+++ b/include/uapi/linux/tc_act/tc_pedit.h
@@ -10,6 +10,7 @@ enum {
 	TCA_PEDIT_UNSPEC,
 	TCA_PEDIT_TM,
 	TCA_PEDIT_PARMS,
+	TCA_PEDIT_PAD,
 	__TCA_PEDIT_MAX
 };
 #define TCA_PEDIT_MAX (__TCA_PEDIT_MAX - 1)
diff --git a/include/uapi/linux/tc_act/tc_skbedit.h b/include/uapi/linux/tc_act/tc_skbedit.h
index 7a2e910a5f08..fecb5cc48c40 100644
--- a/include/uapi/linux/tc_act/tc_skbedit.h
+++ b/include/uapi/linux/tc_act/tc_skbedit.h
@@ -39,6 +39,7 @@ enum {
 	TCA_SKBEDIT_PRIORITY,
 	TCA_SKBEDIT_QUEUE_MAPPING,
 	TCA_SKBEDIT_MARK,
+	TCA_SKBEDIT_PAD,
 	__TCA_SKBEDIT_MAX
 };
 #define TCA_SKBEDIT_MAX (__TCA_SKBEDIT_MAX - 1)
diff --git a/include/uapi/linux/tc_act/tc_vlan.h b/include/uapi/linux/tc_act/tc_vlan.h
index f7b8d448b960..31151ff6264f 100644
--- a/include/uapi/linux/tc_act/tc_vlan.h
+++ b/include/uapi/linux/tc_act/tc_vlan.h
@@ -28,6 +28,7 @@ enum {
 	TCA_VLAN_PARMS,
 	TCA_VLAN_PUSH_VLAN_ID,
 	TCA_VLAN_PUSH_VLAN_PROTOCOL,
+	TCA_VLAN_PAD,
 	__TCA_VLAN_MAX,
 };
 #define TCA_VLAN_MAX (__TCA_VLAN_MAX - 1)
diff --git a/net/core/gen_stats.c b/net/core/gen_stats.c
index e640462ea8bf..f96ee8b9478d 100644
--- a/net/core/gen_stats.c
+++ b/net/core/gen_stats.c
@@ -25,9 +25,9 @@
 
 
 static inline int
-gnet_stats_copy(struct gnet_dump *d, int type, void *buf, int size)
+gnet_stats_copy(struct gnet_dump *d, int type, void *buf, int size, int padattr)
 {
-	if (nla_put(d->skb, type, size, buf))
+	if (nla_put_64bit(d->skb, type, size, buf, padattr))
 		goto nla_put_failure;
 	return 0;
 
@@ -59,7 +59,8 @@ nla_put_failure:
  */
 int
 gnet_stats_start_copy_compat(struct sk_buff *skb, int type, int tc_stats_type,
-	int xstats_type, spinlock_t *lock, struct gnet_dump *d)
+			     int xstats_type, spinlock_t *lock,
+			     struct gnet_dump *d, int padattr)
 	__acquires(lock)
 {
 	memset(d, 0, sizeof(*d));
@@ -71,16 +72,17 @@ gnet_stats_start_copy_compat(struct sk_buff *skb, int type, int tc_stats_type,
 	d->skb = skb;
 	d->compat_tc_stats = tc_stats_type;
 	d->compat_xstats = xstats_type;
+	d->padattr = padattr;
 
 	if (d->tail)
-		return gnet_stats_copy(d, type, NULL, 0);
+		return gnet_stats_copy(d, type, NULL, 0, padattr);
 
 	return 0;
 }
 EXPORT_SYMBOL(gnet_stats_start_copy_compat);
 
 /**
- * gnet_stats_start_copy_compat - start dumping procedure in compatibility mode
+ * gnet_stats_start_copy - start dumping procedure in compatibility mode
  * @skb: socket buffer to put statistics TLVs into
  * @type: TLV type for top level statistic TLV
  * @lock: statistics lock
@@ -94,9 +96,9 @@ EXPORT_SYMBOL(gnet_stats_start_copy_compat);
  */
 int
 gnet_stats_start_copy(struct sk_buff *skb, int type, spinlock_t *lock,
-	struct gnet_dump *d)
+		      struct gnet_dump *d, int padattr)
 {
-	return gnet_stats_start_copy_compat(skb, type, 0, 0, lock, d);
+	return gnet_stats_start_copy_compat(skb, type, 0, 0, lock, d, padattr);
 }
 EXPORT_SYMBOL(gnet_stats_start_copy);
 
@@ -169,7 +171,8 @@ gnet_stats_copy_basic(struct gnet_dump *d,
 		memset(&sb, 0, sizeof(sb));
 		sb.bytes = bstats.bytes;
 		sb.packets = bstats.packets;
-		return gnet_stats_copy(d, TCA_STATS_BASIC, &sb, sizeof(sb));
+		return gnet_stats_copy(d, TCA_STATS_BASIC, &sb, sizeof(sb),
+				       TCA_STATS_PAD);
 	}
 	return 0;
 }
@@ -208,11 +211,13 @@ gnet_stats_copy_rate_est(struct gnet_dump *d,
 	}
 
 	if (d->tail) {
-		res = gnet_stats_copy(d, TCA_STATS_RATE_EST, &est, sizeof(est));
+		res = gnet_stats_copy(d, TCA_STATS_RATE_EST, &est, sizeof(est),
+				      TCA_STATS_PAD);
 		if (res < 0 || est.bps == r->bps)
 			return res;
 		/* emit 64bit stats only if needed */
-		return gnet_stats_copy(d, TCA_STATS_RATE_EST64, r, sizeof(*r));
+		return gnet_stats_copy(d, TCA_STATS_RATE_EST64, r, sizeof(*r),
+				       TCA_STATS_PAD);
 	}
 
 	return 0;
@@ -286,7 +291,8 @@ gnet_stats_copy_queue(struct gnet_dump *d,
 
 	if (d->tail)
 		return gnet_stats_copy(d, TCA_STATS_QUEUE,
-				       &qstats, sizeof(qstats));
+				       &qstats, sizeof(qstats),
+				       TCA_STATS_PAD);
 
 	return 0;
 }
@@ -316,7 +322,8 @@ gnet_stats_copy_app(struct gnet_dump *d, void *st, int len)
 	}
 
 	if (d->tail)
-		return gnet_stats_copy(d, TCA_STATS_APP, st, len);
+		return gnet_stats_copy(d, TCA_STATS_APP, st, len,
+				       TCA_STATS_PAD);
 
 	return 0;
 
@@ -347,12 +354,12 @@ gnet_stats_finish_copy(struct gnet_dump *d)
 
 	if (d->compat_tc_stats)
 		if (gnet_stats_copy(d, d->compat_tc_stats, &d->tc_stats,
-			sizeof(d->tc_stats)) < 0)
+				    sizeof(d->tc_stats), d->padattr) < 0)
 			return -1;
 
 	if (d->compat_xstats && d->xstats) {
 		if (gnet_stats_copy(d, d->compat_xstats, d->xstats,
-			d->xstats_len) < 0)
+				    d->xstats_len, d->padattr) < 0)
 			return -1;
 	}
 
diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index 96066665e376..336774a535c3 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -657,12 +657,15 @@ int tcf_action_copy_stats(struct sk_buff *skb, struct tc_action *a,
 	if (compat_mode) {
 		if (a->type == TCA_OLD_COMPAT)
 			err = gnet_stats_start_copy_compat(skb, 0,
-				TCA_STATS, TCA_XSTATS, &p->tcfc_lock, &d);
+							   TCA_STATS,
+							   TCA_XSTATS,
+							   &p->tcfc_lock, &d,
+							   TCA_PAD);
 		else
 			return 0;
 	} else
 		err = gnet_stats_start_copy(skb, TCA_ACT_STATS,
-					    &p->tcfc_lock, &d);
+					    &p->tcfc_lock, &d, TCA_ACT_PAD);
 
 	if (err < 0)
 		goto errout;
diff --git a/net/sched/act_bpf.c b/net/sched/act_bpf.c
index 8c9f1f0459ab..4fd703362563 100644
--- a/net/sched/act_bpf.c
+++ b/net/sched/act_bpf.c
@@ -156,7 +156,8 @@ static int tcf_bpf_dump(struct sk_buff *skb, struct tc_action *act,
 	tm.lastuse = jiffies_to_clock_t(jiffies - prog->tcf_tm.lastuse);
 	tm.expires = jiffies_to_clock_t(prog->tcf_tm.expires);
 
-	if (nla_put(skb, TCA_ACT_BPF_TM, sizeof(tm), &tm))
+	if (nla_put_64bit(skb, TCA_ACT_BPF_TM, sizeof(tm), &tm,
+			  TCA_ACT_BPF_PAD))
 		goto nla_put_failure;
 
 	return skb->len;
diff --git a/net/sched/act_connmark.c b/net/sched/act_connmark.c
index c0ed93ce2391..2ba700c765e0 100644
--- a/net/sched/act_connmark.c
+++ b/net/sched/act_connmark.c
@@ -163,7 +163,8 @@ static inline int tcf_connmark_dump(struct sk_buff *skb, struct tc_action *a,
 	t.install = jiffies_to_clock_t(jiffies - ci->tcf_tm.install);
 	t.lastuse = jiffies_to_clock_t(jiffies - ci->tcf_tm.lastuse);
 	t.expires = jiffies_to_clock_t(ci->tcf_tm.expires);
-	if (nla_put(skb, TCA_CONNMARK_TM, sizeof(t), &t))
+	if (nla_put_64bit(skb, TCA_CONNMARK_TM, sizeof(t), &t,
+			  TCA_CONNMARK_PAD))
 		goto nla_put_failure;
 
 	return skb->len;
diff --git a/net/sched/act_csum.c b/net/sched/act_csum.c
index d22426cdebc0..28e934ed038a 100644
--- a/net/sched/act_csum.c
+++ b/net/sched/act_csum.c
@@ -549,7 +549,7 @@ static int tcf_csum_dump(struct sk_buff *skb,
 	t.install = jiffies_to_clock_t(jiffies - p->tcf_tm.install);
 	t.lastuse = jiffies_to_clock_t(jiffies - p->tcf_tm.lastuse);
 	t.expires = jiffies_to_clock_t(p->tcf_tm.expires);
-	if (nla_put(skb, TCA_CSUM_TM, sizeof(t), &t))
+	if (nla_put_64bit(skb, TCA_CSUM_TM, sizeof(t), &t, TCA_CSUM_PAD))
 		goto nla_put_failure;
 
 	return skb->len;
diff --git a/net/sched/act_gact.c b/net/sched/act_gact.c
index 887fc1f209ff..1a6e09fbb2a5 100644
--- a/net/sched/act_gact.c
+++ b/net/sched/act_gact.c
@@ -177,7 +177,7 @@ static int tcf_gact_dump(struct sk_buff *skb, struct tc_action *a, int bind, int
 	t.install = jiffies_to_clock_t(jiffies - gact->tcf_tm.install);
 	t.lastuse = jiffies_to_clock_t(jiffies - gact->tcf_tm.lastuse);
 	t.expires = jiffies_to_clock_t(gact->tcf_tm.expires);
-	if (nla_put(skb, TCA_GACT_TM, sizeof(t), &t))
+	if (nla_put_64bit(skb, TCA_GACT_TM, sizeof(t), &t, TCA_GACT_PAD))
 		goto nla_put_failure;
 	return skb->len;
 
diff --git a/net/sched/act_ife.c b/net/sched/act_ife.c
index c589a9ba506a..556f44c9c454 100644
--- a/net/sched/act_ife.c
+++ b/net/sched/act_ife.c
@@ -550,7 +550,7 @@ static int tcf_ife_dump(struct sk_buff *skb, struct tc_action *a, int bind,
 	t.install = jiffies_to_clock_t(jiffies - ife->tcf_tm.install);
 	t.lastuse = jiffies_to_clock_t(jiffies - ife->tcf_tm.lastuse);
 	t.expires = jiffies_to_clock_t(ife->tcf_tm.expires);
-	if (nla_put(skb, TCA_IFE_TM, sizeof(t), &t))
+	if (nla_put_64bit(skb, TCA_IFE_TM, sizeof(t), &t, TCA_IFE_PAD))
 		goto nla_put_failure;
 
 	if (!is_zero_ether_addr(ife->eth_dst)) {
diff --git a/net/sched/act_ipt.c b/net/sched/act_ipt.c
index 350e134cffb3..1464f6a09446 100644
--- a/net/sched/act_ipt.c
+++ b/net/sched/act_ipt.c
@@ -275,7 +275,7 @@ static int tcf_ipt_dump(struct sk_buff *skb, struct tc_action *a, int bind, int
 	tm.install = jiffies_to_clock_t(jiffies - ipt->tcf_tm.install);
 	tm.lastuse = jiffies_to_clock_t(jiffies - ipt->tcf_tm.lastuse);
 	tm.expires = jiffies_to_clock_t(ipt->tcf_tm.expires);
-	if (nla_put(skb, TCA_IPT_TM, sizeof (tm), &tm))
+	if (nla_put_64bit(skb, TCA_IPT_TM, sizeof(tm), &tm, TCA_IPT_PAD))
 		goto nla_put_failure;
 	kfree(t);
 	return skb->len;
diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
index e8a760cf7775..dea57c1ec90c 100644
--- a/net/sched/act_mirred.c
+++ b/net/sched/act_mirred.c
@@ -214,7 +214,7 @@ static int tcf_mirred_dump(struct sk_buff *skb, struct tc_action *a, int bind, i
 	t.install = jiffies_to_clock_t(jiffies - m->tcf_tm.install);
 	t.lastuse = jiffies_to_clock_t(jiffies - m->tcf_tm.lastuse);
 	t.expires = jiffies_to_clock_t(m->tcf_tm.expires);
-	if (nla_put(skb, TCA_MIRRED_TM, sizeof(t), &t))
+	if (nla_put_64bit(skb, TCA_MIRRED_TM, sizeof(t), &t, TCA_MIRRED_PAD))
 		goto nla_put_failure;
 	return skb->len;
 
diff --git a/net/sched/act_nat.c b/net/sched/act_nat.c
index 0f65cdfbfb1d..c0a879f940de 100644
--- a/net/sched/act_nat.c
+++ b/net/sched/act_nat.c
@@ -267,7 +267,7 @@ static int tcf_nat_dump(struct sk_buff *skb, struct tc_action *a,
 	t.install = jiffies_to_clock_t(jiffies - p->tcf_tm.install);
 	t.lastuse = jiffies_to_clock_t(jiffies - p->tcf_tm.lastuse);
 	t.expires = jiffies_to_clock_t(p->tcf_tm.expires);
-	if (nla_put(skb, TCA_NAT_TM, sizeof(t), &t))
+	if (nla_put_64bit(skb, TCA_NAT_TM, sizeof(t), &t, TCA_NAT_PAD))
 		goto nla_put_failure;
 
 	return skb->len;
diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c
index 429c3ab65142..c6e18f230af6 100644
--- a/net/sched/act_pedit.c
+++ b/net/sched/act_pedit.c
@@ -203,7 +203,7 @@ static int tcf_pedit_dump(struct sk_buff *skb, struct tc_action *a,
 	t.install = jiffies_to_clock_t(jiffies - p->tcf_tm.install);
 	t.lastuse = jiffies_to_clock_t(jiffies - p->tcf_tm.lastuse);
 	t.expires = jiffies_to_clock_t(p->tcf_tm.expires);
-	if (nla_put(skb, TCA_PEDIT_TM, sizeof(t), &t))
+	if (nla_put_64bit(skb, TCA_PEDIT_TM, sizeof(t), &t, TCA_PEDIT_PAD))
 		goto nla_put_failure;
 	kfree(opt);
 	return skb->len;
diff --git a/net/sched/act_simple.c b/net/sched/act_simple.c
index 75b2be13fbcc..2057fd56d74c 100644
--- a/net/sched/act_simple.c
+++ b/net/sched/act_simple.c
@@ -155,7 +155,7 @@ static int tcf_simp_dump(struct sk_buff *skb, struct tc_action *a,
 	t.install = jiffies_to_clock_t(jiffies - d->tcf_tm.install);
 	t.lastuse = jiffies_to_clock_t(jiffies - d->tcf_tm.lastuse);
 	t.expires = jiffies_to_clock_t(d->tcf_tm.expires);
-	if (nla_put(skb, TCA_DEF_TM, sizeof(t), &t))
+	if (nla_put_64bit(skb, TCA_DEF_TM, sizeof(t), &t, TCA_DEF_PAD))
 		goto nla_put_failure;
 	return skb->len;
 
diff --git a/net/sched/act_skbedit.c b/net/sched/act_skbedit.c
index cfcdbdc00c9b..51b24998904f 100644
--- a/net/sched/act_skbedit.c
+++ b/net/sched/act_skbedit.c
@@ -167,7 +167,7 @@ static int tcf_skbedit_dump(struct sk_buff *skb, struct tc_action *a,
 	t.install = jiffies_to_clock_t(jiffies - d->tcf_tm.install);
 	t.lastuse = jiffies_to_clock_t(jiffies - d->tcf_tm.lastuse);
 	t.expires = jiffies_to_clock_t(d->tcf_tm.expires);
-	if (nla_put(skb, TCA_SKBEDIT_TM, sizeof(t), &t))
+	if (nla_put_64bit(skb, TCA_SKBEDIT_TM, sizeof(t), &t, TCA_SKBEDIT_PAD))
 		goto nla_put_failure;
 	return skb->len;
 
diff --git a/net/sched/act_vlan.c b/net/sched/act_vlan.c
index bab8ae0cefc0..c1682ab9bc7e 100644
--- a/net/sched/act_vlan.c
+++ b/net/sched/act_vlan.c
@@ -175,7 +175,7 @@ static int tcf_vlan_dump(struct sk_buff *skb, struct tc_action *a,
 	t.install = jiffies_to_clock_t(jiffies - v->tcf_tm.install);
 	t.lastuse = jiffies_to_clock_t(jiffies - v->tcf_tm.lastuse);
 	t.expires = jiffies_to_clock_t(v->tcf_tm.expires);
-	if (nla_put(skb, TCA_VLAN_TM, sizeof(t), &t))
+	if (nla_put_64bit(skb, TCA_VLAN_TM, sizeof(t), &t, TCA_VLAN_PAD))
 		goto nla_put_failure;
 	return skb->len;
 
diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
index 563cdad76448..e64877a3c084 100644
--- a/net/sched/cls_u32.c
+++ b/net/sched/cls_u32.c
@@ -1140,9 +1140,10 @@ static int u32_dump(struct net *net, struct tcf_proto *tp, unsigned long fh,
 				gpf->kcnts[i] += pf->kcnts[i];
 		}
 
-		if (nla_put(skb, TCA_U32_PCNT,
-			    sizeof(struct tc_u32_pcnt) + n->sel.nkeys*sizeof(u64),
-			    gpf)) {
+		if (nla_put_64bit(skb, TCA_U32_PCNT,
+				  sizeof(struct tc_u32_pcnt) +
+				  n->sel.nkeys * sizeof(u64),
+				  gpf, TCA_U32_PAD)) {
 			kfree(gpf);
 			goto nla_put_failure;
 		}
diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index 3b180ff72f79..64f71a2155f3 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -1365,7 +1365,8 @@ static int tc_fill_qdisc(struct sk_buff *skb, struct Qdisc *q, u32 clid,
 		goto nla_put_failure;
 
 	if (gnet_stats_start_copy_compat(skb, TCA_STATS2, TCA_STATS, TCA_XSTATS,
-					 qdisc_root_sleeping_lock(q), &d) < 0)
+					 qdisc_root_sleeping_lock(q), &d,
+					 TCA_PAD) < 0)
 		goto nla_put_failure;
 
 	if (q->ops->dump_stats && q->ops->dump_stats(q, &d) < 0)
@@ -1679,7 +1680,8 @@ static int tc_fill_tclass(struct sk_buff *skb, struct Qdisc *q,
 		goto nla_put_failure;
 
 	if (gnet_stats_start_copy_compat(skb, TCA_STATS2, TCA_STATS, TCA_XSTATS,
-					 qdisc_root_sleeping_lock(q), &d) < 0)
+					 qdisc_root_sleeping_lock(q), &d,
+					 TCA_PAD) < 0)
 		goto nla_put_failure;
 
 	if (cl_ops->dump_stats && cl_ops->dump_stats(q, cl, &d) < 0)
-- 
2.8.1

