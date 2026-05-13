Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B982D12ED
	for <drbd-dev@lists.linux.dev>; Wed, 13 May 2026 06:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778655405; cv=none; b=lRbL7vkYZoAg++HVBUDLEfjPKKK1+F+uaw66tWpLzfNEaBl5ttNVZuXODpKeO8/CCZBc40qDcBOH4nHcVk2ruKkHiFTnDANpCkgVRQJMB+O0xDsWJJhAky/tSeLKykh3ax7Ctki0u31Lza4KmMNMOv1heKuYAcBiKsrf+Y8aJNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778655405; c=relaxed/simple;
	bh=yhT0EdIn34OudW5j/r+UeOcpI1T1LAByDG3DZD/bLMs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VVr3SlViSP0q7OKLWcj/39mDHNOwTYHHC3aPACBTzbUFHDfee9mwuY8jy05yN6R4kgmkSr7oUnOAEfP3O2qYx4idpkMiJFrKVIf9DVKGLJkNKYg1e42qJpa9TB8+FiMau9dvzOHZNRREfHpNc3r3yHIWchhrZXRttwCZhH5Elcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b=eDNnf6jv; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b="eDNnf6jv"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-44ce78ab5feso5427051f8f.0
        for <drbd-dev@lists.linux.dev>; Tue, 12 May 2026 23:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20251104.gappssmtp.com; s=20251104; t=1778655402; x=1779260202; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ICO8dJZapJhTfhwfOJGvuSMwHyEwmud9Z8lFAXKdCLI=;
        b=eDNnf6jvtwaSx3Ebf0BFskqSIye1vVUYpZEFPloTxu8oBxYPWnHZnrs8sxrXHWb9DY
         LEpGMZmJCyX5RvNK5rKbnivQmE38PRQtoyckokYOr3RWwHrtYACO423e07STl8uszm9H
         E3mhhPkiwKOx5E3JnHdvhOLboS9td8nODYmQfif51cd/5nWjbsUlhKAJCiJ7hOOKJVuR
         emTnHFGpfsJMX7ctn+L3ffwL/4UXkUfZqBgjHXxcLm3NS0YzjcAHuVhkCulSfppK/pDj
         r4/5cJ/J0krYLGNLTJJ99hJwhuSRH3b96CrejQd9Q+nyq9yjE0JLXlCwpEzfbcTa5USd
         H0+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778655402; x=1779260202;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ICO8dJZapJhTfhwfOJGvuSMwHyEwmud9Z8lFAXKdCLI=;
        b=aAWn5QGTqv5xWxTF0mSsu3CKDTWIh9kyHlupHnDTILrPYbkjqAMxClxR/nVTUcmApP
         dC8LeRV8/OtETNt0KCs3/M9Kfh7ofkKnhBszUlYaf7+s77Qt/9A7Ab7bofKQaiw0Z2Me
         dKLz5ulSsLCsaNBTSChfJksJoEw1Vh0VkD8aU32RRoJNX4w8V3OA3vPQFhObXpXRIsm1
         mdMhWF0GSD+kKC5xth6CI85OZHp+fZ51aOjTabiSEt9elRcvx5WkEJhmi3eDP9L0//Bp
         Vm4BAMFss3GBW4kD8c5xMyX1AEoFruZ67n8+zjorSAAAzX5VbvvXoEiTf9LjIq86HlFL
         f7RQ==
X-Forwarded-Encrypted: i=1; AFNElJ8vX31+uL3uR5VPQvJK5B9ypI4P1IJ8NN/CWRlVIw2wJ3vHUEJQCwM8U2+mm9mydAen7h7atWJ7/Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw5FQrZjSFNmwOG1DTDJseAtd3GtlkAWtV5yhcUnaqsNXrqbUBQ
	r+8SPyiRyXITB758H0vkc3VlkTfDZZ4IIAHpmBDkr1P7MJF6GsAonz44AoB4DlwMmno=
X-Gm-Gg: Acq92OHVGLnPjQmM2DD+n59kTxmtC01nXP1oKuHpH31RmQ1VCDVr0q64BRonOMsfpag
	On5UnS3nc03tzF4qPw/+PVfYzUnVF0WXKwgZZi5xiqVzCgs3xxr5QBrp46z3wJsxQhf3a8Mwwwo
	M6GsFfsLbDbZrRetLVWIhMytRAarPNEpCS1y8UiRPlF6XnatKGLUnk4AlKDnYFfxe6UHnvZcE3w
	8cd6NwrIerbsgQ458r0W/ngkhChAQhkOxn4hFAwyRrkGYO8tr+VPGRNfdSG6XjVNv7Cmtr+qA7f
	xoPa1SfAD5EGbJNxNXMSLym39yEbtXEBJVhReWW55TbVAMuRfx6SkNHnCrY+ILpNtg8PIwZXFnE
	L3MSJDv+zVkgNsBHXvkeqPw5lo/LH5FpZhWn4DULfJ0SXyAhbq/a9BXnuzVjoYJ78bJXv1zBOlT
	mAjXaIWRAd68yGPDcfnuDmLavUyKfEiJiMJ+MGuNl5b8bTkVj/4HEhDg/bjxonYmISd1LB36Aq8
	9Kuj+wrbLPjCD3zBDBBtb9KCRwARQ==
X-Received: by 2002:a05:6000:268a:b0:43f:e934:50ac with SMTP id ffacd0b85a97d-45c5859efc6mr2894173f8f.7.1778655402253;
        Tue, 12 May 2026 23:56:42 -0700 (PDT)
Received: from localhost.localdomain (178.115.63.61.wireless.dyn.drei.com. [178.115.63.61])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4549130549bsm39386799f8f.18.2026.05.12.23.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 23:56:41 -0700 (PDT)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars@linbit.com>,
	drbd-dev@lists.linux.dev,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Subject: [PATCH] MAINTAINERS: use new drbd-dev mailing list
Date: Wed, 13 May 2026 08:55:57 +0200
Message-ID: <20260513065557.36042-1-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: drbd-dev@lists.linux.dev
List-Id: <drbd-dev.lists.linux.dev>
List-Subscribe: <mailto:drbd-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:drbd-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

We are migrating from our own infrastructure to lists.linux.dev, so
change the drbd-dev address to point to the new domain.

Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4abb3345bc4e..b8db0c038c55 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7773,7 +7773,7 @@ DRBD DRIVER
 M:	Philipp Reisner <philipp.reisner@linbit.com>
 M:	Lars Ellenberg <lars.ellenberg@linbit.com>
 M:	Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
-L:	drbd-dev@lists.linbit.com
+L:	drbd-dev@lists.linux.dev
 S:	Supported
 W:	http://www.drbd.org
 T:	git git://git.linbit.com/linux-drbd.git

base-commit: 36446de0c30c62b9d89502fd36c4904996d86ecd
-- 
2.53.0

