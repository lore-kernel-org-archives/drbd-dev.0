Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 8FD29105644B
	for <drbd-dev@lists.linbit.com>; Tue, 26 Apr 2016 14:36:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 885A73EFFDD
	for <drbd-dev@lists.linbit.com>; Tue, 26 Apr 2016 14:36:06 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id Bsy9pdVuOl30 for <drbd-dev@lists.linbit.com>;
	Tue, 26 Apr 2016 14:36:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 6CD333F79B2
	for <drbd-dev@lists.linbit.com>; Tue, 26 Apr 2016 14:36:06 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 1sgBLSzTukNO for <drbd-dev@lists.linbit.com>;
	Tue, 26 Apr 2016 14:36:06 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 46F493EFFDD
	for <drbd-dev@lists.linbit.com>; Tue, 26 Apr 2016 14:36:06 +0200 (CEST)
Resent-Message-ID: <20160426123605.GH20950@soda.linbit>
Received: from proxy.6wind.com (host.76.145.23.62.rev.coltfrance.com
	[62.23.145.76])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id E6EA51056448
	for <drbd-dev@lists.linbit.com>; Tue, 26 Apr 2016 10:12:12 +0200 (CEST)
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
To: netdev@vger.kernel.org
Date: Tue, 26 Apr 2016 10:06:16 +0200
Message-Id: <1461657978-13360-7-git-send-email-nicolas.dichtel@6wind.com>
In-Reply-To: <1461657978-13360-1-git-send-email-nicolas.dichtel@6wind.com>
References: <1461657978-13360-1-git-send-email-nicolas.dichtel@6wind.com>
Cc: dev@openvswitch.org, Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	sd@queasysnail.net, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, jhs@mojatatu.com,
	pshelar@nicira.com, lars.ellenberg@linbit.com, jack@suse.com,
	johannes@sipsolutions.net, philipp.reisner@linbit.com,
	davem@davemloft.net, kvalo@codeaurora.org, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH net-next 6/8] rtnl: align nlattr properly when
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
 net/core/rtnetlink.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 9efc1f34ef3b..5503dfe6a050 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -876,7 +876,7 @@ static noinline size_t if_nlmsg_size(const struct net_device *dev,
 	       + nla_total_size(IFNAMSIZ) /* IFLA_IFNAME */
 	       + nla_total_size(IFALIASZ) /* IFLA_IFALIAS */
 	       + nla_total_size(IFNAMSIZ) /* IFLA_QDISC */
-	       + nla_total_size(sizeof(struct rtnl_link_ifmap))
+	       + nla_total_size_64bit(sizeof(struct rtnl_link_ifmap))
 	       + nla_total_size(sizeof(struct rtnl_link_stats))
 	       + nla_total_size_64bit(sizeof(struct rtnl_link_stats64))
 	       + nla_total_size(MAX_ADDR_LEN) /* IFLA_ADDRESS */
@@ -1181,7 +1181,7 @@ static int rtnl_fill_link_ifmap(struct sk_buff *skb, struct net_device *dev)
 		.dma         = dev->dma,
 		.port        = dev->if_port,
 	};
-	if (nla_put(skb, IFLA_MAP, sizeof(map), &map))
+	if (nla_put_64bit(skb, IFLA_MAP, sizeof(map), &map, IFLA_PAD))
 		return -EMSGSIZE;
 
 	return 0;
-- 
2.8.1

