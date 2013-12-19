Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id F0907105AC58
	for <drbd-dev@lists.linbit.com>; Fri, 20 Dec 2013 10:16:43 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id EC2862B772E
	for <drbd-dev@lists.linbit.com>; Fri, 20 Dec 2013 10:16:43 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id tzjEoMOx1pLg for <drbd-dev@lists.linbit.com>;
	Fri, 20 Dec 2013 10:16:43 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id C4FEF2B7730
	for <drbd-dev@lists.linbit.com>; Fri, 20 Dec 2013 10:16:43 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id rfTLWG3j2iEg for <drbd-dev@lists.linbit.com>;
	Fri, 20 Dec 2013 10:16:43 +0100 (CET)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id A78832B772E
	for <drbd-dev@lists.linbit.com>; Fri, 20 Dec 2013 10:16:43 +0100 (CET)
Resent-Message-ID: <20131220091643.GF31214@soda.linbit>
Date: Thu, 19 Dec 2013 15:07:47 +0530
From: Rashika Kheria <rashika.kheria@gmail.com>
To: linux-kernel@vger.kernel.org
Message-ID: <abcddebb1d8f39a081838be28fb29c77a3611d45.1387445396.git.rashika.kheria@gmail.com>
References: <f460591345e87defe53122cf056991c7f2eefa10.1387445396.git.rashika.kheria@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f460591345e87defe53122cf056991c7f2eefa10.1387445396.git.rashika.kheria@gmail.com>
Content-Transfer-Encoding: quoted-printable
Cc: josh@joshtriplett.org, drbd-user@lists.linbit.com,
	Lars Ellenberg <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] [PATCH 05/13] drivers: block: Move prototype declaration
 to appropriate header file from drbd_main.c
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

Move prototype declaration of functions drbdd_init() and drbd_asender()
from drbd/drbd_main.c to header file drbd/drbd_int.h because these
functions are used by more than one file.

This eliminates the following warning in drbd/drbd_receiver.c:
drivers/block/drbd/drbd_receiver.c:4836:5: warning: no previous prototype=
 for =E2=80=98drbdd_init=E2=80=99 [-Wmissing-prototypes]
drivers/block/drbd/drbd_receiver.c:5245:5: warning: no previous prototype=
 for =E2=80=98drbd_asender=E2=80=99 [-Wmissing-prototypes]

Signed-off-by: Rashika Kheria <rashika.kheria@gmail.com>
Reviewed-by: Josh Triplett <josh@joshtriplett.org>
---
 drivers/block/drbd/drbd_int.h  |    4 ++++
 drivers/block/drbd/drbd_main.c |    2 --
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.=
h
index 0e06f0c..0cc79f4 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -587,6 +587,10 @@ struct drbd_epoch {
 	unsigned long flags;
 };
=20
+/* Prototype declaration of function defined in drbd_receiver.c */
+int drbdd_init(struct drbd_thread *);
+int drbd_asender(struct drbd_thread *);
+
 /* drbd_epoch flag bits */
 enum {
 	DE_HAVE_BARRIER_NUMBER,
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_mai=
n.c
index 9e3818b..4a24e71 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -57,9 +57,7 @@
 #include "drbd_vli.h"
=20
 static DEFINE_MUTEX(drbd_main_mutex);
-int drbdd_init(struct drbd_thread *);
 int drbd_worker(struct drbd_thread *);
-int drbd_asender(struct drbd_thread *);
=20
 int drbd_init(void);
 static int drbd_open(struct block_device *bdev, fmode_t mode);
--=20
1.7.9.5

