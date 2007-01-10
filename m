Return-Path: <ard@kwaak.net>
Received: from mail.kwaak.net (gw-cistron.kwaak.net [62.216.22.210])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 6D2352D9E0D8
	for <drbd-dev@lists.linbit.com>; Wed, 10 Jan 2007 13:31:29 +0100 (CET)
Received: from ard by mail.kwaak.net with local (Exim 4.50) id 1H4cbs-0006rd-Gg
	for drbd-dev@lists.linbit.com; Wed, 10 Jan 2007 13:31:16 +0100
Date: Wed, 10 Jan 2007 13:31:16 +0100
To: drbd-dev@lists.linbit.com
Message-ID: <20070110123116.GX15730@kwaak.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
From: Ard van Breemen <ard@kwaak.net>
Subject: [Drbd-dev] drbd 2.6.19 crypto changes
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

This is a preliminary patch as in: as far as I can see it
*should* work.
Biggest change in the crypto api is that calls are more
encapsulated.
Instead of a hmac, we talk about hash only. We allocate and free
hash structures, independent what kind of hash.
To calculate the digest there are now 2 calls necessary: a call
to setkey (if you want to use a key), and a call to generate the
digest itself.
This patch tries to keep the changes contained at a single point.
This means we set the hash_key 2 times instead of being clever
and setting it once in a more central point, and use that later
on a few times.
Anyway: it compiles without warning, it loads, what more do we
want.

Index: drbd-latest/drbd/drbd_receiver.c
===================================================================
--- drbd-latest/drbd/drbd_receiver.c	(revision 2678)
+++ drbd-latest/drbd/drbd_receiver.c	(working copy)
@@ -2754,7 +2754,11 @@ STATIC void drbd_disconnect(drbd_dev *md
 			mdev->tl_hash_s = 0;
 		}
 		if(mdev->cram_hmac_tfm) {
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,19)
 			crypto_free_tfm(mdev->cram_hmac_tfm);
+#else
+			crypto_free_hash(mdev->cram_hmac_tfm);
+#endif
 			mdev->cram_hmac_tfm = NULL;
 		}
 		kfree(mdev->net_conf);
@@ -2951,7 +2955,11 @@ STATIC int drbd_do_auth(drbd_dev *mdev)
 		goto fail;
 	}
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,19)
 	resp_size = crypto_tfm_alg_digestsize(mdev->cram_hmac_tfm);
+#else
+	resp_size = crypto_hash_digestsize(mdev->cram_hmac_tfm);
+#endif
 	response = kmalloc(resp_size,GFP_KERNEL);
 	if(response == NULL) {
 		ERR("kmalloc of response failed\n");
@@ -2962,8 +2970,22 @@ STATIC int drbd_do_auth(drbd_dev *mdev)
 	sg.page   = virt_to_page(peers_ch);
 	sg.offset = offset_in_page(peers_ch);
 	sg.length = p.length;
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,19)
 	crypto_hmac(mdev->cram_hmac_tfm, (u8*)mdev->net_conf->shared_secret,
 		    &key_len, &sg, 1, response);
+#else
+	{
+		struct hash_desc desc;
+		int ret;
+		desc.tfm=mdev->cram_hmac_tfm;
+		desc.flags=0;
+		ret=crypto_hash_setkey(mdev->cram_hmac_tfm,
+			(u8*)mdev->net_conf->shared_secret, key_len);
+		if(ret) printk("crypto_has_setkey()@" __FILE__":%d failed ret=%d\n",__LINE__,ret);
+		ret=crypto_hash_digest(&desc, &sg, sg.length, response);
+		if(ret) printk("crypto_has_digest()@" __FILE__":%d failed ret=%d\n",__LINE__,ret);
+	}
+#endif
 
 	rv = drbd_send_cmd2(mdev,AuthResponse,response,resp_size);
 	if (!rv) goto fail;
@@ -3002,8 +3024,22 @@ STATIC int drbd_do_auth(drbd_dev *mdev)
 	sg.page   = virt_to_page(my_challenge);
 	sg.offset = offset_in_page(my_challenge);
 	sg.length = CHALLENGE_LEN;
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,19)
 	crypto_hmac(mdev->cram_hmac_tfm, (u8*)mdev->net_conf->shared_secret,
 		    &key_len, &sg, 1, right_response);
