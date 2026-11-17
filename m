Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794925863;
	b=etlmHgDF3wCtMqGW2wp9dckgQdoRbjUkkt3Yl9BBQSrNBGj5vC6qS53kYMJmv8SBiQRH
	 Nhxbp+ppJ5Vv5FsI2nhnuFrts5R9iiaD6gLCpu+XQTgq9N6xpQFlVQpB+VEUzZgBvhtv5
	 BNj1MFNXuxtw13phHWNBYVgjIXCEFO7vpCeL1UQSh4vwFBeCs6cDDlChwVe3S96DnMNkG
	 GjwwUnI7EpX8dnu8uvUMpFADGTM9snuKeUhK2bQA9e2ALyKudv3dEs7Mwtq7p6lhcx2vW
	 XvSeLyYMOQcLFC4cvHHytHqxzZsv5EzzVjuDaeLK906XaCikix4XAOuw4hDKH4IqQ5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794925863;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:Mail-Followup-To:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=0ph2zl6rwyEKg3O5TgI+UXa3FjOJ6TNy4j3lJzs1fJg=;
	b=tMwLaHRSeQqhBk8ywZhd+V171tA51P5InqiXDWv/UChcggvTZQ47Rn2js3ezu4ico1B+
	 L3aesXhLWFxTYTV4CoQqAFMToTUYh3Z0Nm/wGaLzKIZUpv3MyJjpG1PZz3VcxCKhshvuE
	 hG5Nr5yxkustVKObHtfm4K1ndd5GUHs0zT4/IZL7Hyo341Axf0rJ9Q02/+Y3mof+BWZsS
	 XLIzhUaP5vxxmfHYgI9lxvxaoBK8ZiwTE6iYZw2NrDIvI6HogSIPKIPPi9AqNQVZyUUIh
	 3rL3N9DKXW9pU5Bvnhlm7IXmF/wxY2axLJ/ev3umZWgg9IRp4ft66Yr8yvUlHhrs1iA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linbit.com;
	spf=pass smtp.mailfrom=linbit.com;
	dkim=pass header.d=linbit.com header.i=@linbit.com header.a=rsa-sha256 header.s=google header.b=IIxV05Aj;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9182A606A332
	for <drbd-dev@lists.linux.dev>; Tue, 17 Nov 2026 14:31:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9182A606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit.com header.i=@linbit.com header.a=rsa-sha256 header.s=google header.b=IIxV05Aj
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a2153c8525so31014935e9.3
        for <drbd-dev@lists.linux.dev>; Tue, 17 Nov 2026 06:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit.com; s=google; t=1794925861; x=1795530661; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:mail-followup-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0ph2zl6rwyEKg3O5TgI+UXa3FjOJ6TNy4j3lJzs1fJg=;
        b=IIxV05AjECDBFBifR2itiv/wBy3pfufRiTCDic7E0UlyU5E34nxUXKzbghAwLjWgxJ
         Zt+AiLGPxJpp28i+V/8PRvuXVrwYg8nvLpx2+LZgjl5lf9Dnaziih2HmpCi3szfKrHIc
         RjogBgmNsYmQOeEnbkaRgLaDEfQm/zn065sl4Jw9iMTQIjixvJbEMnMj1+H3PiDadAkp
         uKBGTI4+VhLRcWMwbygSIwk6UxUYz1cDTYT/KR+3YQBuBHrI60kmdbUZj2qfrH5JA4xO
         s5FhAOog2HJIUe7RNjA8LpGDiLUY0bCkzxTJWbWq3vcEj3Ya3o/bW5cKIx9K8L2/sLwh
         e3Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794925861; x=1795530661;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:mail-followup-to:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0ph2zl6rwyEKg3O5TgI+UXa3FjOJ6TNy4j3lJzs1fJg=;
        b=CGsoaxglvO3nA3rSHQDVaH6OKNv3ZMbp+93xYgW+h2niGAWAwOkTrI5LR6mGCQOR2s
         EOZHujQW0EyPLGvDzUOC6QsuBwmsSfFn/yDX7CkGQIbmTe6kD98jcfOaiMPgh5K8eTQP
         6oYiqbMKWu+mIlTalH2Y7Chkaki959hU7latKcyG/ErB+V7e0Lr5yIkk8S6TNnOx+pgR
         +dcKmEmeI4yY+aqOoBGz3/od8mU5cjLNeDVih3uf/kdfrYZC/Q5ePXIR1GgNwg5ylWjm
         PuID9khLbSGcw5e1/9WS9GJmZ3h3eKD0JpsfeCvdqtgr4kQnpbKa7br4fLQNdSvktEZX
         Om6A==
X-Forwarded-Encrypted: i=1; AL+hErEfFP4Nc3spF6jIcf1Hdg3OMJ00VosG6kCNZg1n1MkEYeHY5aPZZ8kC1RRNfCmaF8FSQevKMfPkfg==@lists.linux.dev
X-Gm-Message-State: APuU4Z8oPpkLEFfnE9fpmg0QaWGs4bqJfyIfmiOTTv2rpbTi0+O/qWC5
	CbHbwuL/oN9U4RzzhWm5G6AoghG6ZxB1gwZ36pNyCkKck6U0A1qH1bWXXcFTbk6r8tJl1rCXLww
	rcCiR894=
