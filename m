Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E606148642A
	for <drbd-dev@lists.linux.dev>; Mon, 21 Sep 2026 11:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789991170; cv=none; b=V/P2CzpVmXrO7VMSPC85LTbL1Qa4HB2WwSKDTZ35vPYDqz4g7frZLDQVuIZfa1B9bee3biyDbOiDnleEcF3Us8Kb5B5jpGYvC+DmeTHJDEyPUJPxq10h6j0THaquCmzquumNGJmGDyXkRxLdfud3sRLqdkagkion2/7g6F8QPUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789991170; c=relaxed/simple;
	bh=7JeXBQLqae/WhahNYE53gzs3rKK7p/5RFDwmui2eLnA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mMKmqv+MfHPGpq1iLyn0eHDUDwH4jBKEAOqYYYr7sLOnnaWUwDYCOrUDThnVcmnB5zs/MDMWp4nxz3QrSaEGsSw2r8Gn68PacqPIrmfDilw4igISgeRaYaJiZFcnWi7HooOkr2knvQNAb2Vn96a86lhIdGMP1hdB54DmS7dZ05g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b=LRkUxm/Q; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b="LRkUxm/Q"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4843796e373so1571125f8f.1
        for <drbd-dev@lists.linux.dev>; Mon, 21 Sep 2026 04:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20251104.gappssmtp.com; s=20251104; t=1789991167; x=1790595967; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7NySXqRqBMQS4yyS45j4W45LZP8TO8LAexSEh597hdw=;
        b=LRkUxm/Q1ar78ZpHVI3zpWKIOjZ6YeozIh+ZM5EOfzkcGcAbIkepHO8abVeMe+RLwX
         px9WlTbMUSEALIMrggfWdY8aQ1DlX6c8Lo2GyOv16a+hE3t02u/3etEMFExnSJR3r1oQ
         F5/CQX/49styPj4hMZtS2iZY/EPgXYkJIiSsVlhEE8QdwLLQPdtTMzpzdwXFpJwlh8Oj
         sZsYBF5ZzZ0HDBZ2s0ZA0UEtmi4heIT1gr58ZEkKZzSxhLjErIH4qcYOCgPiroZ3A3Ow
         NcBu5JFEgivpLAHDpST6jbQ7PyzjoVWIa+LqdOLWkbJFlwfSnge3tGjOKNumTYup9G7G
         HmcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789991167; x=1790595967;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7NySXqRqBMQS4yyS45j4W45LZP8TO8LAexSEh597hdw=;
        b=lbNxlMDUEEPB9MFFHkefbSZZyRXSivFh/zlYK4m+3FWWVl5Ww32wVl413aI4MCAYJw
         zFX6++GU3/jzBZH7GKNuwleuZrYvKQAvK4Xi97KfPYgkvBhYxXNmGRyOLifstAuxIKil
         IU4G71epGXnq/AOz61pSFpYzZRe8nPknwum3he8MHYEeEueZOCtLr3D8aDPH5uiws9oC
         GSmIE8Xh5D0dkY4tAKmoPQzUOd73Muy7DkNnwefiBErulLlnzU2jXjJ4AHFpRDfGcHRZ
         PjLx/Bb0wo9RU4DHmRWe+sWee3Ci+6gvW5rkF1+7jZ1b33UpVyZpnMLZ6HjdqMjqx5jB
         9iZA==
X-Forwarded-Encrypted: i=1; AKwUvBzsIdBpwphU6pBkIBBgkt2skn2AmsWaTwoQnZgeGFc8A+eDipBIy59H6z5SBCtVVMghOVBPtmB3Lw==@lists.linux.dev
X-Gm-Message-State: AFuF++lKw1V2sszqWBO6ajRUgH1BrwLH/xDlw5JZmkFys1/Yj05Zqu7U
	NzJjOD5Jczt3dBOqPgX/MQyDAWScSi1SQJ3Hs6nmETXWWb0atYe5h91jziL1GYRAYSo=
