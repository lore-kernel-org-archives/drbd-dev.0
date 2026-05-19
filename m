Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DD22DB780
	for <drbd-dev@lists.linux.dev>; Tue, 19 May 2026 20:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779223913; cv=none; b=EkHY1OKmsrWersIERC0WhSQDJsoKB0kGDDQIsZCo8QyTjMeaPN4XUxfv/AzVMmzhmo1x6+ScoFyx0F69HZbjC+On754H5aLnVFTH8ZDOjGLUXJ9FhPJC23jh5PyJ1C+w+0u1Ya93kJjLC9pzCmfbafRYUU8MS7Px295R6erbQ1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779223913; c=relaxed/simple;
	bh=whjXp8rWkJeXDbOFZ/V58cb/3zF2lbhUXZVSFzpVNWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ms4/OlairOkDaOVaYV/4E8sChF9kM8FmMkpHshcsSohXnEfLgm2Rpg493FMR2UNl/vicizOSb0nVm8E6EYaSIMPY6DHVN4W/wRZ10TYqJp4i7h6DQQ1t9hVCWa6DKGCt4RSH6SnRVcgMGRJzaMxu690gMLHIY3P5lFJRAFL6MMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b=DmlD2vSV; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b="DmlD2vSV"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4891c0620bcso25980745e9.1
        for <drbd-dev@lists.linux.dev>; Tue, 19 May 2026 13:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20251104.gappssmtp.com; s=20251104; t=1779223909; x=1779828709; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6WCYsOu0Hdsv3nYRv+K8TQXlAkq1BjCEa9xNFJ1ynkw=;
        b=DmlD2vSVGSFzJdGtoLJ+YaJnTd2TnMHtwSVZD0hlpAOTK7Qr1FkS+M7MuEaR63eac5
         +EUGFpoP1KHpYGm/AWzvZk7OhDeif8AVsfB6NbXL3Hb4Jcm23jKytJ7jSMMosqm73oS/
         2NX3HlUWfL2vr1FWkW+JutpQY7ZdJF/sggV4UpeTuNx/zbt6ZjFfq/YF4hWyyIf4dynw
         LlsenkiQJY3/IzZbjhRWlXam8/mE2fOPNMBAiZIdCbVcswQRwom8EStyDjaR8AN38mVH
         rKutdZrtOw8FJftYMtnMZnDAW/HNDL76If6/G64bHTnQjOZKN97xNZp5puYoBkGbz7N/
         Nq3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779223909; x=1779828709;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6WCYsOu0Hdsv3nYRv+K8TQXlAkq1BjCEa9xNFJ1ynkw=;
        b=ALZVByq+XjwqHxFQfHaIlt7e/m1e6fuZZs701K4QHX9YetXjqNIO4gwia9sKWVWT+N
         yd2glLGHU8pRWyzeTqXPl46FgdhDx2bPvLYqKRMrpDn2zTpLVgExNdu/Vuy71O0a/Gs9
         P5I3i0ZdwNVHTt4PxgIZE9oDBUPYKn8mibh1ZRlXMMnBU5DkE1Np6np/atW3++Cn4FVi
         t5EYYhib3PFWkvCsKiX8SLHXt0S1Ek+DyonkxFw7ebkVob9i6IY/ImmRhbW5QusIil8q
         UBaGvWRJ2Nv0NIyv96vA9ccALP6fqasdPOPD+088wyAV0xda4soW21wygl6dfOLtlDdR
         IKkQ==
X-Forwarded-Encrypted: i=1; AFNElJ9j3JnZUxaWoEKG65q0MtHfrEBHbbJ/M9CBK4yNL+JTPm6e3jp4nb/gyI+y28hh8XrCqEH25ZFTow==@lists.linux.dev
X-Gm-Message-State: AOJu0YxZNkpkVNq1HrT9vrYA28++eK4VA2+dWtgGQSZW2DCb/JhAVNbi
	4d0otfwdWj9jwS4NJLx6xWzo/tB7hf6n+QxJm60PXxeYV/sUsJw9s3ZNjcmTISO1JuM=
X-Gm-Gg: Acq92OEB86DGjj2juvFKlCpkglGqBTqUNOBEdiq777xmEVR+Kwu6r82blsftDL4G76O
	HD7wETjEExaG5ZDTs1CWwlpbP1nKUeIewMpcq8lZB844YxeGrd6LcoViOX2qYxxd3JPJhL+H2R8
	WwQxhHCjU4FfF0uczE2/I3PXRGy8ByWA+uEUlvkjeLhFP4edl2tFdKr7THLyxhc5Yj461HNszaP
	SMhGwyBCdEY0DIfqDDG1IhpCr50gWxUCA+kmmJpUJFRVsB5cUZoriKzSpr5iHI2aeVu5Y1hWCMY
	1RhAC6YlXcf8TKAwObgmX5Vmsi/uzACYXUGtvFfvBpw2acf1XtjWy3nUc5aji3QraWZeZLNJohX
	t7zFRZFYbQ7tAWtkTQRNkL+lOXrTCIVK38sbkAsVSu+SmDrfiIJkFmOWair+p5uWfeUtcP2myHA
	LicFv93tCNhIokoTTFKSxd2RcheyqtuhxdUtGlI8gvP6ESqBlhKm3sq+PJvkC/AxjhIz3ojegpT
	sUG0goftiQ2NqisK3UDn7eoXaZE2XW0Xkc=
X-Received: by 2002:a05:600c:8901:b0:48e:526e:1040 with SMTP id 5b1f17b1804b1-48fe63021f9mr298522225e9.23.1779223909230;
        Tue, 19 May 2026 13:51:49 -0700 (PDT)
Received: from [10.61.154.145] (91.141.120.117.wireless.dyn.drei.com. [91.141.120.117])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9e767cb9sm46504270f8f.2.2026.05.19.13.51.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 13:51:48 -0700 (PDT)
Message-ID: <65088b94-a603-4e84-8601-0663f85303b9@linbit.com>
Date: Tue, 19 May 2026 22:51:44 +0200
Precedence: bulk
X-Mailing-List: drbd-dev@lists.linux.dev
List-Id: <drbd-dev.lists.linux.dev>
List-Subscribe: <mailto:drbd-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:drbd-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drbd: remove unused drbd_nl_mcgrps[] array
To: Arnd Bergmann <arnd@kernel.org>,
 Philipp Reisner <philipp.reisner@linbit.com>,
 Lars Ellenberg <lars.ellenberg@linbit.com>, Jens Axboe <axboe@kernel.dk>,
 Jakub Kicinski <kuba@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, drbd-dev@lists.linbit.com,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 drbd-dev@lists.linux.dev
References: <20260519203057.1340528-1-arnd@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
In-Reply-To: <20260519203057.1340528-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

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

Oops, looks like a copy/paste error on my side.
Thanks for noticing and fixing.

Reviewed-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
