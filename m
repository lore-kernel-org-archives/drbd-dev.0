Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB052C11E4
	for <drbd-dev@lists.linux.dev>; Thu, 23 Jul 2026 07:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784792727; cv=none; b=YWd3wxxy1U3rYByC/jyS5oyIGk8dNqMx0L1ttSoiDriZcGabxaQQh5utmXrD8HFWEIDPsxMjvcdAcTzZ2i2/Wx8MzCGyKQRdVN/PKtXMGvFZzHqZGmGQzYMUPcJkFL0s2tzzRl25jX1BMT6kbsM6/fXNfXcUDv9NUBokc0lsq9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784792727; c=relaxed/simple;
	bh=FK4nuECWzh/2cINKiJS9Y1w/QvpKWO46HahbEljsyGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kX1aaHmoMfsexX52UHw/ah8zlnNNc53XMq48rw9qeNgOMOe+BlrplkCodXojJoIro9PYHefXmfRx0HRVngCKZdGURhvH73kO8uHql9hfPpjHhujEDu0QgoYwAbQgvCBMQM3uItnEL3eXdt/sqg680x/c7SqVdd/+DRM5gwtnHCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b=UlT7CY2w; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b="UlT7CY2w"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-47db714766aso82314f8f.0
        for <drbd-dev@lists.linux.dev>; Thu, 23 Jul 2026 00:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20251104.gappssmtp.com; s=20251104; t=1784792723; x=1785397523; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:mail-followup-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FK4nuECWzh/2cINKiJS9Y1w/QvpKWO46HahbEljsyGI=;
        b=UlT7CY2wnq5VtTRSZEBr2hdVHBIGBc1wbwmOVpu5nJ+Tq/d6OXa9lnR8J0rUy9JK3b
         Uu4mOacY2Sid4kygUnvhbJVWw45cbijKPHnuZ3Yw9cLfn1qwHN1mAXaKQNWWgakDNG9z
         Is7hJ3BAv238PUdG0X8ibEidWGXsetSXeWHwSBfpnBtqhP+ycbE5riwzMib4MBvvUquI
         O6XiaI+oiv93zO0KjstSlj4Iu9LWKOEKRb9HTuLItCKIBs9b6rS/409Dq6P/2rA+Z3Oo
         W5P9vkHrGYj3DYa+O4ojrNSIph1bjgx2DSPkqjp8VaovKk8+D73ld6a4PTVoKdUeB+zV
         rAIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784792723; x=1785397523;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:mail-followup-to:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FK4nuECWzh/2cINKiJS9Y1w/QvpKWO46HahbEljsyGI=;
        b=fPJK2FNWUrY9HNDfPg9rarJr35I5AlppfGzccWYKM0BBMqsMmMxsvLechsTA1xFJ/O
         RAe0rmvM9LX+G08OPXbu47E48aJ1m2xohTLw44V0NY3pXjkt/Bp0eMnslimRpYJblA0T
         o/Z70A4R0qFZJ8j/904GrRxeZBNN9S9mjHg5784LZJsDbky9LldfsD2Ic4b2YfBcsCk1
         lXRvzpIJpYTOqs6H2eRrjXSmASuo4a97avJNlz5v2SRmqyxXmEtLdgFmfBgBL+S/7k+O
         7tiX2sB9mMe6sn8I5IoxYeNdpJJiAjl+06C+wTrYZ8VEjSGQ81swTZndijyhn0JEInyg
         0x4g==
X-Forwarded-Encrypted: i=1; AHgh+Rrfwbem03e0qPyyTBM5MO3vteZvxgmBRWitkI1h/7gSEINjyJ65juFYWctIyVAyk8vBYqyND8cH2g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw1xKlRiRAMO3fEcJk7Sba3yz47KvpdksOfPEME5bvbC/QI09UT
	exHBDeV6/OeDBl5Xdd4TYj59drLx0JT9fWFn9bCW93o0mv3Kf+1FwVK47JYoNPU13Ek=
