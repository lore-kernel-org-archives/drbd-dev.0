Return-Path: <Markus.Elfring@web.de>
Received: from mout.web.de (mout.web.de [212.227.15.3])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 7CA6A4202D0
	for <drbd-dev@lists.linbit.com>; Wed, 29 Mar 2023 15:42:09 +0200 (CEST)
Message-ID: <f03b9407-0336-e949-e98d-9e0ddf3bfa57@web.de>
Date: Wed, 29 Mar 2023 15:42:07 +0200
MIME-Version: 1.0
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, drbd-dev@lists.linbit.com,
	=?UTF-8?Q?Christoph_B=c3=b6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>
References: <6cbcf640-55e5-2f11-4a09-716fe681c0d2@web.de>
	<33226beb-4fe2-3da5-5d69-a33e683dec57@web.de>
In-Reply-To: <33226beb-4fe2-3da5-5d69-a33e683dec57@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
Subject: [Drbd-dev] [PATCH 2/3] lru_cache: Improve two size determinations
	in lc_create()
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

Date: Wed, 29 Mar 2023 15:00:13 +0200

Replace the specification of data structures by pointer dereferences
as the parameter for the operator =E2=80=9Csizeof=E2=80=9D to make the cor=
responding size
determination a bit safer according to the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 lib/lru_cache.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/lru_cache.c b/lib/lru_cache.c
index e0db27b3a2d7..31820f03b146 100644
=2D-- a/lib/lru_cache.c
+++ b/lib/lru_cache.c
@@ -94,11 +94,11 @@ struct lru_cache *lc_create(const char *name, struct k=
mem_cache *cache,
 	if (e_count > LC_MAX_ACTIVE)
 		return NULL;

-	slot =3D kcalloc(e_count, sizeof(struct hlist_head), GFP_KERNEL);
+	slot =3D kcalloc(e_count, sizeof(*slot), GFP_KERNEL);
 	if (!slot)
 		return NULL;

-	element =3D kcalloc(e_count, sizeof(struct lc_element *), GFP_KERNEL);
+	element =3D kcalloc(e_count, sizeof(*element), GFP_KERNEL);
 	if (!element)
 		goto out_fail;

=2D-
2.40.0

