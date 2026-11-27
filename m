Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795765224;
	b=oIe6ZgEvefRXkVKLZ6dyaF/U8c+kOpWlQDg6+WdhdNnrtXs5XsNTpWFCBSsi0w/k87n2
	 4o98F3Lwr07vdrXM2ifGNgK+BrWPUCos1ZSExT/CX8qmXbWPq05msO/0VDmxdNGcZKQWt
	 Lk6xZ2flaISDXK1VzFUb1kDVXVRuPXK7mxcQ3uahmvSMcwZyOhaZuA3DqTX4lQ1QC3G3g
	 EZT9Eg0Krq+c0NxmNzAMO5gCIhn72h5B9ic0aFr2HdjGK3eT9qMonNdXUx1zZADquPV5h
	 RkEIzDjStxkVyL6r93RF6IhmTm4fBhXUWo8+HrcB53+1qPjnOdGr2ZcUikkwGitp/GA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795765224;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=AzBbVRQtWclUaqleNTyHW/my1uoUuj6+hUg7E7a0AMc=;
	b=5XWgrBKftW+jxC/2eOFC0R7a+Occ2DvJJAZMh4fTKdU9jKj6hF7nVS+a/CEbjuhsrzEf
	 FQqmgrRWcy4ig0/9MDFiTfn/hHzNHBWt0T/IKJWKiDzsbs4shqqL49Nzw3/3/STxOygl8
	 oo+Qz7lymYm0O9b9ZVQQv+XHz0ENYukhSV9ku+lZgfCUSMOIPWUYvoyir0fHUN2Krjz8S
	 hmBUSNL4eru95ccYrkKfgXx8erTEkyzVZkWVErC/brbbOLvzRYcLVjZzJFNAHmUCSGTYg
	 M6RkG8dhj6LfzV7ifp7XM6URGZLU7wwLNh5jDPbLazVZKmFlMRPLP4ln2UedDe6gejg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=okSkktnD;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57E6606A31C
	for <drbd-dev@lists.linux.dev>; Fri, 27 Nov 2026 07:40:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D57E6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=okSkktnD
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3b3e85baf7cso4581793a91.0
        for <drbd-dev@lists.linux.dev>; Thu, 26 Nov 2026 23:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795765223; x=1796370023; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=AzBbVRQtWclUaqleNTyHW/my1uoUuj6+hUg7E7a0AMc=;
        b=okSkktnDikDyi50oJJEQ6sazvVVevEuLTtXHAh33tGB+5yM3JjbAqm3vv079sH1NlL
         knAPkSbCX8afrwSxWhaxEay3nSToxFuVboESubrg0BvFYici3qSkMdHhRogaanlVZblm
         tvw3HJYT4xEHsVfIFgyWliuXcb+Eu0ov5vX8/g0IjQTNnRiPI0n6p3g7wPyHK+zbFSLh
         eapCWIrLMynlMSUnEUWmCbz+oGvbEuVEfw4ikC8Ur+2SDBNYozmFS4QGPS2HmmDN1m5O
         d0vpUgMGyqLlaENdFwxuRFKyDQpg1soyHS7ktEDOZ0rilUTrJNLehVmKOpW17Nt1aTGN
         OsxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795765223; x=1796370023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=AzBbVRQtWclUaqleNTyHW/my1uoUuj6+hUg7E7a0AMc=;
        b=lqlpcMh1sH0YBT+KbIDN2cDMD+M0WOfC1LiewCAjJdPbdxwAGkQxe0H0TSTw7b+g3g
         TLwR4cTN47vUBcnVr7S4P8YEDgnrfSyNq2JAfLjwL5vAJ0uzKtlFEZqj5zAMYpisqDYP
         EPF7hlwO/eAMwjJabHyugWmDdaPQzsun/7FtUEDemUfkRVvywsmh4BjcPH+TlG3bR3uq
         47v77bmQbYGlxARYU3trdrW1ULzT73fnPrmGYLH+oINbubOZefBg3/pOaTDO75Zr9cVg
         STnGiLg3lTg2A4/RVMc+a/k2ZHUBTsFwgqXNdWqLfRhiNsg87RzyKKHoqErgZZJ2pYJK
         dqqg==
X-Gm-Message-State: APuU4Z+Qe1+utaOS/TDsQfmC2righTlnC8t4JYQ4wqfdQbit7jHmnOTD
	5R6aK4tTqVoZ+DUA6k0MVtHzHGI7MrSsh2S08GuhjzZtcX4tPi3cnhMPmEAeiA==
