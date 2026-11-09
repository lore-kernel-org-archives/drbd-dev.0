Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794246024;
	b=GUMxD5YiDNOHxJs0+JR5r96ecJ8RtyTjpU94kJfgZ88/npTh1v2U4pmfJR8lduoJtKYt
	 z0twmPyaLAr9rjBMoS8dLTOyuNrUNg5OMymOb46J26lrqGLqKMCrUjhXQZR+ToVf8a62D
	 xEZh87UhyGv8dsYHj9+P5goTBG+cSw8JmC2L7n1kxTmDhVmJwV5u9Ah0azb1KcNMtLRIV
	 g362qrKnj71PoSFmEX0YrBA9+yRka3AOPCjcxJosc3h2R6xSSInAFLxJtzjUQxBk8PdAh
	 gQt9rMgmfRIII4x9seO4HqnyNDeiBJH9mDdwfpSQZzAo1KEoJp5xtUR6KPaZz7R130Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794246024;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=RTN7GJRGxjj0prh56qCTTHNAOwYTCgOl6J/IwT1bHGo=;
	b=aij65A80f/fQ0RsEZ5G6QVb9qjEvmcjv7fcM8XMqt1d2qJxoxml5BchGEYPBmVVjMvOt
	 FVbgkvv9o9ARANNzU/yJHdXuUWmCL69qgs+dMPGS4/aW9NmhCc9MmLRo5fszwTCSeW3Zk
	 sIj6vd5GfLtv8lKD3kvpIFv2RJ/KOPs//RNIdmpagYd8tZuqgQhe0HiqhG0ctdskCV0tL
	 7KoI7Oxnbk2/xfoX0lGdYjMmPyUEi1y4TrhSGGCqw4NOIXGcXheHH+XjgiL3Ul7ce6Lzm
	 arZ9O+y2Tp3VFrKvA9prepDazJ492saSOPGP5SRuHidWc8eJIM7MxKWp4vOhvAUmJ8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=AIXrOSzP;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6B1606A31C
	for <drbd-dev@lists.linux.dev>; Mon,  9 Nov 2026 17:40:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B6B1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=AIXrOSzP
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-36fb88ea38cso1439349eec.1
        for <drbd-dev@lists.linux.dev>; Mon, 09 Nov 2026 09:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1794246021; x=1794850821; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RTN7GJRGxjj0prh56qCTTHNAOwYTCgOl6J/IwT1bHGo=;
        b=AIXrOSzP84vwBFAec67t1cNZ322RiPh+d/g9Y4Aqg3PaziQqMiL+tFrv34c5+s+sof
         2LkPx2T2k0uihocFJIIORbV1JyHhnWchrOTrDptz0P+7JQZdmUf/i/GrGAtfquPCFRAD
         dE8HAY4Lcb+RND8DMugv2H9CiOeK99bx2G1mthmgB/iJZHB9YzlRBgJIL2K8YEWpof+h
         oSd43dvP6t5f8oYwWrjkfse60Qz43gSzl07uildyGZNwHbA4KWm2Uf9s6JOov57IqdcX
         EQyGtTC1K32Wq17lJ7HtCIH3crpMwmNKk/J7rgccItXAdGR+6q8VcKFseeHONUQDM88E
         XBDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794246021; x=1794850821;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RTN7GJRGxjj0prh56qCTTHNAOwYTCgOl6J/IwT1bHGo=;
        b=EOoJGMQfHCS5UYUXHuz/3GM8QN2kWCmS5MNYi/rUB10I/px69EXgrxfus5r59om+ns
         quxEKaOu89LHGdii9o9y+YsQrpOV60pcDXfdV4IZMzBOqbtOm9yhWgNLkR3L28oOJc7q
         UIgHlzyYfqAf0YStmIWrOv3hJJGe7996RiOpBpMxnhN0Wa7GPJ/xJZCF9RgqQGCZvygM
         Hpm3Ku0HNDm9kpv9fPN1PuwLyDQdeg7SlMlsijgnbMnpT9jMUkhAdpWXyLA4GHnD8IG0
         MIR2hLLs7yv9lgaOZEkjBqBHZxTXGkrvwmWfyHU4YIX6K+8uYWFAksZ5ovBVS2Z5Z/6p
         E0mw==
X-Forwarded-Encrypted: i=1; AL+hErG4oKNGJiWQ2JcCWreMLu98E+iuGj+fHPpmZGhYzDAYdOFa91laHbig/FCmMzGBC7oIHJJoz1jHrQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z85snpk1aTGHxwKWhRlPT6JKcVGYfDZ9CDFr4Ffpf3Sihoza9P7
	prYdHJTM2lGd29eyAZVs5triSJEbQB5eJpeooowyTTIhNAlfuNalXCjxDIU/kUNiodQ=
