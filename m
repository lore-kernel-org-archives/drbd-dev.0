Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792945798;
	b=LkRNDdM2bN2vMDZq6ebyWznqcK0IBPqj2njnX7JVFYV+Rp9OE1CNrv3k9NZZyZqQqgPB
	 B7kXMOV+p30U5NG73ERvoGfYDdSnoZY2M/TnGx5XH1ElN5IKGe3aMgXXppLK89UXO4bnX
	 hp7TF0vDrfpgqAXkeOm2wnSw2YPHBK8qsgT6NNJlXqno/R/E9wm9PcJ+UDloYQ0AgTsk4
	 fFtASBo6PLiXylSg82dhbYOkDDFTjwM2wNpMq4sx7eaLphWXMBGe63z2al5mgBcUaXvbG
	 Lm+p8B6OgIvDD78bBZfZWzO0ejmXvdvFqixO3JJAZYifpDLS014gVbmY92WT1FkGC3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792945798;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=nI+xYq05/ilJFvxkwNugXyip7U8J6e3kdg9Q/C4jBKQ=;
	b=hs1uZxy1whL/YGtvciUQ9PG52S1PK22shdQsPEApgan8c1x8MfrSwUiVQBJbvjABNUKI
	 sJ2eN2+489IFMgltn+monT0S8uVOZyvNsbp2MtBmAOA5qKN/Wsk9ijcn/nKsFykA1LZ8Y
	 9HSAENlkcE+Kc+wkQW4Lhy56xdzhQuwTpMfScvxpm/ud5w94Qf3n9fWsgPiFu/MwKbXGH
	 gu3c4OzFVFYUQzeMnfM8cvqCX9Kk6DAMNIUiFVNhQngL8V/g3RhrzGA0A+0EEqsYHf+BN
	 ES2Kqn6JrmVF8M7GzthgqNO1zs6KeVduyWyIlX2+2qbwU1oaICTIrHOklMzGKCUXxMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linbit.com;
	spf=pass smtp.mailfrom=linbit.com;
	dkim=pass header.d=linbit.com header.i=@linbit.com header.a=rsa-sha256 header.s=google header.b=BhbM51XD;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD9B606A31A
	for <drbd-dev@lists.linux.dev>; Sun, 25 Oct 2026 16:29:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2BD9B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linbit.com header.i=@linbit.com header.a=rsa-sha256 header.s=google header.b=BhbM51XD
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a2069b9710so21545555e9.2
        for <drbd-dev@lists.linux.dev>; Sun, 25 Oct 2026 09:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit.com; s=google; t=1792945796; x=1793550596; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nI+xYq05/ilJFvxkwNugXyip7U8J6e3kdg9Q/C4jBKQ=;
        b=BhbM51XDMpvLN6o+obyQ1gFVfdyv0X0Q+XrseuiefBvUCncj64yhbi4Y2B6lMzjBjC
         Uw0xuIAU2N2ploDwFqy7auXuN13evb0LLxhH6QDp+/PJIBmROyZQfjlTz2JcxUixM+tY
         jLXMd9/YkAyVU8sG2mviNnYfBdyQBeeKxIiCL+Z7TFL35reoTNzr4qCWunx0ufsYxXhU
         4Tc1fnbXhysNhPV87jbwqZ+iOogl+t3w5Ze8WtdnnaYP3bXelHJ8yM93BsiK1eF1aMus
         thWcwNb6cbd9JPl0pmU6JxWVkePvad9sR213iAcaaWFWA8kJFqrdww9SGWyPPwZNDjPP
         043w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792945796; x=1793550596;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nI+xYq05/ilJFvxkwNugXyip7U8J6e3kdg9Q/C4jBKQ=;
        b=AL6b0XWwVEvW/HFCtOQhT9J++aFLMlL5IpbKeMhD88TanCQF3yhHMYiQSzcb+7XY/O
         q77B/tofw3ADl8HTju42P7bR0mr3aAfSBeIMcL66V33EzSFeqYYnbGwECPDUM5QXuKUs
         5mbPCXWTVVA/nm6KWl732fASeEZUoYADrSyoGKEK6eZ3J7qDrMNV3CLoEGf3Y10sSTUz
         vx1U0HeGIa8uBynQsxpCl6gkKhy2YrnFC4FbfAnoh235WTLFVACTQ7PNBwhpUTiR7gyv
         Mj098Focq4lAUsY6KZICYQ/eLw7SEHWxB/e11O5nEG6cMbF4JiGCWMzrtFXSEVduzomv
         giXQ==
X-Gm-Message-State: AFq9FYIZVTi0Hysve9ZqEXbSBs/TMadbVjKxuNuvoNeG+WJ9mrdgnJfE
	xBtKbtcHhEOow/AIhMKf8lOc6+fAMJPx94ineYXztpIHZL3RbAJbtaGDtIKTLJiRx9TtRPIHtC1
	Jf/C7dH0=
