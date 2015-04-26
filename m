Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 8D62E100EBF0
	for <drbd-dev@lists.linbit.com>; Thu,  7 May 2015 11:35:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 80DB044270C
	for <drbd-dev@lists.linbit.com>; Thu,  7 May 2015 11:35:23 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id bOQ8Tuu9S5mc for <drbd-dev@lists.linbit.com>;
	Thu,  7 May 2015 11:35:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 6347F44A1C0
	for <drbd-dev@lists.linbit.com>; Thu,  7 May 2015 11:35:23 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id nFf-VOH7Vkg7 for <drbd-dev@lists.linbit.com>;
	Thu,  7 May 2015 11:35:23 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 2813644270C
	for <drbd-dev@lists.linbit.com>; Thu,  7 May 2015 11:35:23 +0200 (CEST)
Resent-Message-ID: <20150507093522.GN18767@soda.linbit>
Received: from fiona.linuxhacker.ru (unknown [217.76.32.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 4A2531019A36
	for <drbd-dev@lists.linbit.com>; Sun, 26 Apr 2015 08:13:16 +0200 (CEST)
From: green@linuxhacker.ru
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>, drbd-dev@lists.linbit.com
Date: Sun, 26 Apr 2015 01:28:43 -0400
Message-Id: <1430026123-26329-1-git-send-email-green@linuxhacker.ru>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
	Oleg Drokin <green@linuxhacker.ru>
Subject: [Drbd-dev] [PATCH] drbd: fix memory leak in drbd_adm_resize
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

From: Oleg Drokin <green@linuxhacker.ru>

new_disk_conf could be leaked if the follow on checks fail,
so make sure to free it on error if it was not assigned yet.

Found with smatch.

Signed-off-by: Oleg Drokin <green@linuxhacker.ru>
---
I thought about just moving the allocation around so that
there is is no failure path after allocation, but looking
at the history of changes in that file, people tend to insert
extra checks at random places and that's how we ended up
with the current bug, so better let it fail and handle the failure.


 drivers/block/drbd/drbd_nl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index 74df8cf..87fa774 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -2585,6 +2585,7 @@ int drbd_adm_resize(struct sk_buff *skb, struct genl_info *info)
 		mutex_unlock(&device->resource->conf_update);
 		synchronize_rcu();
 		kfree(old_disk_conf);
+		new_disk_conf = NULL;
 	}
 
 	ddsf = (rs.resize_force ? DDSF_FORCED : 0) | (rs.no_resync ? DDSF_NO_RESYNC : 0);
@@ -2618,6 +2619,7 @@ int drbd_adm_resize(struct sk_buff *skb, struct genl_info *info)
 
  fail_ldev:
 	put_ldev(device);
+	kfree(new_disk_conf);
 	goto fail;
 }
 
-- 
2.1.0

