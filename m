Return-Path: <philipp.reisner@linbit.com>
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com
	[209.85.128.179])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 6BA6042012B
	for <drbd-dev@lists.linbit.com>; Wed, 18 Sep 2024 11:57:15 +0200 (CEST)
Received: by mail-yw1-f179.google.com with SMTP id
	00721157ae682-6dbc75acbfaso43512807b3.3
	for <drbd-dev@lists.linbit.com>; Wed, 18 Sep 2024 02:57:15 -0700 (PDT)
MIME-Version: 1.0
References: <20240913083504.10549-1-chenqiuji666@gmail.com>
In-Reply-To: <20240913083504.10549-1-chenqiuji666@gmail.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
Date: Wed, 18 Sep 2024 11:57:03 +0200
Message-ID: <CADGDV=Vhx79JmTSzSJ+KN_236vKD0mZD6u3_23WRmte2wXW3fg@mail.gmail.com>
Subject: Re: [PATCH] drbd: Fix atomicity violation in drbd_uuid_set_bm()
To: Qiu-ji Chen <chenqiuji666@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Cc: axboe@kernel.dk, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	linux-block@vger.kernel.org, baijiaju1990@gmail.com,
	lars.ellenberg@linbit.com, drbd-dev@lists.linbit.com
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

Hello Qiu-ji Chen,

The code change looks okay to me.

Reviewed-by: Philipp Reisner <philipp.reisner@linbit.com>

On Fri, Sep 13, 2024 at 10:35=E2=80=AFAM Qiu-ji Chen <chenqiuji666@gmail.co=
m> wrote:
>
> The violation of atomicity occurs when the drbd_uuid_set_bm function is
> executed simultaneously with modifying the value of
> device->ldev->md.uuid[UI_BITMAP]. Consider a scenario where, while
> device->ldev->md.uuid[UI_BITMAP] passes the validity check when its value
> is not zero, the value of device->ldev->md.uuid[UI_BITMAP] is written to
> zero. In this case, the check in drbd_uuid_set_bm might refer to the old
> value of device->ldev->md.uuid[UI_BITMAP] (before locking), which allows
> an invalid value to pass the validity check, resulting in inconsistency.
>
> To address this issue, it is recommended to include the data validity che=
ck
> within the locked section of the function. This modification ensures that
> the value of device->ldev->md.uuid[UI_BITMAP] does not change during the
> validation process, thereby maintaining its integrity.
>
> This possible bug is found by an experimental static analysis tool
> developed by our team. This tool analyzes the locking APIs to extract
> function pairs that can be concurrently executed, and then analyzes the
> instructions in the paired functions to identify possible concurrency bug=
s
> including data races and atomicity violations.
>
> Fixes: 9f2247bb9b75 ("drbd: Protect accesses to the uuid set with a spinl=
ock")
> Cc: stable@vger.kernel.org
> Signed-off-by: Qiu-ji Chen <chenqiuji666@gmail.com>
> ---
>  drivers/block/drbd/drbd_main.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_mai=
n.c
> index a9e49b212341..abafc4edf9ed 100644
> --- a/drivers/block/drbd/drbd_main.c
> +++ b/drivers/block/drbd/drbd_main.c
> @@ -3399,10 +3399,12 @@ void drbd_uuid_new_current(struct drbd_device *de=
vice) __must_hold(local)
>  void drbd_uuid_set_bm(struct drbd_device *device, u64 val) __must_hold(l=
ocal)
>  {
>         unsigned long flags;
> -       if (device->ldev->md.uuid[UI_BITMAP] =3D=3D 0 && val =3D=3D 0)
> +       spin_lock_irqsave(&device->ldev->md.uuid_lock, flags);
> +       if (device->ldev->md.uuid[UI_BITMAP] =3D=3D 0 && val =3D=3D 0) {
> +               spin_unlock_irqrestore(&device->ldev->md.uuid_lock, flags=
);
>                 return;
> +       }
>
> -       spin_lock_irqsave(&device->ldev->md.uuid_lock, flags);
>         if (val =3D=3D 0) {
>                 drbd_uuid_move_history(device);
>                 device->ldev->md.uuid[UI_HISTORY_START] =3D device->ldev-=
>md.uuid[UI_BITMAP];
> --
> 2.34.1
>
