Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795689437;
	b=Dh9YEsORk5apCwccxmzbp3HJKCohoGoa4BxjgwkTAS0KjJU9pXP6Vo0s2qBeJsc0HZQa
	 C1IuEso6IYYG26M7JOA+G9WKeG+50UKtpqG5fAvFqje8NTZwuISJ/rcC3QDVvDaQ346+Z
	 IFI5bmQcGEkeObb/Lo80126cI1xnccTplPEEUXdNzOi6RDz0NdqQyucTJ6x1ml0uD2E7p
	 rUM5cdCkg0bYTR28kuxBsub4K146hEtphgxPrYdLj3++r1yw5r3z42r+LMb7XGe1TCQX/
	 Vk5C2muTg5Bp4MHiWTZiZwQddV/qo7yHtQ5mxyhgj8n6nl+Rzgy5Mwl5aMo02zWp4nQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795689437;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=vg2X34kB5/98PUVik8tEk6SE6yZcxeD5sJ4RavHE/0Y=;
	b=bi09SGSEbqTmYQIN0FxpiB4Uh3v4F1y3JztYz78ZNHmIN5kgTmpWdZsZBAHK/2TNZS4A
	 UWGbAvaad2G2MJURkBhjFb3jdngyqRL81YiUFAjkgkS76dMcdIJsyr7fzxT5TfEMBMuEN
	 ARPzVf+CR/e1KDvvj0f1IM9xKyXysLGuoIDbvf726Lbv9hB2zTVUqxuXzTOkHBRM1i7U7
	 WC3QaVNJpEefhVe1tDdx+2wK9Ub/I1ytBiKEuKT1Y35mSIjqOnx3bPgdt4HDQhyIgy8TT
	 T7yjTUXvU2LIvPmN7jLJb2xVJp6vVSLi4P9O6f0ZUUzNXt0icmyFzP5mYwqsBVhzY+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RFEH5NIW;
	arc=none smtp.remote-ip=209.85.216.42
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582F5606A321
	for <drbd-dev@lists.linux.dev>; Thu, 26 Nov 2026 10:37:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 582F5606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RFEH5NIW
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3b3e85baf7cso4139522a91.0
        for <drbd-dev@lists.linux.dev>; Thu, 26 Nov 2026 02:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795689436; x=1796294236; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vg2X34kB5/98PUVik8tEk6SE6yZcxeD5sJ4RavHE/0Y=;
        b=RFEH5NIWa3gARJaWUeXizgi+giOsLJnbFGtpNg6D2BONLGg7DCu3wyxChnIx4EvRXA
         pmtIeEtxX2aBpU+7LOBWtlJYAa5OQlupxoGGFOLjXHkM3QyC7adwEZJxXnOemPloQSr5
         GycIayBrr8K6BsKVmSRrdYlDygciJxp0/kT+U8US2hphumIhT/iA9QLkzInXFkm6fAo8
         9UpEVGUjUvtNk5EMvWL79ZfOvwrp0RdDhu2RpPqI790yCKkTKQNZ0kU54eyELskOckVz
         q6HHuD43jWrgSHGPWC5Fz0CNtW6QY/dPEOai6TXNsVp3icmBJ037eoE/z2CY8qAR8yIQ
         d+3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795689436; x=1796294236;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=vg2X34kB5/98PUVik8tEk6SE6yZcxeD5sJ4RavHE/0Y=;
        b=rfrEZM8BkXpbL03yQvir8VAOh+/OHiXpi1iY3lSYwAzuvRzoOsjl7hKwGooZWOkKHw
         v0k6EHGXEVam49hfdxpxnnRPS1ibgSrhznQOofVN1jei17iYqCGnZe4/ROxtI1UV7hrg
         Tb3i7TR7ankbcjbQnmZvrbIzYDBegMtT/iZl8F467HWzhffOSscHY6PvY9uMmKzh3l+8
         F+QjQAd3kgOoK5G00/5uIQl/aGS2Q8txmBrKt1SHXOE+qLL/oMKniiaN3039/3x72cyH
         nBI1K1PZruKv3FZREODyw5EP2O8wavZnR97CEUFVN+GIFcHPSa7dM6Dcb06joJqZZ9d+
         w70A==
