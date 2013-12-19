Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id D5DCE105AC2D
	for <drbd-dev@lists.linbit.com>; Fri, 20 Dec 2013 10:15:49 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 9737D2B75F1
	for <drbd-dev@lists.linbit.com>; Fri, 20 Dec 2013 10:15:49 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id neKd_OEOTkIc for <drbd-dev@lists.linbit.com>;
	Fri, 20 Dec 2013 10:15:49 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 777902B772D
	for <drbd-dev@lists.linbit.com>; Fri, 20 Dec 2013 10:15:49 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id gtz2R1GXF5cQ for <drbd-dev@lists.linbit.com>;
	Fri, 20 Dec 2013 10:15:49 +0100 (CET)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 30DAE2B75F1
	for <drbd-dev@lists.linbit.com>; Fri, 20 Dec 2013 10:15:49 +0100 (CET)
Resent-Message-ID: <20131220091549.GC31214@soda.linbit>
Date: Thu, 19 Dec 2013 15:03:36 +0530
From: Rashika Kheria <rashika.kheria@gmail.com>
To: linux-kernel@vger.kernel.org
Message-ID: <107e3f5de68d07bca6eaf3e439eb62bcc8f0a5b6.1387445396.git.rashika.kheria@gmail.com>
References: <f460591345e87defe53122cf056991c7f2eefa10.1387445396.git.rashika.kheria@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f460591345e87defe53122cf056991c7f2eefa10.1387445396.git.rashika.kheria@gmail.com>
Content-Transfer-Encoding: quoted-printable
Cc: josh@joshtriplett.org, drbd-user@lists.linbit.com,
	Lars Ellenberg <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] [PATCH 02/13] drivers: block: Remove unused function
 drbd_bm_write_lazy() in drbd_bitmap.c
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

Remove unused function drbd_bm_write_lazy() in drbd/drbd_bitmap.c.

This eliminates the following warning in drbd/drbd_bitmap.c:
drivers/block/drbd/drbd_bitmap.c:1208:5: warning: no previous prototype f=
or =E2=80=98drbd_bm_write_lazy=E2=80=99 [-Wmissing-prototypes]

Signed-off-by: Rashika Kheria <rashika.kheria@gmail.com>
Reviewed-by: Josh Triplett <josh@joshtriplett.org>
---
 drivers/block/drbd/drbd_bitmap.c |   10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/block/drbd/drbd_bitmap.c b/drivers/block/drbd/drbd_b=
itmap.c
index b12c11e..d8e2bf4 100644
--- a/drivers/block/drbd/drbd_bitmap.c
+++ b/drivers/block/drbd/drbd_bitmap.c
@@ -1201,16 +1201,6 @@ int drbd_bm_write_all(struct drbd_conf *mdev) __mu=
st_hold(local)
 }
=20
 /**
- * drbd_bm_lazy_write_out() - Write bitmap pages 0 to @upper_idx-1, if t=
hey have changed.
- * @mdev:	DRBD device.
- * @upper_idx:	0: write all changed pages; +ve: page index to stop scann=
ing for changed pages
- */
-int drbd_bm_write_lazy(struct drbd_conf *mdev, unsigned upper_idx) __mus=
t_hold(local)
-{
-	return bm_rw(mdev, WRITE, BM_AIO_COPY_PAGES, upper_idx);
-}
-
-/**
  * drbd_bm_write_copy_pages() - Write the whole bitmap to its on disk lo=
cation.
  * @mdev:	DRBD device.
  *
--=20
1.7.9.5

