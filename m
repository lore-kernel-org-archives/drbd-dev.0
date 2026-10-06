Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EC722A4EE
	for <drbd-dev@lists.linux.dev>; Tue,  6 Oct 2026 03:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791259060; cv=none; b=elsRUeXXDZPd4X0IuQoTYgBhYoKNTE5LxF57w7Ji9AwcWkXNbEBgRQnKrkKh1ngmIcu8WP6+6JbwTUScA45tC0HY3tusjeRQJI7onhLF1WfFOG4HMCREFVEDm5fjWsQAp28ZYtOLH2p+k+io01rYN6OYsi3pJB2IWSCyHAL1M78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791259060; c=relaxed/simple;
	bh=AKFO+6kMRIf999SHyvoUrdjxxCfFmmXdHeh9Zljcz8g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pJQ4HqLVNcWscPQzpknc5oEqKwliT+b7TgBtX0l+ht14u0/4SsCP5cEH/fKCdDgL77VqgsJqKi8Y4Ey66/SZ4c+VszSz39GRCtSU5dy8vaWyhiBOaYgkDjSTyn7SgQ8S+yyG8cNkJWuU6TBNKpy101Jf9rLFLZ5IqpSUKvlu8lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=UUFLZ7U+; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="UUFLZ7U+"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3a4a7eb86a4so354148a91.3
        for <drbd-dev@lists.linux.dev>; Mon, 05 Oct 2026 20:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1791259056; x=1791863856; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FIg2j8cR5l8EWHD0aFToxc23c2wafCfRdD264dRHKCg=;
        b=UUFLZ7U+jSySkaRePB02zNqLQEJwYCv9MLZBp3xyfsaDxd0j9p5xwhZte04ev0otC9
         B0gR9Db7qBY95ASZ9bxgpyuFJTCpxinbr2XR6T3kB7p296SH5w1wzU9bodI7psUi0pq0
         hKmsoIthZweIMVCYiUiesO5gbVT7TltIhwy8Z8ah1mXzzOgE3KRBN67UV53+fjUy4NYt
         vGOkk1XbYK/7NSNbgcpLd91Ik43kSnZj3AqLf07NQNHxyZv9fFvwz1R3tuhgCFMrYFRJ
         YXYo7+yVuorgRYVNpnAMoqru/X8OlqVtB397fLKLFg44rvbu74dZO6ykS6hlm1R581qT
         Kd+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791259056; x=1791863856;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FIg2j8cR5l8EWHD0aFToxc23c2wafCfRdD264dRHKCg=;
        b=gsOM3CDH/a2/+xWfyYUG2P3Nnsl8oeJ1iMMPys5xGTyM+g41QQuCeS5LpYLwqNbHD7
         84FlOPrnt1Tn5l5/HdCWjZ5POnt7hdOoodRE67aie3IpDHMcJY+XmBunBrsiTNZejjbl
         wC9JAfoOd9WJ765YYNnm8929pzUXkcg6juoD+k6Cb50FPxo/C4H3XEFhWhCeuShfowYL
         Gfrom4QISTgqBPN4k88YjOvFVLziSwObdEQJ+xy5Y48UMe+7MQGRlX+8wqWeL+O4nbBm
         cW/Ztjt6cx+u78UnnZdrOqbic2YfYjSjViRc56R1wXyS4WsE2H00XmaAgatIYfxhZrBB
         WnXQ==
X-Forwarded-Encrypted: i=1; AKwUvBxWVYE5YbBFz9K5euAkbL3R4Xa+W5ps1b5/scZANaJBBpI3Pp8wj5iSP1K3epYPawRfO7fruN1sKw==@lists.linux.dev
X-Gm-Message-State: AFq9FYKLzcYwnigCoQCcgUBZM/VLlfmI46VWyoziK3jxbPbifiNxnRTB
	dPrD02mapaqVCP4Qsm8NiTL8tL7S3Krk6IpCgrOwLUg05Q7k5kIEMTbi+BqujXuLv3g=