X-Gm-Gg: AYBFou2GxFbKbxTJDKCHaumQ1MZJVZMHwsjDQx+g1ZL4q71/LaclJvJc4ZgtfhscpFT
	oYNVcLP66HkcOCNbidjuJcAu8/F0Eqs4VV4k4NmTXSzbIVkHUlOZJi1ULCNCAZlSml0OSt+9jkE
	1panzgCkzBZCgLxurDwOJOuz3kN+JlDTNBTtBUIMMTpbwyV4QtuQjGcQRQZVGIDmh9s7/hnvs3L
	L/G/+7Pxd181sijF2/8liXqGDdUCpe+tBI2O0TZPv5bFZJHpHq6XGrNNQI8xfbU/mGLqksMjwgq
	o4MYx+w3js2FncwmLTMJu7JGuSLodOPw30bAqxYON2dBWvDGhhSOMvrTCGGAPdGSRvNHk7VmoJm
	NA0eOAoE4zkbmcbgMzjiE0UXqvq4I1XGKlo3bYLCYI4qUZnR7GC+CF0nJwY0lvQD/IkRDyo+MA9
	ot0+gdXFX98D8OhAfC/0LFDukILsvI17n9RXNmciEsb1Hlhmw8ZoXx82A3V/zxUgVgBjgosVhG0
	3gERP5WaY3WiCx5KVe/HEQY2w+LZNwW1VF14M3+pmWkrmxEI82+iQz/QrM4
X-Received: by 2002:a05:6000:2909:b0:487:355:4619 with SMTP id ffacd0b85a97d-4871e2159a6mr15005534f8f.4.1789991167137;
        Mon, 21 Sep 2026 04:46:07 -0700 (PDT)
Received: from [10.190.130.145] (178.115.89.92.wireless.dyn.drei.com. [178.115.89.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4872459d409sm21348115f8f.33.2026.09.21.04.46.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 04:46:06 -0700 (PDT)
Message-ID: <b0ec8c92-cf1b-4e71-81ee-cbed5db56365@linbit.com>
Date: Mon, 21 Sep 2026 13:46:04 +0200
Precedence: bulk
X-Mailing-List: drbd-dev@lists.linux.dev
List-Id: <drbd-dev.lists.linux.dev>
List-Subscribe: <mailto:drbd-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:drbd-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: use assign_bit() where applicable
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
 Philipp Reisner <philipp.reisner@linbit.com>,
 Lars Ellenberg <lars.ellenberg@linbit.com>, Jens Axboe <axboe@kernel.dk>,
 Denis Efremov <efremov@linux.com>, Yuho Choi <dbgh9129@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Hongyan Xu <getshell@seu.edu.cn>,
 Mateusz Nowicki <mateusz.nowicki@posteo.net>
Cc: linux-kernel@vger.kernel.org, drbd-dev@lists.linux.dev,
 linux-block@vger.kernel.org
References: <20260918141609.3022848-1-peng.fan@oss.nxp.com>
Content-Language: en-US
From: =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
In-Reply-To: <20260918141609.3022848-1-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/18/26 16:16, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Convert open-coded if/else with set_bit/clear_bit and their
> non-atomic __set_bit/__clear_bit variants to the assign_bit/__assign_bit
> API.
> 
> Done with Coccinelle semantic patch:
>      // set_bit -> clear_bit => assign_bit
> 
>      @@
>      expression cond, bit, addr;
>      @@
> 
>      -if (cond)
>      -        set_bit(bit, addr);
>      -else
>      -        clear_bit(bit, addr);
>      +assign_bit(bit, addr, cond);
> 
>      // clear_bit -> set_bit => assign_bit
> 
>      @@
>      expression cond, bit, addr;
>      @@
> 
>      -if (cond)
>      -        clear_bit(bit, addr);
>      -else
>      -        set_bit(bit, addr);
>      +assign_bit(bit, addr, !cond);
> 
>      // __set_bit -> __clear_bit => __assign_bit
> 
>      @@
>      expression cond, bit, addr;
>      @@
> 
>      -if (cond)
>      -        __set_bit(bit, addr);
>      -else
>      -        __clear_bit(bit, addr);
>      +__assign_bit(bit, addr, cond);
> 
>      // __clear_bit -> __set_bit => __assign_bit
> 
>      @@
>      expression cond, bit, addr;
>      @@
> 
>      -if (cond)
>      -        __clear_bit(bit, addr);
>      -else
>      -        __set_bit(bit, addr);
>      +__assign_bit(bit, addr, !cond);
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>   drivers/block/drbd/drbd_nl.c       | 16 ++++------------
>   drivers/block/drbd/drbd_receiver.c |  5 +----
>   drivers/block/floppy.c             |  8 ++------
>   drivers/block/mtip32xx/mtip32xx.c  |  6 ++----
>   4 files changed, 9 insertions(+), 26 deletions(-)
For DRBD:

Reviewed-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>

Regards,
Christoph
