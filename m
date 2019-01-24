Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
	[209.85.221.67])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 2CFF6103B4AE
	for <drbd-dev@lists.linbit.com>; Thu, 24 Jan 2019 17:49:07 +0100 (CET)
Received: by mail-wr1-f67.google.com with SMTP id v13so7235594wrw.5
	for <drbd-dev@lists.linbit.com>; Thu, 24 Jan 2019 08:49:07 -0800 (PST)
Received: from soda.linbit (212-186-191-219.static.upcbusiness.at.
	[212.186.191.219]) by smtp.gmail.com with ESMTPSA id
	b12sm30486386wmj.3.2019.01.24.08.43.02
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 24 Jan 2019 08:43:02 -0800 (PST)
Resent-Message-ID: <20190124164300.GH13258@soda.linbit>
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 64FC4103B4B2
	for <drbd-dev@lists.linbit.com>; Thu, 24 Jan 2019 06:04:37 +0100 (CET)
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Philipp Reisner
	<philipp.reisner@linbit.com>, Lars Ellenberg <lars.ellenberg@linbit.com>,
	Jens Axboe <axboe@kernel.dk>, Joshua Morris <josh.h.morris@us.ibm.com>,
	Philip Kelleher <pjk1939@linux.ibm.com>
Date: Thu, 24 Jan 2019 04:54:50 +0000
Message-ID: <BYAPR04MB45022D08A83F69712FEC0D95869A0@BYAPR04MB4502.namprd04.prod.outlook.com>
References: <20190123064501.GA26147@embeddedor>
In-Reply-To: <20190123064501.GA26147@embeddedor>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>
Subject: Re: [Drbd-dev] [PATCH] block: Mark expected switch fall-throughs
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


Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>




From: linux-block-owner@vger.kernel.org <linux-block-owner@vger.kernel.org>=
 on behalf of Gustavo A. R. Silva <gustavo@embeddedor.com>
Sent: Tuesday, January 22, 2019 10:45 PM
To: Philipp Reisner; Lars Ellenberg; Jens Axboe; Joshua Morris; Philip Kell=
eher
Cc: drbd-dev@lists.linbit.com; linux-block@vger.kernel.org; linux-kernel@vg=
er.kernel.org; Gustavo A. R. Silva
Subject: [PATCH] block: Mark expected switch fall-throughs
=A0=20
=20
In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

This patch fixes the following warnings:

drivers/block/drbd/drbd_int.h:1774:6: warning: this statement may fall thro=
ugh [-Wimplicit-fallthrough=3D]
drivers/block/drbd/drbd_int.h:1774:6: warning: this statement may fall thro=
ugh [-Wimplicit-fallthrough=3D]
drivers/block/drbd/drbd_int.h:1774:6: warning: this statement may fall thro=
ugh [-Wimplicit-fallthrough=3D]
drivers/block/drbd/drbd_int.h:1774:6: warning: this statement may fall thro=
ugh [-Wimplicit-fallthrough=3D]
drivers/block/drbd/drbd_int.h:1774:6: warning: this statement may fall thro=
ugh [-Wimplicit-fallthrough=3D]
drivers/block/drbd/drbd_receiver.c:3093:6: warning: this statement may fall=
 through [-Wimplicit-fallthrough=3D]
drivers/block/drbd/drbd_receiver.c:3120:6: warning: this statement may fall=
 through [-Wimplicit-fallthrough=3D]
drivers/block/drbd/drbd_req.c:856:6: warning: this statement may fall throu=
gh [-Wimplicit-fallthrough=3D]

Warning level 3 was used: -Wimplicit-fallthrough=3D3

This patch is part of the ongoing efforts to enabling
-Wimplicit-fallthrough

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
=A0drivers/block/drbd/drbd_int.h=A0=A0=A0=A0=A0 | 2 +-
=A0drivers/block/drbd/drbd_receiver.c | 4 ++--
=A0drivers/block/drbd/drbd_req.c=A0=A0=A0=A0=A0 | 2 +-
=A0drivers/block/rsxx/core.c=A0=A0=A0=A0=A0=A0=A0=A0=A0 | 1 +
=A04 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index 000a2f4c0e92..f070f7200fc0 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -1778,7 +1778,7 @@ static inline void __drbd_chk_io_error_(struct drbd_d=
evice *device,
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 _drbd_set_state(_NS(device, disk, D_INCONSISTENT), CS=
_HARD, NULL);
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 br=
eak;
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* NOTE fall through for DRBD_M=
ETA_IO_ERROR or DRBD_FORCE_DETACH */
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* fall through - for DRBD_META=
_IO_ERROR or DRBD_FORCE_DETACH */
=A0=A0=A0=A0=A0=A0=A0=A0 case EP_DETACH:
=A0=A0=A0=A0=A0=A0=A0=A0 case EP_CALL_HELPER:
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* Remember whether we saw=
 a READ or WRITE error.
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_r=
eceiver.c
index c7ad88d91a09..74350663443f 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -3094,7 +3094,7 @@ static int drbd_asb_recover_0p(struct drbd_peer_devic=
e *peer_device) __must_hold
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 rv=
 =3D=A0 1;
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 br=
eak;
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* Else fall through to one of =
the other strategies... */
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* Else fall through - to one o=
f the other strategies... */
=A0=A0=A0=A0=A0=A0=A0=A0 case ASB_DISCARD_OLDER_PRI:
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (self =3D=3D 0 && peer =
=3D=3D 1) {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 rv=
 =3D 1;
@@ -3119,7 +3119,7 @@ static int drbd_asb_recover_0p(struct drbd_peer_devic=
e *peer_device) __must_hold
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (after_sb_0p =3D=3D ASB=
_DISCARD_ZERO_CHG)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 br=
eak;
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* else: fall through */
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* else, fall through */
=A0=A0=A0=A0=A0=A0=A0=A0 case ASB_DISCARD_LEAST_CHG:
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if=A0=A0=A0=A0=A0 (ch_self=
 < ch_peer)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 rv=
 =3D -1;
diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index 643a04af213b..3809c7e6be8c 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -866,7 +866,7 @@ int __req_mod(struct drbd_request *req, enum drbd_req_e=
vent what,
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 } =
/* else: FIXME can this happen? */
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 br=
eak;
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* else, fall through to BARRIE=
R_ACKED */
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* else, fall through - to BARR=
IER_ACKED */
=A0
=A0=A0=A0=A0=A0=A0=A0=A0 case BARRIER_ACKED:
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* barrier ack for READ re=
quests does not make sense */
diff --git a/drivers/block/rsxx/core.c b/drivers/block/rsxx/core.c
index 0cf4509d575c..898d522e8338 100644
--- a/drivers/block/rsxx/core.c
+++ b/drivers/block/rsxx/core.c
@@ -439,6 +439,7 @@ static void card_state_change(struct rsxx_cardinfo *car=
d,
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * Fall through so the D=
MA devices can be attached and
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * the user can attempt =
to pull off their data.
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 */
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* fall through */
=A0=A0=A0=A0=A0=A0=A0=A0 case CARD_STATE_GOOD:
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st =3D rsxx_get_card_size8=
(card, &card->size8);
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (st)
--=20
2.20.1

    =
