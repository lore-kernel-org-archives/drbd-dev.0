Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794244960;
	b=RU8Ixcugxyejm5D9cISZlhfQMgpQRKhpJTugpuILLsZ2scRy+2wm0c6sntR/uQA9ae4Q
	 3GN01xTP1cYCbircKfrBORmgyaEV6Traxwyb5DQ5NqGZNGCymPNlklMU4vL2ay95PNDNq
	 U6gy/qkC5O/Mf/+nYesEPUsappliB1qOUYwylXQkx4WmXtIBPv2mqM+bKuxrNId2mU0EP
	 ouYP/BNIMKf3NdW7LpvpgR9z/90AECFDPPT9fPxiQo8xz5dXjh0kotUi03bqQtPqfEOI/
	 MO1ZwVaHSTaNHOk8rv+ZOMXwF10EmHKx6PxRYC3cf0Itfw9TaiQbshTLNGpVrJlk/UQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794244960;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:Mail-Followup-To:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=b6mHS43xjC7bUToGiz9ZtsTkKl4SjMG7SXbvThwI2D0=;
	b=Ef5e2yUXOZSts/QDxeYWZ78FM+s1Ahv604WnWnHGRL3VlHfg0xIJk5yQcdca3CvAUA/Y
	 vJQWLC6QtOI9VR+qRem6M5TmjgFwcn4AUzqH2vil8KjOs4xBt/1+GcHG5u+LxxRt1bc9i
	 3QZqkua8wLvYk5KK9r4ZHiavi/sCQ5Z2JoYh2FGeOh2Uki4Gy6vnCW+fLfwJKWp0in17l
	 4dutKVRz3hzaHpPEYvN8JCG3+B4H500J7hS2eHqJZ0kRcHKHkUZg6MdwXchf8IrvFdHWX
	 TJDdfrLuchRXHxGUXuXmdPlLbhcbHr3ex2ybNcKH3ZaUab87JuknAVHNfuDBxnQotkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linbit.com;
	spf=pass smtp.mailfrom=linbit.com;
	dkim=pass header.d=linbit.com header.i=@linbit.com header.a=rsa-sha256 header.s=google header.b=wULo8LMG;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E66A606A33E
	for <drbd-dev@lists.linux.dev>; Mon,  9 Nov 2026 17:22:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E66A606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit.com header.i=@linbit.com header.a=rsa-sha256 header.s=google header.b=wULo8LMG
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a35d5d4a20so13912405e9.2
        for <drbd-dev@lists.linux.dev>; Mon, 09 Nov 2026 09:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit.com; s=google; t=1794244958; x=1794849758; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:mail-followup-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b6mHS43xjC7bUToGiz9ZtsTkKl4SjMG7SXbvThwI2D0=;
        b=wULo8LMGTEV75td2MBR8c3s7GCiav0l34MOpNvxZEQbSOHjA5+/y1Hso3fl7D9ezQv
         NLuOjTnbiI3/aWkKx3c+2vC5wG/FM3cjdqHkVl9TymzXP3Zrcytqn4p+KJ9xmTFbUVbr
         L5Y9HFHaffHcqkvjuQ+BDh/68JbsoNUC7oKiowqSlQ35TC3QLPfOQYYn41aDMlFtKrbR
         fhgiO1uTBFj4eJOOv5c76zMM+9aMDo2dkQBbVK7Q0XtdRGsgs4C0x9AQ821q+MXrmyAg
         Ehvzs9JASfKtwUQOZHrf5ISJXO+nOOmt2F/ocJ/i+PrhxrCtFE5V+0CxTzOe+EfMtRRy
         uH7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794244958; x=1794849758;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:mail-followup-to:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=b6mHS43xjC7bUToGiz9ZtsTkKl4SjMG7SXbvThwI2D0=;
        b=GjzkmdAQG5KD5wwmwPHmiAhRn+L24wSuHTbo0GGv2Bn4wZcj993mE/PG3D9MEgUZJI
         7aWbSMb09Sw21FxsngVToIuGSdte5nOlzANMoDCy/ihqFB93qbQU8uMd887veLhH+xHh
         zWojvHzgUg1dVKbSWHB6BkL2Nrv3q/SLKyiWICp6BJdccav6ekFoYX9gQis0529GoH/6
         2bB9bKbqENyT8+J2yvhwe0LezQHboYsC0cD8ZYIX4+p76ZLdE5IZduj/rM4KEXhGT7sV
         XS4y1n+ZN1NhG2nwUBy5+GVwiS3RG2VjKFf2mqJRCmiqRV/1OFrYY3VnQKGWLn7iU8hX
         fR2g==
