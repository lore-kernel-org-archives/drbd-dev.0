Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEEA244687
	for <drbd-dev@lists.linux.dev>; Wed, 23 Sep 2026 14:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790172400; cv=none; b=Ov0VMw4GVslY30JowuWTZawtGeTk0A67He2y0+2Q8LvrF6HvXEkoK+UlxKmyv3iWBry49TLOUlfXk2BRIlRokcHeg37O9NXCYssoCr+tqM5uKqofy/ewqOtVzBNC4b7ugWBUw5DN+YYNSkGYnIbbmF8YHga3J/X+Jg2pgfndch4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790172400; c=relaxed/simple;
	bh=oTN0UkvymfxfGzObUk2qVdjzgU9xGJX4xG3MjkmtUl4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=W7ZfBBp2HupqClb2nb8RNTySfvTUBpCxu/AIqQ/EQWImOYc160nHuE3SYlXE64dqHKKYZ0mYwI1R5NeVUj7MOQ8AO4+2GLCVXTiEKFQjfqcKALU9OCcRU4XzZQEbgZitYBOXlVyW6mJUMaMVPBonJ+prPyBYz1Wykhmbx9fglE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b=OSfhTtFV; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b="OSfhTtFV"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49b912e4ad9so5449795e9.2
        for <drbd-dev@lists.linux.dev>; Wed, 23 Sep 2026 07:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20251104.gappssmtp.com; s=20251104; t=1790172396; x=1790777196; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yK7mZx0EiqY5laEgalU2cR5RMQsFjx+sycq1PNzq5sY=;
        b=OSfhTtFVnumrwdsVjGXuQ6uNEKc4H723VWzU805M7M2Oq47DsweP30k3a/Mt47z5Gw
         5xAIb/z5DABnQ4Brz8440Lh0MTAmLyUoAm6ZUvpQLOFsvDnHf53yOqhxX63M9avAy61o
         cYTGhQPMVKH1b+Hxo1KrbTwYxI88AbO3/DjmFivKN5xC8DkYiGsYYFt1mMTKsXRPymkR
         N80bY8hqSgggXiob/chZV1x8+Cs6zwpdl3o75XoerGOLwjAWQ1k91WPKKJ3mRJr+ap9K
         3oBiRTndftPi9hQft4BamikJY0cPlVZwknrORTzuuNf3GNErhY+M+1xfE2US9xVdTmK6
         fidQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790172396; x=1790777196;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yK7mZx0EiqY5laEgalU2cR5RMQsFjx+sycq1PNzq5sY=;
        b=U3nxcBMvm4GN7QVCDNTV+qG4274DlNJ3tB80oBnd7pz6S8kuMuK9chc20axw02mnVl
         7rD/mO7XoHRvJWvopIB5dJ1t+tpXHP5jtSIFC79WecBMcDd2npsEAuc2NcWfBUFM9eSI
         pAl0dcNt2hTsArOHw6QXbm4xHX2TAFyTCv/rV+OxGB5yNrP0FO71MSWbz5uuSoL0A0G4
         LP+HIX73RxdfxPcA577VZwuebZy+RhBMtF9GLnDQXAmeu5EiYR0jz8rRFRqeyLbcRp0r
         KMpGU4yjWKWttslTUp/Xt/eEvkIzkeQmEc+NwZqH0OUChXqibClLlbykWGhl4aKCw/Qk
         6UzA==
X-Forwarded-Encrypted: i=1; AKwUvBxLvDzcMY8e34dk0lcJdv7whjS4sHHIMEnlUYD23OK/BuYShqnNy6Wz9DxHt/kRLUNNiYWazPYO+w==@lists.linux.dev
X-Gm-Message-State: AFuF++mbXAv/Ufjl1wlnixmayifleb3LvKqTjU4egcOeShLMn3uv6gxF
	jUspxVwwpADqaDO8IvHnqiAf2E1EaCsYbRcMJVUbRSOCm6f/04uVD4aOzhB1rJktqSs=
