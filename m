Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794328019;
	b=VsHrmHhne2fyjiCnxT0Odg3UZV6Sa6iorlujNaUoj+cVlCJ+ZgDK4DKvmWlJvagGsDSg
	 xBdfDk81Pd4fJWzZ9a7p2XYv1/4+ulOwzptV9LNpzqWoLhfP7miWMvhPYKdKqPqNfkxWN
	 xfZedbkshn2gX64Z/XBmuBS59a2XSdPY1sRzhug6Z+hKapOUuPG/EnGkCZBrD8lVg4f6Q
	 9X6P0Hr8rKaEdZ/GOG0Wl5vu7BuXzBNBs6g8ML4jZRVnVk8SvVtrc44/pJFvkgkVUl5FX
	 o5h5a09bltTiz0UP1NqGoJ0ZlJpdOnhVwsEZI2BMdNCjE22SDFsDng0xryUHLNdaLqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794328019;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=j66A61VB02ttIT3aNMpet5+IqRoDe8F2uoe9E4qYXPI=;
	b=3ysDMGwf0GT0O3LPFlnvmFQk/32LLObeHFdkvS1NMEOBQIbcL55dbw2eq28iw4Kgfo5H
	 Igh8Y9NXfaUGnnR9W1+Kod3b4ZHKXv8YyVfvcm4y0yNrTtuURzMGABEdafcBKcvoozKiU
	 hw+Q+C8JI5q2ZRUYyCKeuSdlY6n3aHUlzX3S1OYUGRwLUAdw/7p+yxKGnkwz393IZYATS
	 aDvFN85/s5xlZ/0I0nFxrOaKr8r2r4dSGl38MmTaXBYBzyAg6Q8UiGc3mI/I9KvFrYPDG
	 sx7VmP6YwSkOuNEhi/AurRR6ePrjqSbG4DpDiP1JRyUP2GZ30pVEBwcsPB/vxCh+ADQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linbit.com;
	spf=pass smtp.mailfrom=linbit.com;
	dkim=pass header.d=linbit.com header.i=@linbit.com header.a=rsa-sha256 header.s=google header.b="q/4iXnGG";
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5711D606A332
	for <drbd-dev@lists.linux.dev>; Tue, 10 Nov 2026 16:26:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5711D606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit.com header.i=@linbit.com header.a=rsa-sha256 header.s=google header.b=q/4iXnGG
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a2153c8525so17005285e9.3
        for <drbd-dev@lists.linux.dev>; Tue, 10 Nov 2026 08:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit.com; s=google; t=1794328018; x=1794932818; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=j66A61VB02ttIT3aNMpet5+IqRoDe8F2uoe9E4qYXPI=;
        b=q/4iXnGGVzPg1hpyGVSiEhMd6WUtfTkP7MCkJQq/othgoSkn/FkefQwwpGa8PHQRmy
         C9d3GZwngr8qFlf3NY96c7YSD95PeGB7q11SRAn2Zv58Q8DeC3Q6fVZ5/++Jdj6yG8WL
         NBhftWpVVvZVWzfxv73OeadPPlNHQLDvnHy8P4L4A2/OhmWxFH10F+eaM7lS5wgUIALM
         I8JouFqliFCYITnbfW2QSsBU9KZepCSv17phhLYqd34t6/koyqv2h7JbL2T9PesC3Rg0
         8+uemys0azaM5U9WiMOdC7xctJ2NUZqAv1u9HDZsLbsrYOwNXZgIiI+u0EImwkKCdv7C
         NZfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794328018; x=1794932818;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j66A61VB02ttIT3aNMpet5+IqRoDe8F2uoe9E4qYXPI=;
        b=12H4HdZnOdagjPfI7jdFm88KwkCvmezAl9BNZouFBujeaIFYmDeaqVx6pK45W/+1qx
         SBRnErQopjT272w3QokJgzi4/5yA12Ijnem6qtAo6RQr1VNIgaFfKl4qSjrVkbTCi6/H
         XBOScBR4d4HpmzB8uSQDxPC6iXril6a3k9RbrSiIjT/MOn5aMDVZ+uMJWMOSC94iGcFl
         Jc/ieF4YhbCUwb1Jy3AXhCppUxuK/eV2mvii980cq+WGHhps449ug6h0P38YuX/Zc0DC
         2YL9PC+V3Eg2qNxgf0t/XID2h7mmSulhEasrXVorW4UHAYFzMedO3QdknSd14GQFpUsl
         efrQ==
