Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 1A661105B0BB
	for <drbd-dev@lists.linbit.com>; Fri, 20 Dec 2013 10:16:52 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 769B42B7734
	for <drbd-dev@lists.linbit.com>; Fri, 20 Dec 2013 10:16:49 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id osHk_yPRWwMi for <drbd-dev@lists.linbit.com>;
	Fri, 20 Dec 2013 10:16:49 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id B5A192B7733
	for <drbd-dev@lists.linbit.com>; Fri, 20 Dec 2013 10:16:48 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id fFIWBfFadrUz for <drbd-dev@lists.linbit.com>;
	Fri, 20 Dec 2013 10:16:48 +0100 (CET)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id D70582B7734
	for <drbd-dev@lists.linbit.com>; Fri, 20 Dec 2013 10:16:47 +0100 (CET)
Resent-Message-ID: <20131220091647.GJ31214@soda.linbit>
Date: Thu, 19 Dec 2013 15:13:37 +0530
From: Rashika Kheria <rashika.kheria@gmail.com>
To: linux-kernel@vger.kernel.org
Message-ID: <aaf95204c9af025e2ad4c00c0e9d6ed23bbe96ac.1387445396.git.rashika.kheria@gmail.com>
References: <f460591345e87defe53122cf056991c7f2eefa10.1387445396.git.rashika.kheria@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f460591345e87defe53122cf056991c7f2eefa10.1387445396.git.rashika.kheria@gmail.com>
Content-Transfer-Encoding: quoted-printable
Cc: josh@joshtriplett.org, drbd-user@lists.linbit.com,
	Lars Ellenberg <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] [PATCH 08/13] drivers: block: Mark function as static in
 drbd_actlog.c
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

Mark the function drbd_al_begin_io_prepare() as static in
drbd/drbd_actlog.c because it is not used outside this file.

This eliminates the following warnings in drbd/drbd_actlog.c:
drivers/block/drbd/drbd_actlog.c:277:6: warning: no previous prototype fo=
r =E2=80=98drbd_al_begin_io_prepare=E2=80=99 [-Wmissing-prototypes]

Signed-off-by: Rashika Kheria <rashika.kheria@gmail.com>
Reviewed-by: Josh Triplett <josh@joshtriplett.org>
---
 drivers/block/drbd/drbd_actlog.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/drbd/drbd_actlog.c b/drivers/block/drbd/drbd_a=
ctlog.c
index 28c73ca..7ba73c4 100644
--- a/drivers/block/drbd/drbd_actlog.c
+++ b/drivers/block/drbd/drbd_actlog.c
@@ -274,6 +274,7 @@ bool drbd_al_begin_io_fastpath(struct drbd_conf *mdev=
, struct drbd_interval *i)
 	return _al_get(mdev, first, true);
 }
=20
+static
 bool drbd_al_begin_io_prepare(struct drbd_conf *mdev, struct drbd_interv=
al *i)
 {
 	/* for bios crossing activity log extent boundaries,
--=20
1.7.9.5

