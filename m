Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA914E80C7
	for <drbd-dev@lists.linux.dev>; Sat,  5 Sep 2026 18:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788632754; cv=none; b=ZzM3MczXdRRuXC54+3GyKI7LVZYkJFRErfWZseC5XTm5UC2lFpH0gLG07GNIfzmWR765cDb0Xm9Rb4k0mEE4NhSl+GHaHTv8uKfArMRQQVsN86JD5/rqW1mkLirpijKLaP4t9AWMh7M+SjKhpZ3W7gb0yHAv7nKi5Q8n0+sqT08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788632754; c=relaxed/simple;
	bh=rakUssaS3Z60N+MJ5OmiZGkRVrp4Fe3erHejZIlcqBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D2iJ7AJrC+IntQqv2tyOWQ/uidzlx4fphRR8g1NXI7xppUuIiMGGWQXmU9Aj3rDHGrDpDymRANLbibnCosY+N1DT4qygeerdkULKeRIBQPpGHtUYMg96Ttv5/aj9MDtSyWZvQvCvQ90es5BLNXP/1rUy9TGaPddjvgsP2I7lW4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b=dKgwubni; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b="dKgwubni"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-49b8e527d63so26563815e9.2
        for <drbd-dev@lists.linux.dev>; Sat, 05 Sep 2026 11:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20251104.gappssmtp.com; s=20251104; t=1788632750; x=1789237550; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Vh1tho+DMPBe6dOnmyRhQgSZf9FdJaDw5EyeCtsHdOA=;
        b=dKgwubniKwgpbcy6Ta73p9kvjtDOg1hq+1Hn2FpVXn96iXG5FnGf5jSa/uT+HN19C+
         xHFAUwR4CR+aKBGBzWi/8LwYEcDtJwBUnsng/2rTD59XmtqIIiHNL07brhdjvSt7Dx/g
         HGfp7eLYPYA1m2wbV+GzR49YLidaT4Vr3AbcAju4eMRhciVQVrTKW7VtGWEe60CqELNc
         CoToMcMp4o2ugHhY1bRWE2A60EAdx96vGRvToiN0tefJIhAn3MEQgLe6rt1Ebiqm7UIl
         3gFCOfD6Mx6NaijH5NBTmrthCVuub1j52ipUUKFxias9Jgyc+u6Ty6aE54h4mdfZUOK6
         PXCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788632750; x=1789237550;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Vh1tho+DMPBe6dOnmyRhQgSZf9FdJaDw5EyeCtsHdOA=;
        b=YvZGE/ElK/mZ7gPXi8eawrYhP8Lye7tlMhaFcpr6EsZyfpvKcFNFIsJh/5hciJK5/f
         g3leHhHYmGlIQgepIPLtshoAtpkMmtRqqpmHt4BIVbDEhse3TNMMk/uyKlBPW+q0TcNC
         baoo3rpIA0MJi+ZIuQR7DKMsoieYuS8ehimrOHVcrJuEeXMjd1RiHfdmoK2wUnjJTSvI
         GacyndC3lOYZjd1GKIM4r5LY5h5EVpUWragexdIUE0FvDUJatTfwuOorhQXbaRsH34Dz
         3jQn27j2PwWOlH59/kiSA7COWPFHFsW8Q2H4IfFikBjaLOherhuRsTzxXN6soOR8X/Uy
         fmBA==
X-Forwarded-Encrypted: i=1; AKwUvByDmZYgfp7ggBkaUcAU7dqSqYMYzFszX0MUl3fGZMTZvfO5upgEVHvylw3kf+4T/coQuFUB+WrPdw==@lists.linux.dev
X-Gm-Message-State: AFuF++kpYZAve2ToB6/QXdPpf9k2cdsVH99UBxWxSf1dqFZtgqaSqKlL
	7cCYREW36cEiprkhPJtie3wYCxQefEmuylE4bpjoQvYveP45O+JtJZsVJYgW7EAXvok=
X-Gm-Gg: AYBFou2RTLIF9ebQwsUI/dORMMVIFAukAI0LQdfkQC14JaJUc+t2950mLx/H6u4kJzz
	XFJQceeqQ714RkKkzICNmz2Lax3gPoID85u+pHFHDq4gVeGPrmWNL++9vQLnrjxRQDFrSkfSeS8
	9G7Vxnd8hJqzriZ93d3h5veNeNBO8rl/71jL9IfvS8U8pC3zacPR+v47AwLzZSABjjp643RFV82
	+FBFKkmGOFYi55lUlbZrn6FqiKIBkDNtEvyMtbGsf26x5C2/dDipXAbUcgcZp58r/+NfNdWtKDf
	UQ2Eb/QGE4gMP9UiXHm8PzIa1tj2g1WkW5uBLzx2/gLwNyESSKbr9qt3DUSRIOso7wXm5AJGTnP
	Gj7Xf5iY/qlz5IkMFsLhVqG/AaUjYsuqsRA86SbyiV9ERf/aQf7jYKqgbfNjsgHaOFfd+IyCoQd
	jHUEDW2xBz0Ni5yJK+jlJcJP6mvtRncQ2RE1jNoUJysLzqk1laLU0BQ01nMucTG6vnLY7IxHrTm
	Z5ZgbLesKDAG/r7Kb3gLzkJ9ga35PN8
X-Received: by 2002:a05:600c:3b02:b0:49b:9202:6f80 with SMTP id 5b1f17b1804b1-49cf8220edemr149030685e9.6.1788632750385;
        Sat, 05 Sep 2026 11:25:50 -0700 (PDT)
Received: from localhost (h082218129081.host.wavenet.at. [82.218.129.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee60bae6sm298811535e9.9.2026.09.05.11.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 11:25:49 -0700 (PDT)
Date: Sat, 5 Sep 2026 20:25:48 +0200
From: Christoph =?utf-8?Q?B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Hemanth Selam <hemanth.selam@gmail.com>
Cc: Philipp Reisner <philipp.reisner@linbit.com>, 
	Lars Ellenberg <lars.ellenberg@linbit.com>, Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org, 
	drbd-dev@lists.linux.dev, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] block: drbd: fix typos in comments
Message-ID: <apxeZOBtnBZtgjfw@linbit.com>
Mail-Followup-To: Hemanth Selam <hemanth.selam@gmail.com>, 
	Philipp Reisner <philipp.reisner@linbit.com>, Lars Ellenberg <lars.ellenberg@linbit.com>, 
	Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org, drbd-dev@lists.linux.dev, 
	linux-block@vger.kernel.org
References: <20260904113103.10805-1-hemanth.selam@gmail.com>
 <20260904113103.10805-2-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: drbd-dev@lists.linux.dev
List-Id: <drbd-dev.lists.linux.dev>
List-Subscribe: <mailto:drbd-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:drbd-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260904113103.10805-2-hemanth.selam@gmail.com>

On Fri, Sep 04, 2026 at 05:00:59PM +0530, Hemanth Selam wrote:
>Fix typos in comments, reported by scripts/checkpatch.pl using the
>misspelling list in scripts/spelling.txt.  Only touches comments, no code
>changes.
>
>Assisted-by: Cursor:claude-opus-5
>Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
>---
> drivers/block/drbd/drbd_nl.c    | 2 +-
> drivers/block/drbd/drbd_req.c   | 4 ++--
> drivers/block/drbd/drbd_state.c | 2 +-
> 3 files changed, 4 insertions(+), 4 deletions(-)

Typo fixes like this are usually only worth it if they come with "real"
fixes in the same general area. Otherwise, they just cause unneccessary
churn for the involved maintainers.

Regards,
Christoph
