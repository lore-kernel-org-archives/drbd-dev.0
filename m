Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id E75051056447
	for <drbd-dev@lists.linbit.com>; Tue, 31 May 2016 11:47:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id DAE333EB2B4
	for <drbd-dev@lists.linbit.com>; Tue, 31 May 2016 11:47:42 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id EbzGRpzHWTns for <drbd-dev@lists.linbit.com>;
	Tue, 31 May 2016 11:47:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id B14AE3F68C0
	for <drbd-dev@lists.linbit.com>; Tue, 31 May 2016 11:47:42 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ly1XcECUXAPI for <drbd-dev@lists.linbit.com>;
	Tue, 31 May 2016 11:47:42 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 3791C3EB2B4
	for <drbd-dev@lists.linbit.com>; Tue, 31 May 2016 11:47:42 +0200 (CEST)
Resent-Message-ID: <20160531094740.GD3235@soda.linbit>
Received: from mail-pa0-f66.google.com (mail-pa0-f66.google.com
	[209.85.220.66]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id AAE751056444
	for <drbd-dev@lists.linbit.com>; Sat, 28 May 2016 15:23:33 +0200 (CEST)
Received: by mail-pa0-f66.google.com with SMTP id f8so16139726pag.0
	for <drbd-dev@lists.linbit.com>; Sat, 28 May 2016 06:23:33 -0700 (PDT)
Date: Sat, 28 May 2016 18:36:05 +0530
From: Amitoj Kaur Chawla <amitoj1606@gmail.com>
To: philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
	drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org
Message-ID: <20160528130605.GA23065@amitoj-Inspiron-3542>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Cc: julia.lawall@lip6.fr
Subject: [Drbd-dev] [PATCH] drbd: Replace if and BUG with BUG_ON
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

Replace if condition and BUG() with a BUG_ON having the conditional
expression of the if statement as argument.

The Coccinelle semantic patch used to make this change is as follows:
@ disable unlikely @ expression E,f; @@

(
  if (<+... f(...) ...+>) { BUG(); }
|
- if (unlikely(E)) { BUG(); }
+ BUG_ON(E);
)

@@ expression E,f; @@

(
  if (<+... f(...) ...+>) { BUG(); }
|
- if (E) { BUG(); }
+ BUG_ON(E);
)

Signed-off-by: Amitoj Kaur Chawla <amitoj1606@gmail.com>
---
 drivers/block/drbd/drbd_state.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/drbd/drbd_state.c b/drivers/block/drbd/drbd_state.c
index 5a7ef78..154eb21 100644
--- a/drivers/block/drbd/drbd_state.c
+++ b/drivers/block/drbd/drbd_state.c
@@ -2160,8 +2160,7 @@ conn_set_state(struct drbd_connection *connection, union drbd_state mask, union
 			ns.disk = os.disk;
 
 		rv = _drbd_set_state(device, ns, flags, NULL);
-		if (rv < SS_SUCCESS)
-			BUG();
+		BUG_ON(rv < SS_SUCCESS);
 
 		ns.i = device->state.i;
 		ns_max.role = max_role(ns.role, ns_max.role);
-- 
1.9.1

