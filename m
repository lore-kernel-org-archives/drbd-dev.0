Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795704784;
	b=yzziT8i7grxUkJukjd2FiDmFGOhPXypjKLvZJWI4hY7DEyKUspygH64cmrzxudmYMys8
	 Np7tue67k5rvqj5tirV6b7ou9w0uZ8cHNrwsRzGg22g6A/b9VU5vBG7+pza0bFpRFVmxU
	 Fefl4aDm+2wQO7VJZsr0hZ21TsmX6nSbAIYY1vpVlIAxhJp6HsDNEdZu7kAVRRQUCl960
	 O3u8Y/judYKULL/RnkJMYb9FeMj45Wi88OMNY4NJ5OrSvZfsXPtr8ZD3x9+zJrhbjq1pV
	 kX6GMlw8MOPbPnklxZVDJ5KQrhZB7g0fPREOAdl71GFsvKU641LcNam8iiYnEiIBnkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795704784;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=L3L0Ub8N0gUUtY/O7U7dLEItaB3jvAIkFWpIo7dlmSA=;
	b=YMQpCtjILiCPareI4X0MwFUbD/rI96QKoyFhKatzKwvAfOOsRnoTryFPoL6XcKw+rg5b
	 i3Q+ieEk30fgKdDxb8YxN/ZWKHpaguhCM1jGJcRXnaRdrLYNd2Fp6HydRCKTwv5gGbYyJ
	 Jr1og+fpJXBZ/Shjq4CWR+8NPiNIidOHV/sggKxdN3Eth+HfKI42b37VU8kudq5PoeoFC
	 dHD3chjBseCjsUIhM4xuTvPU3CjP7kuvgXppx4QSJDioWjp2PyI4TL6N3JRqo72NCqiPr
	 ecLYzoBWhLqOcptVpVAYCTLkDCYRjktNFsI9/gc9DSUxzi6N+Se41OOOC+ImyQIthQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linbit.com;
	spf=pass smtp.mailfrom=linbit.com;
	dkim=pass header.d=linbit.com header.i=@linbit.com header.a=rsa-sha256 header.s=google header.b=gqO0myaX;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB006606A31E
	for <drbd-dev@lists.linux.dev>; Thu, 26 Nov 2026 14:53:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB006606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit.com header.i=@linbit.com header.a=rsa-sha256 header.s=google header.b=gqO0myaX
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4bb64c99d2fso66076365e9.3
        for <drbd-dev@lists.linux.dev>; Thu, 26 Nov 2026 06:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit.com; s=google; t=1795704782; x=1796309582; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L3L0Ub8N0gUUtY/O7U7dLEItaB3jvAIkFWpIo7dlmSA=;
        b=gqO0myaXxEnNBCNtsckrMHU7Sz67zxNI2njnak+vKhAUHrxvMqSNd8cIlM0GiycnP2
         Riwar4DvQLAv8SZk4BsNHDfdjA8PjzUEgMOPJfSaaijNEESGXrMEaQ3of2gqjH0sY1rO
         5TFiXWksMUcEy/wSoe5WoxJCsY0YXcYwhQIwKM28X03yEdNQhr2zc2LzmyfyvrmjGcW4
         IPwS7t7Cfw9F2azLpaVpWikwBpCn1JWQCX6DduspSM9KJuLfpm2rYpcqv+5VQl+aiijv
         pG5Xdr14gohpcZB3/SW839gyFL18y32edSDzGfy9sQoiIvMZqW/Sh3BztTQJFCARZWzt
         mcdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795704782; x=1796309582;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=L3L0Ub8N0gUUtY/O7U7dLEItaB3jvAIkFWpIo7dlmSA=;
        b=DW+D+TH2GpU7MxgVCEAHno2IlbZkhl0zFxRx6KtsIsrKTcXLTFE4kC1ISrGINFr5fh
         t/TX5tEssq2OPZVh7iotWdS37kLD3d6tK7hdsiT0DmH0A8b3ZAO65qe1PFjFNWCfL3jf
         UWYisRFtojxSUlESCVr8j1c4Z8RlcAKL+ol7SDJxpUw9R2ddHWsUcTQXbJUdN3x0vJQi
         MzlB8M7ndp06CTrTkcSek8emH+UrOMBP43ATQ3+5u32+Va3l97hazbDa94ZOqB4TUo/W
         3MnRaCSt4TN+0UB1Eep3KMJt5Rm9fsbZm2sMi2lbXI/MTTNbnfoINrfeOmt1ZhPZcxnT
         Si/Q==
