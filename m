Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D113649E5FC
	for <drbd-dev@lists.linux.dev>; Tue,  6 Oct 2026 16:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791302637; cv=none; b=SSfMdBhlhQV/bXaQCBXN0KFirkMhziscANX0A7BVXrwimnpjyMRIa+K5+EtuNVLBM07pJma8UBWdJBqxenBYHFrWPEvxLv/25UVKU/V4drChEy+ou11aM5+lftl05/VB65c1Vx+cZhv19N7AuBMOyuQJhpNHBygy5LrbIO0MvuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791302637; c=relaxed/simple;
	bh=ejBJ34A0WaeKhICYz9jB7191YUYJRJJt9TTi/tvbCNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QhdJWvdkkpnCqECGLC8PhabCZ4mCH7XUABZNGLmoemFcFeiDeYkg/UyXQaf+kAE4/ZszX26BiLLWFO0X34GhLbRjq+zcNvXrc+ez77YpiCK5YuSm5fo3CEy0BfVDDPcEpPDj7Gvn3mb4cDzv1BKE+cn6XDjLouM+HuAUwMxlvB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit.com header.i=@linbit.com header.b=E9N7k5hi; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit.com header.i=@linbit.com header.b="E9N7k5hi"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-486e70f2457so1415998f8f.2
        for <drbd-dev@lists.linux.dev>; Tue, 06 Oct 2026 09:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit.com; s=google; t=1791302634; x=1791907434; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vH6paKGTpK+wu4U0x6N7KJfQorX+loOh90vjv3Up694=;
        b=E9N7k5hiPFabFvNRvlNA3TQCNc/IS2ruteV8blUmum7Ajvh3ghKH0ryz/1ELuwjrml
         OID+0CmAw5bu1NC+s9OrR0BRdv01e/3ccT9vaVUZUHfcfEy8WwZoi4rdcEjWw6DIyrHt
         NDT3NSkc5OzwRuX0VxSCFh6P6IrnhpZMJFuiFNiVWI3xLcVGp0H3wt19d9tCOx18Gfib
         GBlsbcIIfUm4H0kl6Spxjxa7GgXIVH5lb6uBziMlDUiX4drONnNfZGl/h3SQgbjZH9UG
         J9HESLn7enkrFyv97k46ksjl3kS5W9h7Zrl1VjFCf3xuvbDMvL28RsdmBIWbBVsDAhlZ
         MEHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791302634; x=1791907434;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vH6paKGTpK+wu4U0x6N7KJfQorX+loOh90vjv3Up694=;
        b=iL/4RCcHDevcEO3bwn7aLuOk2NR1EGGvE23wyP21/yMsyF6E3EaER8TOsnJsBh7+zu
         h729/TvOtF5LTcec0E/gddt7F7uNGbOby7pPDpZoTFCCcEg+X0jwoXkDq20CoWL+AEgA
         zeS/TqTBzzHOXx+0FF2GhGkaa0uKyUeRg/BMNeSytCeENAclif3UQWGhxroFfmABidgE
         Jzz9ACQL4B6jBPXIaZQSuVMfTEvI8mHl2NKn4mCzHcX5oOkhtTz76s+fns7cOUcDE7FQ
         KcrsgR3eHd7ToPFvPi5ZFm2lSBwNiuCbAsKwc0VhXxMHm718UluEzBcdRiXQ1r+3oeDv
         21kA==
X-Forwarded-Encrypted: i=1; AKwUvBx/umt/UfdfLKOikORX0XAafkNEUWz6uup/q4Fg3SROxDx4zEfd3FGjUbMvSvrkWBvxoM/2R1JFTg==@lists.linux.dev
X-Gm-Message-State: AFq9FYJ72EQdYDQOD6Oj0C3aBFYqLsmAbYEV/Oz1RmucYbwsOJtzWTIq
	OaHbZFQyAzAOWmaab/G2fCD2yr3hdC5yyUJ2YUAC7X7mAtSuLhi8H3UYY4Ku4W87kK0=
