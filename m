Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973B347F3B3
	for <drbd-dev@lists.linux.dev>; Thu, 24 Sep 2026 13:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790256053; cv=none; b=RU0R6beddRkc0STlXo7oAaNprOqNv0u8OSvEi207+kg8rYgRGc52IZb8EEzxkx+TRSlWkK9OA23B2vE2YlDizN21hfODBxKaL8fgUkVqTsu5c2WGXDKMbyetpId+vaTOzd3nOoL/7nXpXNUh84LIS8WDUWvuunVUBNGvi9CBDYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790256053; c=relaxed/simple;
	bh=EnvthftjhvU8ihf6MuZ2HVlJqWyKvLQbdgWDQpD+FZY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l4KKSXdMTMYu38Gi5X32R3AtUiBBgANIRNOpZVa8ZNTqq0JcZlCQf0/8COnmIyo571lkXZ+3FidgKI20UyVpSJ1XqfNmuTWu/sRjm/vokR3rOgrNxRylPiJRYKrCD2gh+kqkyFOtj6q/zhJAiDeMo4Pzm3tZcqcbpztl2cWkJi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b=osO+vvI+; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b="osO+vvI+"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-488780459e2so127266f8f.2
        for <drbd-dev@lists.linux.dev>; Thu, 24 Sep 2026 06:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20251104.gappssmtp.com; s=20251104; t=1790256046; x=1790860846; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S3ndpV76gcHySuhNV3ES4GgzpJyufvPVRLRBa1QmBk4=;
        b=osO+vvI+pxbmk2Zu3t7hF3Y8+BnNvcf18rk1/dVVD3LsVobCtN8bX6wVCqXaQ0TBEh
         MCmnSsjqtDEmxUcUz+zljAVEqQCvn9rw8uBhtkzONAMdBJpwlFOA+WVunUkE1AMKE4xK
         oIcJla0VYivMKTe67CdxnS8wfe0ltKqq2YJ9teIQU2PMGc1AXbsVXm6UQF6Wk83YUuQk
         lwWibOHabrBa1+xESB280Y1uc8vD3KpNObv9sNXv5ckjPevU/I9r53WCm9CwYsHquR9p
         nGb2t/PU4UFBZ2W+KMBieYKUZl9WiqsCvQ6moeC4hBDge8t3bbymydEwu+i8LAFVMYVX
         i+ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790256046; x=1790860846;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S3ndpV76gcHySuhNV3ES4GgzpJyufvPVRLRBa1QmBk4=;
        b=NUxJ368P+C8EltTjNG+/X9FapJpr3cjrI6zGlGmoFt/Yn55OMOPte3TQAbNyU+Y9HX
         CqBk2MoRgRiW6tUTEBzkcz3PsXUPqB/ltCrXXTtzDTnv8+ZGZN2wTdjn+s6brG0EZty8
         FUuKTiyY4uYWV1qaeDw6NbtxuDaPgsqu5LRFOhW46j0WRXb/b0svG+FrNj+DrY6wOXFF
         B1X4Vaj/nI9YDrBtECsHBkkDGV6hvqeSn5F/QBmfGm1xuzvVNIBoLUZ7ayS/c0Y+UHrX
         gift1jfv2aysqQswcMctPm/0LYqc3qYGYuf4BoP7VKXLJiufWHYJzheWlHEfMivAGN4D
         tJFw==
X-Forwarded-Encrypted: i=1; AKwUvBz39qz5IKuHzXGH146ALgcFhHEQ///L44yZc4ZlcnDye5k2l1UOWDxnIeDZ1YTABjVzqPOJ2FhaiQ==@lists.linux.dev
X-Gm-Message-State: AFuF++nl+58ZxHFW8riLXGz3nNoT14LcX2iYXP2Bi3pYliAgmrilO2IB
	zFG1btjwBHTUo7ulylm5vUObNA3ERO7dNPCaWQeEAJ/uTaUBQDZtmmsR/LeWOFrMrR0=
X-Gm-Gg: AYBFou2dFzU0ha+S0B0OTTbOqdSBZwRZys3AdaYynkZLWQUNtYR9IHYwsNzURUTp9X+
	SKUxc4LQYpAKho8xbft1HaBpfrUXcasYb3lZSHqv9h2NZwN9zmYc3qVyLKbVDAzsKj0LrQSYdxL
	I2mbnsH3N1vf8OBw6iGe1i7axMnr2zDkZyWa71ANV4WuP3cD3b4b5u+mefxMJ1jVYnScyDnqxsE
	Oi4LS5hq58h9HJEnzKjepnN1bSf2VyrlSvGJYODDkE8HsFwHKVl3De7iEWonaRIQ7OfjSpbFJ2q
	xeW8T2KhCyWsgurZg1xs6DISNQf/pRLwgQGp3KWWQJe+RNmEhouKqrWWAwjziteUAXhVVgYctjH
	1ufbvPkkNZ/+I5hI3wIK0h3Akyqd4UBJ2OZDsuJ71+6sdQ9p9W7n0UJ6qZ82P1xsV4W5N0T7LIO
	GiPrK/abCBNsGxPya+UU7HbhWloT8umAXtsaIgwCoCYEwLsGtt+aF9ZvSl1pTzMMzLo928zd7wy
	IM8uebLRYnEFqNygrRmDhywwUI4+YxJDdOcA4kegrdxvnDjXBzaEuX8
X-Received: by 2002:a05:6000:2083:b0:488:5c28:94d0 with SMTP id ffacd0b85a97d-4887172596fmr3965034f8f.19.1790256046354;
        Thu, 24 Sep 2026 06:20:46 -0700 (PDT)
Received: from [10.190.130.145] (046125162068.public.t-mobile.at. [46.125.162.68])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4886877a2d5sm14280483f8f.27.2026.09.24.06.20.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2026 06:20:45 -0700 (PDT)
Message-ID: <d6dc53d4-e2b2-4012-9ef9-6c7c15b51c15@linbit.com>
Date: Thu, 24 Sep 2026 15:20:43 +0200
Precedence: bulk
X-Mailing-List: drbd-dev@lists.linux.dev
List-Id: <drbd-dev.lists.linux.dev>
List-Subscribe: <mailto:drbd-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:drbd-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drbd: remove unused drbd_nl_mcgrps[] array
To: Jens Axboe <axboe@kernel.dk>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>,
 Philipp Reisner <philipp.reisner@linbit.com>, drbd-dev@lists.linux.dev
References: <20260519203057.1340528-1-arnd@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
In-Reply-To: <20260519203057.1340528-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/19/26 22:30, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> After the rework, two files have a copy of drbd_nl_mcgrps[], but one
> of them has no references:
> 
> drivers/block/drbd/drbd_nl_gen.c:641:42: error: 'drbd_nl_mcgrps' defined but not used [-Werror=unused-const-variable=]
>    641 | static const struct genl_multicast_group drbd_nl_mcgrps[] = {
>        |                                          ^~~~~~~~~~~~~~
> 
> At the default warning level, -Wunused-const-variables is turned off,
> so this has gone unnoticed.
> 
> Remove the extra variable.
> 
> Fixes: 8098eeb693c4 ("drbd: replace genl_magic with explicit netlink serialization")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   drivers/block/drbd/drbd_nl_gen.c | 4 ----
>   1 file changed, 4 deletions(-)
@Jens ping, seems like this was never applied? I think it should also 
apply to the current tree.

Thanks,
Christoph
