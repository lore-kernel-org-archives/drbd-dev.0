Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 79336105B0CC
	for <drbd-dev@lists.linbit.com>; Fri, 20 Dec 2013 10:16:53 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 283072B7732
	for <drbd-dev@lists.linbit.com>; Fri, 20 Dec 2013 10:16:52 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id nLse4OhsUeeu for <drbd-dev@lists.linbit.com>;
	Fri, 20 Dec 2013 10:16:52 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id B61772B7733
	for <drbd-dev@lists.linbit.com>; Fri, 20 Dec 2013 10:16:51 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id BSAXknANJh51 for <drbd-dev@lists.linbit.com>;
	Fri, 20 Dec 2013 10:16:51 +0100 (CET)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 809742B7736
	for <drbd-dev@lists.linbit.com>; Fri, 20 Dec 2013 10:16:50 +0100 (CET)
Resent-Message-ID: <20131220091650.GL31214@soda.linbit>
Date: Thu, 19 Dec 2013 15:16:22 +0530
From: Rashika Kheria <rashika.kheria@gmail.com>
To: linux-kernel@vger.kernel.org
Message-ID: <e392fa86848d078db6ca8e2de9f3a7d151b0b129.1387445396.git.rashika.kheria@gmail.com>
References: <f460591345e87defe53122cf056991c7f2eefa10.1387445396.git.rashika.kheria@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f460591345e87defe53122cf056991c7f2eefa10.1387445396.git.rashika.kheria@gmail.com>
Content-Transfer-Encoding: quoted-printable
Cc: josh@joshtriplett.org, drbd-user@lists.linbit.com,
	Lars Ellenberg <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] [PATCH 10/13] drivers: block: Mark functions as static
	in drbd_main.c
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

Mark functions _drbd_send_uuids(), fill_bitmap_rle_bits() and
init_submitter() as static in drbd/drbd_main.c because they are
not used outside this file.

This eliminates the following warnings in drbd/drbd_main.c:
drivers/block/drbd/drbd_main.c:826:5: warning: no previous prototype for =
=E2=80=98_drbd_send_uuids=E2=80=99 [-Wmissing-prototypes]
drivers/block/drbd/drbd_main.c:1070:5: warning: no previous prototype for=
 =E2=80=98fill_bitmap_rle_bits=E2=80=99 [-Wmissing-prototypes]
drivers/block/drbd/drbd_main.c:2592:5: warning: no previous prototype for=
 =E2=80=98init_submitter=E2=80=99 [-Wmissing-prototypes]

Signed-off-by: Rashika Kheria <rashika.kheria@gmail.com>
Reviewed-by: Josh Triplett <josh@joshtriplett.org>
---
 drivers/block/drbd/drbd_main.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_mai=
n.c
index 4a24e71..3cc0997 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -821,7 +821,7 @@ int drbd_send_protocol(struct drbd_tconn *tconn)
 	return err;
 }
=20
-int _drbd_send_uuids(struct drbd_conf *mdev, u64 uuid_flags)
+static int _drbd_send_uuids(struct drbd_conf *mdev, u64 uuid_flags)
 {
 	struct drbd_socket *sock;
 	struct p_uuids *p;
@@ -1065,7 +1065,7 @@ static void dcbp_set_pad_bits(struct p_compressed_b=
m *p, int n)
 	p->encoding =3D (p->encoding & (~0x7 << 4)) | (n << 4);
 }
=20
-int fill_bitmap_rle_bits(struct drbd_conf *mdev,
+static int fill_bitmap_rle_bits(struct drbd_conf *mdev,
 			 struct p_compressed_bm *p,
 			 unsigned int size,
 			 struct bm_xfer_ctx *c)
@@ -2587,7 +2587,7 @@ void conn_destroy(struct kref *kref)
 	kfree(tconn);
 }
=20
-int init_submitter(struct drbd_conf *mdev)
+static int init_submitter(struct drbd_conf *mdev)
 {
 	/* opencoded create_singlethread_workqueue(),
 	 * to be able to say "drbd%d", ..., minor */
--=20
1.7.9.5

