Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795620954;
	b=aZfdVpge+jwv1t7cwUMbUylWd873bs/HDBj1smyCaZMul1Jijzxc0pVminWdoWtt046c
	 y4NsJpzIJ8mAyLmPW00p5Wmbq/tL2S7R3ho7QwOdyfm4AW6NoW7js32hSZQ90z8kq7Gm1
	 NFJPiwGYzPt4DbDuH/EmVVBGbikKKoQkF3mC/TWBPOySZu290Ubt400XK/tORuQebinKN
	 6TgEO/lUUD786inXiNWFzbyrR1H/EzASBJicfcR+YewxtKRvMe8eZ4wlNHHv8QM8ywl6A
	 KSamYInCOGSewd3IsfRd6iYzYPWjsQnG2T3BIupclEBcXusDGH1iT5477Csk4U6jb1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795620954;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=zW5K52MSqR13vjMOGRw7WSmYMI0ONd2XOyiatd+7KVc=;
	b=qsK0Nvui40Z6BeJvKYVfHVxmPDHIN9BQW0lwT8fwP1pSRYQCTnbdMth60vmAELYLKNmZ
	 +qd3esvpAN247zY73KA9H9ADlvZiLOrFelRNVAeWP6H7M/TraBS7uoyg7DsG43eJPCxC0
	 TXjO0HMP/P6zdvyZrVyehOWv66SS4x9GhFEote/HbAYwIzN47zTMKPYOAzD2hy5xJLbrp
	 iiWHM6r7UiDfwaRZCix6sn2Q2CFdXXOolcdWqu+ycal49PsQNzjIihdLDLwMlubY2sNps
	 ACnRIipwY3SNovQScpGIhgS0V8hUv2DNkTCwVs50MWpwl0urhHHsd7joTmZFeEZTlMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linbit.com;
	spf=pass smtp.mailfrom=linbit.com;
	dkim=pass header.d=linbit.com header.i=@linbit.com header.a=rsa-sha256 header.s=google header.b=wj1OOz0Y;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97A6606A339
	for <drbd-dev@lists.linux.dev>; Wed, 25 Nov 2026 15:35:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B97A6606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit.com header.i=@linbit.com header.a=rsa-sha256 header.s=google header.b=wj1OOz0Y
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4acb44dcd7bso5214599f8f.0
        for <drbd-dev@lists.linux.dev>; Wed, 25 Nov 2026 07:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit.com; s=google; t=1795620948; x=1796225748; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zW5K52MSqR13vjMOGRw7WSmYMI0ONd2XOyiatd+7KVc=;
        b=wj1OOz0Y0y2cKqNcFbtC991XtXqWx69uYeN9C7dy7tu9sT+3/EESyvCAORBccDViAk
         GgQz6yqPAUKNrjnqMB1qYVIVTjwIFv1l5cB8iLqhqvajdKhsV0Qt4kOstXbyKbehTubt
         3lXvdSZhcinMJLiq4oEzSbeDWW1sLe0NBrXASESPXv1zmxt4QOoWGjbQrqCBSHvYy2YP
         mhW/ev5JDZWX6fwLMDSIEwfzdhJ07l4nJ4dMl9B3FmyvfYcE+6zOCA3HxhYwVdTc8JVJ
         8E3aR5XUXvzIs+P30fC3nc8ZiyUTIFEFWQFNyhe+nCG/Qcwac51NtH7bYBn1k9KjD9J3
         YcdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795620948; x=1796225748;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zW5K52MSqR13vjMOGRw7WSmYMI0ONd2XOyiatd+7KVc=;
        b=JvS9+bdUQh1EXqoR2LkyWPOGRm8geA9GfMJayJoKlWeGb2Dgqb9uH7TAyUfvziT49K
         QcYvmneImEpg1rQi4P0Q5VSqdG2hD3WAlNnqD8uNRygkbJ56+2zgF1MqhKJi1Tcvtw+d
         SZRLovrh6xFaymhstljrrOKObXe9j//5t76EkLGCYNxWH4nf4xfxbbwHZpytWnAWeyvh
         2IeRYkoBedv+ZWaq4CiVZKeRWSf0CFPzznbLaQAKhJd/Xb03b2SOaxDtmwC8IqxQaHNj
         LotDqhLp/2vX9XJtAtaba1D/DmAmQPpANASv2s0bvU61lW0eYC7Md+QfqNsFb60VuIxX
         jaXQ==
