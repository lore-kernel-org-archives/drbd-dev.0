Return-Path: <Markus.Elfring@web.de>
Received: from mout.web.de (mout.web.de [212.227.15.14])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 3C3C54202D0
	for <drbd-dev@lists.linbit.com>; Wed, 29 Mar 2023 15:40:09 +0200 (CEST)
Message-ID: <18b0a6f6-8a18-2073-1e73-78bceac03fad@web.de>
Date: Wed, 29 Mar 2023 15:40:07 +0200
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
Subject: [Drbd-dev] [PATCH 1/3] lru_cache: Return directly after a failed
 kzalloc() in lc_create()
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

Date: Wed, 29 Mar 2023 14:45:34 +0200

1. Return directly after a call of the function =E2=80=9Ckzalloc=E2=80=9D =
failed
   at the beginning in these function implementations.

2. Omit extra initialisations (for the variables =E2=80=9Cslot=E2=80=9D an=
d =E2=80=9Celement=E2=80=9D)
   which became unnecessary with this refactoring.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 lib/lru_cache.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/lib/lru_cache.c b/lib/lru_cache.c
index b3d9187611de..e0db27b3a2d7 100644
=2D-- a/lib/lru_cache.c
+++ b/lib/lru_cache.c
@@ -78,8 +78,8 @@ struct lru_cache *lc_create(const char *name, struct kme=
m_cache *cache,
 		unsigned max_pending_changes,
 		unsigned e_count, size_t e_size, size_t e_off)
 {
-	struct hlist_head *slot =3D NULL;
-	struct lc_element **element =3D NULL;
+	struct hlist_head *slot;
+	struct lc_element **element;
 	struct lru_cache *lc;
 	struct lc_element *e;
 	unsigned cache_obj_size =3D kmem_cache_size(cache);
@@ -96,7 +96,8 @@ struct lru_cache *lc_create(const char *name, struct kme=
m_cache *cache,

 	slot =3D kcalloc(e_count, sizeof(struct hlist_head), GFP_KERNEL);
 	if (!slot)
-		goto out_fail;
+		return NULL;
+
 	element =3D kcalloc(e_count, sizeof(struct lc_element *), GFP_KERNEL);
 	if (!element)
 		goto out_fail;
=2D-
2.40.0

