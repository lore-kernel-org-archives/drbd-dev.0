Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] drbd 2.6.19 crypto changes
Date: Wed, 10 Jan 2007 17:23:46 +0100
References: <20070110123116.GX15730@kwaak.net>
In-Reply-To: <20070110123116.GX15730@kwaak.net>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_TMRpFUMC7Wu93LK"
Message-Id: <200701101723.47571.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

--Boundary-00=_TMRpFUMC7Wu93LK
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Ard,

Here is the result of my work, maybe you can test it with a new
kernel ? -- I only tested it on an old kernel with the old
API.

My idea was to have wrappers that look like the new API for the
old kernels, and make DRBD to use the new API in the DRBD code.

PS: In case you test it, please post the outcome.

-Phil
-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Vivenotgasse 48, 1120 Vienna, Austria        http://www.linbit.com :

--Boundary-00=_TMRpFUMC7Wu93LK
Content-Type: text/x-diff; charset="iso-8859-1"; name="new_crypto_api.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="new_crypto_api.diff"

Index: drbd/drbd_receiver.c
===================================================================
--- drbd/drbd_receiver.c	(revision 2678)
+++ drbd/drbd_receiver.c	(working copy)
@@ -2754,7 +2754,7 @@
 			mdev->tl_hash_s = 0;
 		}
 		if(mdev->cram_hmac_tfm) {
-			crypto_free_tfm(mdev->cram_hmac_tfm);
+			crypto_free_hash(mdev->cram_hmac_tfm);
 			mdev->cram_hmac_tfm = NULL;
 		}
 		kfree(mdev->net_conf);
@@ -2913,8 +2913,20 @@
 	Drbd_Header p;
 	unsigned int key_len = strlen(mdev->net_conf->shared_secret);
 	unsigned int resp_size;
+	struct hash_desc desc;
 	int rv;
 
+	desc.tfm=mdev->cram_hmac_tfm;
+	desc.flags=0;
+
+	rv = crypto_hash_setkey(mdev->cram_hmac_tfm,
+				(u8*)mdev->net_conf->shared_secret, key_len);
+	if(rv) {
+		ERR("crypto_hash_setkey() failed with %d\n",rv);
+		rv = 0;
+		goto fail;
+	}
+
 	get_random_bytes(my_challenge, CHALLENGE_LEN);
 
 	rv = drbd_send_cmd2(mdev,AuthChallenge,my_challenge,CHALLENGE_LEN);
@@ -2951,7 +2963,7 @@
 		goto fail;
 	}
 
-	resp_size = crypto_tfm_alg_digestsize(mdev->cram_hmac_tfm);
+	resp_size = crypto_hash_digestsize(mdev->cram_hmac_tfm);
 	response = kmalloc(resp_size,GFP_KERNEL);
 	if(response == NULL) {
 		ERR("kmalloc of response failed\n");
@@ -2962,9 +2974,14 @@
 	sg.page   = virt_to_page(peers_ch);
 	sg.offset = offset_in_page(peers_ch);
 	sg.length = p.length;
-	crypto_hmac(mdev->cram_hmac_tfm, (u8*)mdev->net_conf->shared_secret,
-		    &key_len, &sg, 1, response);
 
+	rv = crypto_hash_digest(&desc, &sg, sg.length, response);
+	if(rv) {
+		ERR( "crypto_hash_digest() failed with %d\n",rv);
+		rv = 0;
+		goto fail;		
+	}
+
 	rv = drbd_send_cmd2(mdev,AuthResponse,response,resp_size);
 	if (!rv) goto fail;
 
@@ -3002,8 +3019,13 @@
 	sg.page   = virt_to_page(my_challenge);
 	sg.offset = offset_in_page(my_challenge);
 	sg.length = CHALLENGE_LEN;
-	crypto_hmac(mdev->cram_hmac_tfm, (u8*)mdev->net_conf->shared_secret,
-		    &key_len, &sg, 1, right_response);
+	
+	rv = crypto_hash_digest(&desc, &sg, sg.length, right_response);
+	if(rv) {
+		ERR( "crypto_hash_digest() failed with %d\n",rv);
+		rv = 0;
+		goto fail;		
+	}
 
 	rv = ! memcmp(response,right_response,resp_size);
 
Index: drbd/drbd_nl.c
===================================================================
--- drbd/drbd_nl.c	(revision 2678)
+++ drbd/drbd_nl.c	(working copy)
@@ -960,16 +960,19 @@
 	return 0;
 }
 