X-Gm-Gg: AZFdTZf7wSS2CtYrNznFWrZyxZgsD+NACadbPq91v28h5qXCscpzhLq+PWr08Yc8PTY
	oVHWjVOdXYExHspYPZUcg989BUGMgwG2Er+1srGToRXneE0COWZ+HU6HzqyLW1q3J2bbgtw23Wd
	X6P8rnOpWpQg/jzB/MIJfKuacqUdRNo77R0jZQl2u71jymQNnvIYwSW+veg+CUshFN6/aVnTP2+
	Xb+OjaRBw/c8R8FS8wZn4th0SIckFs1qocLRKyO6eesvLgNxi9F9n9nzH19gjpaPmMzKBVqE48A
	xYLxXiqyZt8wdkVewJpxFaThbtmHERguw7OQ+ApPX4mLUOiLq6VAZFf9nr7B3VQmLIVn/7ZI4op
	9ezHfZ9DbY8KdqPI7MD1OjPnc3GGvB6eTTnfzXyADa7wjDUYdi4ibZRPbmjBDcKBYru37zDNaaU
	c5+qHiu/n5FJXfTPDOoBn5i7Z9VIoy+frH99jWmHfIdi3eAIb25qEpIDnH9u8xSnx2M0pOBfKgA
	HQcVTTpeeD6l2JKNMI6JBeb+1bOGYTc1BFMfFfrH2fOPSUO59LBWp7yPiPq2765ISzFMK1EBRBx
	bUkY9edMoJnsGvOdow5r3Po+3PLcvFQuaYrGHSTIYZV9KHYWQEmCtEo=
X-Received: by 2002:a17:90b:3d92:b0:3b3:b621:4026 with SMTP id 98e67ed59e1d1-3b41c55a4aemr23005645a91.0.1795765223016;
        Thu, 26 Nov 2026 23:40:23 -0800 (PST)
Received: from localhost.localdomain ([219.251.253.167])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405d639fdsm39908375a91.10.2026.11.26.23.40.22
        for <drbd-dev@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 26 Nov 2026 23:40:22 -0800 (PST)
From: Kitae Yoo <ryugitae777@gmail.com>
To: drbd-dev@lists.linux.dev
Subject: Re: [PATCH] drbd: fix resync stall when P_RS_CANCEL_AHEAD overtakes the state change
Date: Fri, 27 Nov 2026 16:40:19 +0900
Message-ID: <20261127074019.53346-1-ryugitae777@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261126103713.45457-1-ryugitae777@gmail.com>
References: <20261126103713.45457-1-ryugitae777@gmail.com>
X-Mailing-List: drbd-dev@lists.linux.dev
List-Id: <drbd-dev.lists.linux.dev>
List-Post: <mailto:drbd-dev@lists.linux.dev>
List-Help: <mailto:drbd-dev+help@lists.linux.dev>
List-Subscribe: <mailto:drbd-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:drbd-dev+unsubscribe@lists.linux.dev>
List-Owner: <mailto:drbd-dev+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

More test data for this patch, on a setup the original notes did not
cover (more than two nodes, newer kernel):

  DRBD 9.3.4 (Ubuntu PPA 9.3.4-1ppa1~resolute1), kernel 7.0.0-43-generic,
  3 diskful nodes on one 1GbE LAN, replication over a WireGuard tunnel,
  protocol A, on-congestion pull-ahead, congestion-fill 8M,
  sndbuf-size 10M, 20G volume, resources managed by LINSTOR 1.35.2.

  Workload on the primary, after the initial sync had finished:
  12 bursts of 20s 64k random writes (fio, iodepth 16, direct I/O)
  with 5s pauses in between.

Unpatched, 4 runs: a resync stalled in every run. Each stalled target
sat at done:0.00 with about 4GB out of sync and "postponing
start_resync" repeating; in the first run both secondaries stalled at
the same time and stayed that way for more than 15 minutes until I
reconnected. In the run I inspected in detail, the target's log shows
the case 1 order from the patch notes. A disconnect/connect recovered
every time.

Patched module on all three nodes, 3 runs of the same workload:
0 stalls. Every "peer pulled ahead during resync" on a target was
followed by "peer back from ahead, resuming resync requests", and the
resync finished about 90s after the last burst. Online verify between
all three pairs found no differences after each run (patched and
unpatched).

The stale "postponing start_resync" messages from the side note still
show up with the patch, about 2000 lines per run on each target.

Thanks,
Kitae
