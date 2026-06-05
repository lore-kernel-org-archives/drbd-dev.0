Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098FB40E8FD
	for <drbd-dev@lists.linux.dev>; Fri,  5 Jun 2026 13:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780666030; cv=pass; b=p+GgPFyUlTO1GJmPu6ks5aejI7Ap8U2EpP3bbxP2JTSbMx3b9Jp0YR5l5myYOqyVwiPbkqfX7qPBcTfErtkOsct//4dMgIJokMcGi7ipCT/sAjL3DeyJKj3M8Kv5vDTyDHkTKH25vu6UnxDrmyTdFwLO9FVTbMrPPOQ2qcsoapg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780666030; c=relaxed/simple;
	bh=7RHe36LRAJK1EW/vhXh7OS46vYnzMFtf5HZBIACtdwU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lxRAmEUAb5zIYgQQEv6SfrCmTnOrgqwHnq6FF+OL3i1YMk2rI3rC0DdPo8SzyncFjrehZIw39mxZO1+Fwyg31YqWdMK6SisvV+eQYMLPGnLgWzgM78Kowu/+V1DTaOiEOYHoOroFFZDmQGofm01DSN0QLCsuucTIRB2I9DGe83E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b=ly91M9QY; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b="ly91M9QY"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-68ca6f01079so2239226a12.0
        for <drbd-dev@lists.linux.dev>; Fri, 05 Jun 2026 06:27:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780666027; cv=none;
        d=google.com; s=arc-20240605;
        b=NLzwi2uPgzk/n1XGQumRDeIMzOEPe32WC/lJwgMSUWvP46pvKcnwGmKO2a7zpSceGe
         /hfK0mcn2Psp/oaanQsdp1iZ8eIa33S6X2b4iMU4oJfTSD3bO6pi9VjX/nUbKNzZ8kOg
         EapYFsbs/dbTXui9qcxHj9KXSN/GkvS6xN3QYA+9Ut+Zb98dem1NTmAeWvtMgbzbxR0y
         lhfEpY63mLwDTiyxmezJDansmBYzM1s71GO4iv9SjXzBnwbCJ9vwETqrBniO3PL2A/Vh
         ORty/MTGd2Eo+gHpIfbQ7nihGAofe//6bEfGHA9Jl/zAo/DCdM1acF5+vw2TdvRjXxEW
         nwVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=57Fchk4UbJPCvgeG8uKrKVu/ZdJJkjTVgvF3//OForE=;
        fh=MJcPQ7g02SMB3zMh8hyfGmkpRz+wW1ksaziWdmj/o80=;
        b=eEtHJErj5Jt7MMoFQ4OswyfsjkKVIpNXU1xv6vjnvRzx2lxZG2tD3jBmpZejrOvwPk
         vAD2iiW/z8NFktKp/zoGdkFjFMtKQvbFBt5YlrAoalmir0DkhLOTzCO+41aD+UYPrpt2
         U3NfUPEBBAHo6bioPFdLnn3sYRuKyeUeNP53OT/+DanD/Ns96E1Usld598tS++NjYUtI
         LNZfDb4QdiNvu3C1D5pyHa/NnwtfF4/cx8ZHTIO8Bdcq5HuIXQVef7tgHmqhbYd6QtHK
         zhuU7WCGaXdSZfj9ObqepNk+N5GKxk9a4/f1T1lMSA72rDTsR+STdOAdPHaelTKh1oP6
         przQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20251104.gappssmtp.com; s=20251104; t=1780666027; x=1781270827; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=57Fchk4UbJPCvgeG8uKrKVu/ZdJJkjTVgvF3//OForE=;
        b=ly91M9QYZSIM0P0bo9Rwm3BbNLOUBdFwL1vTpuMbmSWIoEVFzjUmKq1+MavH/UJ/G3
         wWrSiUIyMX+AJnBSQhx7dqYnYoV2dbdvLsIo26z2ft2HtbIvetN1xbDmzhEPdPDwXnKK
         H75ngtGTD304DeD27GlpaOSUYT0DjJH2LfuS2FJE50uBgjUaiw//41qoSWIXdG9J0npX
         /x78vOnFaOBKa8HYvyrik7TeHrE/lfxtHcMenojrda6LDuXEAMWtT2BUsPvjAvcmp8Bg
         1gbrGEyr8B47J5Zj+ihslTLgINgi5SAi/PTUNthYr752K3MOLbD82mLeT+6VDLO6eVXe
         jzJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780666027; x=1781270827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=57Fchk4UbJPCvgeG8uKrKVu/ZdJJkjTVgvF3//OForE=;
        b=NaIyz8yq8vLwlogR62w39lrH1ldyIbeCqWoivDxscXs6p5t2LK6TttJnUmUwUW1omj
         LHf4P3i/IvMDXLc+URfnJs/7xEbMGTBDowa6YO7buQLAlNDYeU1xAn4By0V+tMrkajk/
         WELSHi60AqLOJDLrqjN9JfjX5AEuWOFYKPrZGzfyUWkl98R3COKpObBOkUTP7DSmMxno
         TaYT5tywvfpk3ZA59J+pCPi4onZ/cmP+Zc0HoW81NijBDM7rxElo/uC3PHSxEVjjlkTK
         3mWvAfryATNyJ+ErZfNv2WapjLtGm3tEXOQYM08hR1VZ9Wp7GxFKHSF2V9oaAwe9YMaP
         V6sA==
