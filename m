Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 2C6A2105644D
	for <drbd-dev@lists.linbit.com>; Tue, 26 Apr 2016 14:36:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 267633EFFDD
	for <drbd-dev@lists.linbit.com>; Tue, 26 Apr 2016 14:36:07 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 5PP1UE3IR99o for <drbd-dev@lists.linbit.com>;
	Tue, 26 Apr 2016 14:36:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 0913F3EFFFB
	for <drbd-dev@lists.linbit.com>; Tue, 26 Apr 2016 14:36:07 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id DoPGnGTmPbfa for <drbd-dev@lists.linbit.com>;
	Tue, 26 Apr 2016 14:36:06 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id D6D163EFFDD
	for <drbd-dev@lists.linbit.com>; Tue, 26 Apr 2016 14:36:06 +0200 (CEST)
Resent-Message-ID: <20160426123606.GI20950@soda.linbit>
Received: from proxy.6wind.com (host.76.145.23.62.rev.coltfrance.com
	[62.23.145.76])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id EB7EF105644A
	for <drbd-dev@lists.linbit.com>; Tue, 26 Apr 2016 10:12:12 +0200 (CEST)
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
To: netdev@vger.kernel.org
Date: Tue, 26 Apr 2016 10:06:17 +0200
Message-Id: <1461657978-13360-8-git-send-email-nicolas.dichtel@6wind.com>
In-Reply-To: <1461657978-13360-1-git-send-email-nicolas.dichtel@6wind.com>
References: <1461657978-13360-1-git-send-email-nicolas.dichtel@6wind.com>
Cc: dev@openvswitch.org, Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	sd@queasysnail.net, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, jhs@mojatatu.com,
	pshelar@nicira.com, lars.ellenberg@linbit.com, jack@suse.com,
	johannes@sipsolutions.net, philipp.reisner@linbit.com,
	davem@davemloft.net, kvalo@codeaurora.org, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH net-next 7/8] neigh: align nlattr properly when
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
 net/core/neighbour.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 6a395d440228..29dd8cc22bbf 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -1857,7 +1857,8 @@ static int neightbl_fill_info(struct sk_buff *skb, struct neigh_table *tbl,
 			ndst.ndts_table_fulls		+= st->table_fulls;
 		}
 
-		if (nla_put(skb, NDTA_STATS, sizeof(ndst), &ndst))
+		if (nla_put_64bit(skb, NDTA_STATS, sizeof(ndst), &ndst,
+				  NDTA_PAD))
 			goto nla_put_failure;
 	}
 
-- 
2.8.1

