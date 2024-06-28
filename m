Return-Path: <philipp.reisner@linbit.com>
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com
	[209.85.219.179])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 600564202BA
	for <drbd-dev@lists.linbit.com>; Fri, 28 Jun 2024 14:07:35 +0200 (CEST)
Received: by mail-yb1-f179.google.com with SMTP id
	3f1490d57ef6-dff0712ede2so493279276.2
	for <drbd-dev@lists.linbit.com>; Fri, 28 Jun 2024 05:07:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240624054619.23212-1-zhengbing.huang@easystack.cn>
	<20240624054619.23212-5-zhengbing.huang@easystack.cn>
In-Reply-To: <20240624054619.23212-5-zhengbing.huang@easystack.cn>
From: Philipp Reisner <philipp.reisner@linbit.com>
Date: Fri, 28 Jun 2024 14:07:24 +0200
Message-ID: <CADGDV=XCh8QLqYZ0-zddu6nwdJJor9UGb960K-CmN5yLB58XzA@mail.gmail.com>
Subject: Re: [PATCH 05/11] drbd_transport_rdma: dont break in
	dtr_tx_cq_event_handler if (cm->state != DSM_CONNECTED)
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

It appears that you are trying to fix a leak of cm structures. Is that corr=
ect?
Do you the reference on cm that is held because of the timer?
Please describe what the problem is, and how you are improving the situatio=
n.

In case this approach is the right solution, the patch should also change t=
he
dtr_handle_tx_cq_event() function to type void.

best regards,
 Philipp

On Mon, Jun 24, 2024 at 8:22=E2=80=AFAM zhengbing.huang
<zhengbing.huang@easystack.cn> wrote:
>
> From: Dongsheng Yang <dongsheng.yang@easystack.cn>
>
> We need to drain all tx in disconnect to put all kref for cm
>
> Signed-off-by: Dongsheng Yang <dongsheng.yang@easystack.cn>
> ---
>  drbd/drbd_transport_rdma.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drbd/drbd_transport_rdma.c b/drbd/drbd_transport_rdma.c
> index b7ccb15d4..9a6d15b78 100644
> --- a/drbd/drbd_transport_rdma.c
> +++ b/drbd/drbd_transport_rdma.c
> @@ -1956,9 +1956,6 @@ static void dtr_tx_cq_event_handler(struct ib_cq *c=
q, void *ctx)
>                         err =3D dtr_handle_tx_cq_event(cq, cm);
>                 } while (!err);
>
> -               if (cm->state !=3D DSM_CONNECTED)
> -                       break;
> -
>                 rc =3D ib_req_notify_cq(cq, IB_CQ_NEXT_COMP | IB_CQ_REPOR=
T_MISSED_EVENTS);
>                 if (unlikely(rc < 0)) {
>                         struct drbd_transport *transport =3D cm->path->pa=
th.transport;
> --
> 2.27.0
>
