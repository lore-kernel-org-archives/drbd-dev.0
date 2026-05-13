Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC4A2848BA
	for <drbd-dev@lists.linux.dev>; Wed, 13 May 2026 13:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778680450; cv=none; b=cpqoi0ybDIw3PYXOde7MKUB0Y+epJA88/+Yzao8nGqxnxTWL1FxqhxGDnu9doB+g9wRFL5XBg6Hd1uPY5a1i4DQe4WSFBQ4veSSpbo/FZu8T0dKi/MPbh2+iZPaYdrCd2P4wzDUlMBiCFXtO9LAZyRZfZmJ6JJxJyhWWVJnly90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778680450; c=relaxed/simple;
	bh=VblI1AdyJkR5aKIEzu1iv+NjnkZBsAcb1LuT0EYm6A0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CDngNWF4rx6YP/HNUVB0ewwRSAiHOp5iLjXDuJjgHnat02Qhee2M31hWUGk3rSIvsmENsPXuvcOXxNeeA1LLMidMFDAAzbfkmopkRjuZWm6xgjWAor3riaVxQnNX3YkF5DFlqo1E7qZ0SumozuELT8qjHFkZYSRe1Xa6crsEmB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=0VlXXRqs; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="0VlXXRqs"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-47cbd444fd0so4333900b6e.2
        for <drbd-dev@lists.linux.dev>; Wed, 13 May 2026 06:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1778680447; x=1779285247; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E2FCDgUz+zxvMvODNC6gcP65BHRtM5wnyKHr7DJ3v+E=;
        b=0VlXXRqsnRsU9biYiNZv7DbgaI4nyOQs3UTn2kCIx2OrCYqsJDuWk9nPZc/chIdu9p
         WghUk/J4jEBHAQqtnwFQKS4xMGk6AhWyd/uho3YVXM5SRexWEYjRMI94qmh6ncfYoIn9
         pfJm2kdyELGcxYwU5Rudp2Gwr8QedglMw5DGOgxnke61L9P4wCOLB+9SykaiRrrzQ7mj
         mO3fUow2HbkQRh1zUIG6sAGeRyUXQ/3x5bBgCnHDb7NrJNyWa8JZlxHNLdDGVndUprID
         O4TAPG2jHTASCmEhYYYZtnEbobDzmLTpERngMMpq38DnXpCYXS4qaceSnUiosFUltY0x
         y+cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778680447; x=1779285247;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E2FCDgUz+zxvMvODNC6gcP65BHRtM5wnyKHr7DJ3v+E=;
        b=oWeJmezj6YzVlB3AGPyX/aq2hX13J62lm22QDMXm6e2uQLbEVtcN/4nLC4Hnaum6dt
         2kQa4HgX4gP0Dl7ZOW8ceOAUfkLAFRE+lfT7c+V9lWS8+N8RSoxn5KGW441tPy5L9H3W
         taPJrKQtmv759KXFXmVLmHUlNRwrQzsg7m08IjWOX8+qcQrBcMEaUgkEQU7bz0TfK4tY
         1kqE7AnEliBiUS6tRLCMorV2TRvnFxCMhsUBYuMBMB1/FQ7IQOzu2yYTQ2Ac6Cl3zje7
         /5lkiIzk1PQm4dcOsahgoLGcsQ7YFNUEfHUBLEOGwCy1k7/9jLvaOczVRmQgpzQq1X6z
         7NIA==
X-Gm-Message-State: AOJu0Yzevj9pj2DAF/1GJkFKE6JXZUhoyr6ZVWi/O/zKLVReo0KrjpCr
	X3iYV2H/6gYZufRo13C9GSRfBMe47q6gQKqfDqEaXM5O6vY9orsuHcbdSGPq9L2DW7Q=
X-Gm-Gg: Acq92OHVcTs13gmd2TecFxBeXFwsUauPxsYZ7Hd5LD5bcDWBSgCdv2KuiTZ62oCAWyW
	pnvh2m9rR1t031MeF429sfiU5FNSx205P3HL43SmnU5w+5nxLQX8xQx3r+mPM/uub+IwPEndQ+j
	vxX8xugWMj8kR0a5ch/xvJiySB7oyj6yuzvGBaScac0tCot/Vg2OvklVzG2h7cn88/ddQVmCihe
	YkmTk54goO2aYow+UVBlZ/T4ZES8U5L6nlByh3HKpezNm6tDtZTmlksXrE4lC38sIGJ1B1ssKSc
	iG4QZoUW8+MeEdb9XL1KZfUJZXbffU9CT9mcCeiZFpUjejQUhHeQ2eVWItZeJhX+LdXVfXyjWmC
	/Aa9lGgl1PxUcLLVGRxA8IHkfexbOoL+PvsFjNlqnieoxxVaFyD77OXzMZjLV2wS9dWR+NvCN3P
	KoOOaP2Ow8NLC2TsQpOepK3+EnEe5gEPrI2h8EohsBGryI0d9NdoEqZ9KRYsDt5nfA0zilMNjKF
	rYQ
X-Received: by 2002:a05:6808:e652:b0:467:e7b:6fd5 with SMTP id 5614622812f47-482b623a6aemr1425000b6e.41.1778680447575;
        Wed, 13 May 2026 06:54:07 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-47c76985f8fsm24532821b6e.14.2026.05.13.06.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 06:54:07 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: =?utf-8?q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Cc: drbd-dev@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Lars Ellenberg <lars.ellenberg@linbit.com>, 
 Philipp Reisner <philipp.reisner@linbit.com>, linux-block@vger.kernel.org, 
 kernel test robot <lkp@intel.com>
In-Reply-To: <20260513110343.3170338-1-christoph.boehmwalder@linbit.com>
References: <20260513110343.3170338-1-christoph.boehmwalder@linbit.com>
Subject: Re: [PATCH] drbd: clean up UAPI headers
Message-Id: <177868044624.398953.18340642491837775041.b4-ty@b4>
Date: Wed, 13 May 2026 07:54:06 -0600
Precedence: bulk
X-Mailing-List: drbd-dev@lists.linux.dev
List-Id: <drbd-dev.lists.linux.dev>
List-Subscribe: <mailto:drbd-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:drbd-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2


On Wed, 13 May 2026 13:03:42 +0200, Christoph Böhmwalder wrote:
> Commit b1798910fc7f ("drbd: move UAPI headers to include/uapi/linux/")
> broke compilation on targets without a hosted libc:
> 
>   ./usr/include/linux/drbd.h:18:10: fatal error: sys/types.h: No such
>   file or directory
> 
> The underlying issue is that there were some constructs left over in
> those headers that don't belong in uapi.
> 
> [...]

Applied, thanks!

[1/1] drbd: clean up UAPI headers
      commit: d5607f1fafd7eb72ed693b6a033d96221e870edd

Best regards,
-- 
Jens Axboe



