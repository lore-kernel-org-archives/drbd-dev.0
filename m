Return-Path: <philipp.reisner@linbit.com>
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com
	[209.85.219.169])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id BCAA3160644
	for <drbd-dev@lists.linbit.com>; Wed, 12 Mar 2025 09:57:59 +0100 (CET)
Received: by mail-yb1-f169.google.com with SMTP id
	3f1490d57ef6-e63a159525bso2440876276.2
	for <drbd-dev@lists.linbit.com>; Wed, 12 Mar 2025 01:57:59 -0700 (PDT)
MIME-Version: 1.0
References: <20250311110633.1122918-1-zhengbing.huang@easystack.cn>
In-Reply-To: <20250311110633.1122918-1-zhengbing.huang@easystack.cn>
From: Philipp Reisner <philipp.reisner@linbit.com>
Date: Wed, 12 Mar 2025 09:57:47 +0100
Message-ID: <CADGDV=XjFc4W6JL89B14K5XTbJP1WRr5a4BCirrHOSNBj8G5KA@mail.gmail.com>
Subject: Re: [PATCH] rdma: Add network ping detection
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

Applied as https://github.com/LINBIT/drbd/commit/78c472291ad471f77bdf8fcc3a=
056a5806a530d3

Thanks!

PS: One of us will also review your "[PATCH] drbd: Fix IO block after
network failure" soon.


On Tue, Mar 11, 2025 at 12:11=E2=80=AFPM zhengbing.huang
<zhengbing.huang@easystack.cn> wrote:
>
> In rdma mode, the drbd establishes a connection between two nodes,
> and without I/O. If one node suddenly crash,
> the connection status of the remain node is still normal.
> That is, the remain node cannot detect the exception of the peer node.
>
> So in rdma transport mode, we also add a ping work, like tcp transport mo=
de.
>
> Signed-off-by: zhengbing.huang <zhengbing.huang@easystack.cn>
> ---
>  drbd/drbd_transport_rdma.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drbd/drbd_transport_rdma.c b/drbd/drbd_transport_rdma.c
> index 427065789..9799be396 100644
> --- a/drbd/drbd_transport_rdma.c
> +++ b/drbd/drbd_transport_rdma.c
> @@ -3152,6 +3152,9 @@ static void dtr_set_rcvtimeo(struct drbd_transport =
*transport, enum drbd_stream
>                 container_of(transport, struct dtr_transport, transport);
>
>         rdma_transport->stream[stream].recv_timeout =3D timeout;
> +
> +       if (stream =3D=3D CONTROL_STREAM)
> +               mod_timer(&rdma_transport->control_timer, jiffies + timeo=
ut);
>  }
>
>  static long dtr_get_rcvtimeo(struct drbd_transport *transport, enum drbd=
_stream stream)
> --
> 2.43.0
>