X-Gm-Gg: AYBFou1DuOka+zfZ5bFrXUq5op7zlGEF9my4ugrLHyufHz8X4m5QIG0DWgFREXQLtzF
	6Z/hS3Sa2zSi0gS2kBJFLihk1ecohjjgQfxX6Dm0UWQezsyzQXy4FiprU8+epNJmDBPVhZBJbOT
	vNHdcB+i6vgE0TFatzdFnAf+j3q9Hk6XCZUE1zXGgE2OKVkyaVvtNbnw1XAanLOzY2ehEnouxFY
	2VWuG9lsfjXo0D2dvJbHKPWymogS3U82XVow5R9xD60K3hjyoTP2P0zVujJIH3K2FslpY9YIne0
	oE75ZawXFomV7/EXkawRhKEjfYH8GneOGNLuw9/QVt/pfeEZTlx4rQKUZRHzaCIIFhozbeoaQ95
	6SZBVW304JR5avGn79Kd27FSi7t+3pBHIHKqaqNtpzh3WYydzH4L7X9LfIeJfB9FuYQNhcTcSIx
	FDqDqnXuzs1SxvIAb+WwYHJiOSeaz8xnGiT10WT9zxrd8Lim9K5qKEVM/apZ/0cHYUf/M4sG92y
	iXRNWiSuM8BD9RcVahvOj5dhurEn1EHvaWnuklCskeCxc7m8IdY6/4ss9mm2jYtSTQJcc3iZT5K
	29aSXlbjzrANpR6LpkCQ+Ib9uq9hSTPblSwY0L1dpkkKd4qfrrmHT9XvP855S4HAyWEArfhkdI2
	34qzbuhLRcPgv
X-Received: by 2002:a05:7300:e9d9:20b0:36a:2f6c:490e with SMTP id 5a478bee46e88-37508f421a2mr245104eec.6.1794246021164;
        Mon, 09 Nov 2026 09:40:21 -0800 (PST)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-372656187f8sm13250129eec.5.2026.11.09.09.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 09:40:20 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: =?utf-8?q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Cc: Philipp Reisner <philipp.reisner@linbit.com>, 
 Lars Ellenberg <lars@linbit.com>, drbd-dev@lists.linux.dev, 
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Lars Ellenberg <lars.ellenberg@linbit.com>
In-Reply-To: <20260923140608.1116713-1-christoph.boehmwalder@linbit.com>
References: <20260923140608.1116713-1-christoph.boehmwalder@linbit.com>
Subject: Re: [PATCH 0/7] drbd: preparation for DRBD 9
Message-Id: <179424602031.19772.15096346833030118942.b4-ty@b4>
Date: Mon, 09 Nov 2026 10:40:20 -0700
X-Mailing-List: drbd-dev@lists.linux.dev
List-Id: <drbd-dev.lists.linux.dev>
List-Post: <mailto:drbd-dev@lists.linux.dev>
List-Help: <mailto:drbd-dev+help@lists.linux.dev>
List-Subscribe: <mailto:drbd-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:drbd-dev+unsubscribe@lists.linux.dev>
List-Owner: <mailto:drbd-dev+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2


On Wed, 23 Sep 2026 16:06:01 +0200, Christoph Böhmwalder wrote:
> This series contains preparatory changes for bringing DRBD 9 upstream.
> Each patch moves a piece of the in-tree DRBD 8.4 code to the form it
> has in the out-of-tree DRBD 9 code. Doing these steps separately and
> up front keeps them out of the much larger rework that follows, so
> that rework shows only what DRBD 9 actually changes.
> 
> The patches are a file rename, comment and internal cleanups, and two
> higher configuration maximums. Defaults are unchanged, all existing
> configurations remain valid, and apart from those limits only the
> wording of some log messages is visible to userspace.
> 
> [...]

Applied, thanks!

[1/7] drbd: rename drbd_worker.c to drbd_sender.c
      commit: 40059d1813d8834cf4779b8c9c2faa80b4a6a0a5
[2/7] drbd: modernize the file header comments
      commit: 4df3cf912f90dedfeee025b1fb34b6ecead7c8bf
[3/7] drbd: raise the socket buffer size limits to 128 MiB
      commit: 80869ca32c8969eeb857f4d1a3f959dba952109a
[4/7] drbd: raise the maximum resync rate to 8 GiB/s
      commit: ebf0023b636ad47afeb13ece37123507d27e131e
[5/7] drbd: replace the drbd_interval bitfields with a type and flags
      commit: 6826d3b194b1e01128fca6e0925a8afe72b7cca9
[6/7] drbd: move the packet name table to drbd_strings.c
      commit: b87ef682279fd67600b92eb83d10e70b01eccda5
[7/7] drbd: rate limit log messages per object
      commit: dc2ec1327db41fb8c7c0ae5a5e29654b6ca3fe17

Best regards,
-- 
Jens Axboe



