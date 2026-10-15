Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE814EFFCF
	for <drbd-dev@lists.linux.dev>; Thu, 15 Oct 2026 22:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792103286; cv=none; b=WTxAajmbnX4Y6IKSjrk3C4Kjm26diAmG2VS2LyPZqutiQkcKOxgT3/QYtSwU8gpizr4OtI+gfEFGmQxCHqFVIzGqqXBuT8aT4zcuEXWClwy4lQabcAWCdbnzNOHOYQ5wGtd79Y21qgWuhwoOdFI7oSlz0zcWawnZtf7oJ43LZNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792103286; c=relaxed/simple;
	bh=bVJbmuh2Z6L0fhHJG0FQsb2y8FSWqxobc73yJaXV8aU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=slUxRclPm7/uObtQBsHR2XJorNhLJR2bKIWMIwb4pM9VsJKV0gAHIewPhCklbGVzlVTopGUHei0ys1zTVXRMeSYsaAN9ECXGW/qU0KSqkGPo5yL0PyNDJ2Og8zVsLJXqiitOsQrt3jhATPMqYOe+J8EJxTcHNcNTjU2a59z47Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B6mAdZRn; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B6mAdZRn"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-35d0be18c71so467644eec.1
        for <drbd-dev@lists.linux.dev>; Thu, 15 Oct 2026 15:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792103284; x=1792708084; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6uo7AcE10nfV9W8UwlYp+hn2TzXz6q+VsQs/rEy/+Mk=;
        b=B6mAdZRn+74Uo7VJWpWleFShkMEH1yqwMuY3xgJZLN98EW1KajfM1IXwHrgyHgB6D2
         6vCoWCFga64K7wMNzhB1qNIloh0Lm7CJAUCrYfyO2NkAExV8rFqYNxXTlKNauzt7WoLE
         eXjteuSgBwgxfWpI3uNjtsv3ucPU7r49VVPQA7BAyA4VshMEz/9vSq4REc7snoqYU50O
         EaCYbOIP2XAbS6gpYhWgR+FUsLHWcRwCTsvb9T6VdRreenORmJB9dGgk9+5sz8wdHf6k
         YDqVx0DHTWicSrjzc28zluSkJowyYezICRsBOOxA7MiY3f+xty7YhPCI5CxuKeV9L5wh
         MfKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792103284; x=1792708084;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6uo7AcE10nfV9W8UwlYp+hn2TzXz6q+VsQs/rEy/+Mk=;
        b=XpgPI6/vMSGJnPCjdZNstqsFRmEzPE7Ix+DCMmPgVd7zVmPu+42vBqwKKfPHBW/uqZ
         J1rfR/cMXoN5FJ9sQHd6XMGRuPoTWop0kieoG4sMNX/uZGTMM+cLN05/gZBUIWAAiDTx
         X5q8V//nFhH4Z8czT9b1lsmYZUhkgnYMaaZ65CrVW5xF6tXIg4uNa/ejRAkVY136aq0c
         XAbc7eg/UBW/SV3bcyBgqjbi+KXTNUJx7MOg7T7pTooqio2Ul+Q6JaX2CwPxgqdzvuqE
         bEU0Tx/hv0/Bo63eCjBgT40CbefWY0p4dm2HC0bTUVxti3JXKuvnnAAoxjr0y2mRW1/h
         BYOA==
X-Gm-Message-State: AFq9FYKEgMHOHTUJQRrU+U90L4ngUa7Gfr45dc1Lvdveh0elePFWBzIl
	av0UjDbXam/Q1xE/aLsxll5LQPHyimK+gWtmfRdzottDaITgIi64LorX
X-Gm-Gg: AYBFou2BSlS9SvggUaiR6b6MKL0g8+2V3KqGJkp0w3n1NHFBYWydZacvR7Xkly5cum5
	ttrwLEiXYlj7qo7mR67Jkuq5wMYVg6P2NZ2Veq5uUJezBvgcu2c9nY+b/TT7Sorzl5ekNapPhJt
	rmkVL6HNgIvPrrKHW4IjldXGCmCUOHZFPA4i8qrGEMRMrin5xiXumDacHMsYDGcuPGskpR/kre5
	bejehPfIfmYibEz7Hb5+i5K42ofzj0wzIwbcHNZIcXL7ITiBhF/5miU2lp0XwH0np6oVXOaBOtX
	8TJF/Ej1NfhIi3S6WRXJRcULzvcMMbtTHIoTfvAfdGz9I7HnvROaec/6uuljTs2vvUBg2lpghMz
	9MP63nxTr5HSj5YjjK0Cb51qwCCJgvaZ6nCLMSD+/f0vFAbZt239+pw9VXhq0Zxv3zwoZ7tjw6u
	eq3BQATbuOgg5yUIiTvXFnLC5o8tFNDdK1cI702Wy4/ozmsnhWF1K4UW0NcYvufVSnqCVKxWHHA
	ZpyP8jinLz5ZYiESySzaL0M0clFpkD/bCPtLaCBnmJBpbRfrsaWC/WhXRK94k5JHcwu8gsz4TA=
X-Received: by 2002:a05:7022:3a8a:b0:15b:1959:15e0 with SMTP id a92af1059eb24-182570eccd1mr1740173c88.4.1792103283611;
        Thu, 15 Oct 2026 15:28:03 -0700 (PDT)