X-Forwarded-Encrypted: i=1; AL+hErGKyvXNyvJ2S3UvCkx0s/Y6UiHaoqJ9nTf8OmNKF5qKvaYNOsNgRwPbnvXaUxLij3vMCdZdv/+hog==@lists.linux.dev
X-Gm-Message-State: APuU4Z9FsGsrXzVXtEYh9U1Ds2CM/EpaACr8WfZUNhzZW03OSPy8VTm/
	mgbUns1T8Uj85FMaCRcYlwPDI9zkf6xoq64afB8khPOfpGrvW23T0yA4E4y5igqsgqE=
X-Gm-Gg: AZFdTZc0F8mRA66QeIPU9CfenYWK/yCDFMxYwmsvHYqwZvXB59VT1am/W+LBjjxcN1p
	RnONw5gY0sA5drwxvgZbQQQHI9olUM09nemMUVi1HMk2MHKC6Opjld2WoeNrjJFD/M3v9LxSAae
	JwlXctq7eId7pa4H+dX2FmB8ODNP2OS0lrm0MMq21H3JjgReddqf03LmtOX0p1zJRQMhtAOjGlm
	wF0U3cZ0+FTjJigQV+tzxm95fsE8Ac4XphwtdzRUdVKUp9Vr6dqSpsBkgNOc1iHArtmLjMThUqK
	yqqUQNQj/2SlNkxJv2uAP6Aaz8ST8Hh7BOhmt8Mis0zxMH70Itp0VmqgWW+SM0yIaNpUlYBiuWf
	4LUn29UWsY/k9oX36Oc1FE1DB63ZnIpowaMnLfplzLLAbfW2Q/Pa5gmP37XewmsN8Lpu4DwPCUw
	1F3QXQuh5X4xGYVKTDGh4pgxMohSrknMlZFltjVFgUAR/qSyNdcTMGvDfveZ0rGM5xSiHywCNSb
	oPEU2q570x1r80zQAFyCNZoe9QqFLlMVqBtuM5FvALql+gB8GwgfOsddojUJI3fcdJW97xaeW/n
	xMABMPJGQTazCSzocYvKOsKEUtJ7EhOTezmzJ/PMhmtXb2gQxm1cik6m0OdUqafmLsXCp5ZtAw=
	=
X-Received: by 2002:a05:600c:c086:b0:4bb:a5e1:8288 with SMTP id 5b1f17b1804b1-4bba5e1b76amr87718865e9.6.1795704782235;
        Thu, 26 Nov 2026 06:53:02 -0800 (PST)
Received: from linbit.com (h082218129081.host.wavenet.at. [82.218.129.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb906c089dsm356445905e9.1.2026.11.26.06.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 06:53:00 -0800 (PST)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	drbd-dev@lists.linux.dev,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Subject: [PATCH 0/4] drbd: assorted fixes for discard limits, bitmap IO and resize
Date: Thu, 26 Nov 2026 15:52:53 +0100
Message-ID: <20261126145257.592085-1-christoph.boehmwalder@linbit.com>
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

Hi Jens,

a few DRBD fixes for for-7.5/block:

- Assume a capable peer for the discard limit before the first handshake,
  so devices stacked on top of DRBD don't latch the 4 MiB limit.
- Fix a lost bitmap-work wakeup on weakly ordered CPUs (seen on aarch64)
  that froze application IO until the connection timed out.
- Two resize fixes: don't silently truncate the device after rejecting a
  too small peer, and refuse implicit shrinks on resize unless an explicit
  size is given.

Lars Ellenberg (4):
  drbd: assume a capable peer for the discard limit before the handshake
  drbd: fix lost bitmap-work wakeup on weakly ordered CPUs
  drbd: resize: do not silently "truncate" the effective size
  drbd: refuse to shrink on resize unless an explicit size is requested

 drivers/block/drbd/drbd_int.h      |  3 +++
 drivers/block/drbd/drbd_main.c     |  8 ++++++++
 drivers/block/drbd/drbd_nl.c       | 22 ++++++++++++----------
 drivers/block/drbd/drbd_receiver.c |  5 +++++
 4 files changed, 28 insertions(+), 10 deletions(-)


base-commit: 64e3fd6772bd8621a751fb916274be2f2dee3a16
-- 
2.56.0

