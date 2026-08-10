Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC3E3FE35A
	for <drbd-dev@lists.linux.dev>; Mon, 10 Aug 2026 14:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786373199; cv=none; b=XhXf7HfJwE/GvsnbzuvIont/+MZ8UnC/FvBpwOElKTOYP+kcpgWtBQkLCelYOkBQKAvVUlm8dMykrDl0dzaB7HgSJPalCyhzMw33z4sQoBFFpUBl6PXJzWZSPRcbSekecVKnWYlArbGtdEVEH65Akmcj3tnxlMFbPSGwmHIexNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786373199; c=relaxed/simple;
	bh=xnO/3tRQ/dRSYwCuTksr2aqfx1rrExH7KLmPwM2j/ss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DXKloVJhajJRXKqqvxazNXEmrrlU63nTeAnfkuDJrH+O8OWsYLcVdt8ZBy5D6er8ndHtcCIolsjec/TQaTlYLylhbmyErBE7+G6cZX2wlxPlOPMr9dnt3d030y88U4FXGBhtvp3EuthVvw5cnAmNbNp7OSr2ym14kozfuEt5UqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b=KbEY+Bnw; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b="KbEY+Bnw"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49553515a8bso30946775e9.1
        for <drbd-dev@lists.linux.dev>; Mon, 10 Aug 2026 07:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20251104.gappssmtp.com; s=20251104; t=1786373195; x=1786977995; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tCttc6k64h4wAjlZ196iGabJt80ujK6RxFX/JQJNzX4=;
        b=KbEY+BnwArKeE1jq3+MBcZEgag0ijO9NAuiaKlJqAw5wTQzuX9ePVaFOAx7cDbiJFE
         kbhfEGYNbwCnaEmk+sGpEURY/3HkifQtRoaECOOb09PusSDyjkirztu1XQVzm4MsCbCQ
         sZaHZj7++dLsxianK7i1yl2CsowQLE2ElD+RryZSF/BQK/ppr1yZYl8v8WpDYwo5apYP
         +y582LkSKNTY2cgWHe47ucU6eEtjmhf/NQ5qS4P7zs2KXcD2JA3TJNXmmEXzZ+IiR7NU
         /yYWDWUQcr9zew5a3TF+hxAHkIZh0F0SI6Yyfmk7O+GpFnacYuTnPtdclt00NUHjPs3Y
         L2TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786373195; x=1786977995;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tCttc6k64h4wAjlZ196iGabJt80ujK6RxFX/JQJNzX4=;
        b=akUo/4U5TnywqlhfzRPlI0KVcj/1NpfBWyYP/i0o5nNkfqXDzzr+FSD1dhXrNcyxQf
         94N04VPwmNayQ2boIkrsr/0Vy4DTDRebkbRdH0uN7MHQKtok90RRjFqW1sExtcTUQn46
         yjil6UrwZon2VFHD8ZcDzj5A+EX94n31hW7pShAKXwqRx2g5WlWRs/HgliVkpLO3+sT6
         HBUIWPExSWbJV3iciHy+VDJl0y+ZQaPijgPpemHiwJ8qigY1GhGCB3YXS1nvxHa+u93O
         MK8iDkBp6SEKWQQU78BZ6brcFauOSJhduRplx5MUILT+5ehJL9jJsv7pev/kZi9Kqu9i
         Vp9A==
X-Forwarded-Encrypted: i=1; AHgh+RqXbsulzdr3nhr1Ie+v9Pbnqipk9BqKBbpQGOhY4pzcgCLs7xTvr+t58zR6hIx7bCjjWa74+VWHQg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwRpMI2MPCOQeybtdirZ8Gl3WmSmSjinGmVWGRBJX215bmpE6U6
	ConIsOGwfUNKmiepILxRTNxHJ5Z852ZafMuAei5Lg0ZRTW/75o9++gTm7+qCoohZzPA=
X-Gm-Gg: AR+sD10snfYUMVRYQONCWHL8MZ2Jn064TR/TWPh1PW+C9obSPoIyF+ouV31wdERXnNc
	gRU8PDbuMPohtvuNtHLkhF6VluxK6p3TlEdqsD0aGWrhCTdGfFbm3yvc5rgiT/qgXb5ba5iPcZq
	XA7Mtudesa1outF7Z4sVurSKtnHoFabLDU52R8P0m9MglMAc77VvllF11rKkEuSnQGnoCw0hDbo
	QI3rRA4d/yt8vIqo1UM9RRpUaj6mVZvuPD6UaOGKsmTuWM70/Pm/vjpCeFQiP6gus9Pv3awKmLq
	Dy9sYe89MGFGFZYxsQN20+w0+8M0lyjwB9D/nfbAGRR78R9pghVUY+fJtnQQ3YEZINiAWaDLf7u
	TMwB5GmDzXHTqFlDUOrPqiSOY1NBYvmYf+meGWTipt3zmn0MPircuYF6ZEssTbDChzsokXm95Q0
	sjBqphNdvfNJDiDpCmxrR8TU6Z8ALv8L9eafltdD2DrvyjMRTZIgCzjYy3IfDRaKIeOUxrfZRwr
	ZRYwhQrlQCKsSeV2En8mHLsg0aMBxS6t9/q2f9whQ==