X-Gm-Message-State: APuU4Z9qQfx0iH5tOp4SxRqZRe5Zu4nUqVIeOCLfPfhZc6/76jpNmhMT
	MWnTCDgdt3H9YCF4YSTpii+YSiABtdrd//d8rwAWiJERFKSV5E1qbJHl+VB52EB24W8=
X-Gm-Gg: AZFdTZe1CdisUVGHkKZgbMfNXPrvIQhlIHTbBGVi9Q8vrQ8i2AESM12yMB2uSkViN0+
	+Dpql3MBFN/Q8Esh894CH4nxHqvvfzSOBJyBuKvHBVaYkSZhnPI2VOt5HfLF+kCZCXBg/Uv/zUg
	5Nw5LfazN7Yf8x11a9ycOJOx1tXN4kp8dUAv/sJbQY3N/svrO7W4XbxVVznAawDhAVjcetRiVtv
	sROJRKlMr/DWJ4OdXM1tS7EOzxYpMZbu2YJ/9BU44mHbWUHJFHd64uYllRJICPss5yTliTWuvcn
	uMRtQ3/Z/OgjpbkPUiL53oQ/8TllNWYRAH6IL5EJJItZojKBaaug5QSXEL2W9rxq0S8HfsMGB05
	iKMoj2k6NBhTE16/DaKLhOtk0bmKyFbGaV0M/SRh9GVLnWoWjXEkIvli9ieSiOoLeV3SROPSN96
	gWsM+gfNRGctFPTn3qxXU6DQL3UWjpNiploYaGYsU/+20UlsmhTWylHDabIrzNyQFLBSvN1WLWy
	3HFGtljDCkY31EUU40MUve7AH5RmCpZQgS/jHZ7QDbEwbO85WgesG3HjtGKvr4HmB+dk/TuMWsZ
	FeUJaCLYRfian8P+yfMSWaIKkTBCwM5mnwuH6TlUEGOAL0AxwJAhAMRW67Wo6MO6VtuHfn8mIw=
	=
X-Received: by 2002:a05:6000:1a86:b0:4ad:d65:aaf9 with SMTP id ffacd0b85a97d-4ad0d65afa1mr37658772f8f.56.1795620948143;
        Wed, 25 Nov 2026 07:35:48 -0800 (PST)
Received: from linbit.com (h082218129081.host.wavenet.at. [82.218.129.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab658e2d60sm35816275f8f.3.2026.11.25.07.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 07:35:47 -0800 (PST)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: drbd-dev@lists.linux.dev,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Subject: [PATCH v4 21/21] drbd: remove BROKEN for DRBD
Date: Wed, 25 Nov 2026 16:35:11 +0100
Message-ID: <20261125153511.3060599-22-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261125153511.3060599-1-christoph.boehmwalder@linbit.com>
References: <20261125153511.3060599-1-christoph.boehmwalder@linbit.com>
X-Mailing-List: drbd-dev@lists.linux.dev
List-Id: <drbd-dev.lists.linux.dev>
List-Post: <mailto:drbd-dev@lists.linux.dev>
List-Help: <mailto:drbd-dev+help@lists.linux.dev>
List-Subscribe: <mailto:drbd-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:drbd-dev+unsubscribe@lists.linux.dev>
List-Owner: <mailto:drbd-dev+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Remove the BROKEN dependency now that the DRBD 9 rework is complete
and the driver compiles cleanly again.

Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/block/drbd/Kconfig b/drivers/block/drbd/Kconfig
index 713ac6c9f9f1..058a30efd6d0 100644
--- a/drivers/block/drbd/Kconfig
+++ b/drivers/block/drbd/Kconfig
@@ -8,7 +8,6 @@ comment "DRBD disabled because PROC_FS or INET not selected"
 
 config BLK_DEV_DRBD
 	tristate "DRBD Distributed Replicated Block Device support"
-	depends on BROKEN
 	depends on PROC_FS && INET
 	select LRU_CACHE
 	select CRC32
-- 
2.56.0

