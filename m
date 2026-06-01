Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF351DB13A
	for <drbd-dev@lists.linux.dev>; Mon,  1 Jun 2026 08:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780300966; cv=none; b=VR8oPpAzYQ09A4NneLs04uR+Q/Q2An6gj64nqt68GnLaXYJwPD56fHQYWh2ZaXpAmLSpR8ssIVSxpoCrfOqLa3Xz0PsY0LirDfcZBk93EiyH9yKO9NfOGPgWw3Gl7h/iYl6ydr+F5pQbkeNgh4cTXw3ioFynkDQdrHKEaGz5qG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780300966; c=relaxed/simple;
	bh=AgD+BzwxhQRkx6OqAI3ZzibLKjyCAVWY50FPyoOIYh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HEVuRNCGzYjUOUz3BlLpECFwXMk/bliHqYUWEboQh+/iXzHtVh1TcfzZYWg5oL8eOhbIwqejOFLylidtRhF3080ZerIHOq0W9Y8WgCbikMSL9yJdt1oTAoN31yxANEIIMLv/X98hh100j03VSULDdkVEWOH0vM1lmow0mR/nv9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b=LDPxDaQB; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b="LDPxDaQB"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-45efa80e0afso1169631f8f.2
        for <drbd-dev@lists.linux.dev>; Mon, 01 Jun 2026 01:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20251104.gappssmtp.com; s=20251104; t=1780300963; x=1780905763; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bhYB9HvL0n+VB2gN+GfbC+Zc+n1I631BCVDzgaKbOyU=;
        b=LDPxDaQBVraZgj49/61u/dkmHXkPs0SI29n3qfpuMWCY0+nXFM4ukkyLxNrkf4bywu
         Pt8Vk4nZ/Ei1LmgUxijyyZi67DEtJYatsPdUW5Z4s0iJWC/Y9yl32MfruP2I7fVNjSBY
         sDTITJ/cxcJgjIBl8LOB5+IsSUWTY+b6uOpP749OASaXH+y2ssGIa99dM23Esy2IavVS
         Vg4O7sPrukDXrQigGLPdILsWj245DXZRTTJq3G36aseoi9mfYMqZ0L2e3fovl2OKGbDI
         8aR73N8pU+Dl1xzRKreo3lWDGLUemN/VF28oZW0I7CMe4igWdHZw64pxvG5WMTl1hzq3
         hDlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780300963; x=1780905763;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bhYB9HvL0n+VB2gN+GfbC+Zc+n1I631BCVDzgaKbOyU=;
        b=k3drmNwGEPIkBAON15hDjg0ZoYO9mzol57TZCpsaEgDn0xAqsg83BLNFUAyOo5X/y8
         v1cqwH7RUvlXWgQjW0D7HJfanCONveoQSmO1Ngsml9nNApTgXNlSNbye94p4EEtR9Qi4
         XyjC7lMc8M6mM7/IGVCfqyt1R83ECjIcrtHUbBRCjFTXdF7/e/OBkkv3kpmFargqebjC
         4H2dWWH8iBZOEbsldmuG3Hp0H8iH48PF2uYlUwaKKQ1f7xCQZApQJG5jtzZjJEtCldT8
         vdESDDpcm7sdOUoWzGZFhQzXfgLhzJwAKr3/DjSARSr6JkeoftpWMDDwPA5065dITLAj
         dWaw==
X-Forwarded-Encrypted: i=1; AFNElJ+52+Z+FeMhZ+eOfytnEuls+w0pa59doz/geLYplUGuQNISIjoQ757jTUEcfoZwae/MP3LmiBJckQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx3/HweNtnFKGTO8np9i2zfeuah3lxTrT1b/Zo8Oy8SC3t5c2qi
	NC1ztsHx57c3kXnJBMulgbqBP5MxpiP/mDV+nMbAkTrmMaONbpafIWJg7n4ZhilIm6gm797GFO2
	4cJRc
