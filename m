Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id D8A6A101AC78
	for <drbd-dev@lists.linbit.com>; Tue, 25 Feb 2014 14:00:52 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id CF4B33207A5
	for <drbd-dev@lists.linbit.com>; Tue, 25 Feb 2014 14:00:52 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 3ixTYEQzLz5a for <drbd-dev@lists.linbit.com>;
	Tue, 25 Feb 2014 14:00:52 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id B0EAE3207F3
	for <drbd-dev@lists.linbit.com>; Tue, 25 Feb 2014 14:00:52 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id pw6tbdUM0BtN for <drbd-dev@lists.linbit.com>;
	Tue, 25 Feb 2014 14:00:52 +0100 (CET)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 6418F3207A5
	for <drbd-dev@lists.linbit.com>; Tue, 25 Feb 2014 14:00:52 +0100 (CET)
Resent-Message-ID: <20140225130051.GI21096@soda.linbit>
Date: Tue, 25 Feb 2014 13:11:35 +0530
From: Rashika Kheria <rashika.kheria@gmail.com>
To: linux-kernel@vger.kernel.org
Message-ID: <616a0d7efd9e54541f9038f0816b97f2336e9e78.1393313946.git.rashika.kheria@gmail.com>
References: <7bf34999aea7f3d1441dc8fc344882a814da6e06.1393313946.git.rashika.kheria@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7bf34999aea7f3d1441dc8fc344882a814da6e06.1393313946.git.rashika.kheria@gmail.com>
Content-Transfer-Encoding: quoted-printable
Cc: josh@joshtriplett.org, drbd-user@lists.linbit.com,
	Lars Ellenberg <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] [PATCH 2/8] lib: Mark function as static in
	lib/lru_cache.c
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

Mark function as static in lib/lru_cache.c because it is not used
outside this file.

This eliminates the following warning in lib/lru_cache.c:
lib/lru_cache.c:172:6: warning: no previous prototype for =E2=80=98lc_fre=
e_by_index=E2=80=99 [-Wmissing-prototypes]

Signed-off-by: Rashika Kheria <rashika.kheria@gmail.com>
Reviewed-by: Josh Triplett <josh@joshtriplett.org>
---
 lib/lru_cache.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/lru_cache.c b/lib/lru_cache.c
index 4a83ecd..6111cd1 100644
--- a/lib/lru_cache.c
+++ b/lib/lru_cache.c
@@ -169,7 +169,7 @@ out_fail:
 	return NULL;
 }
=20
-void lc_free_by_index(struct lru_cache *lc, unsigned i)
+static void lc_free_by_index(struct lru_cache *lc, unsigned i)
 {
 	void *p =3D lc->lc_element[i];
 	WARN_ON(!p);
--=20
1.7.9.5