X-Gm-Gg: AYBFou0XgslZ7/EZEJc8IizFEwyE8dVDlJCP48EcMGXV08mqzmSrWTdcQMT7ENVEv5g
	ItfPoeRdGNslN1ilsgW1VTR2bfPLSOBwj12lF4tj1LwNQ3uDQ5i6tetA3lLyWdZ9/DU/09Xiagp
	VT6r2BDr6aLf3Xnl+TvBecCoDC1/vsNZ1OwMr3+/kdVtJNecDNQJcclOhIaagT0F3Ck1CeWZR3A
	D5dKD7/zsbdn0b08lyUrfede0AwmyQQwOIcdRjy3kBsnKZbEjLhAdwe4jhf1GbrBYAxGPkiXdG4
	5LRSP2De2FrZoxMWnY4idWR/T7cQ16ktfhRij3SQb/dNx1siu7xdt9EWvN6XKAxPDGyIDKWVwiR
	tQiNBcQRyxH0iqRAhlypVx+ZsZc1rRyaG8i7OPqx6AImdy41XS4oXzh32vN7/Eg8bQsATCLpDei
	rgMwVlbUrsE4rL5ZElr/IYv+XOxlfK1GWgKcl5Un8RvJfn0PYAwYTArm9fg5t+qZI9znzVeZuAW
	gnII9cmmakjhW2zdnzN+aMZMDqH9PM=
X-Received: by 2002:a05:600c:a416:b0:49f:df99:ff13 with SMTP id 5b1f17b1804b1-49fdf99ffd1mr35917295e9.21.1790172396347;
        Wed, 23 Sep 2026 07:06:36 -0700 (PDT)
Received: from localhost.localdomain ([2001:4bc9:b01f:2334:39d8:9506:1776:f780])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fde18a8a0sm78087455e9.5.2026.09.23.07.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 07:06:35 -0700 (PDT)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars@linbit.com>,
	drbd-dev@lists.linux.dev,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>
Subject: [PATCH 0/7] drbd: preparation for DRBD 9
Date: Wed, 23 Sep 2026 16:06:01 +0200
Message-ID: <20260923140608.1116713-1-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: drbd-dev@lists.linux.dev
List-Id: <drbd-dev.lists.linux.dev>
List-Subscribe: <mailto:drbd-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:drbd-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series contains preparatory changes for bringing DRBD 9 upstream.
Each patch moves a piece of the in-tree DRBD 8.4 code to the form it
has in the out-of-tree DRBD 9 code. Doing these steps separately and
up front keeps them out of the much larger rework that follows, so
that rework shows only what DRBD 9 actually changes.

The patches are a file rename, comment and internal cleanups, and two
higher configuration maximums. Defaults are unchanged, all existing
configurations remain valid, and apart from those limits only the
wording of some log messages is visible to userspace.

Christoph Böhmwalder (7):
  drbd: rename drbd_worker.c to drbd_sender.c
  drbd: modernize the file header comments
  drbd: raise the socket buffer size limits to 128 MiB
  drbd: raise the maximum resync rate to 8 GiB/s
  drbd: replace the drbd_interval bitfields with a type and flags
  drbd: move the packet name table to drbd_strings.c
  drbd: rate limit log messages per object

 drivers/block/drbd/Makefile                   |   2 +-
 drivers/block/drbd/drbd_actlog.c              |  16 +-
 drivers/block/drbd/drbd_bitmap.c              |  18 +-
 drivers/block/drbd/drbd_debugfs.c             |   4 +
 drivers/block/drbd/drbd_debugfs.h             |   4 +
 drivers/block/drbd/drbd_int.h                 |  59 +++-
 drivers/block/drbd/drbd_interval.c            |   4 +
 drivers/block/drbd/drbd_interval.h            |  55 +++-
 drivers/block/drbd/drbd_main.c                | 106 ++------
 drivers/block/drbd/drbd_nl.c                  |  15 +-
 drivers/block/drbd/drbd_polymorph_printk.h    | 256 ++++++++++++------
 drivers/block/drbd/drbd_proc.c                |  10 +-
 drivers/block/drbd/drbd_protocol.h            |   4 +
 drivers/block/drbd/drbd_receiver.c            |  61 +++--
 drivers/block/drbd/drbd_req.c                 |  40 ++-
 drivers/block/drbd/drbd_req.h                 |  12 +-
 .../drbd/{drbd_worker.c => drbd_sender.c}     |  42 ++-
 drivers/block/drbd/drbd_state.c               |  15 +-
 drivers/block/drbd/drbd_strings.c             | 138 ++++++++--
 drivers/block/drbd/drbd_strings.h             |  27 +-
 drivers/block/drbd/drbd_vli.h                 |  12 +-
 include/uapi/linux/drbd.h                     |  12 +-
 include/uapi/linux/drbd_limits.h              |  12 +-
 23 files changed, 534 insertions(+), 390 deletions(-)
 rename drivers/block/drbd/{drbd_worker.c => drbd_sender.c} (98%)


base-commit: 85bffad4d2fea373a72d68bed8012e8cbccb8ee7
-- 
2.55.0

