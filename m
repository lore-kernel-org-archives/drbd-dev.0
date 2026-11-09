Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794246035;
	b=0gRIVeywiSwDWCETfV3y+HEZVcFfA8KUh4U9zgDjLjzBF4YXq36E6rYYmxHWZqto2UwG
	 XkQaY07+vH6bhBpMDwzFzZEW3fEl7zrvqLoTZwfjbrQrGmkV/gbKvGP9yBPwXji8uQt5v
	 hDfq6wd8bOaVSuzVQzdXpP+9RsX3kmbit+Gcp5+lcyrSiuS9eeg/ERyctV4+Wee3h/DJd
	 zJa4CYp+FuM8zRDAv1QhJl+LCUFYkw3ZEPfERx1DWc6lCo3JJNpdFk4ySok9jNZQaHTb9
	 J1kI7hIs3Xse+18kcqa8irfWYfCR5eUaw9trQPKHsGxJ1UY1FeibX++57IdozMuxOYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794246035;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=+ahcXpVCd20F2a+G4V5LP2pky9vopGhw75vYoQmoXKw=;
	b=KdZD1kerj81DssLTik9ev2//J0yOZGY570vdu0ZaaYK1w3GkkSh16mDDMXJFGQ3mkJ4N
	 F+tGRDWhwJGmJgGi9KihZKmshHzMk3thnTSXX2JoenlfjkkoXbP6JaaCD09vPLx6QPZH/
	 CQL/Brf9Lh1kS+lJAgMwdgdi+NXoong61ner+3442zRqESqywatP2hdHSJ4w/mGkQpoB/
	 LTvabRhGIwNu6V2+AsywKxpHCsY8NHiX9aZ5APduWXVpMn7dF9z6lcqn7oPc7+LBe/OQS
	 3eQ7TCijy8ozzAtrZZHNSP664L3I0UDxOlV3SUxNQ3HrNW2KP4AbpnRM4oJknl0WGZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=X0a+YRit;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116E1606A321
	for <drbd-dev@lists.linux.dev>; Mon,  9 Nov 2026 17:40:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 116E1606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=X0a+YRit
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-36f8cdd30beso1017989eec.1
        for <drbd-dev@lists.linux.dev>; Mon, 09 Nov 2026 09:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1794246034; x=1794850834; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+ahcXpVCd20F2a+G4V5LP2pky9vopGhw75vYoQmoXKw=;
        b=X0a+YRit6i9I/SCfs+/Md7RoDlnFiW/732WEBk7rb86lt2xBgLL/x8xkP95YDkrfxP
         MMRknPz+oGsUCCcsTYYchFXpwCfQ0u2bn23muUo4N4srN3QOzRng68Bno2NEuLeZkSbN
         TqcCxNd+HKPHA396T1LGYTsWESKEj8pB/iRBJ4NHtaLOaQFhDTS3K0nYxN5tmf00/tT0
         1017NV2nh4M1atQimzb/TiBO3QlziAOc62K2fVw4l9NKzyfeiYKWi0PpW4CsnWWBjVqh
         4BVaP8kCWJXv07s9iE2JX/C44Wi+0xRh7gQ6WiboC7DIsKyJynyClRabbLebqdf2sRls
         JAeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794246034; x=1794850834;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+ahcXpVCd20F2a+G4V5LP2pky9vopGhw75vYoQmoXKw=;
        b=UQdDQOS06KTkXjXI9lYOCsCABd2oHHQQEB1mzzZWWw5L4e8ihf+fOeAWesg6Al67K9
         F5ECW/25pK1fryCRJD3c37InSbGM9p9vl3RfWvpdJvHRp9LxZvyqpDXkCmaPIHVJodZX
         7xFu5L4z0NNPy7Y+x1wbx+mTkgcSuq7oFs7GCLQH0L3/9q+/UNl9DERw08nu3L0f6/MO
         VOlCVNT+02jJdir+Pk9GXiyE7J1URrunYR0UZqQt2RNMA5IUCv+3Cu10c7r79BffffLL
         eh4HBjVkj5DkR7ZaLOhutgEUiEfcIPiHYgaia4Ggg5TGWblNwoyGiTi7aoVpJOO8kPc9
         WEvQ==
