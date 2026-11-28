Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795834784;
	b=Z3x6E1w/zjHWBYtE/5MTlFH8jpQQ2GNENgu6nP87e+Y0Qci4ob+yUMtLIiXDEO6wEauB
	 58PiI5ICumDkxtDs5YNvYenO0zgGjeSwQMFPwRoWhhXsFnfXJ+ndVfbQYZPnIzW1/6VRh
	 2oHlScBgvPrRLawpE+bxtHaLDrAP9sJICR0vsZSyXq1+wWs+aTZ4XLNPGZCWyoPO442Gk
	 Ph0/DNdDtuR8sNFuQ6jx+Kf7CL9fb1W8KApD7qq6UfGHHSK/X2zzIozQfYwr3QtUDCJJD
	 A/Y2HpM7QkCUMV8d91EFXCGb+CKOKTBXXb3dwZ/x593l4rdj9FahHWiRFR6oqGUaINQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795834784;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=B3XjVPGi1d0sqXZUZmpjBaglDj36IEF4UV/CSJOQiR8=;
	b=qgUyvukmDQGR0z1No2McauMqWn+76B8SnR+aMEp4FwEfK88na7DoEXuOEkeejrRyRmD0
	 Bo3vYEAKNX/IykoV3nygjEQAWy0iAp856Nu9R7xK77u6eZmXgHJuw9p2CFfqVe37z3nKi
	 +KZ0koxltI4o3PVnD7vt4OFzNT1JsideXYB7WbpgafwU2NAH2RGCm2W+ExSQtCZ+D/q1p
	 5mLv3TlTnwRXG2z2ESnk6ekeTduxKe0PvIpgiQRkfb0v7s1QpCb6ihhqaCGwtIaIpymEs
	 9A58+KvmZQ/hvDcyUKo8YvRQhVWie8A0l27di0XUk5ZXIzbZ07TWtXWnrms2JrkUaXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=WMH79XCl;
	arc=none smtp.remote-ip=209.85.214.175
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9C5606A31F
	for <drbd-dev@lists.linux.dev>; Sat, 28 Nov 2026 02:59:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F9C5606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=WMH79XCl
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2efe591a1f6so28490655ad.2
        for <drbd-dev@lists.linux.dev>; Fri, 27 Nov 2026 18:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel.dk; s=google; t=1795834783; x=1796439583; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B3XjVPGi1d0sqXZUZmpjBaglDj36IEF4UV/CSJOQiR8=;
        b=WMH79XClQWb+hbjXyF4K8z9VaKe6JIvuaHt1rtHzBBs3uM+SZVoypJkTMCa5BQ2cWa
         GiYLjivujtKuKcNUC7ECGLXMKqenEMAX+Bo47aj5hsdC4VgiyULIeIBaFhSA8V6UvFs3
         hDJ8hh7R1gZqT67nLaDl8MV28wSM7gDLBnGZGd980BMHVL9AdOBLZt+LF+ENW1hFF8oP
         ngcQ82cr/K1z1Hu9mkPB99+eI9Sq+lFBvpfqHl1fj6+1jtO5W2mNOchxQUCeobnzkvtH
         Eh/Y43YbG/0RTFwQqdDuHcfq8SLyeK7B0plm9MWwv7/awlGCbyh+WU0Z+XPQ1jggMPx0
         c80A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795834783; x=1796439583;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B3XjVPGi1d0sqXZUZmpjBaglDj36IEF4UV/CSJOQiR8=;
        b=uB+D3PTdo4gf64WUZ/6stloJ8OTJ0HaFCsnIDr5CSKq3WQDfmoIuGuRCSzHbcxuxTl
         5litShRozq7L7eYMIuA5D5FxOPP3H4iFnyk1q5ovut+sERGO9UvZdK1WAa4qckIFXuQW
         OehNPgkk0rnCJdeKdlmDwOXd3P6j/SIFa7tr0GCb60obD2vyZ5wtLm9exBw918gG5cXv
         E5EbqRhCK3yRhCA/NV9I5EZhxd8YgInn8GtYA1Aw0VQOWHpzIHuFxzM9WCP6gJ7qiDUl
         fQqMMOK2UG0X47maI6kfHeiZc58hkG7IGaSHK6Ci7CEJkCATebSnFcwWC59rt8fShy5i
         FzYA==
