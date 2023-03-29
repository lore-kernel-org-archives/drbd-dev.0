Return-Path: <Markus.Elfring@web.de>
Received: from mout.web.de (mout.web.de [212.227.15.4])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 105894202D0
	for <drbd-dev@lists.linbit.com>; Wed, 29 Mar 2023 15:44:43 +0200 (CEST)
Message-ID: <ccdb761c-9ca1-fb59-467b-fb4d34adc65a@web.de>
Date: Wed, 29 Mar 2023 15:44:42 +0200
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
Subject: [Drbd-dev] [PATCH 3/3] lru_cache: Improve exception handling in
	lc_create()
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

Date: Wed, 29 Mar 2023 15:20:39 +0200

The label =E2=80=9Cout_fail=E2=80=9D was used to jump to a kfree() call de=
spite of
the detail in the implementation of the function =E2=80=9Clc_create=E2=80=
=9D
that it was determined already that a corresponding variable contained
a null pointer because of a failed memory allocation.

Thus use more appropriate labels instead.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 lib/lru_cache.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/lib/lru_cache.c b/lib/lru_cache.c
index 31820f03b146..fdc8bd6fc888 100644
=2D-- a/lib/lru_cache.c
+++ b/lib/lru_cache.c
@@ -100,11 +100,11 @@ struct lru_cache *lc_create(const char *name, struct=
 kmem_cache *cache,

 	element =3D kcalloc(e_count, sizeof(*element), GFP_KERNEL);
 	if (!element)
-		goto out_fail;
+		goto free_slot;

 	lc =3D kzalloc(sizeof(*lc), GFP_KERNEL);
 	if (!lc)
-		goto out_fail;
+		goto free_element;

 	INIT_LIST_HEAD(&lc->in_use);
 	INIT_LIST_HEAD(&lc->lru);
@@ -142,8 +142,9 @@ struct lru_cache *lc_create(const char *name, struct k=
mem_cache *cache,
 		kmem_cache_free(cache, p - e_off);
 	}
 	kfree(lc);
-out_fail:
+free_element:
 	kfree(element);
+free_slot:
 	kfree(slot);
 	return NULL;
 }
=2D-
2.40.0

