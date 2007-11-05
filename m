Return-Path: <stf_xl@wp.pl>
Received: from bxn46.internetdsl.tpnet.pl (HELO lapsg1.open-e.pl)
	(stf_xl@wp.pl@[83.18.247.46]) (envelope-sender <stf_xl@wp.pl>)
	by smtp.wp.pl (WP-SMTPD) with AES256-SHA encrypted SMTP
	for <drbd-dev@lists.linbit.com>; 5 Nov 2007 13:02:46 +0100
From: Stanislaw Gruszka <stf_xl@wp.pl>
To: drbd-dev@lists.linbit.com
Date: Mon, 5 Nov 2007 13:04:49 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200711051304.49960.stf_xl@wp.pl>
Subject: [Drbd-dev] don't memset null pointer
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hi, this is trivial fix for memset null pointer:

diff --git a/drbd/lru_cache.c b/drbd/lru_cache.c
index a3171b6..37ab276 100644
--- a/drbd/lru_cache.c
+++ b/drbd/lru_cache.c
@@ -57,8 +57,8 @@ struct lru_cache *lc_alloc(const char *name, unsigned int e_count,
 	bytes *= e_count;
 	bytes += sizeof(struct lru_cache);
 	lc     = vmalloc(bytes);
-	memset(lc, 0, bytes);
 	if (lc) {
+		memset(lc, 0, bytes);
 		INIT_LIST_HEAD(&lc->in_use);
 		INIT_LIST_HEAD(&lc->lru);
 		INIT_LIST_HEAD(&lc->free);
