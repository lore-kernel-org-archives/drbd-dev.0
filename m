Return-Path: <philipp.reisner@linbit.com>
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com
	[209.85.219.169])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 8CE89420167
	for <drbd-dev@lists.linbit.com>; Fri, 28 Jun 2024 14:12:48 +0200 (CEST)
Received: by mail-yb1-f169.google.com with SMTP id
	3f1490d57ef6-e03618fc78bso281388276.2
	for <drbd-dev@lists.linbit.com>; Fri, 28 Jun 2024 05:12:48 -0700 (PDT)
MIME-Version: 1.0
References: <20240624054619.23212-1-zhengbing.huang@easystack.cn>
	<20240624054619.23212-6-zhengbing.huang@easystack.cn>
In-Reply-To: <20240624054619.23212-6-zhengbing.huang@easystack.cn>
From: Philipp Reisner <philipp.reisner@linbit.com>
Date: Fri, 28 Jun 2024 14:12:37 +0200
Message-ID: <CADGDV=WthASvFg32vL67hrpEET2haetQXoHB2DV3P_DV9VY2jA@mail.gmail.com>
Subject: Re: [PATCH 06/11] drbd_transport_rdma: put kref in error path
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

It looks plausible, but still, please provide a description.

On Mon, Jun 24, 2024 at 7:52=E2=80=AFAM zhengbing.huang
<zhengbing.huang@easystack.cn> wrote:
>
> From: Dongsheng Yang <dongsheng.yang@easystack.cn>
>
> Signed-off-by: Dongsheng Yang <dongsheng.yang@easystack.cn>
> ---
>  drbd/drbd_transport_rdma.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drbd/drbd_transport_rdma.c b/drbd/drbd_transport_rdma.c
> index 9a6d15b78..c7adc87e3 100644
> --- a/drbd/drbd_transport_rdma.c
> +++ b/drbd/drbd_transport_rdma.c
> @@ -1157,6 +1157,7 @@ static void dtr_cma_connect_work_fn(struct work_str=
uct *work)
>         kref_get(&cm->kref); /* for the path->cm pointer */
>         err =3D dtr_path_prepare(path, cm, true);
>         if (err) {
> +               kref_put(&cm->kref, dtr_destroy_cm);
>                 tr_err(transport, "dtr_path_prepare() =3D %d\n", err);
>                 goto out;
>         }
> --
> 2.27.0
>