X-Gm-Gg: Acq92OFRZnwExDub+l2JTEGrulzE26FwiGonFBFrINeNBsH+NogFhlBS4jWPUlUQ1zA
	4MsgcshoUbRxt89f9ubyQfycBd8VU0aJulWa/Km7iXN0Ebc6nniWgTi4jJksqeFsaGlEDnx3u45
	QhOsvALci70Plz2i820K/PLutB0Dh2ExQgUKquTtS6aUJlYAeFqd7cNBgGTcRvL36NLlfd+Du5m
	Ko9/EK7Ht32TTRmrnmR+u2qXY1QqfiBWWWQRVqHeS/pGGN6djIo3CQDQ6/OYgT+Sgmo1rLDfgSH
	EIhiptNfvRM8L0GEKJ3HLRLdPhEJN2RrM/ZVR7+C84T5XdSPiLrVpkul4b3o5iHuTEwanWtHHl3
	vYgTKIAT9508nsbKPjCcZhqt5738xUgIJHK6fItQXABIFJZPyWGZVQmWdxHJqTyn8BX45IyerRq
	j3oHu4vp29dQcijndjpkJYlv3BuNmgCLHwQrRfZ9UgK5IAwofZHraHuVi7FuUO/lmIs4U85xjCt
	jUu1g==
X-Received: by 2002:a5d:5f4e:0:b0:460:42c:1133 with SMTP id ffacd0b85a97d-460042c121cmr10149587f8f.14.1780300962972;
        Mon, 01 Jun 2026 01:02:42 -0700 (PDT)
Received: from localhost (h082218129081.host.wavenet.at. [82.218.129.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef34b7d6bsm24631881f8f.10.2026.06.01.01.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 01:02:42 -0700 (PDT)
Date: Mon, 1 Jun 2026 10:02:41 +0200
From: Christoph =?utf-8?Q?B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Philipp Reisner <philipp.reisner@linbit.com>, 
	Lars Ellenberg <lars@linbit.com>, drbd-dev@lists.linux.dev, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: use new drbd-dev mailing list
Message-ID: <ah07tGQ4Fz8CXy9D@localhost.localdomain>
Mail-Followup-To: Jens Axboe <axboe@kernel.dk>, 
	Philipp Reisner <philipp.reisner@linbit.com>, Lars Ellenberg <lars@linbit.com>, drbd-dev@lists.linux.dev, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260513065557.36042-1-christoph.boehmwalder@linbit.com>
Precedence: bulk
X-Mailing-List: drbd-dev@lists.linux.dev
List-Id: <drbd-dev.lists.linux.dev>
List-Subscribe: <mailto:drbd-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:drbd-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260513065557.36042-1-christoph.boehmwalder@linbit.com>

On Wed, May 13, 2026 at 08:55:57AM +0200, Christoph Böhmwalder wrote:
>We are migrating from our own infrastructure to lists.linux.dev, so
>change the drbd-dev address to point to the new domain.
>
>Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
>---
> MAINTAINERS | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/MAINTAINERS b/MAINTAINERS
>index 4abb3345bc4e..b8db0c038c55 100644
>--- a/MAINTAINERS
>+++ b/MAINTAINERS
>@@ -7773,7 +7773,7 @@ DRBD DRIVER
> M:	Philipp Reisner <philipp.reisner@linbit.com>
> M:	Lars Ellenberg <lars.ellenberg@linbit.com>
> M:	Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
>-L:	drbd-dev@lists.linbit.com
>+L:	drbd-dev@lists.linux.dev
> S:	Supported
> W:	http://www.drbd.org
> T:	git git://git.linbit.com/linux-drbd.git
>
>base-commit: 36446de0c30c62b9d89502fd36c4904996d86ecd
>-- 
>2.53.0

Ping. @Jens is there anything still missing before this can be applied?

Thanks,
Christoph
