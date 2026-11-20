Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795186892;
	b=WlQ+W4kYDkpDjQMl4nqImR7GTuJIGC1DssuKuMom2vAPZh0YBpGgZDR/1+BYb9llSu1Q
	 MynndddhkvaxAV795+bfL5mK2ysN/GWl8ojwm8cI48J2YPsrtczF0DZrU6fjTabi2wlIU
	 b685u1kXge85yV6dHQdOhP0NH1bIXGWry4q3Icj4hNswaLM1aMV7tNO0tUhdigNFLyiaU
	 t5gOKKC0+aKsOEO3jaGEN8NP3+/4BIPOK6fFw9tUYTJ8LO1EIWVdnuio43sQ1PkDG3y8W
	 MgpYeVQCwA6eP3I9tOkeNN2a1HkzNLGTTopwzy/bZMhW3qQFhzskSwQ5zBe4UbRxTWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795186892;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=jrWS7IBw0l6WadgVn6pAwxzws8JpQ7BsYeOxejRCwI8=;
	b=jJYR8G7DfbRnBKhm6dsbx+gB9NnKOESO1iVTT4pXV1i4iGYuv+cFzAKbGaGjb2CSWd4I
	 GjzbWbGCBGhgOp3ba46OfDt9oYXj6SrrrRFuWve1zkIn/MTP4nIUdF30PZvQqJbqqH2We
	 y2F5wV9gtsbzjYfYXH6yVfp2pkICG3fqWVBHTAe69o8aAy04s0gDzh8cj1Op6PtC6xtC0
	 hi+uhRPemeIfLejAmpLwqwfbFXgURHYr8NJheBCOJ/yv5A253al//7+aUyZTOgUm4/wzR
	 vvhJykd0Df0aX+YElvA9GwFyQKglXtICPsFKnGdmU0hz9plBFNQU3fWiKPEq4c+ySgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=isslab.korea.ac.kr;
	spf=none smtp.mailfrom=isslab.korea.ac.kr;
	dkim=pass header.d=isslab-korea-ac-kr.20260707.gappssmtp.com header.i=@isslab-korea-ac-kr.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=OQiS0pUP;
	arc=none smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E22C606A332
	for <drbd-dev@lists.linux.dev>; Fri, 20 Nov 2026 15:01:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E22C606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20260707.gappssmtp.com header.i=@isslab-korea-ac-kr.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=OQiS0pUP
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2efddf749e5so9714665ad.1
        for <drbd-dev@lists.linux.dev>; Fri, 20 Nov 2026 07:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20260707.gappssmtp.com; s=20260707; t=1795186892; x=1795791692; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jrWS7IBw0l6WadgVn6pAwxzws8JpQ7BsYeOxejRCwI8=;
        b=OQiS0pUPGhLdH4tDhwgPzieGStZ3ogxGfNq6CcWN3bQduDZJL2T1OCZbt3a+Hsciqj
         j0SEdSJNFn2ZQM9AaEy4xdrExIFW3DtD1aR5kLzIhHeOLtctwd9BjQRQ8vRKEDy74AuV
         oTdUPHLW0TKwTSPzntxeBmaKailyTRa87i8io4G8hOgjm2zWPezF5jUuokZK59CfGCP7
         EAnWyc9jKpCXdbGLF6CpBUj+5dUIuLJt3URBtc/Zg+P0r1asnUDfVj6ymdC3QBb8o6vA
         l/+0xA9A0aaAgDLu2QA4dgljcOyt9wea7eqwMwe2YJihUxTJo2nzUR2MPm/aZVZlhadT
         cxOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795186892; x=1795791692;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jrWS7IBw0l6WadgVn6pAwxzws8JpQ7BsYeOxejRCwI8=;
        b=J7GGf6kot4MzBLUedDPi97MpjRKOOWCcZD5mTf6KFaFVQGYubB3zNdq7zwAMoLCmUH
         gYUlcSfsDkABBjNPNymEGEY7ejAS5rPdui2oCnCE7z1mBCvPtN3N6W3kiFZYjeNfYCyY
         6tL/ikSugkHi0Qcenqxc8mQNqGvoM4Aaaql+VrSBsCeD/LvR8BbrBqzV/fb4L6RCnIFw
         CoiE5P6m6PDlq8M23UFbEXuwp0ZXeOGrtYItZahLgKghVnIEGQsQ301epBOW4gZfegoj
         rq6BML0ewJNZ/ymYZbCBbGaeJe/hTMjz7DgdEm8tRWDHek/zcqdJ6pTDO5wXG09duXqG
         DjiQ==
