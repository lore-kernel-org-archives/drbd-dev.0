Return-Path: <philipp.reisner@linbit.com>
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com
	[209.85.219.182])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 2EC23160953
	for <drbd-dev@lists.linbit.com>; Fri,  2 May 2025 11:48:24 +0200 (CEST)
Received: by mail-yb1-f182.google.com with SMTP id
	3f1490d57ef6-e740a09eae0so1626052276.1
	for <drbd-dev@lists.linbit.com>; Fri, 02 May 2025 02:48:24 -0700 (PDT)
MIME-Version: 1.0
References: <20250417060819.2157347-1-zhengbing.huang@easystack.cn>
In-Reply-To: <20250417060819.2157347-1-zhengbing.huang@easystack.cn>
From: Philipp Reisner <philipp.reisner@linbit.com>
Date: Fri, 2 May 2025 11:48:13 +0200
Message-ID: <CADGDV=UZGxQv=UnKp54ryKN9rnb1_1UF83iFb5UpjMKShZF97w@mail.gmail.com>
Subject: Re: [PATCH] rdma: Fix cm leaks in some abnormal scenarios
To: "zhengbing.huang" <zhengbing.huang@easystack.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Cc: drbd-dev@lists.linbit.com
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <https://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <https://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hi Zhengbing,

Thanks applied.
PS: I had to remove the change to the unpublished change to the
drbd-headers from your patch.

Best regards,
 Philipp

On Thu, Apr 17, 2025 at 8:23=E2=80=AFAM zhengbing.huang
<zhengbing.huang@easystack.cn> wrote:
>
> In dtr_create_rx_desc() function, if ib_dma_map_single() return an
> error, it goes to error code branch, which does not subtract 1
> from the reference count of cm.
>
> In dtr_post_tx_desc() function, in the retry code branch, has similar iss=
ues.
>
> Signed-off-by: zhengbing.huang <zhengbing.huang@easystack.cn>
> ---
>  drbd/drbd-headers          |  2 +-
>  drbd/drbd_transport_rdma.c | 14 ++++++++++----
>  2 files changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/drbd/drbd-headers b/drbd/drbd-headers
> index 94f447251..9188ee14f 160000
> --- a/drbd/drbd-headers
> +++ b/drbd/drbd-headers
> @@ -1 +1 @@
> -Subproject commit 94f4472513f351efba5788f783feba6ac6efe9fc
> +Subproject commit 9188ee14f6de582a493d260c091db0c655b30d50
> diff --git a/drbd/drbd_transport_rdma.c b/drbd/drbd_transport_rdma.c
> index 9ce15a0ce..be919a926 100644
> --- a/drbd/drbd_transport_rdma.c
> +++ b/drbd/drbd_transport_rdma.c
> @@ -2080,8 +2080,10 @@ static int dtr_create_rx_desc(struct dtr_flow *flo=
w, gfp_t gfp_mask)
>         rx_desc->sge.addr =3D ib_dma_map_single(cm->id->device, page_addr=
ess(page), alloc_size,
>                                               DMA_FROM_DEVICE);
>         err =3D ib_dma_mapping_error(cm->id->device, rx_desc->sge.addr);
> -       if (err)
> -               goto out;
> +       if (err) {
> +               tr_err(transport, "ib_dma_map_single() failed %d\n", err)=
;
> +               goto out_put;
> +       }
>         rx_desc->sge.length =3D alloc_size;
>
>         atomic_inc(&flow->rx_descs_allocated);
> @@ -2094,6 +2096,9 @@ static int dtr_create_rx_desc(struct dtr_flow *flow=
, gfp_t gfp_mask)
>                 dtr_free_rx_desc(rx_desc);
>         }
>         return err;
> +
> +out_put:
> +       kref_put(&cm->kref, dtr_destroy_cm);
>  out:
>         kfree(rx_desc);
>         drbd_free_pages(transport, page, 0);
> @@ -2396,9 +2401,10 @@ retry:
>                 return -EINTR;
>
>         flow =3D &cm->path->flow[stream];
> -       if (atomic_dec_if_positive(&flow->peer_rx_descs) < 0)
> +       if (atomic_dec_if_positive(&flow->peer_rx_descs) < 0) {
> +               kref_put(&cm->kref, dtr_destroy_cm);
>                 goto retry;
> -
> +       }
>         device =3D cm->id->device;
>         switch (tx_desc->type) {
>         case SEND_PAGE:
> --
> 2.43.0
>
