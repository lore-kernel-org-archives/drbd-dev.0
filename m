Return-Path: <bunk@iat.uni-leipzig.de>
Received: from v4.rz.uni-leipzig.de (v4.rz.uni-leipzig.de [139.18.1.30])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 20B7C10556C7
	for <drbd-dev@lists.linbit.com>; Mon, 12 Sep 2011 16:57:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by v4.rz.uni-leipzig.de (Postfix) with ESMTP id 116F7473D1
	for <drbd-dev@lists.linbit.com>; Mon, 12 Sep 2011 16:50:57 +0200 (CEST)
Received: from v4.rz.uni-leipzig.de ([127.0.0.1])
	by localhost (v4.rz.uni-leipzig.de [127.0.0.1]) (amavisd-new,
	port 10024)
	with ESMTP id y44lraHacK58 for <drbd-dev@lists.linbit.com>;
	Mon, 12 Sep 2011 16:50:56 +0200 (CEST)
Received: from v1.rz.uni-leipzig.de (v1.rz.uni-leipzig.de [139.18.1.26])
	by v4.rz.uni-leipzig.de (Postfix) with ESMTP id E7323473CB
	for <drbd-dev@lists.linbit.com>; Mon, 12 Sep 2011 16:50:56 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by v1.rz.uni-leipzig.de (Postfix) with ESMTP id 0ECB2F8054
	for <drbd-dev@lists.linbit.com>; Mon, 12 Sep 2011 16:50:55 +0200 (CEST)
Received: from v1.rz.uni-leipzig.de ([127.0.0.1])
	by localhost (v1.rz.uni-leipzig.de [127.0.0.1]) (amavisd-new,
	port 10024)
	with ESMTP id 9njXIlc6nh5I for <drbd-dev@lists.linbit.com>;
	Mon, 12 Sep 2011 16:50:54 +0200 (CEST)
Received: from server1.rz.uni-leipzig.de (server1.rz.uni-leipzig.de
	[139.18.1.1])
	by v1.rz.uni-leipzig.de (Postfix) with ESMTP id ECA69F805A
	for <drbd-dev@lists.linbit.com>; Mon, 12 Sep 2011 16:50:54 +0200 (CEST)
Received: from gg1.iat.uni-leipzig.de (gg.iat.uni-leipzig.de [139.18.202.33])
	by server1.rz.uni-leipzig.de (Postfix) with ESMTPS id E409B2A004
	for <drbd-dev@lists.linbit.com>; Mon, 12 Sep 2011 16:50:54 +0200 (CEST)
Received: from gg1.iat.uni-leipzig.de (localhost [127.0.0.1])
	by gg1.iat.uni-leipzig.de (8.14.3/8.14.3) with ESMTP id p8CEos0d000147
	for <drbd-dev@lists.linbit.com>; Mon, 12 Sep 2011 16:50:54 +0200 (CEST)
Date: Mon, 12 Sep 2011 16:50:49 +0200
From: Michael Bunk <bunk@iat.uni-leipzig.de>
To: drbd-dev@lists.linbit.com
Message-ID: <20110912145049.GA5272@pc514.iat.uni-leipzig.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Drbd-dev] [PATCH] drbdadm: Fix typo in man page
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

---
 documentation/drbdadm.xml |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/documentation/drbdadm.xml b/documentation/drbdadm.xml
index f458e67..32fb88e 100644
--- a/documentation/drbdadm.xml
+++ b/documentation/drbdadm.xml
@@ -79,7 +79,7 @@
     <option>verify</option>, <option>pause-sync</option>, <option>resume-sync</option>,
     <option>role</option>, <option>csytate</option>, <option>dstate</option>,
     <option>create-md</option>, <option>show-gi</option>, <option>get-gi</option>,
-    <option>dump-md</option>, <option>wipe-md</option> are work on whole resources and on
+    <option>dump-md</option>, <option>wipe-md</option> work on whole resources and on
     individual volumes. </para>
 
     <para>Resource level only commands are: <option>connect</option>, <option>disconnect</option>,
-- 
1.4.4.4