X-Forwarded-Encrypted: i=1; AL+hErFX2XfKxAGJO0wv5wNOXBo6TBgrWTtASI+Xrz8VmKj4+mkBZVJ24ZXYA1HnOSQZL3roIw5UQCkZ5Q==@lists.linux.dev
X-Gm-Message-State: APuU4Z+vw3XZwIk1ni8b1xNqJZxjV0oBro7ZMTQ5LsMKH7l4ChLDpsHX
	ZGk22jpJz/uNiAnkX/4UldNPuo0dGJJV6D/oib0K8gl20b31MdR36T7CJgqqwJ/bWug=
X-Gm-Gg: AZFdTZfxZwJhUwoAzpdcxRoyUVvA5sewwKqQOtsKkBO1GmU/fa2xNyh+6SrVqs0StU0
	suz84n3sSCCHueZqxSLTmSaXKJEmMMtlCNMV8Pcgen8f1f3fniwRhbghUtkNGFAR1rJq3ZnPqyo
	weIi6rZYTEZixb89SyLPKvtmxg5ou558u54pv3sqqd0C/RSRxMfIosDANALH6q58n1znhFYHpSM
	AiB2SI8uvXj+EsM8s+iuIc2Z2m+30+YUgW9t1yx9HO1yx4b//vJxNBzFUnmxSyHrQ2dySyYN9To
	Di29133ar82ydpTo2rcZbWPl4EL9CEaUahJyqPhtAf/uJnSBn0FD6dp32HjbzN3QmEWN4ekUKiM
	dyOg1qCNTSTuX6hydRyoCt625ZAV8GX0Bx1//NicrC8CQikkdbLhTwX5l7mnpNdfUqz/Is6PjE8
	iiYl6ngH0ze/B6qISLlyWNzQdAFHsEfijAEIKRxguq4HD+MBoD4zJE+hqiKHeb+RVDNcz6AYWdi
	8VOXxbGAY5+R92q64EBFjbHcn9zDQ3IUMV0U+DxX5+cXm9IgTVy+D6EX/wDfuLoTE/lB7VIiQIv
	KWJsgUTSxrAO2tr8ZUp3Vo+3dmUm/FqdGLc1ntT3YdnkkPhVzeJ9oiH25SaT4EL+vxVU2O/xbRp
	CL71lWZ/Ao7bsU+cNw2dXWv/NB/W08TaLLCMYkD4vvoFbar/K7RbDb9LpMZNlYvsUXzcF5Q==
X-Received: by 2002:a17:903:1c9:b0:2ef:fcd8:df75 with SMTP id d9443c01a7336-2f03f18847fmr296857175ad.36.1795834782691;
        Fri, 27 Nov 2026 18:59:42 -0800 (PST)
Received: from [192.168.1.142] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f0d537a522sm57771515ad.47.2026.11.27.18.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 18:59:42 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: =?utf-8?q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Cc: Philipp Reisner <philipp.reisner@linbit.com>, 
 Lars Ellenberg <lars.ellenberg@linbit.com>, drbd-dev@lists.linux.dev, 
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261126145257.592085-1-christoph.boehmwalder@linbit.com>
References: <20261126145257.592085-1-christoph.boehmwalder@linbit.com>
Subject: Re: [PATCH 0/4] drbd: assorted fixes for discard limits, bitmap IO
 and resize
Message-Id: <179583478160.90611.15435460552982220308.b4-ty@b4>
Date: Fri, 27 Nov 2026 19:59:41 -0700
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


On Thu, 26 Nov 2026 15:52:53 +0100, Christoph Böhmwalder wrote:
> a few DRBD fixes for for-7.5/block:
> 
> - Assume a capable peer for the discard limit before the first handshake,
>   so devices stacked on top of DRBD don't latch the 4 MiB limit.
> - Fix a lost bitmap-work wakeup on weakly ordered CPUs (seen on aarch64)
>   that froze application IO until the connection timed out.
> - Two resize fixes: don't silently truncate the device after rejecting a
>   too small peer, and refuse implicit shrinks on resize unless an explicit
>   size is given.
> 
> [...]

Applied, thanks!

[1/4] drbd: assume a capable peer for the discard limit before the handshake
      commit: 69fdea8a039d6078609e0aaa7efafed4b34c7251
[2/4] drbd: fix lost bitmap-work wakeup on weakly ordered CPUs
      commit: f2d3c2a06548aed8def25c16e772ace4774a3896
[3/4] drbd: resize: do not silently "truncate" the effective size
      commit: cc547179b6fdb93dac3cb8813b57460cdecef9e2
[4/4] drbd: refuse to shrink on resize unless an explicit size is requested
      commit: 86226accf58873f70163e34820423ced87a8d980

Best regards,
-- 
Jens Axboe



