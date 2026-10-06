Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4103B8BC1
	for <drbd-dev@lists.linux.dev>; Tue,  6 Oct 2026 07:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791272944; cv=pass; b=Zk0BJKpJvYwk7QPvtiKlNsSICAvjw+uQgjIOi800vEIywTJKdE0P0caHnkPfGsgcUWeuvKJKerZdbf51iKYPhnj3GleiN26tYrrEx5ABMQq1zdAeFgHGb3dumfj4yzx8F3iPIzer0eBIiSCFxMGlBRH5jYQ5xGk2rxaHMdsgZac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791272944; c=relaxed/simple;
	bh=EjxOLQXTiEKUjAkVwjaXXFmEhgPUo75BO536t5uUPtI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pyz8vvWNsARSwVgx1ok0C+jZlDQUGStENkQVC4qBQtLqiXi+Skee9F16FMkEotxPQuwlFHxadgc2BLVp1uBLBBdaSN9CALkoetVU9Ids1CkU4r44XVO5lIkvFE+Goy7u+LD8OMQBijxJpvR6I/BoTqt3lWJ9QFfN8D6yQrRYVRA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit.com header.i=@linbit.com header.b=sOC+aSMg; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit.com header.i=@linbit.com header.b="sOC+aSMg"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6aa97edc48cso633604a12.3
        for <drbd-dev@lists.linux.dev>; Tue, 06 Oct 2026 00:49:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791272940; cv=none;
        d=google.com; s=arc-20260327;
        b=jTTJultqvXDAoJnPpf38EQ+978fQHSlDM5LBIwbFh3C3KEx0FE4puYRAKswHZ6PoXe
         /w8M5qrcKGACjqSM+UNHACyyfP7UGS1he/18KPx64Gj/mXXtCPzqY/7vvLNNhLv6jqOu
         uVlh4ZVwLIZ7vIgddod2BfHzksLlJ/o6cS/VRSA1ASnz3pvYv81DbPwGqjwbqvLVHzMg
         TWSCsMOv/6rFlNXKXut7AmmvTLA8FruPdnulVhy/RMDqkt5iBEf06EjuLigU/QCgXK5W
         CUj7t7Vn8fqYX5cfIwWiiHnW66C5kipib8uFmPEYxykcXTEBwh+4+3FO5uLrZrS0SDJv
         LI3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=EjxOLQXTiEKUjAkVwjaXXFmEhgPUo75BO536t5uUPtI=;
        fh=U9do9q1TCA/NRbK6aaUWE3E6wDTpZmT8q2BfY6w+Cmk=;
        b=Lj7KgVJrk3fguways5yevnPxOp1BajMC5qJG3M0Sc6d83W2vZe2OI/BLEFBOVSVQ2C
         dR+v+1XfMFt9Ml4wuOVgGtbkvBTfh8vhBbO3qLfV938V9FOIazbziQNVwijE0yGhWwhJ
         jKY1Dod2nOrtmDgFS+jM5D6Bxsu1jjFLPTSrUZLu9SmhmwVu//7IesV/doLSwvz7gZ1i
         RR0z32Qd+jgedWB+LqZRq2Mgeoi3HIUpnlZWs+//Nx5hHFVm3kBCH6uWanX+3J5qbcqW
         lB8/kn/THD4Ksj/89hSkFzBi+7TKNUEsLoVV+VxJi/eqsD1KWRizPk0G/jSlosV0/chB
         KBEg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit.com; s=google; t=1791272940; x=1791877740; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EjxOLQXTiEKUjAkVwjaXXFmEhgPUo75BO536t5uUPtI=;
        b=sOC+aSMg52Odd4hzOfF0pREp5HXWE0a0iKElYd1cp1Y52ECwtgjKYsJwem1emokvlF
         49CHuS9+YcdAO0TguicMQj79hXLjL5HP+KnSmHNqiw8PsexwJBqfcsDnVvhoPsoV5ivO
         bMY8LDX2FFl3d4xZ3ge5uVioKGqVkGpOo7SAgj0KonMQVH9noqPfYjDxcKFodCUWLZbn
         nEcjRY1ZjX8Ya3z1pYKVmrHiOSVROOx87buEktqjUh53nOfY5Tqy0I6MBYOwiMTs4SHC
         Z6S+F79ZfSEE84NEiMQG5cqnHiKMer3uF+4oaEXSJJmCt2FlE7anuIY2fcER8WqSw1Z6
         xw4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791272940; x=1791877740;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=EjxOLQXTiEKUjAkVwjaXXFmEhgPUo75BO536t5uUPtI=;
        b=OK6D+R+bTUdhri+zOggrrvAcywOoY4kQiIaWcoaDQO10CqvZAB/wxQvxSkoA+U8xjC
         QupNuTPKXeTuDn6bXd9iHcDM2AYLcGlpbOdV0y34bPvDbOymWJQ/6J+Dh31C5loJ6p9/
         3PGV6L2P5Rc/KIo+0NlwiZUlIRbkd2saQb7mlH1ieQMjq/wVFSLzzuvreP1VyLQ3Bywh
         DbUM9PnyD5nOwkkFAljYkFF6Lfsu/TxOP+wxc44F7sgJVyES2jGrPkc4bjXbMJAInWIJ
         2oOI5mFXvh4V5YH0h+Gck931xkU/4FHWdoIBZb3ffKxoSvg/S2RZGP+a0Brh1C0N0L4I
         6HgA==