X-Forwarded-Encrypted: i=1; AFNElJ/1lf0E3d6OjQ87/Z9XwHqIaTEQ96B/BbAWj5LaZSYFYgChLxyeUUSCjZw+ZLi23Z9THrJCIJhChg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyZ9D/FAgl/hXWrqjRhtuyOD6qzryQBoigyAS+3N0jjph6RA2Uc
	2Lv+a84f5UQR9rn+KC4iMxZsAEFnLSLG01NEkrim5VSVE+cW69Kkj9mLNoZ+h7Tdv2rTRuqTryk
	XqQ8zT6a7SKO0h88LqBCLLbbFv/1a4T+QjF2i38Q9HoL0mXaCzoPQg7A=
X-Gm-Gg: Acq92OE4LTQXGhIwaOrwmrGnOBA0e6M+7jzTodw77KEQO0kPQ2njQfnKZyftw89C3pZ
	FQ2YG4RBFGwUiSFKFue1Qz07IcyBk8p7Dl5+Cdo1kdN/L/cv1EkmU/FRErHn9wbRzeBmNYiPkLf
	4sVKAL3ONUOyL11zGTe1agqYYKu3e9LbUgGOvX5qToxHsqN5ieR2u11lxK8Fx589CngRuwd3VGB
	YA3x2xHX6PuaJE++pt3h5ld30wazoB8eDdupIx6puBhxhvpAcFtlDYKJvI31N4lZ3W9CuRDWriS
	h+VU7rAHhk4d0lPZlP4iqka/SS+YJ9M=
X-Received: by 2002:a05:6402:4014:b0:689:c099:ef99 with SMTP id
 4fb4d7f45d1cf-68fa51526fcmr1724932a12.22.1780666027340; Fri, 05 Jun 2026
 06:27:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: drbd-dev@lists.linux.dev
List-Id: <drbd-dev.lists.linux.dev>
List-Subscribe: <mailto:drbd-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:drbd-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260528032403.4066750-1-zhengbing.huang@easystack.cn>
In-Reply-To: <20260528032403.4066750-1-zhengbing.huang@easystack.cn>
From: Philipp Reisner <philipp.reisner@linbit.com>
Date: Fri, 5 Jun 2026 15:26:56 +0200
X-Gm-Features: AVVi8CcojkxGvTC_f8jP91LOZFoa44h67ccX96tNb9B7LiI1a6VB7F6ZoiSQ_o4
Message-ID: <CADGDV=WgH8dXJt+mwqMjFfjLWThSgqiOkiEDokysrGcg2sFDKw@mail.gmail.com>
Subject: Re: [PATCH] rdma: fix self-deadlock in dtr_cma_event_handler calling rdma_destroy_id
To: "zhengbing.huang" <zhengbing.huang@easystack.cn>
Cc: joel.colledge@linbit.com, drbd-dev@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Merged. Thanks!

