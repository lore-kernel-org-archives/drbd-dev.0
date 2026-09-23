Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B215C53A8B2
	for <drbd-dev@lists.linux.dev>; Wed, 23 Sep 2026 14:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790172408; cv=none; b=toK251zcCJcFVAy8SSIPdp6iSQKz2CoW8oSSwen233AcLYv3r/0V0DAeWou6pdRy4fc+lkTkwTQ2Z5eqLkiYHVworcjW9nMCVRhHzG0ohsFyDVgw+JSmKwcnX+Jrtfl514Ex2HFH6BDhvqceEGRTxvIX26/5JOho12PQ04ZZ5uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790172408; c=relaxed/simple;
	bh=oQMVU8CpkA9s5kiL5H6wuFFn6MAbCEqOUv5Twc3UmE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NnaUdyMiB1Z1WQHEgHiHOtEKqM9nmG58ppkf2uOXMucZ0NJ0PeQf9+9v3b25sE45ahwjy3wdd71eeZsPEqsbBaJCSRYroSPtLxmclhLQaEO9RnWFX/0XXpJC+CHq26Ptlbeyo0pJuql+reBEl0ZSoMk9XSogYiUcC8qP/KEJ3Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b=oT+4jCcC; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b="oT+4jCcC"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912e4ad9so5451085e9.2
        for <drbd-dev@lists.linux.dev>; Wed, 23 Sep 2026 07:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20251104.gappssmtp.com; s=20251104; t=1790172403; x=1790777203; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=R4doGn8NmMxWa1rKrQkSd1esBv7W7hOO/WeyOJxuxR8=;
        b=oT+4jCcCQg8ni87Wahbj1sLeM4p21bkL1M69OP3ZRAi/RYES9FTT2J/GGyiORj+/jL
         i2HkbjiQ6fDkXKyWP8taCGc9hqXx/cUTAsysT1mJNsgZQArlD2XCQHAu87olXiOPScHL
         YeshSb5PKRN09IADIP+l4mrMyh9lBr5RXmC/Va4UwK0Yoy0fQR2iEPyCDQ+AXRbExG4u
         /Ah4ULtc966ks/bL3SXlLTjjJ3GDVArYzanzpf3Z9V2KEXXlp1VnrtuBaaJypqAVxW/i
         gGrE4YjhfNONfct/iEHpzpj5WondmSgy2n2vZ4EVaT1OAp0xegO3Ebop3q0tRcoy/e8K
         2btg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790172403; x=1790777203;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R4doGn8NmMxWa1rKrQkSd1esBv7W7hOO/WeyOJxuxR8=;
        b=r4qUFWPi1HYyxnSlrxyr96+JWyjkhilqgh7DArR1Fn2YfJX2ZP8vqn7evkC0ljL/wG
         c8HOo2PNLgu3277dXoyIXGe7HbIdu2CrBK++pzvN0fku5Dh9LtSlO+myYaXi8IRUXvQL
         Ucnca6Qjt2qv/4NXYdAOMtmqjpfojCyIdNW1bK09ZXSKMC3Kc3pOs+M16j/06cgCU08c
         PoySccAqbFS9Zyq1kGeYm3BxXXUkfGvfxvGQmzdMrdSPCMlBG+BrJnwpfeuknBajgrRq
         wy7UCO4cFmYfMqloSH3J0zICLYsH+6Otxb9xvCso2amegzFZmBTqVp2lMrt66jgrj9mM
         fi7w==
X-Forwarded-Encrypted: i=1; AKwUvBxy9VrNVwF+uEuSqrUNd5/W5AF92sDBDhPkaZROJZ9uDuV+xKIVnDOrg+NoKfeliBYIkUNbQGBIMg==@lists.linux.dev
X-Gm-Message-State: AFuF++l6w3Ugcy2x9BuIrBY09Db8Z/8Kz/l5FpkNZXR9s0+prRFZf5XF
	iVoY0xndFSJRIo9W+DltW8cCvyQsPuSDINETOUlgxkY9PCviy8Ivb9cW87pmlIz8dQ4=
X-Gm-Gg: AYBFou3ov/hzrTeF1XJ6L2C2vGiAUCRQyyImbpXKpSk8/Z4mmPeyGi+SSe8nZCNA6U3
	aRCdiFAxrTtOKiPkBqjQAmPctR1IbxKyaa5vUXncBSjP8NtSJNTyRuAFODkGmKvsfE0Z8WHzC7W
	459l2LJYPpLLKa+oxR/z/x/ZLpikaGn99tdekjZokkpSWdW48eRdyrtSbFoal0I2sBh+U0BVPAH
	NHBzSt1hBwTq5uBLzPb78lBVrSDdtN97USpyTilv3jTKmtTmukWOaDinNDCoRU5OxN89C2e7zKn
	Rv2OwGHr2yxDInoUf+5pvK7HXtRIvurbu71VF74T+DV3WEKX49V6YQwEzE/T2UIgNyo0M4RDHN+
	K5AofE5l8i+YY6x8pJ4EzEl6v0wa5LAgU+8jkNdxxiN2pcA5keNq7WMLMU1DystOglczbnfYBmV
	iKi1tJcbwH4Bw+Arl2oXALEiV8PdJnVL5KYVXPuVPC5jUCzQ9Msc9k0m8dqcMsnJL/CebWngnY7
	/PBaN9WsfYVEO9h6Q98eX63Fhx3x2c=
X-Received: by 2002:a05:600c:46d1:b0:49d:15b9:2a2a with SMTP id 5b1f17b1804b1-49fdefffe1fmr40005835e9.10.1790172403175;
        Wed, 23 Sep 2026 07:06:43 -0700 (PDT)
Received: from localhost.localdomain ([2001:4bc9:b01f:2334:39d8:9506:1776:f780])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fde18a8a0sm78087455e9.5.2026.09.23.07.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 07:06:42 -0700 (PDT)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars@linbit.com>,
	drbd-dev@lists.linux.dev,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>
Subject: [PATCH 4/7] drbd: raise the maximum resync rate to 8 GiB/s
Date: Wed, 23 Sep 2026 16:06:05 +0200
Message-ID: <20260923140608.1116713-5-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923140608.1116713-1-christoph.boehmwalder@linbit.com>
References: <20260923140608.1116713-1-christoph.boehmwalder@linbit.com>
Precedence: bulk
X-Mailing-List: drbd-dev@lists.linux.dev
List-Id: <drbd-dev.lists.linux.dev>
List-Subscribe: <mailto:drbd-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:drbd-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The resync-rate limit tops out at 4 GiB/s, which was chosen for bonded
10 GbE. Current hardware exceeds that with a single link. Double the
limit to 8 GiB/s, matching DRBD 9, and make the constant unsigned like
its neighbours.

Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 include/uapi/linux/drbd_limits.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/drbd_limits.h b/include/uapi/linux/drbd_limits.h
index 4132b619376c..bba0a0aa8792 100644
--- a/include/uapi/linux/drbd_limits.h
+++ b/include/uapi/linux/drbd_limits.h
@@ -121,7 +121,7 @@
   /* FIXME allow rate to be zero? */
 #define DRBD_RESYNC_RATE_MIN 1U
 /* channel bonding 10 GbE, or other hardware */
-#define DRBD_RESYNC_RATE_MAX (4 << 20)
+#define DRBD_RESYNC_RATE_MAX (8U << 20)
 #define DRBD_RESYNC_RATE_DEF 250U
 #define DRBD_RESYNC_RATE_SCALE 'k'  /* kilobytes */
 
-- 
2.55.0

