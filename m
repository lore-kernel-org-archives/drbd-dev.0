Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793973055;
	b=N648dB9wg+2/75nC1I32J8TnxoJlJXzp4D/WkddXu9ONt5mYuAea/RPJU8BmUZrZ2Kez
	 ic2vyhc0pcRcyx86tJegJKXyIwhuhtPwyATLSbFr/kmD/KNcSNeqGFfGuSZkV/FiH2zbU
	 hUrejo6X94WbhnusIgSoU9ulwXaRtewl3K1HUXvRWR31m5LFDsdAPpmXvKKL0rA/JElL5
	 XlGOvKcSM0NEQX4eLMpHfebRAw8Y3yLHX96r7PTDdYcBu0/QyCaL6W9mG/T1kgVYpTSLS
	 msLp51ZxqSKPJVLM/GolJ0tNISn4UkCisCdyWgMbGS/nJRr2EoAfLW+LjVuJdORrOLw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793973055;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=oQ2Oy2vE4Y+KSIGzjxEVBp2pts3FTmVlEXlZ7nc293g=;
	b=aKzJgpZsAWrDpoFjESj1CAdkO6Xr0bZl74swheQds3hXJwopE+hqVVRyDrCW3+jXR3V9
	 TZ1rfqOTVpvtSuh6R30TX/mxJCSxrpufmpBQNay4IYUA8FXy8IeXDNQJy1hawqioMrEuo
	 8QRMpMY1+X00JMrQSkCpuSUzGVnmYDxB774QJeVbGndq/BIbQq7wA8zBhzOHX/KedG3HR
	 7DMZD22R05X3rBgkeg+CLPQrmvuo/plHNNZJ2QAsHMZ2RY24ghH+E2uF3kHiMa/LaZpTK
	 ELRuF+V595V6ylNDBE3JjCgL53hzWINQXEp4/NHtKkEVVbNnYeluNHpH85Mr2N0JN4w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linbit.com;
	spf=pass smtp.mailfrom=linbit.com;
	dkim=pass header.d=linbit.com header.i=@linbit.com header.a=rsa-sha256 header.s=google header.b=qrKYcMO5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.49
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9899D606A329
	for <drbd-dev@lists.linux.dev>; Fri,  6 Nov 2026 13:50:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9899D606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linbit.com header.i=@linbit.com header.a=rsa-sha256 header.s=google header.b=qrKYcMO5
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6b5669a5100so835410a12.1
        for <drbd-dev@lists.linux.dev>; Fri, 06 Nov 2026 05:50:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793973053; cv=none;
        d=google.com; s=arc-20260327;
        b=rfoVLr4cnb/6QYAuzAemlxjOYTwb6tDe7zacMV5qhj9GM2hQQFxuTLJf0H0MHBrXQk
         L8YL3iNVLAhc5blztWe8P01Nwr8AHU8af4BPpxZxJrKx2O6N7GfSd1wNHwfFkXCA4YX7
         FQz/550cdkSeuDlE/y8GHLsCTDHIxqZSdfdNaRSzXSpxgPtvfl8GUfM6gg9inZDvjMCW
         Ydn3C60kTLe3KyxUa+rWBmCjpN0CLGzYeK/zM1Zkc3W7XghMtOd9GsEXdiC6UlAojkdb
         H4lOijq7h5mlyslCAA5KuYiqjM3Hu9207LcYS5jVJx18kKAHo6xkWXkYaGN/70FLbG/m
         r9/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=oQ2Oy2vE4Y+KSIGzjxEVBp2pts3FTmVlEXlZ7nc293g=;
        fh=0ji70OvZOw2q6ZEKVsL0sAJAuUsESQYqDpYDFnyl6zA=;
        b=jk703yt9q7Z1vucfda4qYbjL6769f+5cCViVWF9FrwLCE0Srv6BdI9TICwbnpKRoT/
         8XlP/TdHcK6BagQes7i2NJXaXRUFgiLwf7cW71UUsWv+mcVK5U12eIBjXobIO8hZJg+O
         pXn3NTkk1Be3Xdt8di6kxulpAGyHprjSQWAAgaCXlRAQz9Pk8lT+dr0yxl6Frr+BLTZt
         P3XSIEBORvN7BRsf8w74A0gT3fKdMjSN2Xtyc9gxlFInsJxZv0/YHhz1wvpgs+b6SysE
         DtzYTVXsXEFjdJktQ/CPDLVCDY/WJ08VIOTGg/ZYdysnbK3EGv3KXNQMCYAC3ZbDj7Kv
         zBaQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit.com; s=google; t=1793973053; x=1794577853; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oQ2Oy2vE4Y+KSIGzjxEVBp2pts3FTmVlEXlZ7nc293g=;
        b=qrKYcMO5dKwWRKnJ76obZv4OXw8wMn08s2mOzh/MITrdKTV1CZjrR7ugvF+IpvcXNJ
         0aLRp25aeIbA0dUCOjabXDV9/jCVQP1qjWjzi7CyqcQab9rR2BI6vt207ttugjZdoYVz
         Ldwimmpyc8yKSE21bRwfRGpM4C5qN/VhDERkluaDZ2WnJIK5H/+vo42CZ2RR5bP9kWZN
         gTAnGZed5OfnIYdGVhN+eW84WrIJDQzsKr+/Srgp1Y65bbPPx+gVhsLWiXk2gU79EC3J
         l4NDghEfPdM7WmmYuwBge3pYhh1z20pF4hOAtuWrbR+RVwO9o+d6QrxiwDeFraI6gSvn
         GwtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793973053; x=1794577853;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=oQ2Oy2vE4Y+KSIGzjxEVBp2pts3FTmVlEXlZ7nc293g=;
        b=M4fJCZFptUYBGRm2nR6geMExbU3+zr/xfWfyxA6hMDdlA+4isBS5CJPOGYkIxlhN28
         p+7mYxdwLlOMA1nf458KxpRs9rHuvHHf8hbaM/dCYoe3GhTT1fElCh99n4YVgY427hmc
         Dhq4l3/J7+xASQ+9OBmc+x3QNZ+GFZIRtVRvfssnuMZejDZ5d24iCqLwh2jneUXIT3XZ
         lmaAIfDZ8AZ+WH+IIUqdfoDCA54I4VnGEpq+Yff0A3hQBDMNbLvOX4fpRAh7brYsibJr
         TiN8ytp1iL54vi6LoCQ2y9DEBuQJGE9bVq7X33aUDI8zm3GaF6VdiX6iweC1Et5uiwOd
         6j7Q==
