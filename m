Return-Path: <philipp.reisner@linbit.com>
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com
	[209.85.219.181])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id A48D4420167
	for <drbd-dev@lists.linbit.com>; Fri, 28 Jun 2024 14:20:00 +0200 (CEST)
Received: by mail-yb1-f181.google.com with SMTP id
	3f1490d57ef6-e02c4983bfaso500209276.2
	for <drbd-dev@lists.linbit.com>; Fri, 28 Jun 2024 05:20:00 -0700 (PDT)
MIME-Version: 1.0
References: <20240624054619.23212-1-zhengbing.huang@easystack.cn>
	<20240624054619.23212-7-zhengbing.huang@easystack.cn>
In-Reply-To: <20240624054619.23212-7-zhengbing.huang@easystack.cn>
From: Philipp Reisner <philipp.reisner@linbit.com>
Date: Fri, 28 Jun 2024 14:19:48 +0200
Message-ID: <CADGDV=U1EG9Zd22ujB=fUGCoExMhCLF6fYGj171MVKxabxz=iA@mail.gmail.com>
Subject: Re: [PATCH 07/11] drbd_transport_rdma: put kref in dtr_remap_tx_desc
	error
To: "zhengbing.huang" <zhengbing.huang@easystack.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Cc: Dongsheng Yang <dongsheng.yang@easystack.cn>, drbd-dev@lists.linbit.com
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

Hello Dongsheng,

This looks wrong. In this loop, we are trying to find a path on which
to repost this tx_desc. When the remapping fails, there is no reason
to drop the drop a ref on the cm.

So, please provide a description what you are intending here with this chan=
ge?

best regards,
 Philipp

On Mon, Jun 24, 2024 at 9:27=E2=80=AFAM zhengbing.huang
<zhengbing.huang@easystack.cn> wrote:
>
> From: Dongsheng Yang <dongsheng.yang@easystack.cn>
>
> Signed-off-by: Dongsheng Yang <dongsheng.yang@easystack.cn>
> ---
>  drbd/drbd_transport_rdma.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drbd/drbd_transport_rdma.c b/drbd/drbd_transport_rdma.c
> index c7adc87e3..77ff0055e 100644
> --- a/drbd/drbd_transport_rdma.c
> +++ b/drbd/drbd_transport_rdma.c
> @@ -2355,8 +2355,11 @@ static int dtr_repost_tx_desc(struct dtr_cm *old_c=
m, struct dtr_tx_desc *tx_desc
>                         return -ECONNRESET;
>
>                 err =3D dtr_remap_tx_desc(old_cm, cm, tx_desc);
> -               if (err)
> +               if (err) {
> +                       pr_err("dtr_remap_tx_desc failed cm : %px\n", cm)=
;
> +                       kref_put(&cm->kref, dtr_destroy_cm);
>                         continue;
> +               }
>
>                 err =3D __dtr_post_tx_desc(cm, tx_desc);
>                 if (!err) {
> --
> 2.27.0
>
