Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 63EE5105644F
	for <drbd-dev@lists.linbit.com>; Tue, 26 Apr 2016 14:36:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 5F8673F79B2
	for <drbd-dev@lists.linbit.com>; Tue, 26 Apr 2016 14:36:08 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id Ci-aJwj3586Z for <drbd-dev@lists.linbit.com>;
	Tue, 26 Apr 2016 14:36:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 418BC3EFFFB
	for <drbd-dev@lists.linbit.com>; Tue, 26 Apr 2016 14:36:08 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id dRka3gvD5lmn for <drbd-dev@lists.linbit.com>;
	Tue, 26 Apr 2016 14:36:08 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 144433EFFDD
	for <drbd-dev@lists.linbit.com>; Tue, 26 Apr 2016 14:36:08 +0200 (CEST)
Resent-Message-ID: <20160426123607.GK20950@soda.linbit>
Received: from proxy.6wind.com (host.76.145.23.62.rev.coltfrance.com
	[62.23.145.76])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id AD6C2105644E
	for <drbd-dev@lists.linbit.com>; Tue, 26 Apr 2016 10:12:17 +0200 (CEST)
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
To: netdev@vger.kernel.org
Date: Tue, 26 Apr 2016 10:06:14 +0200
Message-Id: <1461657978-13360-5-git-send-email-nicolas.dichtel@6wind.com>
In-Reply-To: <1461657978-13360-1-git-send-email-nicolas.dichtel@6wind.com>
References: <1461657978-13360-1-git-send-email-nicolas.dichtel@6wind.com>
Cc: dev@openvswitch.org, Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	sd@queasysnail.net, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, jhs@mojatatu.com,
	pshelar@nicira.com, lars.ellenberg@linbit.com, jack@suse.com,
	johannes@sipsolutions.net, philipp.reisner@linbit.com,
	davem@davemloft.net, kvalo@codeaurora.org, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH net-next 4/8] sock_diag: align nlattr properly
	when needed
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

I also fix the value of INET_DIAG_MAX. It's wrong since commit 8f840e47f190
which is only in net-next right now, thus I didn't make a separate patch.

Fixes: 8f840e47f190 ("sctp: add the sctp_diag.c file")
Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
---
 include/uapi/linux/inet_diag.h | 4 +++-
 net/core/sock_diag.c           | 2 +-
 net/ipv4/inet_diag.c           | 9 ++++++---
 net/sctp/sctp_diag.c           | 5 +++--
 4 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/include/uapi/linux/inet_diag.h b/include/uapi/linux/inet_diag.h
index f5f3629dd553..a16643705669 100644
--- a/include/uapi/linux/inet_diag.h
+++ b/include/uapi/linux/inet_diag.h
@@ -115,9 +115,11 @@ enum {
 	INET_DIAG_SKV6ONLY,
 	INET_DIAG_LOCALS,
 	INET_DIAG_PEERS,
+	INET_DIAG_PAD,
+	__INET_DIAG_MAX,
 };
 
-#define INET_DIAG_MAX INET_DIAG_SKV6ONLY
+#define INET_DIAG_MAX (__INET_DIAG_MAX - 1)
 
 /* INET_DIAG_MEM */
 
diff --git a/net/core/sock_diag.c b/net/core/sock_diag.c
index ca9e35bbe13c..6b10573cc9fa 100644
--- a/net/core/sock_diag.c
+++ b/net/core/sock_diag.c
@@ -120,7 +120,7 @@ static size_t sock_diag_nlmsg_size(void)
 {
 	return NLMSG_ALIGN(sizeof(struct inet_diag_msg)
 	       + nla_total_size(sizeof(u8)) /* INET_DIAG_PROTOCOL */
-	       + nla_total_size(sizeof(struct tcp_info))); /* INET_DIAG_INFO */
+	       + nla_total_size_64bit(sizeof(struct tcp_info))); /* INET_DIAG_INFO */
 }
 
 static void sock_diag_broadcast_destroy_work(struct work_struct *work)
diff --git a/net/ipv4/inet_diag.c b/net/ipv4/inet_diag.c
index ad7956fa659a..25af1243649b 100644
--- a/net/ipv4/inet_diag.c
+++ b/net/ipv4/inet_diag.c
@@ -220,8 +220,9 @@ int inet_sk_diag_fill(struct sock *sk, struct inet_connection_sock *icsk,
 	}
 
 	if ((ext & (1 << (INET_DIAG_INFO - 1))) && handler->idiag_info_size) {
-		attr = nla_reserve(skb, INET_DIAG_INFO,
-				   handler->idiag_info_size);
+		attr = nla_reserve_64bit(skb, INET_DIAG_INFO,
+					 handler->idiag_info_size,
+					 INET_DIAG_PAD);
 		if (!attr)
 			goto errout;
 
@@ -1078,7 +1079,9 @@ int inet_diag_handler_get_info(struct sk_buff *skb, struct sock *sk)
 	}
 
 	attr = handler->idiag_info_size
-		? nla_reserve(skb, INET_DIAG_INFO, handler->idiag_info_size)
+		? nla_reserve_64bit(skb, INET_DIAG_INFO,
+				    handler->idiag_info_size,
+				    INET_DIAG_PAD)
 		: NULL;
 	if (attr)
 		info = nla_data(attr);
diff --git a/net/sctp/sctp_diag.c b/net/sctp/sctp_diag.c
index bb2d8d9608e9..84829fff3bc9 100644
--- a/net/sctp/sctp_diag.c
+++ b/net/sctp/sctp_diag.c
@@ -161,8 +161,9 @@ static int inet_sctp_diag_fill(struct sock *sk, struct sctp_association *asoc,
 	if (ext & (1 << (INET_DIAG_INFO - 1))) {
 		struct nlattr *attr;
 
-		attr = nla_reserve(skb, INET_DIAG_INFO,
-				   sizeof(struct sctp_info));
+		attr = nla_reserve_64bit(skb, INET_DIAG_INFO,
+					 sizeof(struct sctp_info),
+					 INET_DIAG_PAD);
 		if (!attr)
 			goto errout;
 
-- 
2.8.1