X-Gm-Gg: AYBFou3Q+nOl0GnwLfMFG6qh0C/RV7CasAqIa4tKHaQiMHDFSAOH30k9SzP+PdY1C2P
	bhPp1+mKsjece4Y6A21mBllyCa1Y4+Q3FFIs1Dwur9oAv6npe1WPaY0bcREPF6H1yJmByQOK2ND
	x9lU9BgL29POU9Vk1WMg2GjSV1B3jHycAELVSMrCp4w3o21+u8IsBzgMri0eOU9nVmx7S1/eXM8
	//wtM31KozQvhLf0WfwYEvtlRfrXKC1tiRPiRY+AIlmyJcVm3cQxXR4RaJLOMBQSwb5Je/EFCHq
	r4Phj6kexCAUjd5rewEThff6BnBxnwNoa+9E0XXH6Ba4NeJ19D8q++TB1oHONFkk4BAnbatY3Nt
	lmABTi4a5OEhsum0Sj8rfkGNzsmAj5DliEhKlQMCb5f9wIMvavUyAXLJl5AgGwYIZ7jQDHKHH4A
	YWmFbcCZqm8PTadodGH7aGwYDWoF7FWGi/0jwYQ9WmzEwWpF9gWB/upXq02s+BWjajELyJK9Zzr
	7cXYSI7vQ9EPlYPe4G4ZwgcaID0LAQVIs8MBjwVn2Y2YUlxcTc0HbYwzDTgTfIgVp9CwK3hMaZY
	ZgT9+ZlYobU4omyCAdmh31gzpPSE9TVh+Nio0f4v0jujIaSgmNpDh1agU4/EQpi6THYmWCvo
X-Received: by 2002:a05:600c:512:b0:4a2:1a:a120 with SMTP id 5b1f17b1804b1-4bb55a5d7bamr222461205e9.6.1794925860901;
        Tue, 17 Nov 2026 06:31:00 -0800 (PST)
Received: from localhost (h082218129081.host.wavenet.at. [82.218.129.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb783e9288sm73541775e9.15.2026.11.17.06.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 06:30:59 -0800 (PST)
Date: Tue, 17 Nov 2026 15:30:58 +0100
From: Christoph =?utf-8?Q?B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, drbd-dev@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>, 
	Philipp Reisner <philipp.reisner@linbit.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH] drbd: select CRYPTO and CRYPTO_HASH
Message-ID: <avxkfIwp5tqxpwoX@linbit.com>
Mail-Followup-To: Eric Biggers <ebiggers@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, drbd-dev@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Lars Ellenberg <lars.ellenberg@linbit.com>, Philipp Reisner <philipp.reisner@linbit.com>, 
	linux-block@vger.kernel.org
References: <20261111083505.3998706-1-christoph.boehmwalder@linbit.com>
 <20261111212245.GB41158@quark>
X-Mailing-List: drbd-dev@lists.linux.dev
List-Id: <drbd-dev.lists.linux.dev>
List-Post: <mailto:drbd-dev@lists.linux.dev>
List-Help: <mailto:drbd-dev+help@lists.linux.dev>
List-Subscribe: <mailto:drbd-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:drbd-dev+unsubscribe@lists.linux.dev>
List-Owner: <mailto:drbd-dev+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261111212245.GB41158@quark>

On Wed, Nov 11, 2026 at 01:22:45PM -0800, Eric Biggers wrote:
>On Wed, Nov 11, 2026 at 09:35:05AM +0100, Christoph Böhmwalder wrote:
>> DRBD uses the shash API for the data integrity, online verify and
>> checksum-based resync algorithms and for peer authentication, but
>> BLK_DEV_DRBD does not select the crypto core. With CRYPTO=n, a kernel
>> with DRBD built in does not link:
>>
>>   ld: drbd_sender.c:(.text+0x137f): undefined reference to `crypto_shash_finup'
>>   ld: drbd_receiver.c:(.text+0x58f): undefined reference to `crypto_alloc_shash'
>>
>> Select CRYPTO and CRYPTO_HASH.
>>
>> Fixes: b411b3637fa7 ("The DRBD driver")
>> Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
>
>Looks fine for now, but you should consider what algorithms DRBD
>actually needs and consider switching to the library APIs for those
>instead of crypto_shash.  Presumably not more than a handful are
>actually used in practice with DRBD, and you don't really need to keep
>"supporting" MD4, Whirlpool, RIPEMD, CMAC-SM4, etc.?
>
>The "pass arbitrary string from userspace to crypto_alloc_*()" strategy
>has been problematic for other kernel features using it.  For one, it
>gives access to algorithms that are obsolete, insecure, redundant or
>make no sense for the use case.  And it makes it more difficult to
>remove unused algorithms from the crypto API, since it makes it harder
>to prove that they are in fact unused.
>
>Note that the crypto_shash API is also somewhat inefficient and
>difficult to use correctly, even though it's better than crypto_ahash.
>(And the DRBD driver got it wrong, so just FYI, you should expect fixes
>if you keep using it...).
>
>- Eric

Noted, we'll work on that separately. But I think in the meantime this 
is better and more correct than nothing.

Best Regards,
Christoph