X-Received: by 2002:a05:600c:242:b0:493:c845:bc20 with SMTP id 5b1f17b1804b1-49959e0174cmr299256595e9.4.1786373194772;
        Mon, 10 Aug 2026 07:46:34 -0700 (PDT)
Received: from [192.168.178.55] (h082218129081.host.wavenet.at. [82.218.129.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995bdc433bsm320370545e9.1.2026.08.10.07.46.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2026 07:46:33 -0700 (PDT)
Message-ID: <dfc602da-a30f-42d6-9901-97de1c9b26a3@linbit.com>
Date: Mon, 10 Aug 2026 16:46:32 +0200
Precedence: bulk
X-Mailing-List: drbd-dev@lists.linux.dev
List-Id: <drbd-dev.lists.linux.dev>
List-Subscribe: <mailto:drbd-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:drbd-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drbd: fix off-by-one in netlink NUL-string policy
 lengths
To: Ionut Nechita <ionut.nechita@windriver.com>, Jens Axboe <axboe@kernel.dk>
Cc: Philipp Reisner <philipp.reisner@linbit.com>,
 Lars Ellenberg <lars.ellenberg@linbit.com>,
 Joel Colledge <joel.colledge@linbit.com>, drbd-dev@lists.linux.dev,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260802110552.50757-1-ionut.nechita@windriver.com>
 <20260802110552.50757-2-ionut.nechita@windriver.com>
From: =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Content-Language: en-US
In-Reply-To: <20260802110552.50757-2-ionut.nechita@windriver.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Am 02.08.26 um 13:05 schrieb Ionut Nechita:
> For NLA_NUL_STRING attributes, nla_policy.len is the maximum length of
> the string excluding the terminating NUL, as documented in
> include/net/netlink.h. The genl_magic infrastructure encoded that as
> 
> 	.len = maxlen - (nla_type == NLA_NUL_STRING)
> 
> but the hand-written policies that replaced it set .len to the full size
> of the destination buffer. Every NUL-string attribute therefore accepts
> a string that is one byte too long for the buffer it is copied into.
> 
> For such a string validate_nla() succeeds and nla_strscpy() truncates it
> and returns -E2BIG. The return value is stored without being checked in
> the corresponding unsigned length member, e.g.
> 
> 	s->cpu_mask_len = nla_strscpy(s->cpu_mask, nla, DRBD_CPU_MASK_SIZE);
> 
> set_resource_options() copies the whole struct into resource->res_opts,
> so a later dump of the resource options reaches res_opts_to_skb() with
> cpu_mask_len set to (__u32)-E2BIG. The payload length handed to
> nla_put() is computed there as
> 
> 	min_t(int, DRBD_CPU_MASK_SIZE,
> 	      s->cpu_mask_len + (s->cpu_mask_len < DRBD_CPU_MASK_SIZE))
> 
> which evaluates to a negative int. __nla_reserve() then stores
> nla_attr_size() of that negative value in the u16 nla_len, and
> __nla_put() calls memcpy() with an underflowed size argument.
> 
> The five net_conf algorithm names, both disk_conf device paths, the
> configuration context resource name and the resource cpu-mask are all
> affected. The shared secret is the one most likely to be hit in
> practice: SHARED_SECRET_MAX is 64, a secret of exactly 64 characters is
> what "openssl rand -hex 32" produces, and nla_put_status_info() feeds
> the unsanitized net_conf to net_conf_to_skb() for any caller holding
> CAP_SYS_ADMIN. The sanitized path clears both the secret and its length,
> so an unprivileged status dump is not affected.
> 
> Restore the bound the generated code used to emit. With the policy
> corrected nla_strscpy() can no longer truncate, so the unchecked return
> values become harmless again.
> 
> Reaching any of the affected attributes requires CAP_NET_ADMIN. Found by
> inspection while looking at the cpu-mask length limit; no user report.
> 
> Fixes: 8098eeb693c4 ("drbd: replace genl_magic with explicit netlink serialization")
> Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
> ---
>  drivers/block/drbd/drbd_nl_gen.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)

Thanks for the patch, good catch. The fix looks correct.

Reviewed-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>

-- 
Christoph Böhmwalder
LINBIT | Keeping the Digital World Running
DRBD HA —  Disaster Recovery — Software defined Storage