X-Forwarded-Encrypted: i=1; AL+hErGg/TcKcBtMWWzOKnWe8pEaEexgi+Tr0DqBeKF8GZuPqRFl7KErxEuV5Pn5iqZ10WvluFi0vPvv/g==@lists.linux.dev
X-Gm-Message-State: APuU4Z+euquPyFZ7+Ej3L9V0ypuHqBdYvmKnocAQZ9xkFip+kD4LKSkP
	NVCr2tSPxPubMmeglZobH4z8gNmsU57LSPUxIU94EmIpnmwXco42KQAZWuVAnEmxeg8=
X-Gm-Gg: AYBFou0R71qK0hcRac6O1BouU9XxNnY1r7BZopI0W8ptd1Jo7S37TZu831nI9hGOjsI
	nbnth5OB5512+SDm/4kUiZPR0fn0f6sZsz5sDmuzfy0bjXyIngf0fz/kk6Zo+vi40lQuJhje9/3
	ViAzwpdZhTVb5nCUbLOgX9qAKcWZrpuGmwfjxGvI8RrSTTkPq3rohPVn69vq1hFEnfjAAmJccR3
	SGSBaqTozYfjzxFeLrGsBrXD83tQxRGYUD1uxxZqOXNY1Y5WNGG4abA6jtVrc65GnaKeCLyny4Y
	G2BRakHkYxLrD/MhKLWh6EwsFPIGG6zjPuZ5FITgliasyExqpem5ixSmcMWqOF4UX31ut/UqOj+
	E+jDI64ApEMXoS1ESUCebGM9NMJwNbfUAwjVdgOdpdrOrGh+qtiFz67PEWXX8BC1gUtuUqj64o4
	qcuSFSlFfnLiPajn8oAwhJuit/SrGsUTEu1Ac/14Ac6Hkqt5eKB2TSoDrU6CSCirEf1e9JZeEMM
	3G7vGM6sHzDO/pERQT9RAncEmuMDnOQZjJZn6eqTwl6NT3+nxJqnukNSpsB6L6fZ2Ss8zpgO088
	03WiE6B92sURCTAHr9/tCklNCY6nKWGhamIDqMQuEukw8KkQncxjDchqJ4FE2pbiRpjckC7/G6K
	SttzHtvMEA8afD0cAmA==
X-Received: by 2002:a05:600c:470a:b0:4a2:1655:87db with SMTP id 5b1f17b1804b1-4b943f76fdbmr96705385e9.0.1794244957763;
        Mon, 09 Nov 2026 09:22:37 -0800 (PST)
