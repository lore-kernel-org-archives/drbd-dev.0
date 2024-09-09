Return-Path: <m.lobanov@rosalinux.ru>
Received: from mail.rosalinux.ru (mail.rosalinux.ru [195.19.76.54])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id E6B374201EE
	for <drbd-dev@lists.linbit.com>; Mon,  9 Sep 2024 15:50:30 +0200 (CEST)
From: Mikhail Lobanov <m.lobanov@rosalinux.ru>
To: Philipp Reisner <philipp.reisner@linbit.com>
Subject: [PATCH] drbd: Add NULL check for net_conf to prevent dereference in
	state validation
Date: Mon,  9 Sep 2024 09:37:36 -0400
Message-ID: <20240909133740.84297-1-m.lobanov@rosalinux.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Cc: Jens Axboe <axboe@kernel.dk>, lvc-project@linuxtesting.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	linux-block@vger.kernel.org, Mikhail Lobanov <m.lobanov@rosalinux.ru>,
	Lars Ellenberg <lars.ellenberg@linbit.com>, drbd-dev@lists.linbit.com
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <https://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <https://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

If the net_conf pointer is NULL and the code attempts to access its=20
fields without a check, it will lead to a null pointer dereference.
Add a NULL check before dereferencing the pointer.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 44ed167da748 ("drbd: rcu_read_lock() and rcu_dereference() for tco=
nn->net_conf")
Cc: stable@vger.kernel.org
Signed-off-by: Mikhail Lobanov <m.lobanov@rosalinux.ru>
---
 drivers/block/drbd/drbd_state.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_state.c b/drivers/block/drbd/drbd_st=
ate.c
index 287a8d1d3f70..87cf5883078f 100644
--- a/drivers/block/drbd/drbd_state.c
+++ b/drivers/block/drbd/drbd_state.c
@@ -876,7 +876,7 @@ is_valid_state(struct drbd_device *device, union drbd=
_state ns)
 		  ns.disk =3D=3D D_OUTDATED)
 		rv =3D SS_CONNECTED_OUTDATES;
=20
-	else if ((ns.conn =3D=3D C_VERIFY_S || ns.conn =3D=3D C_VERIFY_T) &&
+	else if (nc && (ns.conn =3D=3D C_VERIFY_S || ns.conn =3D=3D C_VERIFY_T)=
 &&
 		 (nc->verify_alg[0] =3D=3D 0))
 		rv =3D SS_NO_VERIFY_ALG;
=20
--=20
2.43.0

