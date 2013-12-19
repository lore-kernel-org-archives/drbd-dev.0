Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 9086F105B0CF
	for <drbd-dev@lists.linbit.com>; Fri, 20 Dec 2013 10:16:53 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 8E35B2B7731
	for <drbd-dev@lists.linbit.com>; Fri, 20 Dec 2013 10:16:53 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id ce_w64cfRTht for <drbd-dev@lists.linbit.com>;
	Fri, 20 Dec 2013 10:16:53 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 7259E2B7734
	for <drbd-dev@lists.linbit.com>; Fri, 20 Dec 2013 10:16:53 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id dutNdjDusHom for <drbd-dev@lists.linbit.com>;
	Fri, 20 Dec 2013 10:16:53 +0100 (CET)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 55B7A2B7731
	for <drbd-dev@lists.linbit.com>; Fri, 20 Dec 2013 10:16:53 +0100 (CET)
Resent-Message-ID: <20131220091653.GN31214@soda.linbit>
Date: Thu, 19 Dec 2013 15:18:37 +0530
From: Rashika Kheria <rashika.kheria@gmail.com>
To: linux-kernel@vger.kernel.org
Message-ID: <2850430f20d631a56978de8884341521d2c3016a.1387445397.git.rashika.kheria@gmail.com>
References: <f460591345e87defe53122cf056991c7f2eefa10.1387445396.git.rashika.kheria@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f460591345e87defe53122cf056991c7f2eefa10.1387445396.git.rashika.kheria@gmail.com>
Content-Transfer-Encoding: quoted-printable
Cc: josh@joshtriplett.org, drbd-user@lists.linbit.com,
	Lars Ellenberg <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] [PATCH 12/13] drivers: block: Mark function as static in
	drbd_state.c
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

Mark functions conn_old_common_state() and conn_set_state() as static in
drbd/drbd_state.c because they are not used outside this file.

This eliminates the following warnings in drbd/drbd_state.c:
drivers/block/drbd/drbd_state.c:1585:6: warning: no previous prototype fo=
r =E2=80=98conn_old_common_state=E2=80=99 [-Wmissing-prototypes]
drivers/block/drbd/drbd_state.c:1674:1: warning: no previous prototype fo=
r =E2=80=98conn_set_state=E2=80=99 [-Wmissing-prototypes]

Signed-off-by: Rashika Kheria <rashika.kheria@gmail.com>
Reviewed-by: Josh Triplett <josh@joshtriplett.org>
---
 drivers/block/drbd/drbd_state.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/block/drbd/drbd_state.c b/drivers/block/drbd/drbd_st=
ate.c
index 120e1c0..9c20c34 100644
--- a/drivers/block/drbd/drbd_state.c
+++ b/drivers/block/drbd/drbd_state.c
@@ -1579,7 +1579,8 @@ static int w_after_conn_state_ch(struct drbd_work *=
w, int unused)
 	return 0;
 }
=20
-void conn_old_common_state(struct drbd_tconn *tconn, union drbd_state *p=
cs, enum chg_state_flags *pf)
+static void conn_old_common_state(struct drbd_tconn *tconn,
+		union drbd_state *pcs, enum chg_state_flags *pf)
 {
 	enum chg_state_flags flags =3D ~0;
 	struct drbd_conf *mdev;
@@ -1667,7 +1668,7 @@ conn_is_valid_transition(struct drbd_tconn *tconn, =
union drbd_state mask, union
 	return rv;
 }
=20
-void
+static void
 conn_set_state(struct drbd_tconn *tconn, union drbd_state mask, union dr=
bd_state val,
 	       union drbd_state *pns_min, union drbd_state *pns_max, enum chg_s=
tate_flags flags)
 {
--=20
1.7.9.5