X-Gm-Gg: AR+sD10CWKAhBWZvBpL/RGb8+Ex9AJT8ArR3OCpJRuHyDhpCEvLXJpwqrqWdEkoigTm
	47wlDJokOfIAA5s8WckIbbFP61TJMKmXrv74PHkFGkGYziyjoYDQCYCJifCB2iU3KfMrvxhRZLb
	4WY0/1xFpvnRboJGUeWKEq8MpiGTVSei4hTGMdiiNNZu925vzd9c+vqlzYBas2Y/PrGpLSM+ZQ2
	c54wvdy0UX6ILQ8lDWnBbIty6JueafEb3ZhqkmDALybJ9b6cxP6WDU/UVr0j+q9notv5C6Ejhff
	l5EYN5rHp54cSdUHNT9iQA9XFXOTB17NlCBoQfg0WHjFckUpLfbPdH8oEZnBIc9p67b8WAiwR+f
	WyWlvXDpcoThtlVOYMQmmdQR0PFPd934X9gXjZxhpNeQ6ZnuYyx7BFPPRMeMw1IO9cZyhJ+Z4cf
	fZL2mxYZQ4JMtXK2tWEVmgHO9m1oNmES8WARqTPXFq5+6ZBA==
X-Received: by 2002:a05:6000:1acd:b0:47f:70f2:ccf6 with SMTP id ffacd0b85a97d-47f90215a85mr1739490f8f.6.1784792722721;
        Thu, 23 Jul 2026 00:45:22 -0700 (PDT)
Received: from localhost (h082218129081.host.wavenet.at. [82.218.129.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c6dc25sm13663180f8f.33.2026.07.23.00.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 00:45:22 -0700 (PDT)
Date: Thu, 23 Jul 2026 09:45:21 +0200
From: Christoph =?utf-8?Q?B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Linmao Li <lilinmao@kylinos.cn>
Cc: Philipp Reisner <philipp.reisner@linbit.com>, 
	Lars Ellenberg <lars.ellenberg@linbit.com>, Jens Axboe <axboe@kernel.dk>, drbd-dev@lists.linux.dev, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] drbd: reject out-of-range sizes when draining data
Message-ID: <amHEWfR808gFEanV@linbit.com>
Mail-Followup-To: Linmao Li <lilinmao@kylinos.cn>, 
	Philipp Reisner <philipp.reisner@linbit.com>, Lars Ellenberg <lars.ellenberg@linbit.com>, 
	Jens Axboe <axboe@kernel.dk>, drbd-dev@lists.linux.dev, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260713023434.288279-1-lilinmao@kylinos.cn>
Precedence: bulk
X-Mailing-List: drbd-dev@lists.linux.dev
List-Id: <drbd-dev.lists.linux.dev>
List-Subscribe: <mailto:drbd-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:drbd-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260713023434.288279-1-lilinmao@kylinos.cn>

On Mon, Jul 13, 2026 at 10:34:34AM +0800, Linmao Li wrote:
>drbd_drain_block() receives the peer-provided payload size through a
>signed int argument. A wire length above INT_MAX therefore becomes
>negative. The receive loop still runs, converts the negative result of
>min_t() to an unsigned length, and may receive more than the single
>allocated page can hold.
>
>Commit bd910a7660d2 ("drbd: reject data replies with an out-of-range
>payload size") addressed the same issue in recv_dless_read(), but the
>error paths which discard payload data still use drbd_drain_block().
>
>Reject negative sizes before allocating and mapping the temporary page.
>
>Fixes: b411b3637fa7 ("The DRBD driver")
>Cc: stable@vger.kernel.org
>Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
>---
> drivers/block/drbd/drbd_receiver.c | 5 +++++
> 1 file changed, 5 insertions(+)

Yep, same thing -- DRBD usually chooses to trust its peers, but the
consequences here are pretty bad and the fix is trivial, so let's do it.

Reviewed-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>

Thanks,
Christoph