+#else
+	{
+		struct hash_desc desc;
+		int ret;
+		desc.tfm=mdev->cram_hmac_tfm;
+		desc.flags=0;
+		ret=crypto_hash_setkey(mdev->cram_hmac_tfm,
+			(u8*)mdev->net_conf->shared_secret, key_len);
+		if(ret) printk("crypto_has_setkey()@" __FILE__":%d failed ret=%d\n",__LINE__,ret);
+		ret=crypto_hash_digest(&desc, &sg, sg.length, right_response);
+		if(ret) printk("crypto_has_digest()@" __FILE__":%d failed ret=%d\n",__LINE__,ret);
+	}
+#endif
 
 	rv = ! memcmp(response,right_response,resp_size);
 
Index: drbd-latest/drbd/drbd_nl.c
===================================================================
--- drbd-latest/drbd/drbd_nl.c	(revision 2678)
+++ drbd-latest/drbd/drbd_nl.c	(working copy)
@@ -966,7 +966,11 @@ STATIC int drbd_nl_net_conf(drbd_dev *md
 	int i,ns;
 	enum ret_codes retcode;
 	struct net_conf *new_conf = NULL;
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,19)
 	struct crypto_tfm* tfm = NULL;
+#else
+	struct crypto_hash *tfm = NULL;
+#endif
 	struct hlist_head *new_tl_hash = NULL;
 	struct hlist_head *new_ee_hash = NULL;
 	drbd_dev *odev;
@@ -1047,13 +1051,17 @@ STATIC int drbd_nl_net_conf(drbd_dev *md
 #undef O_PORT
 
 	if( new_conf->cram_hmac_alg[0] != 0) {
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,19)
 		tfm = crypto_alloc_tfm(new_conf->cram_hmac_alg, 0);
+#else
+		tfm = crypto_alloc_hash(new_conf->cram_hmac_alg, 0, CRYPTO_ALG_ASYNC);
+#endif
 		if (tfm == NULL) {
 			retcode=CRAMAlgNotAvail;
 			goto fail;
 		}
 
-		if (crypto_tfm_alg_type(tfm) != CRYPTO_ALG_TYPE_DIGEST) {
+		if (crypto_tfm_alg_type(crypto_hash_tfm(tfm)) != CRYPTO_ALG_TYPE_DIGEST) {
 			retcode=CRAMAlgNotDigest;
 			goto fail;
 		}
@@ -1126,7 +1134,11 @@ FIXME LGE
 	}
 
 	if ( mdev->cram_hmac_tfm ) {
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,19)
 		crypto_free_tfm(mdev->cram_hmac_tfm);
+#else
+		crypto_free_hash(mdev->cram_hmac_tfm);
+#endif
 	}
 	mdev->cram_hmac_tfm = tfm;
 
@@ -1136,7 +1148,11 @@ FIXME LGE
 	return 0;
 
   fail:
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,19)
 	if (tfm) crypto_free_tfm(tfm);
+#else
+	if (tfm) crypto_free_hash(tfm);
+#endif
 	if (new_tl_hash) kfree(new_tl_hash);
 	if (new_ee_hash) kfree(new_ee_hash);
 	if (new_conf) kfree(new_conf);
Index: drbd-latest/drbd/drbd_main.c
===================================================================
--- drbd-latest/drbd/drbd_main.c	(revision 2678)
+++ drbd-latest/drbd/drbd_main.c	(working copy)
@@ -2490,7 +2490,11 @@ void drbd_free_sock(drbd_dev *mdev)
 void drbd_free_resources(drbd_dev *mdev)
 {
 	if ( mdev->cram_hmac_tfm ) {
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,19)
 		crypto_free_tfm(mdev->cram_hmac_tfm);
+#else
+		crypto_free_hash(mdev->cram_hmac_tfm);
+#endif
 		mdev->cram_hmac_tfm = NULL;
 	}
 	drbd_free_sock(mdev);
Index: drbd-latest/drbd/drbd_int.h
===================================================================
--- drbd-latest/drbd/drbd_int.h	(revision 2678)
+++ drbd-latest/drbd/drbd_int.h	(working copy)
@@ -851,7 +851,11 @@ struct Drbd_Conf {
 	unsigned int al_tr_number;
 	int al_tr_cycle;
 	int al_tr_pos;     // position of the next transaction in the journal
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,19)
 	struct crypto_tfm* cram_hmac_tfm;
+#else
+	struct crypto_hash* cram_hmac_tfm;
+#endif
 	wait_queue_head_t seq_wait;
 	atomic_t packet_seq;
 	unsigned int peer_seq;