X-Gm-Gg: AYBFou23in50cL4WbG0vrHQBlDYcp3wZciwz049i0n26+Bv0lwtNiJb7233fMcAbH7H
	eI/V7YZ3q+7NbE/ktm44FGTsOxciyGbAVBkDPCphQ9LuGrYyuXXT5+6w3ou6Tc1Lf7RN8+3tKq7
	alm8UFr5x1RhIBeEoxRu6PAlT8dbIcB3H4uvzJoiq8SrdSMADrMXARI9moeVMn2w26EEM35YPD8
	HL//6u51c3e6k+igFy4MDILiMLNqz8N/6m6yhQAA18HfFgVtXMtIWxNEMuFJ+3bX2BRbT/0+Y78
	fiZE5EFhEWrenEYdLyl1zlcWTbdp6uhNVuIBTBNcFUjj7UYaPMAPtybC5qEPhkYq+5EViyRK62B
	lOZj4YbyFBQCEHeH3GVvvsRhrX7NHi5dktmf/DKqv6ZwA6T2LD+2blvIxs0QBkYYSAqfJkCNUfm
	ywlIHCeIbcqrkOdjL9T5URWYuGmj3OPS41Z5iis9ZigQRQYXTZGV0b9v2YFdJAFWESXHzrD8cSO
	p2uw/jipDcGUm3AjMCiDLNsW4mmaB4DpfLkkPFbpMdUDDJ7aDI7Tq1/W8wCxEL3Vw==
X-Received: by 2002:a05:6000:4313:b0:48a:fbd2:c2b6 with SMTP id ffacd0b85a97d-48c4801c363mr19266196f8f.55.1791302632870;
        Tue, 06 Oct 2026 09:03:52 -0700 (PDT)
Received: from ?IPV6:2001:4bc9:b00f:d376:7c33:9a50:ef33:f391? ([2001:4bc9:b00f:d376:7c33:9a50:ef33:f391])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c71d2e2e9sm364931f8f.46.2026.10.06.09.03.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Oct 2026 09:03:52 -0700 (PDT)
Message-ID: <0d3a8391-0de9-4b9f-b14a-9d4f33d2e7fd@linbit.com>
Date: Tue, 6 Oct 2026 18:03:50 +0200
Precedence: bulk
X-Mailing-List: drbd-dev@lists.linux.dev
List-Id: <drbd-dev.lists.linux.dev>
List-Subscribe: <mailto:drbd-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:drbd-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/20] drbd: add DAX/PMEM support for metadata access
To: Jens Axboe <axboe@kernel.dk>
Cc: Philipp Reisner <philipp.reisner@linbit.com>,
 Lars Ellenberg <lars@linbit.com>, drbd-dev@lists.linux.dev,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dan Williams <djbw@kernel.org>, Vishal Verma <vishal.l.verma@intel.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>, nvdimm@lists.linux.dev
References: <20261006154607.3936501-1-christoph.boehmwalder@linbit.com>
 <20261006154607.3936501-7-christoph.boehmwalder@linbit.com>
Content-Language: en-US
From: =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
In-Reply-To: <20261006154607.3936501-7-christoph.boehmwalder@linbit.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/6/26 17:45, Christoph Böhmwalder wrote:
> When DRBD's metadata device resides on persistent memory (PMEM/NVDIMM),
> accessing it by reading and writing full blocks is unnecessarily
> costly.
> Add a DAX-based metadata path that directly maps the metadata region,
> enabling byte-granular, IRQ-safe access without having to go through
> the block layer.
> 
> The PMEM path also introduces a more efficient activity log layout:
> instead of writing journal transactions, the in-memory LRU-cache hash
> table is stored directly in persistent memory and updated in-place.
> Similarly, the resync bitmap is accessed directly from PMEM rather than
> being loaded into and flushed from DRAM.
> 
> This is compiled in only when CONFIG_DEV_DAX_PMEM is enabled.
> 
> Co-developed-by: Philipp Reisner <philipp.reisner@linbit.com>
> Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
> Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
> ---
>   drivers/block/drbd/Makefile        |   1 +
>   drivers/block/drbd/drbd_dax_pmem.c | 172 +++++++++++++++++++++++++++++
>   drivers/block/drbd/drbd_dax_pmem.h |  43 ++++++++
>   3 files changed, 216 insertions(+)
>   create mode 100644 drivers/block/drbd/drbd_dax_pmem.c
>   create mode 100644 drivers/block/drbd/drbd_dax_pmem.h

Sorry, the CCs for DAX got dropped, adding them now. Original link:
https://lore.kernel.org/linux-block/20261006154607.3936501-7-christoph.boehmwalder@linbit.com/