X-Forwarded-Encrypted: i=1; AL+hErH5JpLtjJoXO52Z6kPqCe9w2zj55DBRf4ov9ZvxTR8X5jRbRmLhKLi0Rw/LOBS/9MMMZ4cyBTFmww==@lists.linux.dev
X-Gm-Message-State: APuU4Z+ZHae8K2DHn1kjizd2yupNuz5jaHbBBgIp04OuDvbqzV1TQSJu
	nPQjkdbkZP7QgH8cYslrQZ6LF4GCjZUQpU1fdtudPKtS7g1Dm6TPNnhGqCJvIhiurXEU11xitnV
	igsr+r3I=
X-Gm-Gg: AYBFou1+lxHgMrJ/uapKnkhEPdHMZb1l0E3XBLWzu2gr2uJvfTMKYt5kIUeUMX9UIuH
	e3M90Gdu9hTPS94oVR3wl2Nmop4Bl8Tu1FCCB0U7TO8xAbRqtvWO5EPaMpWzQLko3F1RYgTdFNC
	iy9VnLkGAaKPLhZCGlgzTC3TKNpEojtkMNzD1jNb3zImIcGwS7tkVBfFnloYxAWFX8WfPhIQuMa
	pnHFaK9eNzcwJtumPgg4JEH+Dj2DbY1X1GoBA8AYh/9hiiE9pN3svc/KWMoVlLMxcWPH++9G75u
	JpOC8vS7Ohw+U4m/TN+6L6r/xB6Iiw3IbSkswTUylPFVXkv9i4WBCXBn9iWg55uXXW0jVoMIv+0
	lcGgEbVnzYUjBXsZmA7KelumB1lNUE4xl5PYs6+C9NgCwioSZslToFGaTJQ1QzTNn3MUV+ECSAa
	gvU2fwGTx1CIx5/0ipR6zWf0bI6bCb9xGdUnzATY4ftDZ6vJeg2AuEHZKQyKWVlzDGdBH1yMe0I
	7MDSLd7ip9iVtAlMdPSOJLiueBnM6cWpIKntFcfJCsys2cpKspFMvnnMftxK8Bk8T5yPTvpeH6V
	3yo8a0dkubJopBhwRxucFCmpnlRV9YiKcHpVIoEwmmbqTyS7TYW0NyrWCSUlwOIuI6J5aAQeQG8
	WUiLB4egRm64=
X-Received: by 2002:a05:7300:87:b0:361:7ab9:479d with SMTP id 5a478bee46e88-3725e34086amr7318366eec.27.1794246034049;
        Mon, 09 Nov 2026 09:40:34 -0800 (PST)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-372669d48bdsm23580324eec.28.2026.11.09.09.40.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 09:40:33 -0800 (PST)
Message-ID: <4d67e54e-8076-4c91-9c26-0b79d478f590@kernel.dk>
Date: Mon, 9 Nov 2026 10:40:32 -0700
X-Mailing-List: drbd-dev@lists.linux.dev
List-Id: <drbd-dev.lists.linux.dev>
List-Post: <mailto:drbd-dev@lists.linux.dev>
List-Help: <mailto:drbd-dev+help@lists.linux.dev>
List-Subscribe: <mailto:drbd-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:drbd-dev+unsubscribe@lists.linux.dev>
List-Owner: <mailto:drbd-dev+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] drbd: preparation for DRBD 9
To: Philipp Reisner <philipp.reisner@linbit.com>,
 Lars Ellenberg <lars@linbit.com>, drbd-dev@lists.linux.dev,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 Lars Ellenberg <lars.ellenberg@linbit.com>
