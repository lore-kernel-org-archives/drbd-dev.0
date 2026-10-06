Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B7C4A0148
	for <drbd-dev@lists.linux.dev>; Tue,  6 Oct 2026 15:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791301662; cv=none; b=dCK5OxXVQFVVQueZg3K/AJq/acVj5Ku33NXPybFRYLrs+xpuLaiot/bYPembZCTx3AlW3l6O8AsqeV0GpB/AxtG/w7OSrCm5dYjWylZ95l/rjQgBkKhiacVHWAdf8L9VPIEyGjGpVwt7FMFZA5nRIYoDMia6QR0PIncv6JiPFj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791301662; c=relaxed/simple;
	bh=WQgo3gi3KAogDGueOlvmgGly9rIsGOBFx1w+r5ob4TM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UWXIxB/1PvbLVmvsYKKC9m/Ja989cLZbvCk5T6+U25Znu7bn5WtIdql7k9LEg4zlHSRXV4cKscdIwTbfvszS7fO/pCYWmipbQF8PVGIcf3hcWBf2SLfEtFV3BqgQd3Ks482sJKKXR589NqltEVv6gV99sQUEHqdWrK+40OYztdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit.com header.i=@linbit.com header.b=sKjBYu0W; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit.com header.i=@linbit.com header.b="sKjBYu0W"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a168355946so8548625e9.0
        for <drbd-dev@lists.linux.dev>; Tue, 06 Oct 2026 08:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit.com; s=google; t=1791301634; x=1791906434; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8OrE7D9wgxOgfXoLfMaem3xj7KYquRVAqPRjESEqerc=;
        b=sKjBYu0W0zuWWb09WqY3v1pD/3O4PwS3mhim1XAQ+qtgNffXZzNHQIH9ST6qGdgSiK
         iAdgR/CazRoae6Kuu214DQVEE0LJ+2+6yOzHxjnbYOcHtZXD814tTMLXCiPPMXCzhJDH
         bSZTrc/vUuwSNRjJrx38fBNyO3W8Dy+HzgHm7nJv49cUIWVVFYqzy1McyfjFlwWfSJJe
         UT2z53ODBtU4VDmDZJHyNwae/XHL6G0BvkH36Qlj6e50jl9P4VNJqz9gzxLUfprSKd+t
         IpjlCsgL14FjyDvphaTZ2hLNi97cUcKZpEZ0CKKmbm7AoCZ2yRzG6YBwtTUlUrESWRqP
         +vNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791301634; x=1791906434;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8OrE7D9wgxOgfXoLfMaem3xj7KYquRVAqPRjESEqerc=;
        b=qEbKbCSh/FlxdNP99cx61QmOUnTnvQizQAr+VbGCfPAEkzxf7m6B10l5dgJJD7/y5t
         9AN/f8EOSqOEwkyY7yjOZTEDm4I+2qHBXImj0bMeXWUgj2apY9t0DZk1+r+pSYB41yjf
         hKymtWVW1N1XnR4Ysnb/m0/0UUDlPVcBmXyuuEumE/iH+AURscSXY1XUTf8/VKHt97uI
         upn4pih9KYnTzxkHCwWk86qH5Vqbwib9uiyIInkyTWsI+rx5fDUWfiSZL/jy31J4w7ze
         jQnIn0lLYJbtUFSYGdy8dSO9jEnkoo7BA30AGchDjrp4VFCZGhQGee4linzh/dFZmuyx
         2wDg==
X-Forwarded-Encrypted: i=1; AKwUvBzyC6KSCktC0wnynEyd2JXtORj4NRPwf1nHVJrh1y6npn9CvGtjmTL+cXmjzF23HXSdp0nigg6SMw==@lists.linux.dev
X-Gm-Message-State: AFuF++kg/DrK6F7peR9Ykdfu0IZ4+75JU6aYo+HUHDn6J2SUO9n0IzBo
	9fxmHaUjMv8OgDbB1xRb8qZ1vkws6GFZZGEHC5NZ9/AGdONXKerunl17zYK84se/e2w=
X-Gm-Gg: AYBFou0SyhXOy0fczKLgL1d0qxmkCrKPVkzJbb52QqRbaKQBC5HBSChj7yWA8PXkWCF
	W6EqxTOAzqa6MNUSa3nvJcSxdgCVwapkXe65kN2eDzl5G7oNLP91M8F6uGxmFCYLXVOy7zgrG4T
	3uQ1c+ClAburclCzadvVZKd13aVo1W56ZCHspxdO8hp6vKlNSp8ddyGJ9gfKyxj6Q8PL7l6EyFA
	vKcfSh0H9+ifQtZZoBRCKZawcAGBfyjDmsEjdB4YgGCXLzVHpzg2/VLCgrFz0QqdvZEXW5Mwnyd
	36xZb/IP2Bf0L3f+8HW259FnbbH9ywxSTYPkq8cWAKTGSMvUTINR8XSE7AUoiMnSc7v1kcNu4L+
	PINMrgiK8I7ONQ8O2/J5taJ9cQ/Nt9tCu+OZXTs4tHYKPyRCq6GO1nS7vpUS85d4z5TcD4yNppQ
	dBmBLfeRWL+KiKIc0gfziMU9L3QjaTJY3gfKTUivFWiH83+fKBePlKeGr4FWzEKeOYjgPWZuxLN
	JetSaktZXxxs8swABED9OFdgGWIP4Jo
X-Received: by 2002:a05:600d:82c2:b0:49c:cee0:f383 with SMTP id 5b1f17b1804b1-4a17b54978cmr36665195e9.16.1791301634297;
        Tue, 06 Oct 2026 08:47:14 -0700 (PDT)
Received: from localhost.localdomain ([2001:4bc9:b00f:d376:7c33:9a50:ef33:f391])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a178c5b9d6sm72087205e9.13.2026.10.06.08.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 08:47:13 -0700 (PDT)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars@linbit.com>,
	drbd-dev@lists.linux.dev,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Subject: [PATCH v2 20/20] drbd: remove BROKEN for DRBD
Date: Tue,  6 Oct 2026 17:46:07 +0200
Message-ID: <20261006154607.3936501-21-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261006154607.3936501-1-christoph.boehmwalder@linbit.com>
References: <20261006154607.3936501-1-christoph.boehmwalder@linbit.com>
Precedence: bulk
X-Mailing-List: drbd-dev@lists.linux.dev
List-Id: <drbd-dev.lists.linux.dev>
List-Subscribe: <mailto:drbd-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:drbd-dev+unsubscribe@lists.linux.dev>
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
index 261965d7b054..06be6ce164f5 100644
--- a/drivers/block/drbd/Kconfig
+++ b/drivers/block/drbd/Kconfig
@@ -9,7 +9,6 @@ comment "DRBD disabled because PROC_FS or INET not selected"
 config BLK_DEV_DRBD
 	tristate "DRBD Distributed Replicated Block Device support"
 	depends on PROC_FS && INET
-	depends on BROKEN
 	select LRU_CACHE
 	select CRC32
 	help
-- 
2.55.0

