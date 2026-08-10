Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F090540A938
	for <drbd-dev@lists.linux.dev>; Mon, 10 Aug 2026 14:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786373564; cv=none; b=oZ3ewXIaLPs6hZLXnLmDemdBwS/zASiq0UwkOGxQRySO8kRVzYDWfByq6Y68bFIznxXAAJ+TbaOr7qOAJtLmnhsymZxr8FPZPu55Ua+IxPATbo45B8/UxjjdfhEEyu0A1xfpK3glmX8GkYkfN2Qa7BJJsa4jczDMRDRJKd82AjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786373564; c=relaxed/simple;
	bh=gGa2dfj7Ba8n3c6Tqhnr2+TZtTEUTmxzYQpruZO7h8o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oJ8nAHoIljQMYNt/pcuy5rSiYcAyr8wr1zPOCAszs7bIyskUAAZ+ZHK8fUz/4OGN0Ak+IDFpcVihy9gXt5N+VBmxL1Rsrf3DYTE2i3XzrZ8eY4+PddB5LKGeAcESqwH+0W/u+xO6lV33aSdko6wxtIazKQWqvQhKV8C/4vIiGYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b=vZ4+MlCV; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b="vZ4+MlCV"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-47f3b39f2a1so1680152f8f.2
        for <drbd-dev@lists.linux.dev>; Mon, 10 Aug 2026 07:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20251104.gappssmtp.com; s=20251104; t=1786373561; x=1786978361; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xWT9igA0JIdyHy32MUg6eJ3ofaELJzxqELVmEcQys1k=;
        b=vZ4+MlCV35zbfkPqkk+HVJBMVSl5SxYJ5CoPAOlVeuOsBIS6xRBYf6qaHT3JjAMH4a
         Iwi35Jb5/1Wdp2ixm0nNj3vnQ+ir5a+Q0CTWB0lK1W+zozQyzKmYrJtwAVxQB5sxpCT0
         P2SklXHP3wNy/4ey9t4z+519tRAnGpWlEUupd3D2EcyKZHaheNjjdLser1O1Fcz8SG/o
         QFtTFegN9bwDyFZERSCZ8bJJmes7W76I2HFfy/uobUWkCWvtVdgIaXdqSgANx2//x9t5
         hQpAsFGbvr6WB5HRvivDXDMvvkJ+eFjgOrZ9stMWoptsr2Fkq7Zgef7Vdn80TBhbXioU
         Lveg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786373561; x=1786978361;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xWT9igA0JIdyHy32MUg6eJ3ofaELJzxqELVmEcQys1k=;
        b=tY5Z/72iaa99ydy8zLkCp4nD0U5tL/5wONBYtmyJFWHKa6oKbasa1dacccsnlyVTyy
         3gnywahO2OI1e+itK2e0Jw4LBRy+FWQWkTPk2j87MBzr6OL7xHvT1dINMORfmKf0JJl4
         NtzCfbF2O/lnYFiLw3ACXX1soCSMx1/yrsbU7L/jSkudma2HEiV7qqIGk5TlqUvXxPle
         E1YltDY5bO+EvqYZmjAeLHFWDZ5/vOdOxyqxUsRv+fxU8WL2ko3qhgLnXroo7SLDt2yH
         fjsskoCag0j6QCwupPW07C2GfVTBavA172pWNwKjvOh3bo+06OOB8gq8Ty0zqBQGNlZL
         TlTw==
X-Forwarded-Encrypted: i=1; AHgh+RpOLy2qsM03mBEyxylqo+umWmQH0KwfgCy5H/YuC+oNOkpivupUTHeZgwo5/BJeCG6SMLesIj+ELQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzVMDjS6NWy2OkT9lHCSoeEmMqcoBOWXZqeawrVtskP+o9Cm/0P
	aEZoYshCLEm86r61VY5KcFJbaNpoNqq0M3WTWwShvJyz3K8Ybyxf7wixCLsiYMWel5g=
