Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8AF2DD5F6
	for <drbd-dev@lists.linux.dev>; Fri,  5 Jun 2026 12:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780662918; cv=pass; b=NU5jY/KFxOqa8amR2Ebq3xkCFmfODqVGo4DPD/1EeLMI+7BGwwEXIoWCehGVsSZ2xnnuKc/qK6HJhQeDdGwYdbIzqIi4Pj1Uv1jRLjy4YVSU1T6S1wvSOURnUoqOJ0zjq51ELviVsb3uGES0FbFyDle64drMqCozgIIB69pRWaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780662918; c=relaxed/simple;
	bh=+jVpVT13tOKcUR4eRfXjMOST0VhBEsapTYLVX3tBBio=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HRQ9QuYizoDSbAtaXl5zEx8kf/XymVpfGjD2tgEMaVcb7I44cdeZjs+RsqbNb8BGTwSWKG9VfvEO8aPMtAqYbvtPQu5LkGPIjy1/T/haTwNqybyu9vwUOKBlff3W8SOF0imTjqb88gkxWbtntFkeUBoyG5y0Zj5kwQppnSYGEn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b=OD/mk3HG; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b="OD/mk3HG"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-bec449cf976so250525966b.2
        for <drbd-dev@lists.linux.dev>; Fri, 05 Jun 2026 05:35:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780662915; cv=none;
        d=google.com; s=arc-20240605;
        b=gZvet7ZT0CYliuAPi73cswutljfzPxz27g8zPLx0xtCTPmm3sBi1hzAx7s7CswgtmN
         cnhO3w8dpxVTgJHJzgE2OFpIEztVvdFOfXUFLtui+7gppM2thfhuz3q/+v8pHM/Jt8kx
         al3w3LDNabcpfdzdgtxdOHAYTUF/r72eR2xmA0OPUDib09QKxm40hUaFgXZ1N/J/nA6G
         J2g+Ox3puOgHbM1AfUdfOJsYKaGV15/IUeNdHJw0EaKRivIYHLMRczxAqIW9HkVDYmqG
         CtmWOQQyDf+/cUSv/fqGDJVMuvta9KX+bSnOAC8fHerZ6nf+mOyw69i049JhNJQlus6f
         5zMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5bmybVHFYnA9U5nPnPmp9KS9iyAi/hwfKzKcOqt58Zg=;
        fh=s6vlrM81KvoSMvJnli8WhJwveuztEoaTV40N6o/bGFw=;
        b=KHWfkl6jo2lWVs/bMPjJJO9twFYE5SXqvuB7fvFrWH3AoyqwpIeDNeGRbM9tOePwki
         q89nVufDGGwWa/hs/IM0U5U1GSsSvGpEdjIlCxGH31gpHpuek3Xsa7fUEASQhn/W54l2
         sQAEO+TErAWdglfYnAc4L1UFKrKGcWBgw1QhcKVT0TPu+IMaKcKfl9CLsdwbfUL6jRu0
         0LyBhlRvpcd4MvCiVedqMMzedAfywhCHe/C3Ie8mrjwrx7gUSVDl/twIE+EeKgJ3wT89
         LP2i2U3tbPzb1aDsfdHHhhvywzSXt4IQ7W6sL7cbPDUwKQm/aGHD8SXqW0zxdCezklPW
         QwGQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20251104.gappssmtp.com; s=20251104; t=1780662915; x=1781267715; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5bmybVHFYnA9U5nPnPmp9KS9iyAi/hwfKzKcOqt58Zg=;
        b=OD/mk3HGqSuWF0gsH8fO37ScoNNSdL86nAK9kUL6cjRkh2ycHsX0eUokEEnFMwcQP3
         eT3OmLm5FQtXTBJs+MUxbYCqlIEnQOobJb6ykS6nvymZNGJe4LKDPs0g6Blm7yH2BQxv
         //ODiF3e46xWN3JL5tTvO7n8roTit2QU9+hloJ5iVmI8eO78+p8Suq+R8VlaPArIsBjc
         pGTUApq9991C1clx4vyzUxP/seuioHTbgywCFuuqRWu5rKep4x2vAsnZf9SH2AlVAvPT
         ps0PMpFDambyHsij6tJGaHxbfFDO4Sa57eEfn8J/FVlAF7P4r12it7MZy3CUPwb+2F5p
         QSkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780662915; x=1781267715;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5bmybVHFYnA9U5nPnPmp9KS9iyAi/hwfKzKcOqt58Zg=;
        b=N2ukLa8WxMirv6oeG1hUrTu1d1bk7NuXbx58J9C7nWreZNoKSCdWyDnRgGEIi2BGHV
         VXjOM8FVTCbxjWQ+ykSC4ya1mHU2UNk7VeRqPwnLjVRSthhCwwh/d3Xd9HjluBSZuOVR
         fuour+3zOhtPjOKbgLJRfEgILNoIXYLEeTnniuSolff766bYCDPJzXdxriBWc6ejRBqR
         dI+DBvO8/FSeSKaRpWr7jwUFyawB+XLMhdugloqsqJ1t3AbS7EWRZ2zaq6K+nTLhuka5
         TzpDhrNulxmxx+jvPK0iiLmabr6qXwNIZ5vg+1tiDeKsUNAjqf3857bq/6JsDvgd9gCQ
         QQyg==