X-Gm-Message-State: APuU4Z91yOwJqd+0TSa/1VVIvQvSHBvQ3jfsP0jSjFS60+vEhWsk8U5x
	kTEhujVkcZMZZBQz8Ka6vmrIqvnOb0gXhj+60yqRbUMLMZYHCrS2qRokCkofIQ==
X-Gm-Gg: AZFdTZdsdIzPUSzvlZWpGINZJEslCSGiaotJ9Rrbl/WlqZbVkHyki6hwlPK1FstwPQO
	k0YO819fSGuHBLK3RmnDDoPS/6HS0GXk4Xun8re9ugmIcPVRDBmbFTEmf5YX7WgDPRL5Y88dOqj
	sBGbR/T965x8euOD9BzGrT4eoAIbROptV+XPLmmn3OB6+uQhxWB/1iOuW2LWfiMqhpa4Rz7eVpZ
	Gr69q4eY2vfIubk+WakZpEA5DJav41Qap88QnwARVM+HPKvGfXiiOHX+VT1S2YiZR5WegIWp+dY
	IbM5hALOLQLrfFQH9d4ZM85gVB/PYOOIraJ8k0jFQrey8+KHehaDPzZNxkK2r8+ct8SP4PIKITJ
	+1Xbg+BBxZKZzgNZNc0VovmschTPwVJUQKntHQoX9RUUMhhcPby3HAGsU0nSQrUtpTZtGajWQxx
	BaVx8hCJn0ZQyU0vUm2sh8diCOky/JIqk27HDvKc33//LqZvTD2BHdugBVJSUMyZyk4okImh0JG
	buXJW4xzd5A5NFt0lcAq+fPy8rsQn/FZg9Woc7j8AWG6IC9gv3jtFuX0uaRmqy6LJu0RzWd+Rv9
	/3PtPGCc1rlyQrZt0HQXhIdihaviYGqT6RJJCRRm3dnUQn81I70TvR4=
X-Received: by 2002:a17:90a:c10e:b0:3b3:b0f4:1bf6 with SMTP id 98e67ed59e1d1-3b41c8ff7b3mr21367988a91.22.1795689436623;
        Thu, 26 Nov 2026 02:37:16 -0800 (PST)
Received: from localhost.localdomain ([219.251.253.167])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405d63728sm37517832a91.8.2026.11.26.02.37.15
        for <drbd-dev@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 26 Nov 2026 02:37:16 -0800 (PST)
From: Kitae Yoo <ryugitae777@gmail.com>
To: drbd-dev@lists.linux.dev
Subject: Re: [PATCH] drbd: fix resync stall when P_RS_CANCEL_AHEAD overtakes the state change
Date: Thu, 26 Nov 2026 19:37:13 +0900
Message-ID: <20261126103713.45457-1-ryugitae777@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261102070113.52210-1-ryugitae777@gmail.com>
References: <20261102070113.52210-1-ryugitae777@gmail.com>
X-Mailing-List: drbd-dev@lists.linux.dev
List-Id: <drbd-dev.lists.linux.dev>
List-Post: <mailto:drbd-dev@lists.linux.dev>
List-Help: <mailto:drbd-dev+help@lists.linux.dev>
List-Subscribe: <mailto:drbd-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:drbd-dev+unsubscribe@lists.linux.dev>
List-Owner: <mailto:drbd-dev+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Gentle ping on this patch. It fixes a permanent resync stall with
protocol A + on-congestion pull-ahead, when P_RS_CANCEL_AHEAD on the
control socket overtakes the Ahead state change.

I'm happy to rework it if you'd prefer a different approach, for
example dropping the stale start_resync while we are already
SyncTarget, as mentioned in the notes.

Thanks,
Kitae
