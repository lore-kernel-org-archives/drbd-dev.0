Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB54539790
	for <drbd-dev@lists.linux.dev>; Wed, 23 Sep 2026 14:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790172405; cv=none; b=UB4pEPNBzwBMcbQ2QsWWX7SFvpZJS8GiLvWW1kR95kW7NwqgSXmdq66DlyFhlfbgtnJQMjuH7j6c0yKyEiusvn2IeS25Yt6uNmhQ0dKUjYmP+p7UYzYkySo05Jmv5ybM7+UN5vxN8FAIdArbWdvpZ5uAXhkjP3xSsgt5XhUBbnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790172405; c=relaxed/simple;
	bh=7u/4OZ1/l/ZMeEzMXgKr3J6dGgbI5M81i34WvI+iInE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jvBm/+3sLeSuFVRXOOXPiKwewWceY4sJVy2gG1WssFPUuNx1Dz5zZFLFLyLSTIxWKGgng7dQU+ZjD+N8Iz4vdcW35lL6kRVd4jrHJB6vJsEGEroXpYLlbHIa3uoh+fDS+Kw4/5IUEntGvKLj2leerXzaBxZID0Zc1G2HxV+JyLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b=VuAKESi2; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b="VuAKESi2"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e6b885ef8so5246765e9.1
        for <drbd-dev@lists.linux.dev>; Wed, 23 Sep 2026 07:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20251104.gappssmtp.com; s=20251104; t=1790172401; x=1790777201; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aPV2CdE/Dht4I+/gbqIepOjn1d13cJdz8dQIBlNjv9g=;
        b=VuAKESi2h66Ubga15j7kpYRd5oQ2r2H4Kkk1uyfi44zOkz1HH94kdAndH56E0jUaFO
         BthIjgVVXHicUCA5t9MoY6Hvg9wM8JQ06vYx3Eitm2lmNSkB7OQqx/6qRllJkF8sCz5d
         c+j+IAy7VUAcrT4Hn2o/+J0MhFEYckEJi67luT47KjmvLLn6P5bbylF3TpZuhpajMRXp
         9enA3Jz0lMOT4qgE8pJd1SsaMv04QihReTJoicw8KgXCJUudp5F+6MfXGjMlTXfobpKr
         Q0Jc8XXsO3Bz51C5x/FvrvrqzQ82hxbroRB9YX2sD3rM9aPwN6FaFdkHRH1wlpT8i1Xp
         3qng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790172401; x=1790777201;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aPV2CdE/Dht4I+/gbqIepOjn1d13cJdz8dQIBlNjv9g=;
        b=joMNpfibbiiLPNtCTZ4uAGXhwEL55A0qT30h2d3E0MCY/cEXsEHgvCSa3tT2Ey+Vh6
         mwdsW24Fm9aCXqApnb+t6F14nzN8+nkeUp5PAN+ZA7iXmM99gC0g29XELZu/+2HfPh7t
         SJklQ2eIVJwXnChhsJxGWVx1jaTqYIM4FDiSCZf2ZRcPaWqcMcAEd/c2ZcG+jm50evSO
         EVFoyb0jEQ898c4p9fe4OrOdqGVChalhU9/MwSNX5zVYucSjN+zzYdmiIEdO9OlbLmm1
         BdiVQq3q7bZLQSzgUtpuOxQxRZ1ilkByYFzgVTnK99KyLrPT0Av4QGsNZb8pRavylscl
         Kgcg==
X-Forwarded-Encrypted: i=1; AKwUvByvJH6Y2hkn9+4sdiFcinzX/JEyOwA/YzHMct31b5Fw7zv+L1D0anNwulXg8GQtTdQ/nqiLlviWrA==@lists.linux.dev
X-Gm-Message-State: AFuF++lETRukcya5Y6ErZ+xef01/Kkr4g4XzoFaffGAN01vbYveD2S6H
	qPMb3l3+HsZWUVBn8fFhqvBfRcCbu11Tg5sdVB8+OHDwwrIEj5UAh0kwtezPY918gUY=