X-Forwarded-Encrypted: i=1; AL+hErFaGN4eAPH0aJ/XfBMY/m0jhaf7QM5T8j2osHxOMJfrMtHFk9YzVJ37sM76zGnoLYf305/rYVSemQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z8WtkKqUb2zyZ6zwFM3j3fFYjSZduN5Xkefnb48EZ9xyIt1fDu0
	hp0Dft2k1Eri6jA6tDi1gWuOlT9vf7FeS3YZFS6lPiwwUAwhirfIU9NOB0J11RIlXZ4=
X-Gm-Gg: AZFdTZdsfw79NJ4g9E/DJKp9pwhNL0rPkF1wTnmctrJV2ZyYoVjM8iGUmVEwCzq2ZZS
	YVRJL5bI3gvkXwTV+1TgvDkFYUDOSZByQz46rhIFefKAJSbZQmT8B+YbcdcukZkSliSY+LnZg+G
	rOZi5wvD3tcv5IJ6ilLTvXKJdfXbgq560YJwKsEQJT8DYkmSFtgVtEoqR8k0KRGpmW1X9unZB9w
	wZofWypE5PuPuelAPWeVsX9pG7uhgyanq4I63FQU/j/szBIECQ/gBD4bnL6IYk7cA0irKPBajlo
	XApzxFOy+HRSQ77SwzNhufeFuov6QD8RtOk/VgYF66xm98G+qP+b2dAX3H38LtXs7KttsH3Qz/1
	YS9dL2e9JP7TrvrxsySYHWVu2/Z3rZpiu+lCySa2ERBEhK0LF5b91oF+pN5MhQ5VjExuLO+0HLW
	0JvwUrCwAuWMx50mgLyFe/6QmGn9Nm/wyGjdQ/hTOJk4H/viQAcivjc4st8bIB66d48OomgTQxt
	514gePsPevVb5W1hQFKtogbn0SDisiSLVSv09bvr5oM1SiLrgRtz/JgiXxmmajxSa55+sgUUXxn
	nmxu6iDCv4zWyVEe3XBrszhdWpydsRc/fdd4RxygceswdHwLlpSbdxaccDrVScAZ8ryHOVSq0b6
	4wNvBYZrvppOiWWGQR4hdxt39hkI00zxrH4ZtM5WAC05leLk1DdPnttvSkcQ=
X-Received: by 2002:a17:90b:3cc7:b0:3b3:c6b1:2277 with SMTP id 98e67ed59e1d1-3b41c93cdc8mr2237808a91.32.1795186891769;
        Fri, 20 Nov 2026 07:01:31 -0800 (PST)
Received: from yhlee-960QFG.Davolink ([2406:5900:1044:110c:8b25:951:ad8d:5cc1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad46ef5sm4680914a91.8.2026.11.20.07.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 07:01:31 -0800 (PST)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: philipp.reisner@linbit.com
Cc: lars.ellenberg@linbit.com,
	christoph.boehmwalder@linbit.com,
	axboe@kernel.dk,
	drbd-dev@lists.linux.dev,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drbd: reject an out-of-range offset when decoding a compressed bitmap
Date: Sat, 21 Nov 2026 00:01:26 +0900
Message-ID: <20261120150126.3128366-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261006035715.354417-1-yhlee@isslab.korea.ac.kr>
References: <20261006035715.354417-1-yhlee@isslab.korea.ac.kr>
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

On Tue, Oct 06, 2026 at 12:57:13PM +0900, Yehyeong Lee wrote:
> recv_bm_rle_bits() decodes a run-length-encoded bitmap from the peer and
> accumulates the bit position s across the runs.  The upper bound
> (e >= c->bm_bits) is only checked in the branch taken for a set-bits
> (toggle) run, so a clear run advances s with no check at all.  A peer can
> make s run past the bitmap with a single run; it is stored in
> c->bit_offset unvalidated, recv_bm_rle_bits() returns "not done"

This is superseded by v2:
  https://lore.kernel.org/all/20261006141509.521128-1-yhlee@isslab.korea.ac.kr/

Best regards,
Yehyeong Lee
