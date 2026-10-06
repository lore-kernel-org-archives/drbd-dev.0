Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E0A30216D
	for <drbd-dev@lists.linux.dev>; Tue,  6 Oct 2026 15:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791301582; cv=none; b=Nt1T6ffiafCez9nHlY66vCE9hN3RQuULPrVvBzDHBIjw7kCH4BOTGCO4nKZSlVu7aaGJuv2qbER/+aH1pL9S2x7VTKsRVhMRB5O9AAxAOMfTbZMuyLkwnM2WzstuXKnyzTmlVVAMlkLRQrpb4SZZEVyhcB/PYYIL+5ZYrztoGjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791301582; c=relaxed/simple;
	bh=YgsqpuTm8PyDbe2cZPeEOP7o9Ffmmp1AP1QWnfnma8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YKmdTLIA27G5wYzcmAmIdXXP+d799h/6laPtd/GaSbKk+lD4cPzYZU8wNBGmEIXPqsjHyHxilgZaxoGVghgQzktJubqJxFBafPRK8TFFv8r19qbCOigYubEjVQjz951xb7xhvLksNogGh5vWymOFs5KLFWV4CZ1IY4QPQC3rF6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit.com header.i=@linbit.com header.b=KRwNFC3m; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit.com header.i=@linbit.com header.b="KRwNFC3m"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a16aaf2067so34846955e9.0
        for <drbd-dev@lists.linux.dev>; Tue, 06 Oct 2026 08:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit.com; s=google; t=1791301579; x=1791906379; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=E7QbmXfomxVLV2gtFMANYlR3HCma/SUKYm1KNeV0yn8=;
        b=KRwNFC3myD6AFjo/Jeg3rj3zcZYg1JQzgx0t8kC0h+AGWALsmLNOMOrDPIsshjYJBX
         7+WSCzv255Bx7Ukvpn+RkMEj11VuqP8RW/69wpCT/fjos+RafCmm0wDnMrVA9ZqBa0C3
         7BVQZcIDY+6TGZmVKmWJBDEBCRwvUksraJzCp1gY0vh59dipPIAHdHnW4CVWjo0oVOz4
         pDVHQVn3OFrytVFp8FC1Bp2pvUCi8nAioADhkEkH3weTlLLuwJa8M/PZ7HDiDObI3ZGF
         xk7pGBkW2hyAzoIF1EzTi0eLX70ov1xB642FSuX9ybzInyW/1YoZdVhcMZ2CqwAGVIFp
         7PoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791301579; x=1791906379;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E7QbmXfomxVLV2gtFMANYlR3HCma/SUKYm1KNeV0yn8=;
        b=MIjvFr/hK4PaFcxPK+MH06dHNKEqMKwPbNN4Ahls80F0rpUwDt4LqXJsBDrXFuUkoK
         xQWciVi9J14l/46oOIypO07LTS8oKjPcF/ekgQFFBV/16r0obAomt4iyLxEW5KsbWDeu
         SOp86LWqiPLyainsXx0WBPN43I+o5aprbn/NlOBB1wEEssLjUMt9KTY/PkVlBc0Ui0pA
         qo8JpaL4yIPnD/X0TrDiVmNJdcFT6PxU+3UlBr11m8i27fuTIkh/ECOQgjffx8+IIfto
         DOIVdULa6qjbbgHgEwEz/or+kvwayeYbhfFpndEulUse26RovpE7bA4J5B/RAV7GSY4K
         xdXQ==
X-Forwarded-Encrypted: i=1; AKwUvByU8xxlG/KLCoKWUu+X0qEzHrv1YIcVqRsiQgPsg2d4Lac+GEOtRopV8ByVZcDX50z7jJN0APzgAA==@lists.linux.dev
X-Gm-Message-State: AFuF++l3yJJp12hS8yFNXQZ9AWtL6ctXwScgU7OgAiaxN958fQVVTWmL
	y08jBfWk1NvpqYWabECv6HferJoP8lpsr+RITUcotWLMD966ckUGYFbxl6zvOlEk7r8=
X-Gm-Gg: AYBFou3JGqmyV+obk2B8bp6FSuRbZikvn34jjfR0qXy/2jONPdWiF6lNvZ/xt35wtbL
	DSHUhM1AzkySDk+Vupc0zJ4SaT4N0QhZVrKvSEDIMaUYW6yKwqgVuXTDWcADmho1OVs3z8M3DwN
	wYQFmc4LtC/qsDsXRT9jbdLUqY4Aoxq6BylZxoRIMIFQU13cMReTX3vRF23jN70Hy+z7W3wmq+x
	jNIG/N8UhAa8lkZFGccyGGn/abJlzNvJxf7AYFWJk8olE17GKUU+Vr7QbO/isXcHjGmPRb6rVIy
	nSq9oqwdgTQrJoGXCnuRmqY9ham7/csG40VhBST7QmbXoKonVondvUoDWVHLSpG0lWbkzi1B54w
	u16KNcY7XZuHgSq+0O/qivjtp7cqI+0QeXJHgvYNO93TujZLtFWdIzsbSEwUMR39rQcdE3fF6RP
	4aEb6DOUh1Lun2IUgUVg4DRxqtLwSvOaLNJxcZKjGsp76uw44eFs6MiI66KxebVWngh1awB1t8g
	y6NRFPWlncE/XXRZM1obkmLgc6tFgOr
X-Received: by 2002:a05:600c:4f92:b0:4a1:6f41:9102 with SMTP id 5b1f17b1804b1-4a16f41937dmr138539205e9.9.1791301578649;
        Tue, 06 Oct 2026 08:46:18 -0700 (PDT)
Received: from localhost.localdomain ([2001:4bc9:b00f:d376:7c33:9a50:ef33:f391])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a178c5b9d6sm72087205e9.13.2026.10.06.08.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 08:46:17 -0700 (PDT)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars@linbit.com>,
	drbd-dev@lists.linux.dev,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Subject: [PATCH v2 01/20] drbd: mark as BROKEN during DRBD 9 rework
Date: Tue,  6 Oct 2026 17:45:48 +0200
Message-ID: <20261006154607.3936501-2-christoph.boehmwalder@linbit.com>
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
2.55.0