Received: from yibos-mbp.3500.dhcp.asu.edu ([2620:d8:8000:8078:404b:acf5:562d:50f2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36081fa5a6esm873307eec.16.2026.10.15.15.28.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 15 Oct 2026 15:28:03 -0700 (PDT)
From: Yibo Liu <yiboliume@gmail.com>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: drbd-dev@lists.linux.dev,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yibo Liu <yiboliume@gmail.com>
Subject: [PATCH 2/2] drbd: validate digest size in checksum resync and verify requests
Date: Thu, 15 Oct 2026 15:28:00 -0700
Message-Id: <20261015222800.85928-3-yiboliume@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261015222800.85928-1-yiboliume@gmail.com>
References: <20261015222800.85928-1-yiboliume@gmail.com>
Precedence: bulk
X-Mailing-List: drbd-dev@lists.linux.dev
List-Id: <drbd-dev.lists.linux.dev>
List-Subscribe: <mailto:drbd-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:drbd-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

receive_DataRequest() takes the digest length of P_CSUM_RS_REQUEST and
P_OV_REPLY packets from the packet header and passes it to kmalloc()
without any check. The worker later compares the received digest with
one computed by the local csums or verify algorithm. A size mismatch is
only reported by D_ASSERT(), and memcmp() runs anyway.

A digest that is shorter than the algorithm's digest size therefore
makes w_e_end_csum_rs_req() and w_e_end_ov_reply() read past the end of
the digest_info allocation:

  BUG: KASAN: slab-out-of-bounds in memcmp+0x1b8/0x1d8
  Read of size 8 at addr ffff00000a638610 by task drbd_w_r1/212
  Call trace:
   memcmp
   w_e_end_csum_rs_req
   drbd_worker
  Allocated by task 240:
   __kmalloc_noprof
   receive_DataRequest
   drbd_receiver

A digest length larger than the page allocator can serve triggers the
WARN_ON_ONCE() for oversized allocations, as GFP_NOIO does not include
__GFP_NOWARN:

  WARNING: mm/page_alloc.c:5340 at __alloc_frozen_pages_noprof
  Call trace:
   ___kmalloc_large_node
   __kmalloc_noprof
   receive_DataRequest
   drbd_receiver

Reject these packets unless the digest length matches the digest size
of the configured csums or verify algorithm, and also reject them when
no such algorithm is configured. In the worker, only compare digests of
the same size: the peer can switch csums-alg or verify-alg with
P_SYNC_PARAM after the request was received, and a size mismatch is
then treated as "not in sync" instead of reading out of bounds.

Fixes: b411b3637fa7 ("The DRBD driver")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Yibo Liu <yiboliume@gmail.com>
---

Notes:
    - Reproduced in the same setup with csums-alg=sha1, the proxy rewriting
      one P_CSUM_RS_REQUEST: a 0-byte digest gives the KASAN report above,
      a 1 GiB digest length gives the WARNING above. With the patch both are
      rejected with "CsumRSRequest: unexpected digest size ..." and there is
      no KASAN report or warning. A complete csums-alg resync followed by an
      online verify with verify-alg=sha1, without tampering, still passes.
      The harness is available on request.
    - In LINBIT's DRBD 9 tree, receive_digest() only rejects negative sizes
      and the sender keeps the D_ASSERT() before memcmp(), so the pending
      DRBD 9 rework series probably needs the same checks. I have not
      checked the posted series itself.

 drivers/block/drbd/drbd_receiver.c | 9 +++++++++
 drivers/block/drbd/drbd_worker.c   | 8 ++++----
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 97b306676626..87e714477050 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -2629,6 +2629,7 @@ static int receive_DataRequest(struct drbd_connection *connection, struct packet
 	sector_t capacity;
 	struct drbd_peer_request *peer_req;
 	struct digest_info *di = NULL;
+	struct crypto_shash *tfm;
 	int size, verb;
 	struct p_block_req *p =	pi->data;
 
@@ -2713,6 +2714,14 @@ static int receive_DataRequest(struct drbd_connection *connection, struct packet
 
 	case P_OV_REPLY:
 	case P_CSUM_RS_REQUEST:
+		tfm = pi->cmd == P_OV_REPLY ? connection->verify_tfm :
+					      connection->csums_tfm;
+		if (!tfm || pi->size != crypto_shash_digestsize(tfm)) {
+			drbd_err(device, "%s: unexpected digest size %u\n",
+				 cmdname(pi->cmd), pi->size);
+			goto out_free_e;
+		}
+
 		di = kmalloc(sizeof(*di) + pi->size, GFP_NOIO);
 		if (!di)
 			goto out_free_e;
diff --git a/drivers/block/drbd/drbd_worker.c b/drivers/block/drbd/drbd_worker.c
index 0697f99fed18..31e54960c5de 100644
--- a/drivers/block/drbd/drbd_worker.c
+++ b/drivers/block/drbd/drbd_worker.c
@@ -1174,8 +1174,8 @@ int w_e_end_csum_rs_req(struct drbd_work *w, int cancel)
 		 * introducing more locking mechanisms */
 		if (peer_device->connection->csums_tfm) {
 			digest_size = crypto_shash_digestsize(peer_device->connection->csums_tfm);
-			D_ASSERT(device, digest_size == di->digest_size);
-			digest = kmalloc(digest_size, GFP_NOIO);
+			if (digest_size == di->digest_size)
+				digest = kmalloc(digest_size, GFP_NOIO);
 		}
 		if (digest) {
 			drbd_csum_ee(peer_device->connection->csums_tfm, peer_req, digest);
@@ -1301,8 +1301,8 @@ int w_e_end_ov_reply(struct drbd_work *w, int cancel)
 		if (digest) {
 			drbd_csum_ee(peer_device->connection->verify_tfm, peer_req, digest);
 
-			D_ASSERT(device, digest_size == di->digest_size);
-			eq = !memcmp(digest, di->digest, digest_size);
+			eq = digest_size == di->digest_size &&
+			     !memcmp(digest, di->digest, digest_size);
 			kfree(digest);
 		}
 	}
-- 
2.39.5 (Apple Git-154)

