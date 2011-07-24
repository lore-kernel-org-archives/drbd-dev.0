Return-Path: <lars.ellenberg@linbit.com>
Resent-Message-ID: <20110725091403.GF31805@barkeeper1-xen.linbit>
Received: from swan.nt.tuwien.ac.at (swan.nt.tuwien.ac.at [128.131.67.158])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id F03441056784
	for <drbd-dev@lists.linbit.com>; Mon, 25 Jul 2011 01:44:25 +0200 (CEST)
Date: Mon, 25 Jul 2011 01:38:48 +0200
From: Thomas Zeitlhofer <thomas.zeitlhofer@nt.tuwien.ac.at>
To: drbd-dev@lists.linbit.com
Message-ID: <20110724233847.GA2356@swan.nt.tuwien.ac.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Drbd-dev] [PATCH] initialize tconn->peer_integrity_tfm in
	drbd_adm_connect()
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

The support for data-integrity-alg seems to be broken with drbd-8.4.0.
E.g., when trying to resync, the SyncTarget hits:

   ASSERTION IS_ALIGNED(data_size, 512) FAILED in read_in_block
   error receiving RSDataReply, e: -5 l: 126996! read_in_block

This is caused by an uninitialized tconn->peer_integrity_tfm. Therefore,
the digest data is not used/removed at the receiver which leads to
additional 20 bytes that trigger the assertion above.

Initializing tconn->peer_integrity_tfm the same way as tconn->integrity_tfm
seems to fix the problem.

Signed-off-by: Thomas Zeitlhofer <thomas.zeitlhofer@nt.tuwien.ac.at>
---
 drbd/drbd_nl.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drbd/drbd_nl.c b/drbd/drbd_nl.c
index 7fd6408..8095f3b 100644
--- a/drbd/drbd_nl.c
+++ b/drbd/drbd_nl.c
@@ -1864,6 +1864,7 @@ struct crypto {
 	struct crypto_hash *csums_tfm;
 	struct crypto_hash *cram_hmac_tfm;
 	struct crypto_hash *integrity_tfm;
+	struct crypto_hash *peer_integrity_tfm;
 	void *int_dig_in;
 	void *int_dig_vv;
 };
@@ -1902,6 +1903,10 @@ alloc_crypto(struct crypto *crypto, struct net_conf *new_conf)
 		       ERR_INTEGRITY_ALG);
 	if (rv != NO_ERROR)
 		return rv;
+	rv = alloc_hash(&crypto->peer_integrity_tfm, new_conf->integrity_alg,
+		       ERR_INTEGRITY_ALG);
+	if (rv != NO_ERROR)
+		return rv;
 	if (new_conf->cram_hmac_alg[0] != 0) {
 		snprintf(hmac_name, CRYPTO_MAX_ALG_NAME, "hmac(%s)",
 			 new_conf->cram_hmac_alg);
@@ -1928,6 +1933,7 @@ static void free_crypto(struct crypto *crypto)
 	kfree(crypto->int_dig_vv);
 	crypto_free_hash(crypto->cram_hmac_tfm);
 	crypto_free_hash(crypto->integrity_tfm);
+	crypto_free_hash(crypto->peer_integrity_tfm);
 	crypto_free_hash(crypto->csums_tfm);
 	crypto_free_hash(crypto->verify_tfm);
 }
@@ -2152,6 +2158,7 @@ int drbd_adm_connect(struct sk_buff *skb, struct genl_info *info)
 	tconn->int_dig_vv = crypto.int_dig_vv;
 	tconn->cram_hmac_tfm = crypto.cram_hmac_tfm;
 	tconn->integrity_tfm = crypto.integrity_tfm;
+	tconn->peer_integrity_tfm = crypto.peer_integrity_tfm;
 	tconn->csums_tfm = crypto.csums_tfm;
 	tconn->verify_tfm = crypto.verify_tfm;
 
-- 
1.7.2.5