X-Gm-Gg: AR+sD136DeqDIAaBo6osN2Iqo6dnHKLZqmU0Z48JodnZBtUuHv0j/pvs+h5Gn+zbmlD
	lASWXxeOZnyX/SmRmZ0rImvQbD8qjzj62k2fA597A5O1c6bxKW+kySoyC5U2tDN7mlF9OmMKYNu
	Lb23uVt2abAvIeVyftabR/gdy0B1FYDuGEAR4IeZ29PBjbOsvJe0ghW3HTpITNu9PV0A3pYTW7s
	oKVjsVyDLabUuO7/L5w9xA4XBN8jYooGZ4BX7rXgKDjQusvNJix22mFIfxgd0ZMejBro2padWoE
	rSpxicmHpdA/XwFx+bs26WUJBf3ZDKBZAxJ8hd2nj+hg6ygDLTNG/Iw+2x2V6u1qh+Y12zzhTI8
	QDIJ7Jaai4CWOi0yCIuGDzq7cM2xkwVgpASkmuxszeDdgfe8btsN2ZIx5Xb7m36RbOSOAPUTppl
	c54Kl8vpAwI/RJnfBunYQ1Go5sM2IVR6JKWj75+EYy5iOtzWo58Q37s7dJCqzC/UmBXqyza4kRR
	eqD0+dNZKDwMGEUtQIPAb5sazaDLYTH68YOZXZq7g==
X-Received: by 2002:a05:6000:1446:b0:47f:e770:13e0 with SMTP id ffacd0b85a97d-48130e9bbf5mr25653333f8f.7.1786373561057;
        Mon, 10 Aug 2026 07:52:41 -0700 (PDT)
Received: from [192.168.178.55] (h082218129081.host.wavenet.at. [82.218.129.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480021f8b9bsm41742190f8f.25.2026.08.10.07.52.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2026 07:52:40 -0700 (PDT)
Message-ID: <bcca87bc-ec44-4d6b-bcbf-93343e582123@linbit.com>
Date: Mon, 10 Aug 2026 16:52:39 +0200
Precedence: bulk
X-Mailing-List: drbd-dev@lists.linux.dev
List-Id: <drbd-dev.lists.linux.dev>
List-Subscribe: <mailto:drbd-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:drbd-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drbd: increase maximum CPU mask size
To: Ionut Nechita <ionut.nechita@windriver.com>, Jens Axboe <axboe@kernel.dk>
Cc: Philipp Reisner <philipp.reisner@linbit.com>,
 Lars Ellenberg <lars.ellenberg@linbit.com>,
 Joel Colledge <joel.colledge@linbit.com>, drbd-dev@lists.linux.dev,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260802110552.50757-1-ionut.nechita@windriver.com>
 <20260802110552.50757-3-ionut.nechita@windriver.com>
From: =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Content-Language: en-US
In-Reply-To: <20260802110552.50757-3-ionut.nechita@windriver.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



Am 02.08.26 um 13:05 schrieb Ionut Nechita:
> The cpu-mask resource option is limited to DRBD_CPU_MASK_SIZE - 1, i.e.
> 31 characters. bitmap_parse() reads the string as comma separated chunks
> of up to eight hex digits, each describing 32 bits, so 31 characters
> describe at most 112 CPUs. A full mask cannot be expressed on anything
> larger, which by now includes most two-socket machines.
> 
> Sparse masks can still reach higher CPU numbers by padding with zero
> chunks - "8,0,0,0" selects CPU 99 - but that only helps when few bits
> are set.
> 
> Userspace has already moved on. drbd-utils carries its own copy of these
> headers, where DRBD_CPU_MASK_SIZE has been 256 since 2023 ("drbd:
> increase maximum CPU mask size" by Joel Colledge, in LINBIT's
> drbd-headers repository). A drbdsetup built against those headers is
> rejected with -ERANGE by validate_nla() as soon as the mask does not fit
> in the 31 characters this driver accepts.
> 
> Raise the limit to match userspace. 255 characters allow a full mask for
> 908 CPUs: a leading chunk of three hex digits followed by 28 chunks of
> eight.
> 
> The cpu_mask member of struct res_opts grows accordingly. Two instances
> live on the stack, in drbd_adm_resource_opts() and in
> drbd_adm_new_resource(), which is uncritical at this size.
> 
> This only relaxes an upper bound, so an old drbdsetup keeps working
> against a kernel with this change, and a new drbdsetup keeps working
> against a kernel without it as long as the mask string still fits in the
> old limit.
> 
> The new size will likely be too small again eventually. Describing the
> mask with bitmap_parselist() would avoid that, but the list and hex
> formats are ambiguous for the same input - "8" means CPU 3 in one and
> CPU 8 in the other - so it would have to be a separate attribute rather
> than a reinterpretation of this one.
> 
> Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
Thanks, this also looks correct.
Just one nit: in the commit message, you reference
drbd_adm_resource_opts and drbd_adm_new_resource; these have been
renamed to drbd_nl_resource_opts_doit and drbd_nl_new_resource_doit,
respectively, in the recent netlink refactoring commit.

But for the code itself:

Reviewed-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>

-- 
Christoph Böhmwalder
LINBIT | Keeping the Digital World Running
DRBD HA —  Disaster Recovery — Software defined Storage

