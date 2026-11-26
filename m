Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795704789;
	b=3tWIyDDYhaDXf+oboWN9naUmw4NopcemBchQRbbf9j4cwkDI9mqq2SB/J/eHzzPBzo7I
	 tD/N6F4ON477c2BDEZCFn9K/g7ACrr9I8vx2xF59OGLAiZACZg6ZGW70lWdeBL+6qRfSU
	 4/hh26EtU3gzGv0T85koIWVyDSUDOj+je51ZxAjqBzqbAQFveZMZZVVJ9O53Ly9wIU2Hm
	 diD+kYmLlkaQcYg+9B85VUZgl+FzxoGIqPwJEuhXoHimAqUOTOsxeb9KqDFB9QJPO30Jl
	 dqQFsvG/fN5cuAiHwmSU+15sj6v2/Ru1EvU/nuSR4+ifAzPvVGJtGo9/dpLJ5wSeG+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795704789;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=a1dL6bz0M4wUZOGCZr+O+oOZ/mF4biIKzGjIH6tjykQ=;
	b=wyNQJHKukchakyH3+7M8nYdsFbJEZzXXA2sK7IXdmvtAW76oP8h6Xf9WewSWJzXnu8VF
	 YpurptyVTZmWUruid08T6pcW0R25VHVmq/yapDFMN+sDg4Y0fuA14Jo7+qQKKi4UrNi6k
	 WGtgX7tzcl7PnvMFctZBuOQdkLhZa1eLgeWlvJfAZvsWY0bYrLTmcJKnrObpeVKCAHuW5
	 VgVyfTvGFl1BykYlHjbAVPt+aZfuu7RF2YLiw5iXz0uWi/uUYA8iX7/oYv1yZehcotzEE
	 3mDZtdGtQkQohJFnRQgttlvNo5S7ZXcX5F0tFdLxy4ew9wly4LHXmDNOA+9kpG1COiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linbit.com;
	spf=pass smtp.mailfrom=linbit.com;
	dkim=pass header.d=linbit.com header.i=@linbit.com header.a=rsa-sha256 header.s=google header.b=JaYatgME;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D87606A6B1
	for <drbd-dev@lists.linux.dev>; Thu, 26 Nov 2026 14:53:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3D87606A6B1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit.com header.i=@linbit.com header.a=rsa-sha256 header.s=google header.b=JaYatgME
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a9a8d6cea8so91742695e9.1
        for <drbd-dev@lists.linux.dev>; Thu, 26 Nov 2026 06:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit.com; s=google; t=1795704787; x=1796309587; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=a1dL6bz0M4wUZOGCZr+O+oOZ/mF4biIKzGjIH6tjykQ=;
        b=JaYatgMEmzPsbrz++se1n2eSInuAqAThLscgKVtQfAsaaGdtg55HEvT5ekW3tyqRJX
         K8h8dD9juO4017wZFiRV/GyjKN53RiTKmOOxNnkL/k7zo/Pcfk8jkQLyCA0QvwJcLbKC
         bNgnvRjbZaq5fwryByaavkQSOlFE2ZvVT0c/q+i4OvjhsGxF+BPkJvpZHAI8wkjROJSH
         O3jpP0mItNkedSeAPRQCsHMYvlgLj98uJSSPJNmD9DRFy+rASCwrNzMWqAIBC0Poe8vY
         oi+3Ap/MDXosM7HQl029nsg0KxYg72+MT5e0EZLisI5EbouIjKcRSi9dFxn0w6rqOlb5
         AbDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795704787; x=1796309587;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a1dL6bz0M4wUZOGCZr+O+oOZ/mF4biIKzGjIH6tjykQ=;
        b=w/xc842H3NvFvHgx3zcrJyEII77H/3oN85drWEmd70EIinivLB5260XB1bDnT+d4s2
         pEkHH02hHH1DIfOt1xjE+3BjKsIxwA9NXW6ePLXEhao5xI2NfwnDTNz8UYjx5yz9QFrh
         1kRX04v2WoI8LdbgNxVKzfDMpC2ETbROmd04aoGIac+3BPqqiERCBQMDbIAYqkU0WQ6t
         2AFP1j4c32nxf+u4y4okYu4Lw5VXnAXWak0GGfutLgDxf2Zz5kaoCQUoWzF7Jvnij83S
         pSvvTJVN9K1JzJNgyQwLUhDFMnZBfq/RV0S1Z5MtP/eJr59F/NNWR3UQZzq+cC9iBr4g
         JqWQ==
X-Forwarded-Encrypted: i=1; AL+hErHTxRYgqhjzuCOQWjiOjExYSLcvZohkReivfJz205Jsg80h84VifYXEDARcaMQTgEHAM0uuQFZ98A==@lists.linux.dev
X-Gm-Message-State: APuU4Z8gqf+cH3KP5UR+jxGRqtYtlrjwmciLzCfBt8wNd9n5/N+HhVq9
	7Afmdqe1gfBckU/qjVNJ15qJ/ryqegNi4uTH8JF55juN60waVswZXxelnw/fKlETq3E=