References: <20260923140608.1116713-1-christoph.boehmwalder@linbit.com>
 <avIA1j2pX46pzOr0@linbit.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <avIA1j2pX46pzOr0@linbit.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/9/26 10:22 AM, Christoph Böhmwalder wrote:
> On Wed, Sep 23, 2026 at 04:06:01PM +0200, Christoph Böhmwalder wrote:
>> This series contains preparatory changes for bringing DRBD 9 upstream.
>> Each patch moves a piece of the in-tree DRBD 8.4 code to the form it
>> has in the out-of-tree DRBD 9 code. Doing these steps separately and
>> up front keeps them out of the much larger rework that follows, so
>> that rework shows only what DRBD 9 actually changes.
>>
>> The patches are a file rename, comment and internal cleanups, and two
>> higher configuration maximums. Defaults are unchanged, all existing
>> configurations remain valid, and apart from those limits only the
>> wording of some log messages is visible to userspace.
>>
>> Christoph Böhmwalder (7):
>>  drbd: rename drbd_worker.c to drbd_sender.c
>>  drbd: modernize the file header comments
>>  drbd: raise the socket buffer size limits to 128 MiB
>>  drbd: raise the maximum resync rate to 8 GiB/s
>>  drbd: replace the drbd_interval bitfields with a type and flags
>>  drbd: move the packet name table to drbd_strings.c
>>  drbd: rate limit log messages per object
>>
>> drivers/block/drbd/Makefile                   |   2 +-
>> drivers/block/drbd/drbd_actlog.c              |  16 +-
>> drivers/block/drbd/drbd_bitmap.c              |  18 +-
>> drivers/block/drbd/drbd_debugfs.c             |   4 +
>> drivers/block/drbd/drbd_debugfs.h             |   4 +
>> drivers/block/drbd/drbd_int.h                 |  59 +++-
>> drivers/block/drbd/drbd_interval.c            |   4 +
>> drivers/block/drbd/drbd_interval.h            |  55 +++-
>> drivers/block/drbd/drbd_main.c                | 106 ++------
>> drivers/block/drbd/drbd_nl.c                  |  15 +-
>> drivers/block/drbd/drbd_polymorph_printk.h    | 256 ++++++++++++------
>> drivers/block/drbd/drbd_proc.c                |  10 +-
>> drivers/block/drbd/drbd_protocol.h            |   4 +
>> drivers/block/drbd/drbd_receiver.c            |  61 +++--
>> drivers/block/drbd/drbd_req.c                 |  40 ++-
>> drivers/block/drbd/drbd_req.h                 |  12 +-
>> .../drbd/{drbd_worker.c => drbd_sender.c}     |  42 ++-
>> drivers/block/drbd/drbd_state.c               |  15 +-
>> drivers/block/drbd/drbd_strings.c             | 138 ++++++++--
>> drivers/block/drbd/drbd_strings.h             |  27 +-
>> drivers/block/drbd/drbd_vli.h                 |  12 +-
>> include/uapi/linux/drbd.h                     |  12 +-
>> include/uapi/linux/drbd_limits.h              |  12 +-
>> 23 files changed, 534 insertions(+), 390 deletions(-)
>> rename drivers/block/drbd/{drbd_worker.c => drbd_sender.c} (98%)
>>
>>
>> base-commit: 85bffad4d2fea373a72d68bed8012e8cbccb8ee7
>> -- 
>> 2.55.0
>>
> 
> Hi Jens,
> 
> this never got a reply, and neither did the subsequent v2 drbd rework series
> that's based on it [1].
> I think this should still apply to 7.5, would you mind queueing it up?
> 
> Thanks,
> Christoph
> 
> [1] https://lore.kernel.org/linux-block/20261006154607.3936501-1-christoph.boehmwalder@linbit.com/

Queued up now, v2 doesn't apply anymore fwiw.

-- 
Jens Axboe