On Thu, May 28, 2026 at 5:24=E2=80=AFAM zhengbing.huang
<zhengbing.huang@easystack.cn> wrote:
>
> deadlock stack:
> [<0>] rdma_destroy_id+0x24/0x48 [rdma_cm]
> [<0>] __dtr_destroy_cm+0x118/0x160 [drbd_transport_rdma]
> [<0>] dtr_remove_cm_from_path+0xf4/0x100 [drbd_transport_rdma]
> [<0>] dtr_cma_retry_connect+0x24/0xa0 [drbd_transport_rdma]
> [<0>] dtr_cma_event_handler+0x2fc/0x788 [drbd_transport_rdma]
> [<0>] cma_cm_event_handler+0x38/0xf0 [rdma_cm]
> [<0>] cma_ib_handler+0xa0/0x2c8 [rdma_cm]
> [<0>] cm_process_work+0x30/0x278 [ib_cm]
> [<0>] cm_queue_work_unlock+0x80/0x160 [ib_cm]
> [<0>] cm_rej_handler+0xf4/0x288 [ib_cm]
> [<0>] cm_work_handler+0x108/0x420 [ib_cm]
>
> dtr_cma_event_handler() is called from the IB CM workqueue which holds
> handler_mutex.  On error events (REJECTED, CONNECT_ERROR, etc.) it
> called dtr_cma_retry_connect() -> dtr_remove_cm_from_path() ->
> kref_put(dtr_destroy_cm), which drops the path->cm ref.  When that was
> the last kref, __dtr_destroy_cm() -> rdma_destroy_id() tried to lock
> handler_mutex again, causing self-deadlock.
>
> Fix by taking a shield kref before dtr_cma_retry_connect(), so the
> kref_put inside dtr_remove_cm_from_path() never reaches zero.  The
> shield ref is then released at function exit via dtr_destroy_cm_keep_id
> (which does not call rdma_destroy_id).  In the connecting case, the
> shield ref is dropped explicitly while refcount is still >=3D 2, so
> dtr_destroy_cm is not invoked either.
>
> Signed-off-by: zhengbing.huang <zhengbing.huang@easystack.cn>
> ---
>  drbd/drbd_transport_rdma.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drbd/drbd_transport_rdma.c b/drbd/drbd_transport_rdma.c
> index 9099fee93..e513339a7 100644
> --- a/drbd/drbd_transport_rdma.c
> +++ b/drbd/drbd_transport_rdma.c
> @@ -1313,11 +1313,13 @@ static int dtr_cma_event_handler(struct rdma_cm_i=
d *cm_id, struct rdma_cm_event
>                 // pr_info("event =3D %d, status =3D %d\n", event->event,=
 event->status);
>                 set_bit(DSB_ERROR, &cm->state);
>
> +               /* shield ref: prevent the last kref put calling rdma_des=
troy_id() here */
> +               kref_get(&cm->kref);
>                 dtr_cma_retry_connect(cm->path, cm);
>                 connecting =3D test_and_clear_bit(DSB_CONNECTING, &cm->st=
ate) ||
>                         test_and_clear_bit(DSB_CONNECT_REQ, &cm->state);
> -               if (!connecting)
> -                       return 0; /* keep ref; __dtr_disconnect_path() wo=
n */
> +               if (connecting)
> +                       kref_put(&cm->kref, dtr_destroy_cm);
>                 break;
>
>         case RDMA_CM_EVENT_DISCONNECTED:
> --
> 2.43.0
>
