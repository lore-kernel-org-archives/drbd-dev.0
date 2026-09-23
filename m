Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AE65383ED
	for <drbd-dev@lists.linux.dev>; Wed, 23 Sep 2026 14:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790172402; cv=none; b=KJKtucl8u/jcmTi7Yu57s+hqrwdytRv9GWbwIBZHEGkIVERJ5yBP+JpO0skGVnh6uYjqj5goQduvEM7dcpNdsRpEOHY4qEPuAs011+gihPDmb8fwbz8D5sZfM8u9rjSFNWE4yujrci3QAkurtZh4LXRCV9KYgedByH6B3Y3an+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790172402; c=relaxed/simple;
	bh=rmGcpoIKRjU/t1b9m5XR4fyG3dTYuOf8eWB6EDUthNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W3CBq9SapCat67xJGi/sK0tvQNEsCkOAQwbFtkFvm50sG9Rv10Ti5Bntq5jLKEgYVR3bzwxYMJIeAmcXXz6Fse7Xcg7RdQtZNsgKIUR1MGK/aP/sX27d/14ju+++b7udy5oPvUJOCMf+p5EyBmAGjzQErmL1DS90fN/qAXGRzqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b=L0xVbW8q; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b="L0xVbW8q"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49ccfd61ecaso7620355e9.3
        for <drbd-dev@lists.linux.dev>; Wed, 23 Sep 2026 07:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20251104.gappssmtp.com; s=20251104; t=1790172398; x=1790777198; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vL+K9FciO0t0sxXo6V8h49AzokhOlta0lk/EZzHWy48=;
        b=L0xVbW8qPZb+9Mf6FFSF1Dw1/B/7aSZUY5JbqIR6TxQhephoItdqc8DT2mHZ8FIeuh
         GTUywR5S2Xq6uFt1g80kj8tU4bn33gCnvxgHA+PtVlUNWYm+Zc/qDqKuQDeUb/CJF6g4
         QeUNGNJq2oGK50RowCu//5KynAGP9OWj6E/beGGznGoJdC7wEJr3hAklGBQMyBscPfvs
         rDN7xr2HNzFm0wT+JgGfNuVjocQ5IJKsmHFgMGK7aby+RraNwUvHbgyV6Fg+8BXJbsoS
         SfIxosLvRz8gwemkRbel5FO8tIoWXknx0r8FKWxJQeU77k0Bng6fFhXaEtDJ29jh2N3H
         7MTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790172398; x=1790777198;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vL+K9FciO0t0sxXo6V8h49AzokhOlta0lk/EZzHWy48=;
        b=Koybyh8N6K6LVYedqjCBKKeCen3Pq+7H2XvmWSnbmc1KAU05kTmCFSjsA9dzkPus0J
         2JUmrUdB01fzEAC/Ua89N3EcZbr/oTvj3p3WLnFzsgMJbLCuQQxLZdQk4hVu8VG7jiT1
         V2gttJT5ocE79FhD/9nEQXmWwp6gy585oeTnQrPDbtgz3w+loatwa7fuTUEsrXRwXK9f
         Nef0YfD4/d42wYgCmFp84LFUZZfdjpHKwQR4r8DDo4HU4XcLnLAuGvYhxAXxL896ls0S
         aEJkLRc6uoVgJgKTKQm6xglqNubgT8JRsOW5O4OoSevVg5sDlogC8NQtkcMp+dRvBU1h
         va4g==
X-Forwarded-Encrypted: i=1; AKwUvBw/OPmLAv0AjwWKTBtcOyYbGhy2kZq8yuStv0mSsFrcjkkh2QJfhH5fc6z4+fjaCW8wHkVFouFKSQ==@lists.linux.dev
X-Gm-Message-State: AFuF++lDZ4avV8l4Cb5Mt2azBFJq9Bcszs1mOSgTmYQ3E+YPDLXABWuc
	JLnqz1kvYvhFy1w7eBv0i4hsJ4eNEME6Pqrfaegfu7AQQkCViWQWWTMGpDSSow3oPyo=