X-Gm-Message-State: APuU4Z+SglCTWRzCl9WAXl8FSZBsTsvEvDzcQwVeSSJ67I0PhH0gJff8
	pDIOD29F0PjQR2xRhCxRWn9JBKTC5falZN+rWYCd2RZeX2QZt84wrbSdWIi9kw2pC7w=
X-Gm-Gg: AYBFou187wzE4KLO8S2APibUv8NbA89Mi8cFhqI/5qzTWQfhMxbSlb2CNwDpk2A3Eaw
	/IHdNa/VjRQwyFrDJn/nnaDo+ZyeBV4OUSDi/ohM7Wnu800ZEvwL3EiD+ixNdrJxhUYwxpVvDjU
	KPxpRQgRAz+wRjUyR7H6Q3o6YLv8I9XXFCbEYa/cOSXwSEfUs48quXHhnx6Og9cPGaoKrnuQKKh
	YC8VvqKEyE4ySZVyna8CPpXGV8igJO18EVZxNeWva9YLV4tOA5Km9VUBExfSgi14cCc17bnUPCV
	z1VWAEBtl+7U+5NGDr7yTitLBiU8HklV/wgz6Cza9jEJAbdSVzjpv70YciIIlNl3Y7pnTotQZmY
	j1zQU8rZ50qY5PSuUx9k9ie0D8CqiSmHpUjLJRs2u0b7gPeXIQg6lfEkycBgub54Mghkc1PDpQM
	qh5yR9149STM6JAaUx6qgClh3kng6pc7DxAqefRKX1ltt7ffXW9PgiHZOgGe4C8ePmX89hWxTmO
	JR2nYYgagMrN04YynjnTBI/S4fqlriAL7oSgg2a4v//4ORXU4SlNVj+D3AhQq5FqDJ5W9ABeKpv
	dWGRKZq/XHKaPJukjgI4ll/lly8MYOS+z95Sr6k+z4aEmOi9TtWd7gHPNgwB9Uo82FfsxK+rDg=
	=
X-Received: by 2002:a05:600c:19c9:b0:4af:83ad:8f70 with SMTP id 5b1f17b1804b1-4ba02356ac1mr55662755e9.35.1794328017694;
        Tue, 10 Nov 2026 08:26:57 -0800 (PST)
Received: from linbit.com (h082218129081.host.wavenet.at. [82.218.129.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba02345d22sm85050695e9.1.2026.11.10.08.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 08:26:57 -0800 (PST)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: drbd-dev@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-block@vger.kernel.org,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Subject: [PATCH v3 01/20] drbd: mark as BROKEN during DRBD 9 rework
Date: Tue, 10 Nov 2026 17:26:26 +0100
Message-ID: <20261110162646.3028472-2-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261110162646.3028472-1-christoph.boehmwalder@linbit.com>
References: <20261110162646.3028472-1-christoph.boehmwalder@linbit.com>
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

Mark DRBD as BROKEN while the driver is being reworked for DRBD 9
multi-peer support. The following commits restructure the driver
extensively, and intermediate states do not compile. DRBD will be
re-enabled once the rework is complete.

Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/drbd/Kconfig b/drivers/block/drbd/Kconfig
index 495a72da04c6..ab0bf1b7eb7d 100644
--- a/drivers/block/drbd/Kconfig
+++ b/drivers/block/drbd/Kconfig
@@ -9,6 +9,7 @@ comment "DRBD disabled because PROC_FS or INET not selected"
 config BLK_DEV_DRBD
 	tristate "DRBD Distributed Replicated Block Device support"
 	depends on PROC_FS && INET
+	depends on BROKEN
 	select LRU_CACHE
 	select CRC32
 	help
-- 
2.56.0

