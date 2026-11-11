Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794386110;
	b=h9RO6+BoSO6oe3Li2q+oBi2CL93SZmrDQ0+htXU0Azlz0/oraibtprSKJHdANLlB+gbN
	 SwzncWm+VP+7L3a9ZRjMfo/yzPMmYO/NIZjqxu5KereBJKWP3lobVoOldZ1rwZhaloCTS
	 ZeCbxvi0dBAG1Ha6zvhJoQTBlpFlaLoz5qy+UX8blTR/wkg8V3/Xk2QFgO9tp5CBdXqlU
	 68GGXGLG4je9GztC5bozZAaVubxiQjUZnGPxZN2qyfSxYPcQ/8yG60yA+L1noz2NHSDY4
	 razlGKxseckPo+W26Hhumy+zGxMymk+dryJzqj8yHDQ5Ja4R8TDMtqNKjQaUvLLlA1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794386110;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=sSx1r6YADSLNod2etVKoZeGoyw4STJkD6JZ9QURsIZg=;
	b=0hT6p9xrKmu1y7g1xidVBPgPZYZvH4ddW5cKnwKsgpht0hVRSWqAsizoThGWkj9tuqdZ
	 U2dW7xooug4r7KhTZpK7KVikhJVxQDNDGeKKFVkLg6veMM/7Bw/OhZh5gkS7qKZhwJjo4
	 mEEw2qjgrARY/ii3tX7tnWbt3qYLqj3s7gwZOJva3zF2mx7thphc6NeooA25Ll+RfA/+f
	 2f1fgJdFWaKREDOEbqY4CVugTjxGWoOhRyR1eIrklAttyteysi4l4c8xgP7UKNVhTDiwg
	 GB7DHs6OdQbERaQgW2XhPgCmPHquM79kpHhg6uOeLIf76DoZ+bqiAa/E6uJpxDOepug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linbit.com;
	spf=pass smtp.mailfrom=linbit.com;
	dkim=pass header.d=linbit.com header.i=@linbit.com header.a=rsa-sha256 header.s=google header.b=tTR78MQ6;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FFA60A2603
	for <drbd-dev@lists.linux.dev>; Wed, 11 Nov 2026 08:35:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25FFA60A2603
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linbit.com header.i=@linbit.com header.a=rsa-sha256 header.s=google header.b=tTR78MQ6
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a2167bd087so28846865e9.3
        for <drbd-dev@lists.linux.dev>; Wed, 11 Nov 2026 00:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit.com; s=google; t=1794386108; x=1794990908; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sSx1r6YADSLNod2etVKoZeGoyw4STJkD6JZ9QURsIZg=;
        b=tTR78MQ6J+Dkp4ybRVCC8KR+zeY/ZbMaL75SDdPaO8NbvZzhrGT6kXqRBu5QDIft0E
         PpcateZW85OCbbhCaVMkTyyGUzgs365JO5D3d97E+j66uqQ0lgd50d5WzM2UQRl9s2dR
         dNSsxV56zR0vDBFGXeTyZQ1suqUD/fj4iuySn22qSZ74DPgkweaKMcgDpMpI9HoAmUwT
         +QfMqFV5V6kAzsgXslVaGvip0sQuXAj9unMfiK12VWeTIku+VXa1d8ipZxqkDVFXKh6K
         +jhVBgKPDJd6O9bxuheN38NFSSW5znZa6li3oGtJeZvc7/UGw/nk4ADNokv1MVW60Ud/
         lxhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794386108; x=1794990908;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sSx1r6YADSLNod2etVKoZeGoyw4STJkD6JZ9QURsIZg=;
        b=KUb1GzfWuBetu0rVJ0VfLwCZFLeZ5YiJWwF7r4kEAHFJE+eU5tt5i6sTtUgTfH5HNP
         NGfPM02PEwreTCHXtc63CkcbA9kZEekWBSJXP3x7uFOv5yACz61+DjhpyjoH/8iNs8Pt
         g/WiCr4LVPXstff81UvCD5AufV8wwXlJVPs/d5UrNSlY3PxCFIK782Swqmw0eihoMgjc
         58S3XuKUkiwVw3KIGQ2oyW5L2K19wFtAmLM9t3KAq3irDl8h7c+x6FifX0O5CDLNOfGJ
         Pq9f9zKadSdIS3o9ngW9Of+2e7xQwX6uGCNsPno0Tekkh5QG9/KHhsjv9KNKV6vShWFi
         ygKg==
