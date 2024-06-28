Return-Path: <philipp.reisner@linbit.com>
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com
	[209.85.219.179])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id D66254202BA
	for <drbd-dev@lists.linbit.com>; Fri, 28 Jun 2024 13:51:50 +0200 (CEST)
Received: by mail-yb1-f179.google.com with SMTP id
	3f1490d57ef6-dfab4779d95so429381276.0
	for <drbd-dev@lists.linbit.com>; Fri, 28 Jun 2024 04:51:50 -0700 (PDT)
MIME-Version: 1.0
References: <20240624054619.23212-1-zhengbing.huang@easystack.cn>
	<20240624054619.23212-4-zhengbing.huang@easystack.cn>
In-Reply-To: <20240624054619.23212-4-zhengbing.huang@easystack.cn>
From: Philipp Reisner <philipp.reisner@linbit.com>
Date: Fri, 28 Jun 2024 13:51:38 +0200
Message-ID: <CADGDV=XEoNE6r_Q+R3agyytF-AhqduKdwM87FRsRC9axF8P5PQ@mail.gmail.com>
Subject: Re: [PATCH 04/11] drbd_transport_rdma: dont schedule
	retry_connect_work in active is false
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

Please explain what problem you are fixing with this change. Do you
have a log that shows a problem in this area? Please describe why your
proposed change improves DRBD's behavior.

best regards,
 Philipp

On Mon, Jun 24, 2024 at 9:28=E2=80=AFAM zhengbing.huang
<zhengbing.huang@easystack.cn> wrote:
>
> From: Dongsheng Yang <dongsheng.yang@easystack.cn>
>
> Signed-off-by: Dongsheng Yang <dongsheng.yang@easystack.cn>
> ---
>  drbd/drbd_transport_rdma.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/drbd/drbd_transport_rdma.c b/drbd/drbd_transport_rdma.c
> index eccd0c6ce..b7ccb15d4 100644
> --- a/drbd/drbd_transport_rdma.c
> +++ b/drbd/drbd_transport_rdma.c
> @@ -1089,9 +1089,13 @@ static void dtr_cma_retry_connect_work_fn(struct w=
ork_struct *work)
>         if (err) {
>                 struct dtr_path *path =3D container_of(cs, struct dtr_pat=
h, cs);
>                 struct drbd_transport *transport =3D path->path.transport=
;
> +               struct dtr_transport *rdma_transport =3D
> +                       container_of(transport, struct dtr_transport, tra=
nsport);
>
>                 tr_err(transport, "dtr_start_try_connect failed  %d\n", e=
rr);
> -               schedule_delayed_work(&cs->retry_connect_work, HZ);
> +               if (rdma_transport->active) {
> +                       schedule_delayed_work(&cs->retry_connect_work, HZ=
);
> +               }
>         }
>  }
>
> @@ -1116,6 +1120,8 @@ static void dtr_remove_cm_from_path(struct dtr_path=
 *path, struct dtr_cm *failed
>  static void dtr_cma_retry_connect(struct dtr_path *path, struct dtr_cm *=
failed_cm)
>  {
>         struct drbd_transport *transport =3D path->path.transport;
> +       struct dtr_transport *rdma_transport =3D
> +               container_of(transport, struct dtr_transport, transport);
>         struct dtr_connect_state *cs =3D &path->cs;
>         long connect_int =3D 10 * HZ;
>         struct net_conf *nc;
> @@ -1128,7 +1134,9 @@ static void dtr_cma_retry_connect(struct dtr_path *=
path, struct dtr_cm *failed_c
>                 connect_int =3D nc->connect_int * HZ;
>         rcu_read_unlock();
>
> -       schedule_delayed_work(&cs->retry_connect_work, connect_int);
> +       if (rdma_transport->active) {
> +               schedule_delayed_work(&cs->retry_connect_work, connect_in=
t);
> +       }
>  }
>
>  static void dtr_cma_connect_work_fn(struct work_struct *work)
> --
> 2.27.0
>
