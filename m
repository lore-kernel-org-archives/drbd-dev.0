Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id C8C69105B0C4
	for <drbd-dev@lists.linbit.com>; Fri, 20 Dec 2013 10:16:52 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id B38562B7735
	for <drbd-dev@lists.linbit.com>; Fri, 20 Dec 2013 10:16:51 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id R-dNFq3r2-Fj for <drbd-dev@lists.linbit.com>;
	Fri, 20 Dec 2013 10:16:51 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 89FAF2B7733
	for <drbd-dev@lists.linbit.com>; Fri, 20 Dec 2013 10:16:49 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 6kcbxs-HTCTj for <drbd-dev@lists.linbit.com>;
	Fri, 20 Dec 2013 10:16:49 +0100 (CET)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 640E82B7735
	for <drbd-dev@lists.linbit.com>; Fri, 20 Dec 2013 10:16:49 +0100 (CET)
Resent-Message-ID: <20131220091649.GK31214@soda.linbit>
Date: Thu, 19 Dec 2013 15:15:02 +0530
From: Rashika Kheria <rashika.kheria@gmail.com>
To: linux-kernel@vger.kernel.org
Message-ID: <858d992f118ff1695201c7fb22c9a14052a5a96f.1387445396.git.rashika.kheria@gmail.com>
References: <f460591345e87defe53122cf056991c7f2eefa10.1387445396.git.rashika.kheria@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f460591345e87defe53122cf056991c7f2eefa10.1387445396.git.rashika.kheria@gmail.com>
Content-Transfer-Encoding: quoted-printable
Cc: josh@joshtriplett.org, drbd-user@lists.linbit.com,
	Lars Ellenberg <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] [PATCH 09/13] drivers: block: Move prototype declaration
 of function tl_abort_disk_io() to appropriate header file from drbd_state.c
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

Move the prototype declaration of function tl_abort_disk_io() from
drbd/drbd_state.c to appropriate header file drbd/drbd_int.h because it
is used by more than 2 files.

This eliminates the following warnings in drbd/drbd_main.c:
drivers/block/drbd/drbd_main.c:310:6: warning: no previous prototype for =
=E2=80=98tl_abort_disk_io=E2=80=99 [-Wmissing-prototypes]

Signed-off-by: Rashika Kheria <rashika.kheria@gmail.com>
Reviewed-by: Josh Triplett <josh@joshtriplett.org>
---
 drivers/block/drbd/drbd_int.h   |    1 +
 drivers/block/drbd/drbd_state.c |    3 ---
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.=
h
index 0cc79f4..27df55f 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -65,6 +65,7 @@
 extern unsigned int minor_count;
 extern bool disable_sendpage;
 extern bool allow_oos;
+void tl_abort_disk_io(struct drbd_conf *mdev);
=20
 #ifdef CONFIG_DRBD_FAULT_INJECTION
 extern int enable_faults;
diff --git a/drivers/block/drbd/drbd_state.c b/drivers/block/drbd/drbd_st=
ate.c
index 216d47b..120e1c0 100644
--- a/drivers/block/drbd/drbd_state.c
+++ b/drivers/block/drbd/drbd_state.c
@@ -29,9 +29,6 @@
 #include "drbd_int.h"
 #include "drbd_req.h"
=20
-/* in drbd_main.c */
-extern void tl_abort_disk_io(struct drbd_conf *mdev);
-
 struct after_state_chg_work {
 	struct drbd_work w;
 	union drbd_state os;
--=20
1.7.9.5