X-Gm-Gg: AZFdTZcxyCpVuMmGfmWxGxRJ+SfeY8HTV+e7Ii5Ddv6hfbZIblhd80Da1vZEiUUmGHm
	CGb7CVd2fcZqrVCikQJSIdzdICDrBk/udfR739dbQgQbpq0lTzoWgJtZvHv4+0pEDvzO/pV86gp
	mjxDwHZj6+4NOBH/f0I+3TL41i3GQQoFbDlifye6CI4Ia7NqdecJkXkXhpUK97tJ7blL+zQ9OwX
	Q0eEjdZVhAKViCeRl+Lh4HqAb5X/UnZ1Bho84zhSP1c/Xtt8kNVWEDSIB/T/UDquJrO7CPz+JPz
	HGJmPEIykDNb2S5baY3W5LXsVATE+S67EaCiD6AGRYl5XvnIfiZttREB1p8O8aS34yZrU8f8nZt
	4Y7r3sTYArsDlYooOb4usa1+FHQzhumfitlU98cJCWlfJxq5Dh3j2d44zpqBsxIjQTCojai6f7f
	CZjw1RZx5vqL2fmx8I2V521lGyg8YZleyMYdDQ31+6uxV/Bjnza08iCrzGxChgpSOpf9zQIHVK0
	NOtD9Fu77ylYl7WTEWD2wMjBPYjGclcfwg+dMfAMpngjRyNQEIkDmRBUH36fm0XAvsj4NS6J/9f
	g3rGH+6GuCq/dQp82fVL7MvTbbMITQkGsHqSzUbBwzvCsrQsJIhrFZ53OhLqgx88YKQBgY9glw=
	=
X-Received: by 2002:a05:600c:4585:b0:4a1:c6f5:2450 with SMTP id 5b1f17b1804b1-4bb8881b8e4mr439545255e9.17.1795704787080;
        Thu, 26 Nov 2026 06:53:07 -0800 (PST)
Received: from linbit.com (h082218129081.host.wavenet.at. [82.218.129.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb906c089dsm356445905e9.1.2026.11.26.06.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 06:53:06 -0800 (PST)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	drbd-dev@lists.linux.dev,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Subject: [PATCH 4/4] drbd: refuse to shrink on resize unless an explicit size is requested
Date: Thu, 26 Nov 2026 15:52:57 +0100
Message-ID: <20261126145257.592085-5-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261126145257.592085-1-christoph.boehmwalder@linbit.com>
References: <20261126145257.592085-1-christoph.boehmwalder@linbit.com>
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

From: Lars Ellenberg <lars.ellenberg@linbit.com>

There is a check for implicit shrinking, but it was only active
when _also_ changing the activity log on disk layout.

Make it active always.

Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/drbd_nl.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index efa6e46326a2..5c8a3ab326d7 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -981,7 +981,7 @@ drbd_determine_dev_size(struct drbd_device *device, enum dds_flags flags, struct
 	struct drbd_md *md = &device->ldev->md;
 	void *buffer;
 
-	int md_moved, la_size_changed;
+	bool md_moved, la_size_changed, al_layout_changed;
 	enum determine_dev_size rv = DS_UNCHANGED;
 
 	/* We may change the on-disk offsets of our meta data below.  Lock out
@@ -1009,7 +1009,6 @@ drbd_determine_dev_size(struct drbd_device *device, enum dds_flags flags, struct
 	prev.al_stripe_size_4k = md->al_stripe_size_4k;
 
 	if (rs) {
-		/* rs is non NULL if we should change the AL layout only */
 		md->al_stripes = rs->al_stripes;
 		md->al_stripe_size_4k = rs->al_stripe_size / 4;
 		md->al_size_4k = (u64)rs->al_stripes * rs->al_stripe_size / 4;
@@ -1064,8 +1063,11 @@ drbd_determine_dev_size(struct drbd_device *device, enum dds_flags flags, struct
 
 	md_moved = prev.md_offset    != md->md_offset
 		|| prev.md_size_sect != md->md_size_sect;
+	al_layout_changed =
+		   prev.al_stripes   != md->al_stripes
+		|| prev.al_stripe_size_4k != md->al_stripe_size_4k;
 
-	if (la_size_changed || md_moved || rs) {
+	if (la_size_changed || md_moved || al_layout_changed) {
 		u32 prev_flags;
 
 		/* We do some synchronous IO below, which may take some time.
@@ -1098,7 +1100,7 @@ drbd_determine_dev_size(struct drbd_device *device, enum dds_flags flags, struct
 		md->flags = prev_flags;
 		drbd_md_write(device, buffer);
 
-		if (rs)
+		if (al_layout_changed)
 			drbd_info(device, "Changed AL layout to al-stripes = %d, al-stripe-size-kB = %d\n",
 				  md->al_stripes, md->al_stripe_size_4k * 4);
 	}
@@ -2861,7 +2863,6 @@ int drbd_nl_resize_doit(struct sk_buff *skb, struct genl_info *info)
 	struct drbd_device *device;
 	enum drbd_ret_code retcode;
 	enum determine_dev_size dd;
-	bool change_al_layout = false;
 	enum dds_flags ddsf;
 	sector_t u_size;
 	int err;
@@ -2936,8 +2937,6 @@ int drbd_nl_resize_doit(struct sk_buff *skb, struct genl_info *info)
 			retcode = ERR_MD_LAYOUT_CONNECTED;
 			goto fail_ldev;
 		}
-
-		change_al_layout = true;
 	}
 
 	if (device->ldev->known_size != drbd_get_capacity(device->ldev->backing_bdev))
@@ -2955,7 +2954,7 @@ int drbd_nl_resize_doit(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	ddsf = (rs.resize_force ? DDSF_FORCED : 0) | (rs.no_resync ? DDSF_NO_RESYNC : 0);
-	dd = drbd_determine_dev_size(device, ddsf, change_al_layout ? &rs : NULL);
+	dd = drbd_determine_dev_size(device, ddsf, &rs);
 	drbd_md_sync(device);
 	put_ldev(device);
 	if (dd == DS_ERROR) {
-- 
2.56.0

