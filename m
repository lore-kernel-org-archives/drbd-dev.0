Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794328050;
	b=HJKhDHs5n0Fs3NZ7zoRpdp4BwS0YIunj6WFjCyPDVaBpQflGIMo6OOVfr4GlVY/lB/oY
	 twKoVpjUNg4jNumHlVY7cvR7+i9Bdzbv7WdPKAWg5fHZf2TaVn7fzIPrBYQCZIKeUzWO4
	 2KYYrEZxuMdUUf5LEz9g79t/sZ6o02QQ+KiArVEeV+DV9fhlsXo2lDR551js8U+jPd0N8
	 ZnawmkZ9QlqMHK7HbhhOu7CrOw9qWC7fqi0dg3djJ/pJjocf8NNGPRsrKYnAUmvVxcCef
	 BD4IQ3mDfaxAbzHH2bvgGrjKYcth4jws2fbYG4K+rxMIcNJcyunAtuzyyO+W5dx3zVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794328050;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=a1tYd398psi99x2zsisd/32A0Ti86/9u98Bkj+C2fdU=;
	b=jz5wxPcsWXWQIdTNcJb29KeAHuGIpIAKAT6mWidtv3vlgghQ1sW2FLL2UXREAEJwN7iF
	 +q7ySV0v8zFVzAyEWURckqn5OeJLrhE7MKe3wP1E1x1d+1VsKmCVfUDaDU6u0WA2w9Hb1
	 XmFtnCseO0vldWqFRxWpOvp31zPwSJdLZYiyUHsilR5RzZgGKJ2sis7lzzOhFRJm9sVXk
	 t0/An3hVKex63nXz0YQE0kgpdeTvMNro4t9ieHcn339XidtLfhG9tekb0DkCIE/g14ihJ
	 +gAkq4YtF59EZ6YAlHThUAHnfk1C20YFx6JE0sYUig3RVjOemjrmVPLMUmrEqay26IA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linbit.com;
	spf=pass smtp.mailfrom=linbit.com;
	dkim=pass header.d=linbit.com header.i=@linbit.com header.a=rsa-sha256 header.s=google header.b=KjU7C62d;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C603A606A23E
	for <drbd-dev@lists.linux.dev>; Tue, 10 Nov 2026 16:27:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C603A606A23E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit.com header.i=@linbit.com header.a=rsa-sha256 header.s=google header.b=KjU7C62d
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a1b07c3c5fso21821365e9.1
        for <drbd-dev@lists.linux.dev>; Tue, 10 Nov 2026 08:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit.com; s=google; t=1794328047; x=1794932847; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=a1tYd398psi99x2zsisd/32A0Ti86/9u98Bkj+C2fdU=;
        b=KjU7C62dJ/a7iCeorgPPN/B23cX0lZGstISdt47EoPTZePNyL9voVX+3I5yKOXYEEr
         VEJzH/ymLmdasQRyZp8zMf7cfqPQFBA3nbJJ6+n2ydmob7RtMoSFDG/X/ot9UzMyQsrT
         eRjLZYjftQpZ2lTXicRx766/qrb/WdFx3ejTH/m4/QZdPYVWyUfH5CowAUEGGkq25b5L
         63cqBini/43PybmduMGi9v2hSklrhiuoQL2VO4sICZ+wxsdLZdcwo8ZlPwkazKCqKl0j
         BaF0vjgivZKGWZiI/z5qUtX4YMXz//LxBdNg6n6SUdL8ygwh/4UYmoMUrKiErZUqHCWv
         u9SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794328047; x=1794932847;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a1tYd398psi99x2zsisd/32A0Ti86/9u98Bkj+C2fdU=;
        b=gEX2jT6QuKU+Zw+Ti8xWttTYaIvfImK0Uz7XEAQo687uODn0bVRtAoqgbSOqSmoiLJ
         mgBweG/FRzW08kbmJpeeaAxxWdMcr/jnh5oIERiOyEwouOeuc5I5HRz4VXsR2ySNpm8i
         z7RlfAWWHb7hBasPnNa8GGJC76NbsDn8CayKW0D0YC2W4CKovTTyPtyWq+ZOrURbS000
         5gPM7LP2GZ7jyXir29heaNV5RkG/2eqAT5VALyic3h4eYA5XPRf4kYlvQ0mQpLGpFrCR
         MEtJGFDSftOVziI3cyLhV1wW6Sy2xj1PBhsEcm18mPuF6zCqXXWailyGxqw+KLtTEr02
         Xcow==
X-Gm-Message-State: APuU4Z8y++K+CEezSQ91fmz74lJ7f3xkzNYY0YZOEnfW+qz7QpoQR0bu
	i8Ne5PKI8xHTpGV4sXMgwCORi/+rmihhPC7A3TV0BjYqr6yO6vN6E9YLLCJr+WeVwok=
X-Gm-Gg: AYBFou3JvesRSPl8q1A9Pxv0oP+5uv/ibM71sve1kYZMHss8SIZGQEqSLnMgM1jiN9k
	ZOkhm+fgoJMqpj/NbH3mkhTRi+upAusPaNZmMsWycw2KS7vBCdR9CMtUGETVvuuhX5v8qVzC5YU
	TMB0nLMUx6BefjmG6v13Ea1VVlAFlXZLB29tS4utzKwrnu/trbVJZeTCjt34Eij6HsM8+JgALhF
	olLa2rCh9NluhE0O9w3W71EWyQVGSdE6bobQJ3Eauv9RWfKELoqGG4BqsEAbLfDy6BYzfGiZhpa
	WS8hJyRZ7hXcHhjT9pxFsb/x2+gPWLu03VAB8t71DTTdB6WkTLr3LeJ2ZXVfJUbHGJcqlo5IFej
	aFphrPb8AP5MDx6jPnm+sa3A6WVHQHeFCSD1ba52BP0Vv1YHpt5CjyydN63z3sq8VMo5/6nt6pN
	VceRVT75PLCnRMOpjLpwz4v2wV0qTjRXmLlLBCw5erEBsTOaGtMI2rILVQ4L8FaKW5nFi6/32HS
	GHZxmNZdTsiZrknL7pufH1wQZ1mYiNqhLvjx2aWiJruKZWuYRYqfvBKqXgvztYR82u8XGmffJVH
	UDAR1mBRAMayiuLP0lshSTD+NJp/U/qwhE00Z2TOguPmkJKI0STwNTPOndAtqQm1yeMXURlj9w=
	=
X-Received: by 2002:a05:600c:3e85:b0:4a2:1655:87db with SMTP id 5b1f17b1804b1-4ba022c9b4bmr53849215e9.0.1794328047192;
        Tue, 10 Nov 2026 08:27:27 -0800 (PST)
Received: from linbit.com (h082218129081.host.wavenet.at. [82.218.129.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba02345d22sm85050695e9.1.2026.11.10.08.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 08:27:26 -0800 (PST)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: drbd-dev@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-block@vger.kernel.org,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Subject: [PATCH v3 20/20] drbd: remove BROKEN for DRBD
Date: Tue, 10 Nov 2026 17:26:45 +0100
Message-ID: <20261110162646.3028472-21-christoph.boehmwalder@linbit.com>
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
2.56.0

