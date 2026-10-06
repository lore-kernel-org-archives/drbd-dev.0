Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3602646EC79
	for <drbd-dev@lists.linux.dev>; Tue,  6 Oct 2026 14:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791296126; cv=none; b=LXIWpF/mubNnlT/4hK8V1lB1czGFO2iM5r83HhZnPQvVfHbcAkchPjpGww0Zqv1wk7SKToKFMsgdCZ0AVQHLZJP33ykDivSzlkwpa3GETmbMHGVmWd+sAu81LuHENBuBFht4v2IEBBC8prpLhkEE22JCdILoptuXILX45k2+THo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791296126; c=relaxed/simple;
	bh=3twLCOUVctvgm+7HXE5YvCiR9KmGS4GbaF3cOWVcIN8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LtcGbgbN+MAi9xDqj6+699kw2ZPi7thx85CBZukDz0yZfYc78pou0/Y9mVH/eG3v5OnE1WE50pR/SSkvJmHJGJBKjSfzFMy2JczzZLLFFgxJyZj7r/zTkTySks5G1r5+ln6lWlV34aEOz8WOlUc/kcslwvolbFPjnIG2SQhtgrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=rPTSQusf; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="rPTSQusf"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3964dfb5a69so436371a91.1
        for <drbd-dev@lists.linux.dev>; Tue, 06 Oct 2026 07:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1791296123; x=1791900923; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5d+qEg9Unyo+IXTg1hjwRDAAFeW42uTSWnzee3KFft8=;
        b=rPTSQusfK7Dm4cJ2OTfkkMSKnpVgxk5JzAz5Y+akcQKhelbMlTMlqQ7+ONXlfY2FW2
         IsiYEwAN+mIbDreYvgoXkozrvmVX2HYtvOIjgg6POvDSA6BFWjeZCalmYFdntfjNinU/
         5X7QUJD281N7VHAa2AwQxiO4/9jLuAcFgsfPxXim6oWwSQTxMaBRBV0uibXkqzMaqbc4
         E7JO7EVEfNMeuMIuQfKnZiww/Q/qjdMmTrbI7Ken/dIsOOgBbbT5cM2zKeD9h45dGwWL
         HP8wX/TdBbff5jN+DCKKFxlUx4qs+3g+qfund47/Rxs+9fMytizwIvLqaldzum9d8yxm
         lr2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791296123; x=1791900923;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5d+qEg9Unyo+IXTg1hjwRDAAFeW42uTSWnzee3KFft8=;
        b=LTK9HKmPwnSgUttXeujBu8IxBz8tdrqkdM18HoAcdf4KKnpPDjJSL6MEZqztrrCIWK
         fGD6dMQjtQdNJxmYucQ/i48DxILtENUZpP36E5KlIrWLtpQzmaQGExxn5XFIhbPna7eb
         fDZPUOczoW7GPmRY49GfiVvp7BVHiQZTZbbAIGDNYJLnawLpnAJhe6Bb8CeBDB5bODds
         PbA+lLpvGxfvV2rn+6fnV/iSfEkSRg71vJrspndeucbUP/20tCL+CE8ovgGkD8iteqnS
         GwsqkIFa522zSyA5ZqHUIfJUubY3mifWIQ/ommVv1R9Ezm/o1MQdnHbgKv3enA0QtCap
         l+kQ==
X-Forwarded-Encrypted: i=1; AKwUvBzbANy7mxmgl0KlsLAU9hYn01bWJlwYRAJTPjecshira+blQKRo5HO5ujRr1CmN/MibdtTurl4l7Q==@lists.linux.dev
X-Gm-Message-State: AFq9FYKhgHO09pj9Wvzm0zmFJiweexAeMYs69UumB+/+IUBr+FE29ozb
	ajOWl8OzPjr7rTQKgnaN1eJ43LHzPflrnFEO2GLkhBxQhxdzuMZCBaEkb1TY95vQxWQ=
