Received: from mail-ej2-f37.google.com (mail-ej2-f37.google.com [74.125.228.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE74529410
	for <drbd-dev@lists.linux.dev>; Tue, 29 Sep 2026 13:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790688972; cv=none; b=S17+YnAKTQkLrC7Vucaa3m7zpM9TvWyhHm+AoeIBzbijK/kdfoQKRZoR6RhYgghAWRtVIyffChUvBkKHCGhz2/3GP4vDGvc4KMW5FZk0NnWK4/boaENsH7OE66Dni+u7cDUJsUIs7/7I3o3NTfaX9XDZuR1X1igpctkbmBoSkws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790688972; c=relaxed/simple;
	bh=MALsIQkWBc8oYjqtYr61DybGua6MQV6D+0TTQi5Zuik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fGo3+39En2lFECd2sEdj+KyyjqFtWRFkawPVsnUmVeqkRI8Kqg6CP30Ky49Pht/qh7OmgjiAcW70qG4uh2vYwqdWV0A0TRV8UxKe+YECZEM9Xv6jy1VozLbndGTgINFFEKsAc6HOG87mQW9VHHspAHbuMt1tcEvp65kZMQ0gy7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b=aH2dAAAa; arc=none smtp.client-ip=74.125.228.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b="aH2dAAAa"
Received: by mail-ej2-f37.google.com with SMTP id a640c23a62f3a-c2dbbf409b8so418587366b.3
        for <drbd-dev@lists.linux.dev>; Tue, 29 Sep 2026 06:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20251104.gappssmtp.com; s=20251104; t=1790688969; x=1791293769; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+tOBR8m32zYZZOoraKtqO3ebIcizY6A4dWIJE00zfvo=;
        b=aH2dAAAakxtdNp6MHdtsYUB9IM8Z5OFRRL5NOx9Q1nDAGLke1fxKkCplPq13eVOreu
         qdZCmS08LlWJ+hrmqBkPFVT2vyAwHipNZzYqWlbjb01BRf8t7cDgf18G9sQxA/UzEPnA
         v3IJbirGRwh2Qsa/hfNgV/HSJscjANcbkGP3G4zf0YRoao+OHQeofTQwYcFaEJMADNDw
         ZG3k5yF1RbfFZX7uHXFy3IIVohJDNy9LMc9Nj7wa4tDXf9FefIKH5xioXim2Qi2hPoz3
         mGBp36zDEcKrtH3V4W1BFj/O7M3LGmQDylk0LR8CcKDQrwXApfT5g5BfdGmQiWVnP5jY
         VsKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790688969; x=1791293769;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+tOBR8m32zYZZOoraKtqO3ebIcizY6A4dWIJE00zfvo=;
        b=HBME/5quQ1HIyFfXTJ0HHg94tWYkaeGuFXx/2puG8uaFGlSl1K4Wg3ueTIZOdke+QD
         qi1Cp3QFQ0yhqVzDBLWzVNGRYpp4LIchEDKACSAhnmHkPYlcixVwWmr5eBxceoVbTxeo
         9ROfP8GZcbHk52M5BCtntkCKSTKOPbbH49AA2inPlNix2utgE4tkVSP4BlAKejTlQreG
         G9lFzp5QVFhUPaLIxpDnq31LVa5/Ax4YABoFg77xvF0FUGOpCcOTGW5QuiT2zzPcncyk
         mZGIk1zYupN++cqOjlNzwFYP501i2usW4o4QDdtGprXJqC0JCrysxbsPh+YDzLVQqax8
         erEw==
X-Forwarded-Encrypted: i=1; AKwUvByl24CNnhtqaXGhrEkN4ZlPcQ8uyBzPV8X4GMmUA1ZxhkeLyLj0amU+55MxfqwlUIQYyof/qrQttw==@lists.linux.dev
X-Gm-Message-State: AFuF++mjYXArN6OU+dhGnGNLnwHBrbj8I/+evcuQ/YZJAmjmpCEYP7JF
	pikPImR9Y6lNKsa8OoDGZxKd4g6e9P6wMwu5QMWddG7RkxDfsz0F8TPFBH24VtXmK0w=
X-Gm-Gg: AYBFou1YkSvqiSYhLeBcgY13u5yRuZ5Ejq20nZLuoq34BQrYjsU7Bf/OVCm9OsuEQRy
	VNzhwxeX9vGCwu4jBoByfE0bKWbJcgiw6RAMCkz32WlpBYhf7Sm1v5fXBR8c8VugYQaH06T0ibm
	cVuGRh1E6AwyIFTwOGLXVYNhonfdv2oMf9Gz1Pj+noYrT0ZJXkJ/0MSLd5XVEvj5FIiD907Rvxx
	vKGOx2QPAu5kb2XHBezIQka5MDxwWpvfhjC5ll9noRHqVPZEsFJkCA62Pmb3RjB+o9L8wKMJuNZ
	jM5Gjyk6HwGx6lX4MZceqcfHrPg7tJrMUPdPGdTVcJ3X8rLBNtKWOW1Cp1DAH8x0iCV8v2Q22LS
	gZdGvavrvkRuiTrRK6s4iFafTjzXQsgKw7eQk3ykPGmN7RTh4lp9MiDeHDkCaIajk4fBzVSJZJ0
	ItIVUQVvf+gopxDNZK7gw4KeUtwf/PDXL70dK4F3E8qIEHiuzx8c3I3v/WF82AksBCkff12lidS
	7zVSJ1wR+f5SHPkBIbj+10ibEM1xcbztjo19YtEwucHg+LcjmvDVj+XTyzcCdTKvYDHWgGtiA==
X-Received: by 2002:a17:906:6a14:b0:c2d:ca78:ea83 with SMTP id a640c23a62f3a-c2dca78ed66mr642618166b.38.1790688968778;
        Tue, 29 Sep 2026 06:36:08 -0700 (PDT)
Received: from [192.168.40.198] (093111099180.atmpu0044.highway.a1.net. [93.111.99.180])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2df76fad17sm107201466b.60.2026.09.29.06.36.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2026 06:36:08 -0700 (PDT)
Message-ID: <3c683f06-4214-4e0c-b568-a2458fba0cd3@linbit.com>
Date: Tue, 29 Sep 2026 15:36:02 +0200
Precedence: bulk
X-Mailing-List: drbd-dev@lists.linux.dev
List-Id: <drbd-dev.lists.linux.dev>
List-Subscribe: <mailto:drbd-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:drbd-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next 6/9] drbd: use sk_set_nospace()
To: Eric Dumazet <edumazet@kernel.org>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, edumazet@google.com,
 netdev@vger.kernel.org, Alexander Aring <aahringo@redhat.com>,
 David Teigland <teigland@redhat.com>, gfs2@lists.linux.dev,
 John Fastabend <john.fastabend@gmail.com>,
 Jakub Sitnicki <jakub@cloudflare.com>, Sabrina Dubroca <sd@queasysnail.net>,
 Jiayuan Chen <jiayuan.chen@linux.dev>, Matthieu Baerts <matttbe@kernel.org>,
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 mptcp@lists.linux.dev, Wen Gu <guwen@linux.alibaba.com>,
 Dust Li <dust.li@linux.alibaba.com>, "D. Wythe" <alibuda@linux.alibaba.com>,
 Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>,
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>,
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 linux-nfs@vger.kernel.org, Allison Henderson <achender@kernel.org>,
 rds-devel@oss.oracle.com, Philipp Reisner <philipp.reisner@linbit.com>,
 Lars Ellenberg <lars.ellenberg@linbit.com>, Jens Axboe <axboe@kernel.dk>,
 drbd-dev@lists.linux.dev, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
 Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
 Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org
References: <20260929071743.23624-1-edumazet@kernel.org>
 <20260929071743.23624-7-edumazet@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
In-Reply-To: <20260929071743.23624-7-edumazet@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/29/26 09:17, Eric Dumazet wrote:
> Use the new helpers instead of open coding the SOCK_NOSPACE
> manipulation, so that TCP can later maintain a cheaper private
> copy of this bit.
> 
> No functional change intended.
> 
> Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>
> ---
>   drivers/block/drbd/drbd_worker.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
Acked-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
