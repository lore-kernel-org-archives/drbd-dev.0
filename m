Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792520564;
	b=dBCP9YJNF93G1tp7Mn9qmIKa5UYgqi6RDLn33U1YtmbLdF4cd6mE+HedwwEPk+qOcmBV
	 0JM+3FuGJh9iSddCu87ayQpWuyYS3skQumqoBA2UxxOcBOkJMXXBnpj0zfD5NI8flYm/t
	 arpBE3l9CXE1B1j0hxRHdxgsmH+RnBQLEpb9RwGSMpmq88entTkan6P5oU0Ypc7Rnhc0j
	 +h+cAETpSrDcwUYfoZRCTDCdbTAr8mQfJtCkIqHG/lnPTzcV6DV8ZLiNdBsSk6IbYIzHu
	 xbEhMhB8dPiwR7QEkFlSzJR4WMTHItIG0XlXU+eXRLgqotLP+85Q4fY0ZJqSCpj9Jeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792520564;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=QBkELidHnujeG3xBjThPr+adF0FJwgUwsd5WBy30Lkc=;
	b=MHi5o46pFIfFb2iqWn6SzGBX6V3MEVo85KDbCcik+wJvCVGPNu6dcqLPKfmVktlLXbFY
	 /ypbtAsOWKpebFY+q1vnV/n2AFp3q7iu20jv1Z38eWG/c1/lJfpVtWGVRwP4umZBGD0m/
	 FomPJgi7R2RsvnW7j/f00CrtiRd+myktp6xYiiCiJPLOBll7Nv4cRprGPuU+6y+MYXlKs
	 e34cYVFf13egYQv6+0KPxrRSdK2DEp5l5enhgCyp/BswwSUeeGRhkZHuefkt+5dIA4Fe2
	 q2F9/NZJNHZHMFkstpmB+7D+q7+oWP7gLphmicYtU0gRhoyGP8YJ9DQ02fedZZEmFng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZAdiC5qo;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B955E606A327
	for <drbd-dev@lists.linux.dev>; Tue, 20 Oct 2026 18:22:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B955E606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZAdiC5qo
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-3514b90bb89so9736887eec.1
        for <drbd-dev@lists.linux.dev>; Tue, 20 Oct 2026 11:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792520563; x=1793125363; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QBkELidHnujeG3xBjThPr+adF0FJwgUwsd5WBy30Lkc=;
        b=ZAdiC5qoUuBGI9cnsEvgdJEXoi/BB2Pud58WQRgePHhCeCtjDoVQVdrAYdyIwHpG8N
         Fs4lQbjvjHCKl3n6vZcZXyg05AjxJjNN9mzsUigiNp7wB5IxSpWQ9KaSub30JddDPS4y
         WOwCleHlOUlhFVRf3IrJAq5C3p2Hn+R+DiZWMRTGiZirLiHx9WMCHeykbLGoyqg1I47X
         +1Y13MY8VoCgt7DdClY9B+yusWND9UBe6Cxkh/IjGIbHE7xpPnMFSIc4Gm7IZpU2NFAE
         8eRiFJlZIyNnYckYnt5DQ0Eqv1AbN+nWA7hk1+B3Ak1KXb+GXoLemAaB02ksd6t4wmjw
         n8Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792520563; x=1793125363;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QBkELidHnujeG3xBjThPr+adF0FJwgUwsd5WBy30Lkc=;
        b=edkPGtRb3Yr7yvlmkcgdNTQ9r7bkPZ1pxHARibfuFG2U+MC3DdBK4whLPCT9sGOWgg
         SLzaKQfCfSRx4lGytFIiAZ8viuih5UhoG+LmBW+iZB8qeNENwhyIbgnGLTmm8FcUT/Hg
         kBQFcmWF37pCjV6KucqQwIbWpjwzwebRcJZi7cnInT3H+E7XHqdpToNNHHXMulbqH5to
         so1h9s4GNUxJY3ZmQL1biYWzicafZ4/4FWPyU4Y3nWa8GSJcej+6b9jnDQUid1JdCyKc
         Sqn+1D09OrdbSStUF+JtfCYC+eowv98K+4aeVP30AdLsHeq0S+8/fLzPgMdlXPAgWLK1
         Sz1A==
X-Gm-Message-State: AFq9FYKdNQNdZ02+YTzE2fuLFHHd2g3qlu7HYbww/OybFNNsBJPLZcm9
	a9LhyQltPPZrbt/CrI8gAJ8yM2zE4/3jaqgKIjqyrk37nNpPjc9LiYfS
X-Gm-Gg: AYBFou22h00Xcj0SQQ6K04GjUFxJeoxc7PESKQbIy2mrSXtYL0Cg1imu+FNgFmXoCmg
	RTAILlH0kjCxEwDEhx1rQvFr3XPu3Ts1csYUZLeUlVTuCBbBkDNbcDdFEWaGuvQnqcOrDMR5jJy
	s0MAyMyGFvwLcZNkPOhJJGMuh8AVBHF+j1W8PdbmZ1vh0UufQQ3NNFzMvRzbViN4jqXltuJ9AFV
	6qNGNaHXjH3mgStbK3o8pCjc5e81YUYG897QiJvGxGTCxQ/JY2ikLeNiKDG9NikeqnlI89TFjDX
	WnriLhhXbTWpRzWG1WclQ4LJLkEvsPl0zbkl5m1vgvIWAMPH64r/QGA01ZZ1sc+CNce2BM3TTVh
	q7krHLAzLTT9WN9AMulkIA2BWHVYDLcrCUUHSY2fc0qtroToYXm5vgaLM+lyjakhkmSHgjtxcQ5
	6scRYO0hPmvTOUSrw/ipe46dT1py/wgZJ23so04ulkFyFB/EYgqqw4o/cZM6B2IjETWaWX4HItn
	14Ex6K2rsciJmWqRK8K4vErVMrXfEJlGZQghmOHkOj/Dhm+v15+47k=