X-Gm-Gg: AYBFou0bZWMW6L+dn53Uymf6kHBDdDOHmpGO5LaXqWk4VwyVDQQFl6K1Yo/nL7Cn9bf
	ZAEkUAHIdHZ/9L1GRUm58PU0YXDBrtS4iBNFWXYAAcek5suRkqAUfthVFVNhC+eK3tAqGJRYZbx
	tQpaYNisZiSqvjQ4/MwfTrFSPkk/aO2so0OlISKtD9E4I8+tE9MnCN5pGFGenLzXWMIrryDQU8I
	OdgA4QrVkRLBwici5dq74aeJMq5kkDPVj0sRSgJspCjeWcdqHlxB0Lzd4XpuUg/ueB/cJ3uP3Xs
	uYay3Ia6kOgipxue9WVuNc+HaRjDwQ15iKB47Qbwa59lWpndolVy/ORLB2b+vriAHxrq4GlRsDw
	Z+3MOpGs2Is+IsRmAVDSae7IwMmmlgsfhb7k9rX22kQLsLjjn416LmAZArwv7kUiNI0oTntO44N
	8dbseDKsO5IuWg2otHTl57oJ3TQoiGAh/rniAsclCbSIKejrTmLt/2qqapbM41SGU4/abGLA74e
	TC4BwSYwh0cY9A4+SyUOw==
X-Received: by 2002:a17:90b:4b04:b0:3a8:5543:5572 with SMTP id 98e67ed59e1d1-3a872551602mr689793a91.1.1791296123414;
        Tue, 06 Oct 2026 07:15:23 -0700 (PDT)
Received: from yhlee-960QFG.Davolink ([2406:5900:1044:110c:a229:268f:9226:1ba3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a8533aba95sm5917618a91.2.2026.10.06.07.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 07:15:22 -0700 (PDT)
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
Subject: [PATCH v2] drbd: reject an out-of-range offset when decoding a compressed bitmap
Date: Tue,  6 Oct 2026 23:15:07 +0900
Message-ID: <20261006141509.521128-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: drbd-dev@lists.linux.dev
List-Id: <drbd-dev.lists.linux.dev>
List-Subscribe: <mailto:drbd-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:drbd-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

recv_bm_rle_bits() decodes a run-length-encoded bitmap from the peer and
accumulates the bit position s across the runs.  The bound was only
applied where bits are actually set: a clear run advanced s with no check
at all, so a peer could leave c->bit_offset past the end of the bitmap
once the bitstream ran out mid-sequence.  receive_bitmap() then carries
that offset into the next packet, where the plain-bitmap path computes
c->bm_words - c->word_offset, underflows it, and hands the result to
drbd_bm_merge_lel(), which only WARN_ON()s an out-of-range word offset
before reaching bm_word_to_page_idx() and its BUG_ON().

Check each run against the remaining bitmap before advancing s.  A single
VLI code decodes to a run length of up to about 2^56, so checking after
the loop would leave s free to move far out of range (and in principle to
wrap) in the middle of the sequence; bounding every run instead keeps
s <= c->bm_bits as an invariant, which also means c->bm_bits - s cannot
underflow.  The set-run bound becomes redundant once that holds --
e >= c->bm_bits is exactly rl > c->bm_bits - s -- so drop it rather than
leave a check that can no longer fire.

Fixes: b411b3637fa7 ("The DRBD driver")
Cc: stable@vger.kernel.org
Suggested-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
v2: per Philipp Reisner's review -- check each run before advancing s so
    s stays <= c->bm_bits throughout (a single VLI run can be ~2^56),
    instead of only after the loop.  The set-run bound is then redundant
    and is dropped.
v1: https://lore.kernel.org/all/20261006034333.351130-1-yhlee@isslab.korea.ac.kr/

 drivers/block/drbd/drbd_receiver.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 2135c14354a85..1febb5e089cc1 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -4529,12 +4529,19 @@ recv_bm_rle_bits(struct drbd_peer_device *peer_device,
 		if (bits <= 0)
 			return -EIO;
 
+		/*
+		 * A single run can be up to about 2^56, so check it before
+		 * advancing s: that keeps s <= c->bm_bits throughout and
+		 * leaves no way for s to wrap in the middle of the loop.
+		 */
+		if (rl > c->bm_bits - s) {
+			drbd_err(peer_device, "bitmap overflow (s:%lu rl:%llu) while decoding bm RLE packet\n",
+				 s, (unsigned long long)rl);
+			return -EIO;
+		}
+
 		if (toggle) {
 			e = s + rl -1;
-			if (e >= c->bm_bits) {
-				drbd_err(peer_device, "bitmap overflow (e:%lu) while decoding bm RLE packet\n", e);
-				return -EIO;
-			}
 			_drbd_bm_set_bits(peer_device->device, s, e);
 		}
 
-- 
2.43.0