X-Gm-Message-State: APuU4Z+TRtShf5FRa3GqwxEOUfb4GwESuRcb3+asxOxGC7wXUJylY3vo
	OQYBRWdd90Dkelf0unwYqKzMLk87mdivQiUhzuccICsSeJpJavBx3gx9Tz0sHlUGfWF/RR4qQ6E
	buhH04rk=
X-Gm-Gg: AYBFou3qdqA4DUT+cFau3IQUVurNbZZLfddjQS5cdA5WUBTzb/lnf0aFZkLxLaXVqQI
	iqvIeXET0ceaKyzst725rt59QrSxtsgp7E/Ju3mh2rYX+HZYgXE+mksFpU7HEVOH9kguCDlYTo7
	315Krw+wXAYpBD22xIF3muMDVu2CPFYaxYhIvbuhgOmwHcDl27wbzDP1ommOT9J83gojKVtUR6F
	/frCsgFose/7LT2kVKkbpsm0AK0ZjuViKQZw07xxk1lRBhgcfcCzTPmLBU7Z7oBMMZeF4e8dHn4
	4UBduZF0sDmLNIde5nXgeTSNLtConQVAFSPablf0vF7olWDkSu32WPZZFK2JIWsdDFratY7kLkS
	LU+wbauoinuR9Gwz87+AR89Du1zv9F0AnZuGSZpDYbr4R7arNCxmdZ1slStnLgrknK9Q+i66XzK
	e8c1tcQnDhq27bDmotGKKidQNkmF9OLrug2+68deNILedORwaCclPuBZyT1mYq/WnXjhlH/pKgn
	GUDK6Qeg7n1/cwteP6j3ZE/lHc24IvXx/a6zSH6ftMsp967HsBOTKcO0G29ldhtvctgYWZ4AlHI
	V3rZA1weXd1kM4rBDpBIPs/ti0HUZRDj99NtBVXR9uAYNi19ANSF78qUU4BFmzW5QDlPuXANlw=
	=
X-Received: by 2002:a05:600d:82e5:b0:4a1:faa1:3813 with SMTP id 5b1f17b1804b1-4ba0939c32dmr32175315e9.27.1794386108056;
        Wed, 11 Nov 2026 00:35:08 -0800 (PST)
Received: from linbit.com (h082218129081.host.wavenet.at. [82.218.129.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49835c37bdfsm9689492f8f.22.2026.11.11.00.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 00:35:07 -0800 (PST)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: drbd-dev@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-block@vger.kernel.org,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Subject: [PATCH] drbd: select CRYPTO and CRYPTO_HASH
Date: Wed, 11 Nov 2026 09:35:05 +0100
Message-ID: <20261111083505.3998706-1-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.56.0
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

DRBD uses the shash API for the data integrity, online verify and
checksum-based resync algorithms and for peer authentication, but
BLK_DEV_DRBD does not select the crypto core. With CRYPTO=n, a kernel
with DRBD built in does not link:

  ld: drbd_sender.c:(.text+0x137f): undefined reference to `crypto_shash_finup'
  ld: drbd_receiver.c:(.text+0x58f): undefined reference to `crypto_alloc_shash'

Select CRYPTO and CRYPTO_HASH.

Fixes: b411b3637fa7 ("The DRBD driver")
Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/block/drbd/Kconfig b/drivers/block/drbd/Kconfig
index 495a72da04c6..d707187d2cec 100644
--- a/drivers/block/drbd/Kconfig
+++ b/drivers/block/drbd/Kconfig
@@ -11,6 +11,8 @@ config BLK_DEV_DRBD
 	depends on PROC_FS && INET
 	select LRU_CACHE
 	select CRC32
+	select CRYPTO
+	select CRYPTO_HASH
 	help
 
 	  NOTE: In order to authenticate connections you have to select

base-commit: aa7014f8d7565cfea117eac36a5de0a05eba65a4
-- 
2.56.0