X-Gm-Message-State: APuU4Z/OeRzgloCRzq5hSIcmr7w/qB7LDuFWIUFhcKdIYaXIT6yVYZaU
	3WpjqqRnzutcLWjbPN4ma0JXRfIYd9xTOYPz4PRgChfuVfi7KAcTBMNF12v+xTGzCexvbqCsIcr
	wOir4tuzURVEfQYtRCsa25baHzHWBuHVZ3WThzpSwkbfTu5FugegrL54=
X-Gm-Gg: AYBFou3056z9/8LmgKtDwUTeg4o7GwIb8k0ezEkaqzczfNaKFQUafYnHZC2Qvio2z6z
	dEbXkThjq2X4/VGS4S2qVWFtgygp3nktga+KVMX7fH7UAle/xvMpOuk94IsWHqP8IhL1glkEGYT
	oh9R4v2eF/UM4X/CdQT7ZTJK6nijCTE8wCDrrVJGtq0qk6xU04gR9TgCXXF6zE9g5f7zHkAaVpz
	7O4gCTpQ1R+z6nFMQ8dRoa8rc1NliCJeaTtx2+vv6bpA622u+g+G6MM3vwIMsbkyRYlclDR9Hcs
	3rsEa7UyFlvBWE0xHhH9nA9SXWHfSy2uDlrU3cz/pgb2qI0iO1ep5din1oyOE6h1A2wirwur/uF
	6XQkWX6SgKlcP8TNyUvhUpqXHnCpaoPFL1OuwIA==
X-Received: by 2002:a05:6402:138c:b0:6b1:ba86:5f48 with SMTP id
 4fb4d7f45d1cf-6b597a33afamr1184843a12.36.1793973052949; Fri, 06 Nov 2026
 05:50:52 -0800 (PST)
X-Mailing-List: drbd-dev@lists.linux.dev
List-Id: <drbd-dev.lists.linux.dev>
List-Post: <mailto:drbd-dev@lists.linux.dev>
List-Help: <mailto:drbd-dev+help@lists.linux.dev>
List-Subscribe: <mailto:drbd-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:drbd-dev+unsubscribe@lists.linux.dev>
List-Owner: <mailto:drbd-dev+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261105025454.2444754-1-zhengbing.huang@easystack.cn>
In-Reply-To: <20261105025454.2444754-1-zhengbing.huang@easystack.cn>
From: Philipp Reisner <philipp.reisner@linbit.com>
Date: Fri, 6 Nov 2026 14:50:41 +0100
X-Gm-Features: AclHuK-ztDv57lYFndZc2KmzPb_LXhzAYhED9DBC-7fVQ-xdYDGfAe0pVARTfRY
Message-ID: <CADGDV=Wa+ANi=zdSzv_Pf9GbBEyaVsET=BDrF2RJvpRrvQJpJQ@mail.gmail.com>
Subject: Re: [PATCH] drbd: rdma/rdma2: fix control timer use-after-free on teardown
To: "zhengbing.huang" <zhengbing.huang@easystack.cn>
Cc: drbd-dev@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Thanks, applied.
