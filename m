Return-Path: <Markus.Elfring@web.de>
Received: from mout.web.de (mout.web.de [212.227.15.4])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id DF69B420168
	for <drbd-dev@lists.linbit.com>; Sat, 25 Mar 2023 15:13:04 +0100 (CET)
Message-ID: <941709b5-d940-42c9-5f31-7ed56e3e6151@web.de>
Date: Sat, 25 Mar 2023 15:07:54 +0100
MIME-Version: 1.0
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, drbd-dev@lists.linbit.com,
	linux-block@vger.kernel.org, =?UTF-8?Q?Christoph_B=c3=b6hmwalder?=
	<christoph.boehmwalder@linbit.com>,
	Jens Axboe <axboe@kernel.dk>, Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
	<8d193937-532f-959f-9b84-d911984508aa@web.de>
In-Reply-To: <8d193937-532f-959f-9b84-d911984508aa@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
Subject: [Drbd-dev] [PATCH resent] drbd: Fix exception handling in
 nla_put_drbd_cfg_context()
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

Date: Fri, 17 Mar 2023 18:32:05 +0100

The label =E2=80=9Cnla_put_failure=E2=80=9D was used to jump to another po=
inter check
despite of the detail in the implementation of the function
=E2=80=9Cnla_put_drbd_cfg_context=E2=80=9D that it was determined already =
that
the corresponding variable contained a null pointer.

* Thus return directly after a call of the function
  =E2=80=9Cnla_nest_start_noflag=E2=80=9D failed.

* Delete an extra pointer check which became unnecessary
  with this refactoring.


This issue was detected by using the Coccinelle software.

Fixes: 543cc10b4cc5c60aa9fcc62705ccfb9998bf4697 ("drbd: drbd_adm_get_statu=
s needs to show some more detail")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/block/drbd/drbd_nl.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index f49f2a5282e1..9cb947127472 100644
=2D-- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -3187,7 +3187,7 @@ static int nla_put_drbd_cfg_context(struct sk_buff *=
skb,
 	struct nlattr *nla;
 	nla =3D nla_nest_start_noflag(skb, DRBD_NLA_CFG_CONTEXT);
 	if (!nla)
-		goto nla_put_failure;
+		return -EMSGSIZE;
 	if (device &&
 	    nla_put_u32(skb, T_ctx_volume, device->vnr))
 		goto nla_put_failure;
@@ -3205,8 +3205,7 @@ static int nla_put_drbd_cfg_context(struct sk_buff *=
skb,
 	return 0;

 nla_put_failure:
-	if (nla)
-		nla_nest_cancel(skb, nla);
+	nla_nest_cancel(skb, nla);
 	return -EMSGSIZE;
 }

=2D-
2.40.0

