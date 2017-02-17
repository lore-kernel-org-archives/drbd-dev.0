Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wm0-f43.google.com (mail-wm0-f43.google.com [74.125.82.43])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 0562D105631C
	for <drbd-dev@lists.linbit.com>; Fri, 17 Feb 2017 09:42:20 +0100 (CET)
Received: by mail-wm0-f43.google.com with SMTP id v77so5005386wmv.0
	for <drbd-dev@lists.linbit.com>; Fri, 17 Feb 2017 00:42:20 -0800 (PST)
Received: from soda.linbit ([86.59.100.100]) by smtp.gmail.com with ESMTPSA id
	n18sm11939298wra.64.2017.02.17.00.42.19
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 17 Feb 2017 00:42:19 -0800 (PST)
Resent-Message-ID: <20170217084218.GD21236@soda.linbit>
Received: from smtprelay.hostedemail.com (smtprelay0078.hostedemail.com
	[216.40.44.78])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id E37CD1056473
	for <drbd-dev@lists.linbit.com>; Fri, 17 Feb 2017 08:18:38 +0100 (CET)
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com
	[10.5.19.251])
	by smtpgrave01.hostedemail.com (Postfix) with ESMTP id F098C5E9FF
	for <drbd-dev@lists.linbit.com>; Fri, 17 Feb 2017 07:12:38 +0000 (UTC)
From: Joe Perches <joe@perches.com>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>
Date: Thu, 16 Feb 2017 23:11:24 -0800
Message-Id: <c08a9903ce3ae05e266e164312fac78612e24a4c.1487314667.git.joe@perches.com>
In-Reply-To: <cover.1487314666.git.joe@perches.com>
References: <cover.1487314666.git.joe@perches.com>
Cc: linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 11/35] block/drbd: Convert remaining uses of
	pr_warning to pr_warn
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

To enable eventual removal of pr_warning

This makes pr_warn use consistent for drivers/block

Prior to this patch, there were 2 uses of pr_warning and
26 uses of pr_warn in drivers/block

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/block/drbd/drbd_nl.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index 908c704e20aa..4a237b4418bb 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -251,19 +251,18 @@ static int drbd_adm_prepare(struct drbd_config_context *adm_ctx,
 	/* some more paranoia, if the request was over-determined */
 	if (adm_ctx->device && adm_ctx->resource &&
 	    adm_ctx->device->resource != adm_ctx->resource) {
-		pr_warning("request: minor=%u, resource=%s; but that minor belongs to resource %s\n",
-				adm_ctx->minor, adm_ctx->resource->name,
-				adm_ctx->device->resource->name);
+		pr_warn("request: minor=%u, resource=%s; but that minor belongs to resource %s\n",
+			adm_ctx->minor, adm_ctx->resource->name,
+			adm_ctx->device->resource->name);
 		drbd_msg_put_info(adm_ctx->reply_skb, "minor exists in different resource");
 		return ERR_INVALID_REQUEST;
 	}
 	if (adm_ctx->device &&
 	    adm_ctx->volume != VOLUME_UNSPECIFIED &&
 	    adm_ctx->volume != adm_ctx->device->vnr) {
-		pr_warning("request: minor=%u, volume=%u; but that minor is volume %u in %s\n",
-				adm_ctx->minor, adm_ctx->volume,
-				adm_ctx->device->vnr,
-				adm_ctx->device->resource->name);
+		pr_warn("request: minor=%u, volume=%u; but that minor is volume %u in %s\n",
+			adm_ctx->minor, adm_ctx->volume,
+			adm_ctx->device->vnr, adm_ctx->device->resource->name);
 		drbd_msg_put_info(adm_ctx->reply_skb, "minor exists as different volume");
 		return ERR_INVALID_REQUEST;
 	}
-- 
2.10.0.rc2.1.g053435c