X-Gm-Gg: AYBFou0w8n8DuwNfzTzOH9yJhyNZTobB5RCO1LxXWqzWBTMktHqgucspq0WP6+x3YVP
	1eNDrCF7jvG6uc9qfvcMsXRrgAcE0SnrK+1L5DXFk5hzAe0SKuZCsU6L8yCPqjue1z8JBfsrvUI
	vgPnFPiXiXruUMSsEmsUT7d/xVrWpsPYDpVRGhgWoUcvtu3jY3en5XS3GvMxVN8rM8S5U+NgtDg
	9xPi7PP91nn7IFC4DuqTaX4GWXKcPA6s7/1FigjtICqeVIkNctwFH5k+GpoMxaXtKcZYNrRHnEh
	3nr5VE3pwlQJ15jekud8mx3dObb1x1at3Ab67djKWWhThWpRKDnTvHGga+4dmkgGz65gFBwzNZX
	xjWgtiWNDaUBVO+XkT54nIZK5h3cGo21Iyy3Vd0ZuuOldFZ3qzjnxiF/o8qNcoO0At0BTHPh8Tl
	DNZEE2VKxUTB29TnOG7+sMemKXCNl9Cn/CDETkz0D/hqdeY8gJAGvLb4/Kj9rzrMc7lpVAhW6Fv
	OVBTVGgmOvQKD1N0AZLrl4ZH0+b+7k=
X-Received: by 2002:a05:600c:198e:b0:49e:642a:4f6f with SMTP id 5b1f17b1804b1-49fdf151742mr33674895e9.33.1790172397954;
        Wed, 23 Sep 2026 07:06:37 -0700 (PDT)
Received: from localhost.localdomain ([2001:4bc9:b01f:2334:39d8:9506:1776:f780])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fde18a8a0sm78087455e9.5.2026.09.23.07.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 07:06:37 -0700 (PDT)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars@linbit.com>,
	drbd-dev@lists.linux.dev,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>
Subject: [PATCH 1/7] drbd: rename drbd_worker.c to drbd_sender.c
Date: Wed, 23 Sep 2026 16:06:02 +0200
Message-ID: <20260923140608.1116713-2-christoph.boehmwalder@linbit.com>
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

The "worker" thread has long since become the thread that sends data
and resync requests to the peer; the receiving side lives in
drbd_receiver.c. The out-of-tree DRBD 9 code base has called this file
drbd_sender.c for years.

Rename the file up front, with no content change, so that the upcoming
DRBD 9 rework of this thread shows up as a modification of one file
instead of the removal of one file and the addition of another.

Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/Makefile                         | 2 +-
 drivers/block/drbd/{drbd_worker.c => drbd_sender.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename drivers/block/drbd/{drbd_worker.c => drbd_sender.c} (100%)

diff --git a/drivers/block/drbd/Makefile b/drivers/block/drbd/Makefile
index 5faaa8a8e7f0..1a6dc0f482f5 100644
--- a/drivers/block/drbd/Makefile
+++ b/drivers/block/drbd/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 drbd-y := drbd_buildtag.o drbd_bitmap.o drbd_proc.o
-drbd-y += drbd_worker.o drbd_receiver.o drbd_req.o drbd_actlog.o
+drbd-y += drbd_sender.o drbd_receiver.o drbd_req.o drbd_actlog.o
 drbd-y += drbd_main.o drbd_strings.o drbd_nl.o
 drbd-y += drbd_interval.o drbd_state.o
 drbd-y += drbd_nl_gen.o
diff --git a/drivers/block/drbd/drbd_worker.c b/drivers/block/drbd/drbd_sender.c
similarity index 100%
rename from drivers/block/drbd/drbd_worker.c
rename to drivers/block/drbd/drbd_sender.c
-- 
2.55.0

