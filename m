Return-Path: <philipp.reisner@linbit.com>
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com
	[209.85.219.178])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 018214202BA
	for <drbd-dev@lists.linbit.com>; Fri, 28 Jun 2024 11:40:42 +0200 (CEST)
Received: by mail-yb1-f178.google.com with SMTP id
	3f1490d57ef6-e035dc23a21so292341276.0
	for <drbd-dev@lists.linbit.com>; Fri, 28 Jun 2024 02:40:42 -0700 (PDT)
MIME-Version: 1.0
References: <20240624054619.23212-1-zhengbing.huang@easystack.cn>
	<20240624054619.23212-3-zhengbing.huang@easystack.cn>
In-Reply-To: <20240624054619.23212-3-zhengbing.huang@easystack.cn>
From: Philipp Reisner <philipp.reisner@linbit.com>
Date: Fri, 28 Jun 2024 11:40:31 +0200
Message-ID: <CADGDV=V4kpNPAWf6MsdswhbMqKPe5=qEMXkF_KBqXVM7W+aUhQ@mail.gmail.com>
Subject: Re: [PATCH 03/11] drbd_transport_rdma: put kref for cm in
	dtr_path_established in error path
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

Please add more information why you think this change fixes a bug.
Have you experienced a leak of cm structs?
We got a RDMA_CM_EVENT_ESTABLISHED event. Even if DRBD does not do
anything with this cm, we sill expect a RDMA_CM_EVENT_DISCONNECTED in
the future. Is a problem in the handling of the disconnect?

best regards,
 Philipp

On Mon, Jun 24, 2024 at 9:28=E2=80=AFAM zhengbing.huang
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
> index cfbae0e78..eccd0c6ce 100644
> --- a/drbd/drbd_transport_rdma.c
> +++ b/drbd/drbd_transport_rdma.c
> @@ -922,6 +922,7 @@ static void dtr_path_established(struct dtr_cm *cm)
>                         atomic_set(&cs->active_state, PCS_INACTIVE);
>                         wake_up(&cs->wq);
>                 }
> +               kref_put(&cm->kref, dtr_destroy_cm);
>                 return;
>         }
>
> --
> 2.27.0
>