X-Gm-Gg: AYBFou0njXGRXHC0+6MpfO7c45Vxhx08VNG/G9lIuEHKEONvczHtuXWBU+bl9GpTqX9
	uBLxUeJ1eu+xC7mrYQ+onVhEew3BjNduLNzaiGktOrxc1iv5c0JHbVW+3H/oOYHsAteir0ALgVQ
	8jB+1CheKRQSOa++74QQUf8JTDVVzDZmDBG6y26TB3nEue7LqHUHxCw+XDU06AHoJT5UoJkgw80
	IJh6V0bt16EZSjoMh5BUDZ8ROFfTS+XYq3ecugwksPWuNmamIl0DiUa9nFjGmxhKqvNLYp9vFAl
	Dn/4KcEbcMqAOYvOCEtoz01vdvnQ+z7bQzBM5uMhzv3q4saLi8vZTL3V9uMz11nG5lcm7G3Z8gL
	dOq4q7su77hzY2NIjOX19CW33iicVz6oH/TXn2Phfs5l4IO3Q+dRanvrh5nPu3wh3qZTFcpNOsR
	GPGu06MISn6pz19b1V8tkxIZxCsMHdd4Cy2MqJByBcpiXVaSkmev4gA9fAsrMA7e7s6ZEZOMYg4
	qapy5FhkxsmIEKr3J93/L61Zttq1iVx5fCQzt/oVsfqvulZLpBxrCGWpBiSy9XoYUf+uDWXrImF
	ulxJwdNfcEG7RfDVd7eNmOY1oKJgenFllrdlBbw/Ow==
X-Received: by 2002:a05:600c:1987:b0:4a1:db17:c7e6 with SMTP id 5b1f17b1804b1-4a35ac3a7b1mr73744585e9.2.1792945796403;
        Sun, 25 Oct 2026 09:29:56 -0700 (PDT)
Received: from ryzen9 (85-90-145-81.hdsl.highway.telekom.at. [85.90.145.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a30e22csm132813595e9.2.2026.10.25.09.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 09:29:55 -0700 (PDT)
Date: Sun, 25 Oct 2026 17:29:54 +0100
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Dominic Ferard <dominic@let2.com>
Cc: drbd-dev@lists.linux.dev
Subject: Re: [BUG] 9.3.4: resync between two Secondaries stuck at 100% -
 flush request never acked (2 volumes, new-peer before attach)
Message-ID: <at4ugnJ3AYaaJDV_@ryzen9>
References: <atzYnDQ-IN0yi3vx@let2.com>
X-Mailing-List: drbd-dev@lists.linux.dev
List-Id: <drbd-dev.lists.linux.dev>
List-Post: <mailto:drbd-dev@lists.linux.dev>
List-Help: <mailto:drbd-dev+help@lists.linux.dev>
List-Subscribe: <mailto:drbd-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:drbd-dev+unsubscribe@lists.linux.dev>
List-Owner: <mailto:drbd-dev+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <atzYnDQ-IN0yi3vx@let2.com>

Hi Dominic,

thank you for the excellent report. Your analysis is correct. We
found the same bug independently, and the fix is already in git:

  drbd-9.2: 24374f123a95 ("drbd: keep the dagtag of the last request
            across several attaches")
  https://github.com/LINBIT/drbd/commit/24374f123a95877956c3c95a5080b6afae75b28c

  master:   eec2d913473b (merge of the above into drbd-9.3)
  https://github.com/LINBIT/drbd/commit/eec2d913473bf00370b1049e549f10ac0e6181cd

Only 9.3.4 is affected in practice. It is the first release that
also sends the flush to Secondaries. Earlier releases flush only
Primary peers, and a Primary's own writes move the peer acks forward.

The fix will be in 9.3.5, which we plan to release on November 9th.

If you want to confirm the fix in your VMs before then, the commit
above applies on top of 9.3.4.

Best regards,
Philipp

Am Sat, Oct 24, 2026 at 05:11:08PM +0100 schrieb Dominic Ferard:
> Hello,
> 
> On a two-volume resource, a resync between two Secondaries reaches
> 100% (out-of-sync 0) and never completes: the target stays
> Inconsistent/SyncTarget on both volumes indefinitely. It happens when
> the source was brought up with a plain "drbdadm up" and its second
> volume's peer bitmap_dagtag is higher than its first volume's. We hit
> it in production (two standby hosts, both Secondary while the Primary
> OS is down) and have reproduced it in two VMs. Details, debugfs output
> and our reading of the source are below. Please correct the analysis
> if we have it wrong.
[...]
