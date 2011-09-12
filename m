Return-Path: <bunk@iat.uni-leipzig.de>
Received: from v4.rz.uni-leipzig.de (v4.rz.uni-leipzig.de [139.18.1.30])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 1974410556C5
	for <drbd-dev@lists.linbit.com>; Mon, 12 Sep 2011 16:57:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by v4.rz.uni-leipzig.de (Postfix) with ESMTP id 77453473D6
	for <drbd-dev@lists.linbit.com>; Mon, 12 Sep 2011 16:52:10 +0200 (CEST)
Received: from v4.rz.uni-leipzig.de ([127.0.0.1])
	by localhost (v4.rz.uni-leipzig.de [127.0.0.1]) (amavisd-new,
	port 10024)
	with ESMTP id qk-5FsCuHpYA for <drbd-dev@lists.linbit.com>;
	Mon, 12 Sep 2011 16:52:10 +0200 (CEST)
Received: from v1.rz.uni-leipzig.de (v1.rz.uni-leipzig.de [139.18.1.26])
	by v4.rz.uni-leipzig.de (Postfix) with ESMTP id 5080F473D2
	for <drbd-dev@lists.linbit.com>; Mon, 12 Sep 2011 16:52:10 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by v1.rz.uni-leipzig.de (Postfix) with ESMTP id 0AECCF805A
	for <drbd-dev@lists.linbit.com>; Mon, 12 Sep 2011 16:52:10 +0200 (CEST)
Received: from v1.rz.uni-leipzig.de ([127.0.0.1])
	by localhost (v1.rz.uni-leipzig.de [127.0.0.1]) (amavisd-new,
	port 10024)
	with ESMTP id TsqAcHeiTtt3 for <drbd-dev@lists.linbit.com>;
	Mon, 12 Sep 2011 16:52:09 +0200 (CEST)
Received: from server1.rz.uni-leipzig.de (server1.rz.uni-leipzig.de
	[139.18.1.1])
	by v1.rz.uni-leipzig.de (Postfix) with ESMTP id E553DF8054
	for <drbd-dev@lists.linbit.com>; Mon, 12 Sep 2011 16:52:09 +0200 (CEST)
Received: from gg1.iat.uni-leipzig.de (gg.iat.uni-leipzig.de [139.18.202.33])
	by server1.rz.uni-leipzig.de (Postfix) with ESMTPS id E32B92A004
	for <drbd-dev@lists.linbit.com>; Mon, 12 Sep 2011 16:52:09 +0200 (CEST)
Received: from gg1.iat.uni-leipzig.de (localhost [127.0.0.1])
	by gg1.iat.uni-leipzig.de (8.14.3/8.14.3) with ESMTP id p8CEq9iG023366
	for <drbd-dev@lists.linbit.com>; Mon, 12 Sep 2011 16:52:09 +0200 (CEST)
Date: Mon, 12 Sep 2011 16:52:00 +0200
From: Michael Bunk <bunk@iat.uni-leipzig.de>
To: drbd-dev@lists.linbit.com
Message-ID: <20110912145200.GA4560@pc514.iat.uni-leipzig.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Drbd-dev] [PATCH] drbdadm: Avoid null pointer dereference on wrong
	hostnames
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

If all hostnames in the config did not apply to the current host, a pointer was
dereferenced (resulting in a segmentation fault), before an error message
regarding the hostname could be output.
---
 user/drbdadm_main.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/user/drbdadm_main.c b/user/drbdadm_main.c
index db7c0d3..f27eaff 100644
--- a/user/drbdadm_main.c
+++ b/user/drbdadm_main.c
@@ -2556,6 +2556,10 @@ int ctx_set_implicit_volume(struct cfg_ctx *ctx)
 	if (ctx->vol || !ctx->res)
 		return 0;
 
+	if (!ctx->res->me) {
+		return 0;
+	}
+
 	for_each_volume(vol, ctx->res->me->volumes) {
 		volumes++;
 		v = vol;
-- 
1.4.4.4

