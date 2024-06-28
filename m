Return-Path: <philipp.reisner@linbit.com>
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com
	[209.85.219.171])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id E1D104202BA
	for <drbd-dev@lists.linbit.com>; Fri, 28 Jun 2024 14:36:16 +0200 (CEST)
Received: by mail-yb1-f171.google.com with SMTP id
	3f1490d57ef6-e0361c767ddso298397276.1
	for <drbd-dev@lists.linbit.com>; Fri, 28 Jun 2024 05:36:16 -0700 (PDT)
MIME-Version: 1.0
References: <20240624054619.23212-1-zhengbing.huang@easystack.cn>
	<20240624054619.23212-8-zhengbing.huang@easystack.cn>
In-Reply-To: <20240624054619.23212-8-zhengbing.huang@easystack.cn>
From: Philipp Reisner <philipp.reisner@linbit.com>
Date: Fri, 28 Jun 2024 14:36:04 +0200
Message-ID: <CADGDV=X9Ev4Z6x-FnE2J6zdLe5DyVsEwX4Zg3E8=XR=CP+synw@mail.gmail.com>
Subject: Re: [PATCH 08/11] drbd_transport_rdma: fix a race between dtr_connect
	and drbd_thread_stop
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

I am repeating your description in my own words so that you can verify
I got it right:

CPU 0 executes dtr_connect() and is still before the
wait_for_completion_interruptible().
CPU 1 executes send_sig() in drbd_thread_stop().

Then you conclude that wait_for_completion_interruptible() will not
abort, because the signal
was raised before CPU 0 reached wait_for_completion_interruptible().

If that is your description, then it is wrong.
This is not how signals and the wait_event() macros work.

best regards,
 Philipp

On Mon, Jun 24, 2024 at 9:27=E2=80=AFAM zhengbing.huang
<zhengbing.huang@easystack.cn> wrote:
>
> From: Dongsheng Yang <dongsheng.yang@easystack.cn>
>
> If the send_sig() in drbd_thread_stop before wait_for_completion_interrup=
tible() in dtr_connect(),
> it can't return from dtr_connect in network failure.
>
> So replace wait_for_completion_interruptible with wait_for_completion_int=
erruptible_timeout, and
> check status by dtr_connect() itself.
>
> This behavior is similar with tcp transport
>
> Signed-off-by: Dongsheng Yang <dongsheng.yang@easystack.cn>
> ---
>  drbd/drbd_transport_rdma.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/drbd/drbd_transport_rdma.c b/drbd/drbd_transport_rdma.c
> index 77ff0055e..c47b344f8 100644
> --- a/drbd/drbd_transport_rdma.c
> +++ b/drbd/drbd_transport_rdma.c
> @@ -2996,12 +2996,21 @@ static int dtr_connect(struct drbd_transport *tra=
nsport)
>  {
>         struct dtr_transport *rdma_transport =3D
>                 container_of(transport, struct dtr_transport, transport);
> -       int i, err =3D -ENOMEM;
> +       int i, err;
>
> -       err =3D wait_for_completion_interruptible(&rdma_transport->connec=
ted);
> -       if (err) {
> +again:
> +       if (drbd_should_abort_listening(transport)) {
> +               err =3D -EAGAIN;
> +               goto abort;
> +       }
> +
> +       err =3D wait_for_completion_interruptible_timeout(&rdma_transport=
->connected, HZ);
> +       if (err < 0) {
>                 flush_signals(current);
>                 goto abort;
> +       } else if (err =3D=3D 0) {
> +               /* timed out */
> +               goto again;
>         }
>
>         err =3D atomic_read(&rdma_transport->first_path_connect_err);
> --
> 2.27.0
>
