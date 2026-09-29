Received: from mail-qv2-f43.google.com (mail-qv2-f43.google.com [74.125.230.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AEE13A48E4
	for <drbd-dev@lists.linux.dev>; Tue, 29 Sep 2026 07:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790667062; cv=pass; b=kIldUS2bmmOOSqSFX7PNVmfZ0KuBIn5YzEGyjp+BNJWehq2jRtxAErdCbI7kpYoGJk/MNFVceSraG83A98hbK34ms0OjbAXZlGwJo5mG6PQhik/SCtgpC58yOlViSTEgopj/OHxkVD/4Kf3YgiN8qcJyAFuoY8wBj6ENl/tAfDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790667062; c=relaxed/simple;
	bh=I35gDNGA4fpIsc0ElTO4/D3swmmdD1nD0eRHXQrQQRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IdCLs9cXEv+UzgA2SgFG+36xpBTTnF6/P1hSb5ADKENo2vAmySKGTCa9IWbaLIscaZ/YzQWytnZCSPCGLnhrluxQr8pNU13tFbmOCdAJquG4KrUO1+LVinvAfN8tGgTTDQ1gD53m8hx7sxWhLccW9Gh53yZbK2WNAdPLuDuR8hA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pdTuAoE3; arc=pass smtp.client-ip=74.125.230.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pdTuAoE3"
Received: by mail-qv2-f43.google.com with SMTP id 6a1803df08f44-91434eba587so38935706d6.3
        for <drbd-dev@lists.linux.dev>; Tue, 29 Sep 2026 00:30:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790667059; cv=none;
        d=google.com; s=arc-20260327;
        b=mJOarBA1WQtjcw7JnB+GbkU9GZOhklRtraegnW3oVOGeDt8JTXXa0abips1p7WO/uc
         9img6c0UiMWXLF+lJySGYc38M1aqD2DBJk/ow1SIh4Z1GvVS+auL+jziQdnC7p9Oucqh
         HWJGHZirX9Iowo6FedK0Mg9+piMGpe7PXIWaIMiQ+Tv8LxZ0THrymbbhM3fsuz1uVUQH
         GS3U3w/9y4M9j7S2nPFAd/FyZ8el2NGfg5wvy/3vmAQAtqMKq5kPFjDzVQX0fF7SN5Pu
         8cxf7jk+BndikiLQBvF2d75F3MGdprL0CM2NGNdEJ/KDK73JfzLmyWiBWZMjiW73g1O/
         ldmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9v/Z0GcKezXBRqzYvyQ4v0b98G06dRHjg36qbCp+fss=;
        fh=qMoL0LPammD5HOVVnhafyAFVV38JPUZ6rolD3miJHHc=;
        b=bwZ7cLAKuqkHY2HHthOdIKgXRpFxDhgiHBLziF5F3Eypax2Jp/wa7JdeMnwzMGhlzm
         ByWKe/WVPDLWn/nwV6rDczukwxw5jLCrcZw0zpybBBe2iPEmfTxHkXCuRMg9tbRjFFZq
         qzRP1FPV/ym6HoeO3kUFYwB/IO6ZGivEvhFvwe3/Yt4DaFH7lNRWlnbC8FcajaO8R+1y
         NfKidUYt7mayxG0czy6iTnsU46eLLHY92Yb2v40yhk4PPV3bJSGjihYVQ4nUwPxaD40O
         l6JaJt5K+QRsJNi3W3zIPBH0FwEGCknPMcqTpouHDqgC8uspX0SuyDCvRKeUatfYhdWG
         kB4g==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790667059; x=1791271859; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9v/Z0GcKezXBRqzYvyQ4v0b98G06dRHjg36qbCp+fss=;
        b=pdTuAoE3TBwXW3sfvj8C82vM5pqQuiIimdCNzsV2silb+tvySOMcffTVKxyVyESx+v
         W1UUxlCkv1pvluoTgvrCgaCS0CLifQuMnMY+72pIs/lYQdNFocOVHVPEW1h/GAWGHOQ4
         cDJ3quvWjAOJYFwN8s0r8bGALYwnWb7TtYKN8Vg7GFu6VFT2MCEx7bUS/vZNHXjCH7jA
         UR+HQCmdbi1TYZcZq+Awn3+vdreDD0fAdebBxJ+aVgUfMkhxT7NIV5jndDcWLz24CnPA
         Gdz4PIUDayzeAs5S6g9leK6HbxOqnp1WwVznXegWUO2iohZliy+CV/3bA1qWh/A5qH/8
         9IAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790667059; x=1791271859;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9v/Z0GcKezXBRqzYvyQ4v0b98G06dRHjg36qbCp+fss=;
        b=zj04Sy2jjPFq6iXw/KKRapevSFvc0aOdhMcHkLVl8a0XPURi4KNPHwbcWOmLe083an
         Jzbd9T852doAls8glkudg28zn9k+kXr6D6FofUJqHF8ksCGB2HhWROwd2EEvVj5fo4LT
         JfsariWnF4se45fEVrESv0tspuNebVEOmndZkyMApSJ71txQoUstIVAaP1ZawEdU8rUF
         WIoljpVPEwcYSGKt9bftzlJUCbbD8MnRT2t2R1aHpO/4X5GcGV440EEUH1bELjSto7I8
         UjcjB/Jxm6GYIMfEiHkR+FHigaW/YJ/LRx7PBi9VYFjkQ7Jrdyvl4+2Ww9vzIg3F/T5n
         CE+Q==
X-Forwarded-Encrypted: i=1; AKwUvBwMrzCOC/6+e4y7E1ruoPTIHiw5jxxXXfI9qrcRqTnw7XovgQ6uvrUZtb/+PBR862cghdhf/PoJlQ==@lists.linux.dev
X-Gm-Message-State: AFuF++npq64S5/Yg7xRCs0PKfgw2Q07zcgaV6CJhjWqbecv5idQ+3Dul
	ZagzYD6B5ALBdzfgMjYYNd6k/ZEdwwQ4UKwlycgG52/62ChfALMsoUM4oHd9dWRsaxtjZ2Y9G/i
	1CpVrC8/4mccnh4aLkI37jU6qvWJCUF45g5Ilfuyq
X-Gm-Gg: AYBFou1dxTHEwzxppztksECi3QytfhouWSucJ4/VTYK7wedpdKEjErrE8PuXOZSeT+e
	361u6TFvkX/1uEysLRR14PEhSbZ9ZPGv8B28xqVFixGYvv7lgBf3DO49iBYQ07x7Z9tz4b2hIyp
	PciIRFc3oSd1Q/fKT739+jbAm2fURf9QWakE/XTDNAzsrU+5wqKgU+HHqXHxJmjn/emfmTlEsM5
	zzf5OOyicx3aCwvpSSbqfVjK51ahF++wdSSm+V1xsrYhljT1Us9l4J67xpVXFfBGRN6tG20Bufi
	S1kPGnRg4l3FLVg4aXMmDcn/X1rk40QpAq0gZtEsjxDIztpJv1UmZXGtbghl+aBpqbz7xlr0DsV
	IlNPRpy1U14Ydh48xnlG3eONSIBIoBgAyE6TJ9Wd/WrRWlIOrtUgXxxLpjmqLXsGOoQIu
X-Received: by 2002:a05:622a:580a:b0:532:d3c2:165c with SMTP id
 d75a77b69052e-5330dbe7682mr252226541cf.5.1790667058017; Tue, 29 Sep 2026
 00:30:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: drbd-dev@lists.linux.dev
List-Id: <drbd-dev.lists.linux.dev>
List-Subscribe: <mailto:drbd-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:drbd-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260929071743.23624-1-edumazet@kernel.org> <179066667444.31693.3326934466907750947@kernel.org>
In-Reply-To: <179066667444.31693.3326934466907750947@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 29 Sep 2026 09:30:46 +0200
X-Gm-Features: AclHuK9CAnCUx8smImHilXsTcocuUN-fbbX48CMDJnYU9QbhFatMhZFb2tpvc_0
Message-ID: <CANn89iLUKHZVrUOEtqDwuAghCRAkddigPwSWj4uS=fKyWdk86g@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 0/9] tcp: avoid struct socket cache line miss
 in tcp_check_space()
To: netdev-bot+sinfo@kernel.org
Cc: Eric Dumazet <edumazet@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	Alexander Aring <aahringo@redhat.com>, David Teigland <teigland@redhat.com>, gfs2@lists.linux.dev, 
	John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Sabrina Dubroca <sd@queasysnail.net>, Jiayuan Chen <jiayuan.chen@linux.dev>, 
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev, 
	Wen Gu <guwen@linux.alibaba.com>, Dust Li <dust.li@linux.alibaba.com>, 
	"D. Wythe" <alibuda@linux.alibaba.com>, Chuck Lever <cel@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
	Allison Henderson <achender@kernel.org>, rds-devel@oss.oracle.com, 
	Philipp Reisner <philipp.reisner@linbit.com>, Lars Ellenberg <lars.ellenberg@linbit.com>, 
	=?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>, 
	Jens Axboe <axboe@kernel.dk>, drbd-dev@lists.linux.dev, Keith Busch <kbusch@kernel.org>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, 
	linux-nvme@lists.infradead.org, Ilya Dryomov <idryomov@gmail.com>, 
	Alex Markuze <amarkuze@redhat.com>, Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2026 at 9:24=E2=80=AFAM <netdev-bot+sinfo@kernel.org> wrote=
:
>
> Hi!
>
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.
>

Patch 1/9 fixes a bug found by code inspection.

Other patches are not bug fixes.

> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.