+#define HMAC_NAME_L 20
+
 STATIC int drbd_nl_net_conf(drbd_dev *mdev, struct drbd_nl_cfg_req *nlp,
 			    struct drbd_nl_cfg_reply *reply)
 {
 	int i,ns;
 	enum ret_codes retcode;
 	struct net_conf *new_conf = NULL;
-	struct crypto_tfm* tfm = NULL;
+	struct crypto_hash *tfm = NULL;
 	struct hlist_head *new_tl_hash = NULL;
 	struct hlist_head *new_ee_hash = NULL;
 	drbd_dev *odev;
+	char hmac_name[HMAC_NAME_L];
 
 	if (mdev->state.conn > StandAlone) {
 		retcode=HaveNetConfig;
@@ -1047,13 +1050,14 @@
 #undef O_PORT
 
 	if( new_conf->cram_hmac_alg[0] != 0) {
-		tfm = crypto_alloc_tfm(new_conf->cram_hmac_alg, 0);
+		snprintf(hmac_name,HMAC_NAME_L,"hmac(%s)",new_conf->cram_hmac_alg);
+		tfm = crypto_alloc_hash(hmac_name, 0, CRYPTO_ALG_ASYNC);
 		if (tfm == NULL) {
 			retcode=CRAMAlgNotAvail;
 			goto fail;
 		}
 
-		if (crypto_tfm_alg_type(tfm) != CRYPTO_ALG_TYPE_DIGEST) {
+		if (crypto_tfm_alg_type(crypto_hash_tfm(tfm)) != CRYPTO_ALG_TYPE_DIGEST) {
 			retcode=CRAMAlgNotDigest;
 			goto fail;
 		}
@@ -1126,7 +1130,7 @@
 	}
 
 	if ( mdev->cram_hmac_tfm ) {
-		crypto_free_tfm(mdev->cram_hmac_tfm);
+		crypto_free_hash(mdev->cram_hmac_tfm);
 	}
 	mdev->cram_hmac_tfm = tfm;
 
@@ -1136,7 +1140,7 @@
 	return 0;
 
   fail:
-	if (tfm) crypto_free_tfm(tfm);
+	if (tfm) crypto_free_hash(tfm);
 	if (new_tl_hash) kfree(new_tl_hash);
 	if (new_ee_hash) kfree(new_ee_hash);
 	if (new_conf) kfree(new_conf);
Index: drbd/drbd_compat_wrappers.h
===================================================================
--- drbd/drbd_compat_wrappers.h	(revision 2678)
+++ drbd/drbd_compat_wrappers.h	(working copy)
@@ -242,3 +242,86 @@
 #endif
 
 #endif
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,19)
+/* With Linux-2.6.19 the crypto API changed! */
+/* This is not a generic backport of the new api, it just implements
+   the corner case of "hmac(xxx)".  */
+
+#define CRYPTO_ALG_ASYNC 4711
+
+struct crypto_hash {
+        struct crypto_tfm *base;
+	const u8 *key;
+	int keylen;
+};
+
+struct hash_desc {
+        struct crypto_hash *tfm;
+        u32 flags;
+};
+
+static inline struct crypto_hash *
+crypto_alloc_hash(char *alg_name, u32 type, u32 mask)
+{
+	struct crypto_hash *ch;
+	char *closing_bracket;
+
+	// "hmac(xxx)" is in alg_name we need that xxx. 
+	closing_bracket = strchr(alg_name,')');
+	if(!closing_bracket) return NULL;
+	if(closing_bracket-alg_name < 6) return NULL;
+
+	ch = kmalloc(sizeof(struct crypto_hash),GFP_KERNEL);
+	if(!ch) return NULL;
+
+	*closing_bracket = 0;
+	ch->base = crypto_alloc_tfm(alg_name + 5, 0);
+	*closing_bracket = ')';
+
+	if (ch->base == NULL) {
+		kfree(ch);
+		return NULL;
+	}
+
+	return ch;
+}
+
+static inline int 
+crypto_hash_setkey(struct crypto_hash *hash,const u8 *key,unsigned int keylen)
+{
+	hash->key = key;
+	hash->keylen = keylen;
+
+	return 0;
+}
+
+static inline int 
+crypto_hash_digest(struct hash_desc *desc, struct scatterlist *sg,
+		   unsigned int nbytes, u8 *out)
+{
+	
+	crypto_hmac(desc->tfm->base, (u8*)desc->tfm->key,
+		    &desc->tfm->keylen, sg, 1 /* ! */ , out);
+	/* ! this is not generic. Would need to convert nbytes -> nsg */
+
+	return 0;
+}
+
+static inline void crypto_free_hash(struct crypto_hash *tfm)
+{
+	crypto_free_tfm(tfm->base);
+	kfree(tfm);
+}
+
+static inline unsigned int crypto_hash_digestsize(struct crypto_hash *tfm)
+{
+	return crypto_tfm_alg_digestsize(tfm->base);
+}
+
+static inline struct crypto_tfm *crypto_hash_tfm(struct crypto_hash *tfm)
+{
+        return tfm->base;
+}
+
+#endif
Index: drbd/drbd_main.c
===================================================================
--- drbd/drbd_main.c	(revision 2678)
+++ drbd/drbd_main.c	(working copy)
@@ -2490,7 +2490,7 @@
 void drbd_free_resources(drbd_dev *mdev)
 {
 	if ( mdev->cram_hmac_tfm ) {
-		crypto_free_tfm(mdev->cram_hmac_tfm);
+		crypto_free_hash(mdev->cram_hmac_tfm);
 		mdev->cram_hmac_tfm = NULL;
 	}
 	drbd_free_sock(mdev);
Index: drbd/drbd_int.h
===================================================================
--- drbd/drbd_int.h	(revision 2678)
+++ drbd/drbd_int.h	(working copy)
@@ -851,7 +851,7 @@
 	unsigned int al_tr_number;
 	int al_tr_cycle;
 	int al_tr_pos;     // position of the next transaction in the journal
-	struct crypto_tfm* cram_hmac_tfm;
+	struct crypto_hash* cram_hmac_tfm;
 	wait_queue_head_t seq_wait;
 	atomic_t packet_seq;
 	unsigned int peer_seq;

--Boundary-00=_TMRpFUMC7Wu93LK--