Received: from localhost (h082218129081.host.wavenet.at. [82.218.129.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba015c1e31sm4470385e9.1.2026.11.09.09.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 09:22:36 -0800 (PST)
Date: Mon, 9 Nov 2026 18:22:35 +0100
From: Christoph =?utf-8?Q?B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Philipp Reisner <philipp.reisner@linbit.com>, 
	Lars Ellenberg <lars@linbit.com>, drbd-dev@lists.linux.dev, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>
Subject: Re: [PATCH 0/7] drbd: preparation for DRBD 9
Message-ID: <avIA1j2pX46pzOr0@linbit.com>
Mail-Followup-To: Jens Axboe <axboe@kernel.dk>, 
	Philipp Reisner <philipp.reisner@linbit.com>, Lars Ellenberg <lars@linbit.com>, drbd-dev@lists.linux.dev, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Lars Ellenberg <lars.ellenberg@linbit.com>
References: <20260923140608.1116713-1-christoph.boehmwalder@linbit.com>
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
In-Reply-To: <20260923140608.1116713-1-christoph.boehmwalder@linbit.com>

On Wed, Sep 23, 2026 at 04:06:01PM +0200, Christoph Böhmwalder wrote:
>This series contains preparatory changes for bringing DRBD 9 upstream.
>Each patch moves a piece of the in-tree DRBD 8.4 code to the form it
>has in the out-of-tree DRBD 9 code. Doing these steps separately and
>up front keeps them out of the much larger rework that follows, so
>that rework shows only what DRBD 9 actually changes.
>
>The patches are a file rename, comment and internal cleanups, and two
>higher configuration maximums. Defaults are unchanged, all existing
>configurations remain valid, and apart from those limits only the
>wording of some log messages is visible to userspace.
>
>Christoph Böhmwalder (7):
>  drbd: rename drbd_worker.c to drbd_sender.c
>  drbd: modernize the file header comments
>  drbd: raise the socket buffer size limits to 128 MiB
>  drbd: raise the maximum resync rate to 8 GiB/s
>  drbd: replace the drbd_interval bitfields with a type and flags
>  drbd: move the packet name table to drbd_strings.c
>  drbd: rate limit log messages per object
>
> drivers/block/drbd/Makefile                   |   2 +-
> drivers/block/drbd/drbd_actlog.c              |  16 +-
> drivers/block/drbd/drbd_bitmap.c              |  18 +-
> drivers/block/drbd/drbd_debugfs.c             |   4 +
> drivers/block/drbd/drbd_debugfs.h             |   4 +
> drivers/block/drbd/drbd_int.h                 |  59 +++-
> drivers/block/drbd/drbd_interval.c            |   4 +
> drivers/block/drbd/drbd_interval.h            |  55 +++-
> drivers/block/drbd/drbd_main.c                | 106 ++------
> drivers/block/drbd/drbd_nl.c                  |  15 +-
> drivers/block/drbd/drbd_polymorph_printk.h    | 256 ++++++++++++------
> drivers/block/drbd/drbd_proc.c                |  10 +-
> drivers/block/drbd/drbd_protocol.h            |   4 +
> drivers/block/drbd/drbd_receiver.c            |  61 +++--
> drivers/block/drbd/drbd_req.c                 |  40 ++-
> drivers/block/drbd/drbd_req.h                 |  12 +-
> .../drbd/{drbd_worker.c => drbd_sender.c}     |  42 ++-
> drivers/block/drbd/drbd_state.c               |  15 +-
> drivers/block/drbd/drbd_strings.c             | 138 ++++++++--
> drivers/block/drbd/drbd_strings.h             |  27 +-
> drivers/block/drbd/drbd_vli.h                 |  12 +-
> include/uapi/linux/drbd.h                     |  12 +-
> include/uapi/linux/drbd_limits.h              |  12 +-
> 23 files changed, 534 insertions(+), 390 deletions(-)
> rename drivers/block/drbd/{drbd_worker.c => drbd_sender.c} (98%)
>
>
>base-commit: 85bffad4d2fea373a72d68bed8012e8cbccb8ee7
>-- 
>2.55.0
>

Hi Jens,

this never got a reply, and neither did the subsequent v2 drbd rework series
that's based on it [1].
I think this should still apply to 7.5, would you mind queueing it up?

Thanks,
Christoph

[1] https://lore.kernel.org/linux-block/20261006154607.3936501-1-christoph.boehmwalder@linbit.com/