X-Gm-Gg: AYBFou1x6kJz7J1PkY97VjUlgPE1Sv7Rn3KPcPux9fL3hPeKyGMkfFlKKvqjBVzfCVi
	LNflgZEGeFXkOU5rBY/rLuE1w8bitFd7gV5EyLHmal96C/Xwgb0yfthW37SG1kbbMetpXTRCoLF
	opI2kB9vJbycqd4T3yiksFkmAhZRK7+zRIk041OFNtnym2O3bRBQsxTg3nmSMPYe57nOs4WJhQB
	a2rn76M47JZAgpATDjjPzgEfOJbXoyxzIjyOV79X+vRYKdqcjwceuHflHS8zNaIFG1QQSqWhxZx
	l0CGw/8kt6PXCf8XlcQAGeFbfgDpUh2IEjFso6SK0DW7ixJ0lBs3JVTZxZcmrOcCTSfKv+sRc5Z
	yzh/+VzO9XLi4wcQt4eDCPNvQ2N40TS/mzbmw2m3NnD044MQ3t5//Z75rnGfSrQUTMBhalQ+rqF
	Pw4IW5f03MmUPCakOQPVXi3cQ4aVSLKo+wanErj0X9fUiqqtawXnVRlqKkCy7SO2BWR71onPiwF
	HbYsyEQyaIOZGemYkrmDA==
X-Received: by 2002:a17:90b:3d43:b0:3a0:7591:ad7a with SMTP id 98e67ed59e1d1-3a8726b57a2mr111120a91.5.1791259055781;
        Mon, 05 Oct 2026 20:57:35 -0700 (PDT)
Received: from yhlee-960QFG.Davolink ([2406:5900:1044:110c:5364:bba9:2adf:d611])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a853e66d7fsm2543601a91.5.2026.10.05.20.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 20:57:35 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Jens Axboe <axboe@kernel.dk>,
	drbd-dev@lists.linux.dev,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Yehyeong Lee <yhlee@isslab.korea.ac.kr>,
	stable@vger.kernel.org
Subject: [PATCH] drbd: reject an out-of-range offset when decoding a compressed bitmap
Date: Tue,  6 Oct 2026 12:57:13 +0900
Message-ID: <20261006035715.354417-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: drbd-dev@lists.linux.dev
List-Id: <drbd-dev.lists.linux.dev>
List-Subscribe: <mailto:drbd-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:drbd-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

recv_bm_rle_bits() decodes a run-length-encoded bitmap from the peer and
accumulates the bit position s across the runs.  The upper bound
(e >= c->bm_bits) is only checked in the branch taken for a set-bits
(toggle) run, so a clear run advances s with no check at all.  A peer can
make s run past the bitmap with a single run; it is stored in
c->bit_offset unvalidated, recv_bm_rle_bits() returns "not done"
(s != c->bm_bits), and receive_bitmap() goes on to the next packet.

The following plain P_BITMAP packet computes c->bm_words - c->word_offset,
which underflows once word_offset is past bm_words, and drbd_bm_merge_lel()
turns the result into an out-of-range word offset.  drbd_bm_merge_lel()
only WARN_ON()s that and proceeds into bm_word_to_page_idx(), which
BUG_ON()s on the out-of-range page index.  A malicious or buggy peer can
thus panic the node with a crafted bitmap during the bitmap exchange.

Reject a decoded offset that is past the bitmap.  s == c->bm_bits is the
normal end-of-bitmap signal and must still be accepted, so bound with '>'.

Fixes: b411b3637fa7 ("The DRBD driver")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
 drivers/block/drbd/drbd_receiver.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 2135c14354a85..b3da2bcb646a7 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -4559,6 +4559,11 @@ recv_bm_rle_bits(struct drbd_peer_device *peer_device,
 		have += bits;
 	}
 
+	if (s > c->bm_bits) {
+		drbd_err(peer_device, "bitmap overflow (s:%lu) while decoding bm RLE packet\n", s);
+		return -EIO;
+	}
+
 	c->bit_offset = s;
 	bm_xfer_ctx_bit_to_word_offset(c);
 
-- 
2.43.0

