Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EC9175A79
	for <drbd-dev@lists.linux.dev>; Mon,  1 Jun 2026 14:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780323843; cv=none; b=JGNqTzJ+1bHisJtJSkVZo5iVPGe7bwgQCQ1lTwRehkcjPProt4pUKSz+ejSRv46kmJZaiA5IrY/TvgM+Pv0anzstKeF2f4mbNcECF5Wnu/Ik2o/ItA2EayNlcseLFJzW3gTbS8FLSaEZcCYpxxnyVS37gdYKDpA04ZE7VQq9y0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780323843; c=relaxed/simple;
	bh=0g0xJMtNhcpAdosnwfNc2YWqUDhkUGOExVCW00dGG0M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TKNs8m7HlN/53V/hlLA3ySC2U4kL4eOeA/DI3sYYZrZdfWM/TPLQv7qs0AAADniF1LVHei+yJd8sd8JeJ0+hJm9VtEUjZBjYht8WkEmtnsEWrkFItKuNU64J9rGuKyNtIpZc5vcgzcLhpjEYhjFHB4tU9CVaMpPLB9P0MriqgEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=yGUy9NLb; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="yGUy9NLb"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-43bf9548df4so4988361fac.0
        for <drbd-dev@lists.linux.dev>; Mon, 01 Jun 2026 07:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1780323841; x=1780928641; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2WwpNZUyFLop9PabhcETxrFKMUMk036YLF4I9B9pIOo=;
        b=yGUy9NLb+M5KeGkZjSB4SfDhEH7Kt+rf/eSCIVwklrIMiB+a7mugFR0w6waItYN4pG
         GlqXSB+zTFpVsg67R02CODFIYWKZWyfQJsjmuHpylMfWMZGsUhSqpF7WVC7eV5M+Fiyr
         86xKl8Ly6dlTvB7j9Aqlbnlv5Ca4QZx3VGRCr7czAmhaCs3SD7YFrGH6GsdL0U/NCUZ+
         m+KwiFZc9OM0q+Fhaq/J+yqGHeWubUH5tDaCIahlXtRXdXCwSjQnHuAdVrcKzHrR4Vt8
         wvtfZcDkWLVllOxbL7XbIQMlKYPmpfZmqCI08bTYWXL3bjlFuJtK/wpsotinFOF7HHx1
         H/UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780323841; x=1780928641;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2WwpNZUyFLop9PabhcETxrFKMUMk036YLF4I9B9pIOo=;
        b=Pnx6MYB3rD2zX1RkORbgY3o7iIJK1E+mjMtSlQCMFIYo2zAm+coh/DHsVrk5tcskFI
         i7Zpp7dGWk9l33O32mWNYiNMhEl4xds1QNOklqXA1C4xwfEZ/XHNpmJ26YAdzHO5K8cj
         MoHCa6xGGm5DeW1BJVn6HWZOpqFzOSA8sRJaeCYi+BKBvaEOXZg7MIYkWkNgwUu3+HCv
         gtnjUK69wxeXnydtyVIb/FOszNg4mxcte9f8iVadBQLpUgmc9O/iAsM+Qi+Nk1sjlXTT
         8Et8W5ciSdum352+9DDgGKbYJ08noQE61gGc8QfhJhjE+14vNXqibxH6gML7wxP+dB82
         jz3g==
X-Forwarded-Encrypted: i=1; AFNElJ+HWJdqAuq47eNofLhKQcLzIV09l3KXBsR/th3spU7EGWSQNh0InfBgwPK/oghU/cWsjqj7f/wpvw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzBQzUBmsHmnlneECHvRInr9YT8VLeEtIL0Rl0sJUpq3Wbz15pM
	pExlvU3cPsl9b0xQSJPnzbXH7tSdKpQWWRPemHYLWhc3AIlir2jsmr2SjOksC5xRkps=
X-Gm-Gg: Acq92OGQpKo0T7ZfXTEX/VrqPeJVVbA2zQSMIoWMWLSGkRVbB1yveRYuv5+stCZogHW
	zO9yAEVq/j3D5NBGOEJn7FoZC7kk8uzZFm1x+UrivsQyAxacuWIfrSoqSWl1F8EnaZ1WBJ4I1rU
	RwmX+8CfhslliTcCyutWq3JUK8Ui4dmhVLSamOepjEqOOa9cOZ5Jf7f4saF1Ovueq8EoIsuHCqx
	WQXx8eBBk2w7fp6ZNOvW0g5+4Boj7dyVl5jSqxhDgiC3581aKedNgTSZ6GdelTlbwA2h0904utw
	zOEM2ME3k3zvzwkKBUM12aigVq+7BfM2sx5Uzoj3cqepY+HEeiWnhILoXY671WNA5IvVrzYN+pP
	tFMdTLfG7F4rgzw4Eiyf6nhlixE1/zVTOMj7zVwY0X194oHHlJ0zUxvvab6W5S5nJXIV5rxaq85
	gUZgQzQi0ztq2ecfqPMRofXTJE0ku3jPabw3gsOjmoAWS6TQ2tVLAFdkStJ5SHnaKWhC4uUon/Y
	pyOSeLba1JP/B6Hdrwg0O0l
X-Received: by 2002:a05:6820:4c81:b0:67d:e7c3:3c6c with SMTP id 006d021491bc7-69e1043e95fmr5843170eaf.53.1780323841294;
        Mon, 01 Jun 2026 07:24:01 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43c93ae5342sm7818948fac.7.2026.06.01.07.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 07:24:00 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: =?utf-8?q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Cc: Philipp Reisner <philipp.reisner@linbit.com>, 
 Lars Ellenberg <lars@linbit.com>, drbd-dev@lists.linux.dev, 
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260513065557.36042-1-christoph.boehmwalder@linbit.com>
References: <20260513065557.36042-1-christoph.boehmwalder@linbit.com>
Subject: Re: [PATCH] MAINTAINERS: use new drbd-dev mailing list
Message-Id: <178032383948.395085.15762076029664187457.b4-ty@b4>
Date: Mon, 01 Jun 2026 08:23:59 -0600
Precedence: bulk
X-Mailing-List: drbd-dev@lists.linux.dev
List-Id: <drbd-dev.lists.linux.dev>
List-Subscribe: <mailto:drbd-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:drbd-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2


On Wed, 13 May 2026 08:55:57 +0200, Christoph Böhmwalder wrote:
> We are migrating from our own infrastructure to lists.linux.dev, so
> change the drbd-dev address to point to the new domain.

Applied, thanks!

[1/1] MAINTAINERS: use new drbd-dev mailing list
      commit: 9310b955c85ceb4700c7208baff2373a611a5070

Best regards,
-- 
Jens Axboe



