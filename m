Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E8F2D8391
	for <drbd-dev@lists.linux.dev>; Sun, 16 Aug 2026 02:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786846003; cv=none; b=QxDRcsKNA9ENcnEaUHMhs0UL58gK5mWsHGFt//8qaxEhI9PUN7LLdNgj0fswvMZdSeoNejGKhq3fiaA+DYhBFGz7rgVBYsSYkqQZItJ1WMfvttPOGi0GKnuFae8sybkhkge4M6nPH5ME9MgU63mpgavhbUm/PnSe5r20Zrkfz8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786846003; c=relaxed/simple;
	bh=VnjjArI2TT9oxqUTNNsUpo1SvNdQAx/kesCODtC6Q48=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=EI1jYILWUfBSvYhhiZRQTJ5Jxh0BppKqZqQtiDgfc2MesLzXMt5VirZbVck5RPTpQZxDOCuG0C7qr8x4ADu0sqeSvFvXct5mtpRDyKhm4JegZxLleE5QsRLOAF95TO6kY8YECLClwxQenzDZgYZs+Z7OG+A6Vja3lZJhobG0fXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=uf0xiA0G; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="uf0xiA0G"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-6aaf2f9ce3dso1237358eaf.1
        for <drbd-dev@lists.linux.dev>; Sat, 15 Aug 2026 19:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1786846000; x=1787450800; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Qkr9Hc1lLYooEsPvZF2xGEZV9RQr0VpwZuTowoP/YPs=;
        b=uf0xiA0G0cvpwy7SDa6WHODXdsFBzKbvsmJGqKS6L6wYFGuIo3ZrYO9h6wmKT/+G6A
         mLK3Ft1EWSEj+M0lK9zBCDlNe+DO9xCPQCDMMVY7+dzfhJtuQuqYJyjtX3reQ0/rNrC+
         RqjohOf9DFy+8ZDyaGUnxASpNTG5Xphr3uK9L51yFhuAysFUQttpJCzwnw2IbvbZ6yDE
         EWi6ga4xPdo6rEgPa4tvUNrB9JdUvrGoPyywWBXuwJfa+MfSnCYlCBondqtpDh3jycKg
         N9mh7VZD9h2kzy4wqVQ+yZMI9/mYwqGvN4Vh3baDG0ucRFXWn/Cf6ef7ze0CZwS3JRXk
         GPNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786846000; x=1787450800;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qkr9Hc1lLYooEsPvZF2xGEZV9RQr0VpwZuTowoP/YPs=;
        b=DmKhAjis4e/1yg464zqQZi+lPaUAtcpCXWme75J01Aun4DSmokBVCwcGnSNbRAP/1F
         0q4CgQdinwIxGYEJ2ep3CfD/YhsxUGZhs+m2fn/g24r7CVQVj5MoPO0UaVRj507DJuI8
         vMO26pprRvKKPtiNYnlDldi7tGyDKLPlW8qWm0kH7CQL/dk+pXvFWAXN3IIPcQiaHcwg
         OhccThEjv/PmzRGsBjmJcosWeyNaCBb/1Qv/MgDriokXdUvJSHxZrhjyeXJziDz0bCPT
         gHgb5gOtpNAFYCqDQaR4me43Zdcy4mdRsiTKTB152ZPEJXUyEwH+kKbTjzo+043+0OBZ
         VghQ==
X-Gm-Message-State: AOJu0YxxQVXoOSLzSF3tXxAEWQlrmntr7cPebKVavD/awXD/qveMI2FE
	ToH+OIrVlfqJ0pXvkXfdYaGX3H2TsNmBnu5lXHZyi/ZExKOgV/yTOLXA2rVTSD2OhFLhaICnb6G
	NQzSBMkndsw==
X-Gm-Gg: AR+sD10hMPKOI6NO0DxQ6SRrNeeTL+VEZjnqJ939QKidVSP9qVaj6Hu0+H9b7wXPcnh
	hV+BUn7c5csLbFkrnCZ16jHOabgiejUmRX+niHZR8jpWB1B+wYQkR3n+n5Zdfniazy6ICLxN0H9
	T8dKAD2hp+p4ei0XHm0DMKoieV9tF2JiUfWbaXhzm3DBFcuDnAtITMYj0ytEN7zGtvz3i3QJ0Dl
	Oy4Xnwep8zlKsio14GX1yjBZA0CkF4nr1REgzJrig/EuAwa1v96TC0FU+lMWiOVUATu98H9ZY40
	Fz0QYr7CMflQlHeOsRlQzqExlINn0YCkLwyOE9kNlkHsOVQm/S+XS34zj4O8gmQXxVl2JVSpirm
	vsAhxA0Ix8m+M5/rwjh0Gsb9bllEnX+eSK0JbRdHbpjD+NMtaaXTo5Sum5+26oxZ2Q8fgA0H7yx
	ExGN2ORJYOjJ8XfooS8k33HCllEghiI17BqvNj397lSK/zjPteRhkCiRQKjncKFRLWr+Y0UlMPy
	rcOqkQS8d2cIZoWY7wLmqfyaef0W+8a485XqRTfdQ==
X-Received: by 2002:a05:6820:a289:10b0:6a1:80a7:2c8d with SMTP id 006d021491bc7-6b0d690c32fmr10463707eaf.32.1786846000629;
        Sat, 15 Aug 2026 19:06:40 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b0db1e9f89sm5686279eaf.9.2026.08.15.19.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 19:06:39 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: =?utf-8?q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Cc: drbd-dev@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Lars Ellenberg <lars.ellenberg@linbit.com>, 
 Philipp Reisner <philipp.reisner@linbit.com>, linux-block@vger.kernel.org, 
 Vivek Parikh <vivek.parikh@breachx.ai>
In-Reply-To: <20260814151617.73752-1-christoph.boehmwalder@linbit.com>
References: <20260814151617.73752-1-christoph.boehmwalder@linbit.com>
Subject: Re: [PATCH] drbd: don't leak the shared secret to unprivileged
 netlink dumps
Message-Id: <178684599913.2049660.4334999854490321092.b4-ty@b4>
Date: Sat, 15 Aug 2026 20:06:39 -0600
Precedence: bulk
X-Mailing-List: drbd-dev@lists.linux.dev
List-Id: <drbd-dev.lists.linux.dev>
List-Subscribe: <mailto:drbd-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:drbd-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2


On Fri, 14 Aug 2026 17:16:17 +0200, Christoph Böhmwalder wrote:
> The conversion to explicit netlink serialization dropped the
> exclude_sensitive parameter from net_conf_to_skb(), so each caller has
> to sanitize by hand. Two dump paths were missed:
> drbd_nl_get_connections_dumpit() and the volume-less connection branch
> of get_one_status(). Neither op carries GENL_ADMIN_PERM, so any
> unprivileged local user could read the CRAM-HMAC secret.
> 
> [...]

Applied, thanks!

[1/1] drbd: don't leak the shared secret to unprivileged netlink dumps
      commit: c71bf113dfdf426bdaf106636f573ef87b6613a0

Best regards,
-- 
Jens Axboe