X-Forwarded-Encrypted: i=1; AKwUvByyBlWuRiXL17VV4uwD9VFDoqeSTbHPFy5/PMHDl6ibnu4L5/IxR6poxDGbF4r2SYCIA/ExBlJVkg==@lists.linux.dev
X-Gm-Message-State: AFq9FYLZ1Hu46HKwLLQ5aYNYiNL+OHZJs9RgFgt0HrCSmkgHOD3qW6kZ
	dhptQFr5okGgprW65wCqOVJ82YwyuiKieyoMZP32EP0sbccSH5yMc2hkFSaXv9pqJZcegXI5ud9
	+i7dhSPofWT7CdmPtaVcVsdmZsVgCVPHw1Cn+uk4+sg==
X-Gm-Gg: AYBFou1crDKHsunos5+o/iBbhCRLL6BBz0DV6sVjMZwYsX1Lq9KM5lxP9osA8G+0VSq
	VZj9v40RBhj7S5v3Bb0tN75zzdwBoapYMDOsBsLrP67GLe4GFalfviVJW2SHvGdO3gjGFUECg/9
	8BHeVJADiflC3mGGq8ERp5SCVizBn60SCpsdWKwMIeYPlojcOeBThd/sEshZksAxh8YlGeMEQ+g
	Mu9dwmHLrwa/euS68gtEob47mN9QcuuWFdLmKS56NOQXBjgNXMIdbnnex5aptGGhAzWsfLUTVDg
	AODDH79OwaH0O25pH1v8Bk9qUB4DHHtjbqMTVa9NhXtnfgb1LxSp6TgnJBw=
X-Received: by 2002:a05:6402:1907:b0:6ac:bd53:d29a with SMTP id
 4fb4d7f45d1cf-6afe290339fmr597357a12.3.1791272940042; Tue, 06 Oct 2026
 00:49:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: drbd-dev@lists.linux.dev
List-Id: <drbd-dev.lists.linux.dev>
List-Subscribe: <mailto:drbd-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:drbd-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20261006035715.354417-1-yhlee@isslab.korea.ac.kr>
In-Reply-To: <20261006035715.354417-1-yhlee@isslab.korea.ac.kr>
From: Philipp Reisner <philipp.reisner@linbit.com>
Date: Tue, 6 Oct 2026 09:48:48 +0200
X-Gm-Features: AclHuK93qFWTt0rPdrolX-1FvRtK-xCdn7iYpv4S1vx0jkfxOiNyhJFdse2ACcs
Message-ID: <CADGDV=V5NJViqSKS0JpFrm1U_2pGRBf1iE30hn+yuR7NmN9iXQ@mail.gmail.com>
Subject: Re: [PATCH] drbd: reject an out-of-range offset when decoding a
 compressed bitmap
To: yhlee@isslab.korea.ac.kr
Cc: lars.ellenberg@linbit.com, christoph.boehmwalder@linbit.com, 
	axboe@kernel.dk, drbd-dev@lists.linux.dev, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, Oct 06, 2026 at 03:57 UTC, Yehyeong Lee wrote:
> recv_bm_rle_bits() decodes a run-length-encoded bitmap from the peer and
> accumulates the bit position s across the runs. The upper bound
> (e >= c->bm_bits) is only checked in the branch taken for a set-bits
> (toggle) run, so a clear run advances s with no check at all.

Thanks for the report and the analysis, this is correct.

> + if (s > c->bm_bits) {
> + drbd_err(peer_device, "bitmap overflow (s:%lu) while decoding bm RLE packet\n", s);
> + return -EIO;
> + }

Checking only after the loop is not sufficient, though. A single VLI
code decodes to a run length of up to 2^56 + some, and one compressed
bitmap packet can carry a few hundred such codes.

Please check every run right after decoding it, before s is advanced:

if (rl > c->bm_bits - s) {
drbd_err(...);
return -EIO;
}

That keeps s <= c->bm_bits throughout, so neither s nor e can wrap,
and since rl >= 1 it also implies e < c->bm_bits for set runs.

Could you send a v2 along those lines?

Best regards,
Philipp