X-Forwarded-Encrypted: i=1; AFNElJ//nOTZhFantE/WSKFbu5y8/GXJsCimfjfJWBAnU44UHNDQ66cFgKyc5qHWU8avcL0eU2xTV/kd0w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx5WpOq2vYtgL69F57nPn+BzPjOg3Zw11+PJFbJWOwlxFpWvmwk
	Hy0Bb/bgJiPVjMwEYgMEh9L9AO+/5PJua7hsxhrYnI02yzWZJRrITxva6eOxtfy5N43o9C/aM33
	Xdb80xH5lNZ3kT1V4cm+jVJFXUUpgj382yglWwfhNAeTECSpf3s5ce3o=
X-Gm-Gg: Acq92OH0Irt9vq+U63ikM5Jl8jzBero9qQPRSlAe0DkTEBp2Fgpr/nZCTdVuaFcquR9
	1F14PWvBIoOV5uazDbHqBfGARcjGAAhw8EciRfHVWVtU/UG0exm7lGi8xCQwIqmj6M4PpFiB1TW
	UoRbbejqJISYDfDDaIpf+L8XaRpp8B5hRYryeauPlyF5UXlPUi1IIWzYzX+yJmjbMZ6g+WUT6NW
	lzZoLHQ5njBJw7uBtRjniEWfPEUbDh65qH/uGvKP6eBHVVrW7XyMtjw+uKzqTJ3c4/85pCrdM5H
	OIs6Ku/zQeghLThqsugz
X-Received: by 2002:a17:906:6a02:b0:bd5:2a43:b471 with SMTP id
 a640c23a62f3a-bf373ce91b3mr160007066b.48.1780662914553; Fri, 05 Jun 2026
 05:35:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: drbd-dev@lists.linux.dev
List-Id: <drbd-dev.lists.linux.dev>
List-Subscribe: <mailto:drbd-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:drbd-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260513061212.1919002-1-zhengbing.huang@easystack.cn>
In-Reply-To: <20260513061212.1919002-1-zhengbing.huang@easystack.cn>
From: Philipp Reisner <philipp.reisner@linbit.com>
Date: Fri, 5 Jun 2026 14:35:02 +0200
X-Gm-Features: AVVi8CdtwisqILgQd4fErjSKDguhl6iAFjwXkukMwMXKea3Ae18P5FsXriurDq0
Message-ID: <CADGDV=VPu-ePxUzTeNMTssbBPRDVu-VAh9fAEkP=XNNw_YeV4g@mail.gmail.com>
Subject: Re: [PATCH] rdma: fix cm kref leak caused by race in dtr_disconnect_path
To: "zhengbing.huang" <zhengbing.huang@easystack.cn>
Cc: joel.colledge@linbit.com, drbd-dev@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks, merged.


