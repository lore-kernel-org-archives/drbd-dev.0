Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
	[209.85.221.68])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 1D2851011BFC
	for <drbd-dev@lists.linbit.com>; Mon, 27 May 2019 17:42:26 +0200 (CEST)
Received: by mail-wr1-f68.google.com with SMTP id t4so9009786wrx.7
	for <drbd-dev@lists.linbit.com>; Mon, 27 May 2019 08:42:26 -0700 (PDT)
Received: from soda.linbit (212-186-191-219.static.upcbusiness.at.
	[212.186.191.219])
	by smtp.gmail.com with ESMTPSA id w2sm4981967wru.16.2019.05.27.08.42.25
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 27 May 2019 08:42:25 -0700 (PDT)
Resent-Message-ID: <20190527154222.GA5803@soda.linbit>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 1FDF01011BFF
	for <drbd-dev@lists.linbit.com>; Mon,  6 May 2019 00:23:30 +0200 (CEST)
From: Helge Deller <deller@gmx.de>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Jens Axboe <axboe@kernel.dk>, drbd-dev@lists.linbit.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20190505222327.GA32268@ls3530.dellerweb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [Drbd-dev] [PATCH] drbd: Rename LEVEL to VLI_LEVEL to avoid name
	clash
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
Date: Mon, 27 May 2019 15:42:27 -0000

Using a generic word like LEVEL is bad idea - it can easily clash with ano=
ther
LEVEL defined somewhere else.
In this case, it clashed with the LEVEL defined in arch/parisc/include/asm=
/assembly.h
when the header file got included via jump_level.h.

This patch replaces the LEVEL defined in drbd_vli.h by VLI_LEVEL.
Another patch renames the LEVEL defined in arch/parisc/include/asm/assembl=
y.h.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/drivers/block/drbd/drbd_vli.h b/drivers/block/drbd/drbd_vli.h
index 8cb1532a3816..d7ced8626035 100644
=2D-- a/drivers/block/drbd/drbd_vli.h
+++ b/drivers/block/drbd/drbd_vli.h
@@ -121,22 +121,22 @@ prefix    data bits                                 =
   max val  N=BA data bits
  1             16              32                              64
 */

-/* LEVEL: (total bits, prefix bits, prefix value),
+/* VLI_LEVEL: (total bits, prefix bits, prefix value),
  * sorted ascending by number of total bits.
  * The rest of the code table is calculated at compiletime from this. */

 /* fibonacci data 1, 1, ... */
 #define VLI_L_1_1() do { \
-	LEVEL( 2, 1, 0x00); \
-	LEVEL( 3, 2, 0x01); \
-	LEVEL( 5, 3, 0x03); \
-	LEVEL( 7, 4, 0x07); \
-	LEVEL(10, 5, 0x0f); \
-	LEVEL(14, 6, 0x1f); \
-	LEVEL(21, 8, 0x3f); \
-	LEVEL(29, 8, 0x7f); \
-	LEVEL(42, 8, 0xbf); \
-	LEVEL(64, 8, 0xff); \
+	VLI_LEVEL( 2, 1, 0x00); \
+	VLI_LEVEL( 3, 2, 0x01); \
+	VLI_LEVEL( 5, 3, 0x03); \
+	VLI_LEVEL( 7, 4, 0x07); \
+	VLI_LEVEL(10, 5, 0x0f); \
+	VLI_LEVEL(14, 6, 0x1f); \
+	VLI_LEVEL(21, 8, 0x3f); \
+	VLI_LEVEL(29, 8, 0x7f); \
+	VLI_LEVEL(42, 8, 0xbf); \
+	VLI_LEVEL(64, 8, 0xff); \
 	} while (0)

 /* finds a suitable level to decode the least significant part of in.
@@ -147,7 +147,7 @@ static inline int vli_decode_bits(u64 *out, const u64 =
in)
 {
 	u64 adj =3D 1;

-#define LEVEL(t,b,v)					\
+#define VLI_LEVEL(t,b,v)				\
 	do {						\
 		if ((in & ((1 << b) -1)) =3D=3D v) {	\
 			*out =3D ((in & ((~0ULL) >> (64-t))) >> b) + adj;	\
@@ -160,7 +160,7 @@ static inline int vli_decode_bits(u64 *out, const u64 =
in)

 	/* NOT REACHED, if VLI_LEVELS code table is defined properly */
 	BUG();
-#undef LEVEL
+#undef VLI_LEVEL
 }

 /* return number of code bits needed,
@@ -173,7 +173,7 @@ static inline int __vli_encode_bits(u64 *out, const u6=
4 in)
 	if (in =3D=3D 0)
 		return -EINVAL;

-#define LEVEL(t,b,v) do {		\
+#define VLI_LEVEL(t,b,v) do {		\
 		max +=3D 1ULL << (t - b);	\
 		if (in <=3D max) {	\
 			if (out)	\
@@ -186,7 +186,7 @@ static inline int __vli_encode_bits(u64 *out, const u6=
4 in)
 	VLI_L_1_1();

 	return -EOVERFLOW;
-#undef LEVEL
+#undef VLI_LEVEL
 }

 #undef VLI_L_1_1