X-Gm-Gg: AYBFou1iERukypGDwXnShiamkkCfgSlPYzfmsehcCo07DbrNCSVPwD3GMig2VixGHZt
	NLTU35/IKzdIIdPfZqX1nDCnNhb8vOV9UX5QCL2lDOSXyqeT/FUzjjqZMfZhm6bdHccujFlraf9
	NKg0uQGIXzLTiI1ZPxRaiiItzonK+mFyzMr0gTGxP3V3QmYwaFZY4mYgZeNgh8iGsfIriVi0FYd
	ypzwt3tKX/7lfW7xRGBwzHv1g6Pekxqs0v3CTwPhUAQ928Ojb2haI04HPQtuEWTlGlDK8Ri+awF
	goIiolJW3mM63VXVxmGlKZ9MmmnJN93aa7z75uEf66g85xIE1Ja/vFXdu0O+EgBKbe/aeGuHMM8
	cS/ij+45IHJJ3d/fQ/gThX6KLjdZHFevXYdm5EYuQxIFO4BPJOR73ADrR7bmsy2h7RBrBIRt79H
	8a9uemJQfsLljRIxwmCwTpkhjXufCIHkwfky4SblmKkva92Vw7xDivoNiqpQtW6QPp61AiWEm+9
	1nBvOCg+2178e7LCfN9JchU3e5vgp9ztg3OaTSjAw==
X-Received: by 2002:a05:600c:35c5:b0:49e:7d69:83b7 with SMTP id 5b1f17b1804b1-49fdeffff85mr48917285e9.13.1790172401441;
        Wed, 23 Sep 2026 07:06:41 -0700 (PDT)
Received: from localhost.localdomain ([2001:4bc9:b01f:2334:39d8:9506:1776:f780])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fde18a8a0sm78087455e9.5.2026.09.23.07.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 07:06:40 -0700 (PDT)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars@linbit.com>,
	drbd-dev@lists.linux.dev,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>
Subject: [PATCH 3/7] drbd: raise the socket buffer size limits to 128 MiB
Date: Wed, 23 Sep 2026 16:06:04 +0200
Message-ID: <20260923140608.1116713-4-christoph.boehmwalder@linbit.com>
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

sndbuf-size and rcvbuf-size are capped at 10 MiB, with a comment that a
larger TCP buffer is not useful. That was written for the networks of
2008. On today's long-haul 25G+ links the bandwidth-delay product of a
single DRBD connection easily exceeds 10 MiB, and the cap then limits
replication throughput regardless of how the rest of the stack is tuned.

Raise both limits to 128 MiB, the value DRBD 9 has used for years. The
defaults are unchanged: 0 keeps the kernel's auto-tuning.

Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 include/uapi/linux/drbd_limits.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/drbd_limits.h b/include/uapi/linux/drbd_limits.h
index 65d3ebf2437b..4132b619376c 100644
--- a/include/uapi/linux/drbd_limits.h
+++ b/include/uapi/linux/drbd_limits.h
@@ -87,14 +87,13 @@
 #define DRBD_MAX_EPOCH_SIZE_DEF 2048U
 #define DRBD_MAX_EPOCH_SIZE_SCALE '1'
 
-  /* I don't think that a tcp send buffer of more than 10M is useful */
 #define DRBD_SNDBUF_SIZE_MIN  0U
-#define DRBD_SNDBUF_SIZE_MAX  (10U<<20)
+#define DRBD_SNDBUF_SIZE_MAX  (128U << 20)
 #define DRBD_SNDBUF_SIZE_DEF  0U
 #define DRBD_SNDBUF_SIZE_SCALE '1'
 
 #define DRBD_RCVBUF_SIZE_MIN  0U
-#define DRBD_RCVBUF_SIZE_MAX  (10U<<20)
+#define DRBD_RCVBUF_SIZE_MAX  (128U << 20)
 #define DRBD_RCVBUF_SIZE_DEF  0U
 #define DRBD_RCVBUF_SIZE_SCALE '1'
 
-- 
2.55.0