On Wed, May 13, 2026 at 8:12=E2=80=AFAM zhengbing.huang
<zhengbing.huang@easystack.cn> wrote:
>
> When peer's RoCE NIC goes down unexpectedly, a race condition can occur
> in dtr_disconnect_path() between __dtr_disconnect_path() and the
> subsequent xchg(&path->cm, NULL). If another thread installs a new cm
> via dtr_path_prepare() after __dtr_disconnect_path() returns (or sees
> path->cm as NULL and returns early), the xchg will take the new cm
> whose QP was never moved to ERR state. This leaves posted rx_descs
> stuck in the receive queue with no flush CQEs, preventing their kref
> references on cm from being released, causing a cm kref leak.
>
> Fix by ensuring ib_modify_qp(ERR) is always executed on the cm obtained
> via xchg in dtr_disconnect_path() and dtr_free(), so that posted WRs
> are flushed regardless of whether __dtr_disconnect_path() successfully
> processed that cm. Extract the QP->ERR logic into __dtr_modify_qp_to_err(=
)
> helper for reuse across __dtr_disconnect_path, dtr_disconnect_path,
> dtr_remove_cm_from_path, and dtr_free.
>
> Signed-off-by: zhengbing.huang <zhengbing.huang@easystack.cn>
> ---
>  drbd/drbd_transport_rdma.c | 48 +++++++++++++++++++++-----------------
>  1 file changed, 27 insertions(+), 21 deletions(-)
>
> diff --git a/drbd/drbd_transport_rdma.c b/drbd/drbd_transport_rdma.c
> index 195e45648..9099fee93 100644
> --- a/drbd/drbd_transport_rdma.c
> +++ b/drbd/drbd_transport_rdma.c
> @@ -346,6 +346,7 @@ static void dtr_free_tx_desc(struct dtr_cm *cm, struc=
t dtr_tx_desc *tx_desc);
>  static void dtr_free_rx_desc(struct dtr_rx_desc *rx_desc);
>  static void dtr_cma_disconnect_work_fn(struct work_struct *work);
>  static void dtr_disconnect_path(struct dtr_path *path);
> +static void __dtr_modify_qp_to_err(struct dtr_cm *cm);
>  static void __dtr_disconnect_path(struct dtr_path *path);
>  static int dtr_init_flow(struct dtr_path *path, enum drbd_stream stream)=
;
>  static int dtr_cm_alloc_rdma_res(struct dtr_cm *cm);
> @@ -507,8 +508,10 @@ static void dtr_free(struct drbd_transport *transpor=
t, enum drbd_tr_free_op free
>                 struct dtr_cm *cm;
>
>                 cm =3D xchg(&path->cm, NULL); // RCU xchg
> -               if (cm)
> +               if (cm) {
> +                       __dtr_modify_qp_to_err(cm);
>                         kref_put(&cm->kref, dtr_destroy_cm);
> +               }
>         }
>
>         timer_delete_sync(&rdma_transport->control_timer);
> @@ -1091,15 +1094,8 @@ static void dtr_remove_cm_from_path(struct dtr_pat=
h *path, struct dtr_cm *failed
>         struct dtr_cm *cm;
>
>         cm =3D cmpxchg(&path->cm, failed_cm, NULL); // RCU &path->cm
> -       if (cm =3D=3D failed_cm && cm->id && cm->id->qp) {
> -               struct drbd_transport *transport =3D path->path.transport=
;
> -               struct ib_qp_attr attr =3D { .qp_state =3D IB_QPS_ERR };
> -               int err;
> -
> -               err =3D ib_modify_qp(cm->id->qp, &attr, IB_QP_STATE);
> -               if (err)
> -                       tr_err(transport, "ib_modify_qp failed %d\n", err=
);
> -
> +       if (cm =3D=3D failed_cm) {
> +               __dtr_modify_qp_to_err(cm);
>                 kref_put(&cm->kref, dtr_destroy_cm);
>         }
>  }
> @@ -2667,9 +2663,25 @@ static void dtr_end_tx_work_fn(struct work_struct =
*work)
>         kref_put(&cm->kref, dtr_destroy_cm);
>  }
>
> -static void __dtr_disconnect_path(struct dtr_path *path)
> +static void __dtr_modify_qp_to_err(struct dtr_cm *cm)
>  {
> +       struct dtr_path *path =3D cm->path;
> +       struct drbd_transport *transport =3D path->path.transport;
>         struct ib_qp_attr attr =3D { .qp_state =3D IB_QPS_ERR };
> +       int err;
> +
> +       /* between dtr_alloc_cm() and dtr_cm_alloc_rdma_res() cm->id->qp =
is NULL */
> +       if (!cm->id || !cm->id->qp)
> +               return;
> +
> +       /* With putting the QP into error state, it has to hand back all =
posted rx_descs */
> +       err =3D ib_modify_qp(cm->id->qp, &attr, IB_QP_STATE);
> +       if (err)
> +               tr_err(transport, "ib_modify_qp failed %d\n", err);
> +}
> +
> +static void __dtr_disconnect_path(struct dtr_path *path)
> +{
>         struct drbd_transport *transport;
>         enum connect_state_enum a, p;
>         bool was_scheduled;
> @@ -2741,15 +2753,7 @@ static void __dtr_disconnect_path(struct dtr_path =
*path)
>                         cm->state);
>
>   out:
> -       /* between dtr_alloc_cm() and dtr_cm_alloc_rdma_res() cm->id->qp =
is NULL */
> -       if (cm->id->qp) {
> -               /* With putting the QP into error state, it has to hand b=
ack
> -                  all posted rx_descs */
> -               err =3D ib_modify_qp(cm->id->qp, &attr, IB_QP_STATE);
> -               if (err)
> -                       tr_err(transport, "ib_modify_qp failed %d\n", err=
);
> -       }
> -
> +       __dtr_modify_qp_to_err(cm);
>         /*
>          * We are expecting one of RDMA_CM_EVENT_ESTABLISHED, _UNREACHABL=
E,
>          * _CONNECT_ERROR, or _REJECTED on this cm. Some RDMA drivers rep=
ort
> @@ -2836,8 +2840,10 @@ static void dtr_disconnect_path(struct dtr_path *p=
ath)
>         cancel_work_sync(&path->refill_rx_descs_work);
>
>         cm =3D xchg(&path->cm, NULL); // RCU xchg
> -       if (cm)
> +       if (cm) {
> +               __dtr_modify_qp_to_err(cm);
>                 kref_put(&cm->kref, dtr_destroy_cm);
> +       }
>  }
>
>  static void dtr_destroy_listener(struct drbd_listener *generic_listener)
> --
> 2.43.0
>
