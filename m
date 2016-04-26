Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 38BAD1056450
	for <drbd-dev@lists.linbit.com>; Tue, 26 Apr 2016 14:36:10 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 33DB73F79B5
	for <drbd-dev@lists.linbit.com>; Tue, 26 Apr 2016 14:36:10 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id u2g07xQUE4lH for <drbd-dev@lists.linbit.com>;
	Tue, 26 Apr 2016 14:36:10 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 193023F79B2
	for <drbd-dev@lists.linbit.com>; Tue, 26 Apr 2016 14:36:10 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id fjfc5dhaj659 for <drbd-dev@lists.linbit.com>;
	Tue, 26 Apr 2016 14:36:10 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id E4F603F79B6
	for <drbd-dev@lists.linbit.com>; Tue, 26 Apr 2016 14:36:09 +0200 (CEST)
Resent-Message-ID: <20160426123609.GL20950@soda.linbit>
Received: from proxy.6wind.com (host.76.145.23.62.rev.coltfrance.com
	[62.23.145.76])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id D612C1056445
	for <drbd-dev@lists.linbit.com>; Tue, 26 Apr 2016 10:17:12 +0200 (CEST)
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
To: netdev@vger.kernel.org
Date: Tue, 26 Apr 2016 10:06:12 +0200
Message-Id: <1461657978-13360-3-git-send-email-nicolas.dichtel@6wind.com>
In-Reply-To: <1461657978-13360-1-git-send-email-nicolas.dichtel@6wind.com>
References: <1461657978-13360-1-git-send-email-nicolas.dichtel@6wind.com>
Cc: dev@openvswitch.org, Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	sd@queasysnail.net, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, jhs@mojatatu.com,
	pshelar@nicira.com, lars.ellenberg@linbit.com, jack@suse.com,
	johannes@sipsolutions.net, philipp.reisner@linbit.com,
	davem@davemloft.net, kvalo@codeaurora.org, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH net-next 2/8] drivers/wireless: use
	nla_put_u64_64bit()
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
 drivers/net/wireless/mac80211_hwsim.c | 2 +-
 drivers/net/wireless/mac80211_hwsim.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index c757f14c4c00..9ed0ed1bf514 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -1030,7 +1030,7 @@ static void mac80211_hwsim_tx_frame_nl(struct ieee80211_hw *hw,
 	data->pending_cookie++;
 	cookie = data->pending_cookie;
 	info->rate_driver_data[0] = (void *)cookie;
-	if (nla_put_u64(skb, HWSIM_ATTR_COOKIE, cookie))
+	if (nla_put_u64_64bit(skb, HWSIM_ATTR_COOKIE, cookie, HWSIM_ATTR_PAD))
 		goto nla_put_failure;
 
 	genlmsg_end(skb, msg_head);
diff --git a/drivers/net/wireless/mac80211_hwsim.h b/drivers/net/wireless/mac80211_hwsim.h
index 66e1c73bd507..39f22467ca2a 100644
--- a/drivers/net/wireless/mac80211_hwsim.h
+++ b/drivers/net/wireless/mac80211_hwsim.h
@@ -148,6 +148,7 @@ enum {
 	HWSIM_ATTR_RADIO_NAME,
 	HWSIM_ATTR_NO_VIF,
 	HWSIM_ATTR_FREQ,
+	HWSIM_ATTR_PAD,
 	__HWSIM_ATTR_MAX,
 };
 #define HWSIM_ATTR_MAX (__HWSIM_ATTR_MAX - 1)
-- 
2.8.1