X-Received: by 2002:a05:693c:65cc:b0:367:23b6:94e1 with SMTP id 5a478bee46e88-3674e25bf5cmr71459eec.41.1792520562401;
        Tue, 20 Oct 2026 11:22:42 -0700 (PDT)
Received: from localhost.localdomain ([206.206.192.161])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36740cc8439sm402866eec.11.2026.10.20.11.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 11:22:41 -0700 (PDT)
From: Yibo Liu <yiboliume@gmail.com>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: drbd-dev@lists.linux.dev,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	co+0845f49852fd568f@bugs.sh,
	Yibo Liu <yiboliume@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] drbd: validate digest size in checksum resync and verify requests
Date: Tue, 20 Oct 2026 18:22:00 +0000
Message-Id: <20261020182200.236875-1-yiboliume@gmail.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: drbd-dev@lists.linux.dev
List-Id: <drbd-dev.lists.linux.dev>
List-Post: <mailto:drbd-dev@lists.linux.dev>
List-Help: <mailto:drbd-dev+help@lists.linux.dev>
List-Subscribe: <mailto:drbd-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:drbd-dev+unsubscribe@lists.linux.dev>
List-Owner: <mailto:drbd-dev+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

receive_DataRequest() sizes the digest buffer of P_CSUM_RS_REQUEST and
P_OV_REPLY packets from the length the peer puts in the packet header,
without checking it against the digest size of the negotiated csums-alg
or verify-alg. w_e_end_csum_rs_req() and w_e_end_ov_reply() later
memcmp() crypto_shash_digestsize() bytes of that buffer; the D_ASSERT()
on the size only logs a message.

A peer that sends a shorter digest thus causes a slab-out-of-bounds read
in the worker, and a peer that declares a huge length makes the receiver
attempt an oversized kmalloc() that triggers a page allocator warning.

  BUG: KASAN: slab-out-of-bounds in memcmp (lib/string.c:676)
  Read of size 8 at addr ff11000007b9d630 by task drbd_w_r0/601
  Call Trace:
   memcmp (lib/string.c:676)
   w_e_end_csum_rs_req (drivers/block/drbd/drbd_worker.c:1182)
   drbd_worker (drivers/block/drbd/drbd_worker.c:2189)
   drbd_thread_setup (drivers/block/drbd/drbd_main.c:314)
   kthread (kernel/kthread.c:436)
   ret_from_fork (arch/x86/kernel/process.c:158)
   ret_from_fork_asm (arch/x86/entry/entry_64.S:245)

  Allocated by task 605:
   __kmalloc_noprof (mm/slub.c:5439)
   receive_DataRequest (drivers/block/drbd/drbd_receiver.c:2715)
   drbd_receiver (drivers/block/drbd/drbd_receiver.c:5371)
   drbd_thread_setup (drivers/block/drbd/drbd_main.c:314)
   kthread (kernel/kthread.c:436)

Reject the packet and drop the connection unless the declared digest
length matches the digest size of the corresponding transform, or if
no such transform is configured.

Fixes: b411b3637fa7 ("The DRBD driver")
Cc: stable@vger.kernel.org
Reported-by: co+0845f49852fd568f@bugs.sh
Signed-off-by: Yibo Liu <yiboliume@gmail.com>
---
Changes in v2:
- Drop patch 1/2 (P_DATA_REPLY size check); this is now a single patch.
- Check the digest length only in receive_DataRequest(), before the
  buffer is allocated, and leave drbd_worker.c unchanged: with the exact
  size enforced on receive, the sizes compared in the worker always match.

v1: https://lore.kernel.org/all/20261015222800.85928-1-yiboliume@gmail.com/

 drivers/block/drbd/drbd_receiver.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 2135c14354a8..d45c4e68f83b 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -2711,7 +2711,17 @@ static int receive_DataRequest(struct drbd_connection *connection, struct packet
 		break;
 
 	case P_OV_REPLY:
-	case P_CSUM_RS_REQUEST:
+	case P_CSUM_RS_REQUEST: {
+		struct crypto_shash *tfm = pi->cmd == P_CSUM_RS_REQUEST ?
+			peer_device->connection->csums_tfm :
+			peer_device->connection->verify_tfm;
+
+		if (!tfm || pi->size != crypto_shash_digestsize(tfm)) {
+			drbd_err(device, "%s: unexpected digest size %u\n",
+				 cmdname(pi->cmd), pi->size);
+			goto out_free_e;
+		}
+
 		di = kmalloc(sizeof(*di) + pi->size, GFP_NOIO);
 		if (!di)
 			goto out_free_e;
@@ -2742,6 +2752,7 @@ static int receive_DataRequest(struct drbd_connection *connection, struct packet
 			goto submit_for_resync;
 		}
 		break;
+	}
 
 	case P_OV_REQUEST:
 		if (device->ov_start_sector == ~(sector_t)0 &&

base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
-- 
2.34.1

