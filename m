Return-Path: <philipp.reisner@linbit.com>
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com
	[209.85.219.177])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 059084202BA
	for <drbd-dev@lists.linbit.com>; Fri, 28 Jun 2024 11:36:06 +0200 (CEST)
Received: by mail-yb1-f177.google.com with SMTP id
	3f1490d57ef6-dfde5ae0aaeso355744276.1
	for <drbd-dev@lists.linbit.com>; Fri, 28 Jun 2024 02:36:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240624054619.23212-1-zhengbing.huang@easystack.cn>
	<20240624054619.23212-2-zhengbing.huang@easystack.cn>
In-Reply-To: <20240624054619.23212-2-zhengbing.huang@easystack.cn>
From: Philipp Reisner <philipp.reisner@linbit.com>
Date: Fri, 28 Jun 2024 11:35:54 +0200
Message-ID: <CADGDV=W=Nx=_vmxzQZZaSMFW0eVWjHeRYBZ1Ly5DtmU1Pj6jFA@mail.gmail.com>
Subject: Re: [PATCH 02/11] drbd_receiver: get_ldev before use device->ldev for
	drbd_reconsider_queue_parameters()
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

Thanks.

On Mon, Jun 24, 2024 at 8:32=E2=80=AFAM zhengbing.huang
<zhengbing.huang@easystack.cn> wrote:
>
> From: Dongsheng Yang <dongsheng.yang@easystack.cn>
>
> check ldev is not NULL before use it in drbd_reconsider_queue_parameters(=
)
>
> Signed-off-by: Dongsheng Yang <dongsheng.yang@easystack.cn>
> ---
>  drbd/drbd_receiver.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drbd/drbd_receiver.c b/drbd/drbd_receiver.c
> index 49e7815ed..fd07b29d7 100644
> --- a/drbd/drbd_receiver.c
> +++ b/drbd/drbd_receiver.c
> @@ -9845,7 +9845,12 @@ static void conn_disconnect(struct drbd_connection=
 *connection)
>                 rcu_read_unlock();
>
>                 peer_device_disconnected(peer_device);
> -               drbd_reconsider_queue_parameters(device, device->ldev);
> +               if (get_ldev(device)) {
> +                       drbd_reconsider_queue_parameters(device, device->=
ldev);
> +                       put_ldev(device);
> +               } else {
> +                       drbd_reconsider_queue_parameters(device, NULL);
> +               }
>
>                 kref_put(&device->kref, drbd_destroy_device);
>                 rcu_read_lock();
> --
> 2.27.0
>
