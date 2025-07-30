Return-Path: <philipp.reisner@linbit.com>
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com
	[209.85.208.46])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 03BD3162253
	for <drbd-dev@lists.linbit.com>; Wed, 30 Jul 2025 16:19:32 +0200 (CEST)
Received: by mail-ed1-f46.google.com with SMTP id
	4fb4d7f45d1cf-604bff84741so12382820a12.2
	for <drbd-dev@lists.linbit.com>; Wed, 30 Jul 2025 07:19:32 -0700 (PDT)
MIME-Version: 1.0
References: <20250708065040.4043169-1-zhengbing.huang@easystack.cn>
	<20250708065040.4043169-2-zhengbing.huang@easystack.cn>
In-Reply-To: <20250708065040.4043169-2-zhengbing.huang@easystack.cn>
From: Philipp Reisner <philipp.reisner@linbit.com>
Date: Wed, 30 Jul 2025 16:19:20 +0200
Message-ID: <CADGDV=Wkcbrw_OFX1J9Bwrng6x3XfwFDo34tDKtOsExA-CZ3ug@mail.gmail.com>
Subject: Re: [PATCH 2/3] rdma: ratelimit error log
To: "zhengbing.huang" <zhengbing.huang@easystack.cn>
Content-Type: multipart/alternative; boundary="000000000000a9dec5063b2636df"
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

--000000000000a9dec5063b2636df
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Zhengbing,

Thanks. This patch contains a coding style error. Or checkpatch.pl error.
There should be a space between the if and the opening bracket. Please run
a checkpatch.pl on your end before sending patches.

I fixed it and applied it.

Best regards,
 Philipp

On Tue, Jul 8, 2025 at 12:19=E2=80=AFPM zhengbing.huang <
zhengbing.huang@easystack.cn> wrote:

> Have a crash call trace as follow:
>   ? bit_clear+0x120/0x120
>   fbcon_putcs+0xe7/0x100
>   fbcon_redraw.isra.20+0xfd/0x1e0
>   fbcon_scroll+0x8c9/0xde0
>   con_scroll+0x20b/0x220
>   ? bit_clear+0x120/0x120
>   lf+0xa0/0xb0
>   vt_console_print+0x310/0x400
>   console_unlock+0x35f/0x4a0
>   vprintk_emit+0x14d/0x250
>   printk+0x58/0x6f
>   dtr_tx_cq_event_handler+0x895/0x8a0 [drbd_transport_rdma]
>   ? sched_clock+0x5/0x10
>   ? do_IRQ+0x7f/0xd0
>   mlx5_eq_comp_int+0xb0/0x1d0 [mlx5_core]
>   notifier_call_chain+0x47/0x70
>   atomic_notifier_call_chain+0x16/0x20
>   irq_int_handler+0x11/0x20 [mlx5_core]
>
> and the code is:
> (gdb) l *dtr_tx_cq_event_handler+0x894
> 0x3404 is in dtr_tx_cq_event_handler (.../drbd_transport_rdma.c:1935).
> 1930                    if (stream_nr !=3D ST_FLOW_CTRL) {
> 1931                            err =3D dtr_repost_tx_desc(cm, tx_desc);
> 1932                            if (!err)
> 1933                                    tx_desc =3D NULL; /* it is in the
> air again! Fly! */
> 1934                            else
> 1935                                    tr_warn(transport, "repost of
> tx_desc failed! %d\n", err);
> 1936                    }
>
> This problem is that too many logs print in irq, cause the kernel crash.
>
> So, we ratelimit error log
>
> Signed-off-by: zhengbing.huang <zhengbing.huang@easystack.cn>
> ---
>  drbd/drbd_transport_rdma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drbd/drbd_transport_rdma.c b/drbd/drbd_transport_rdma.c
> index 5270e503a..30edfaf96 100644
> --- a/drbd/drbd_transport_rdma.c
> +++ b/drbd/drbd_transport_rdma.c
> @@ -1920,7 +1920,7 @@ static int dtr_handle_tx_cq_event(struct ib_cq *cq,
> struct dtr_cm *cm)
>                         err =3D dtr_repost_tx_desc(cm, tx_desc);
>                         if (!err)
>                                 tx_desc =3D NULL; /* it is in the air aga=
in!
> Fly! */
> -                       else
> +                       else if(__ratelimit(&rdma_transport->rate_limit))
>                                 tr_warn(transport, "repost of tx_desc
> failed! %d\n", err);
>                 }
>         }
> --
> 2.43.0
>
>

--000000000000a9dec5063b2636df
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Zhengbing,<br><br>Thanks. This patch contains a coding =
style error. Or <a href=3D"http://checkpatch.pl">checkpatch.pl</a> error. T=
here should be a space between the if and the opening bracket. Please run a=
 <a href=3D"http://checkpatch.pl">checkpatch.pl</a> on your end before send=
ing patches.<br><br>I fixed it and applied it.<br><br>Best regards,<br>=C2=
=A0Philipp</div><br><div class=3D"gmail_quote gmail_quote_container"><div d=
ir=3D"ltr" class=3D"gmail_attr">On Tue, Jul 8, 2025 at 12:19=E2=80=AFPM zhe=
ngbing.huang &lt;<a href=3D"mailto:zhengbing.huang@easystack.cn">zhengbing.=
huang@easystack.cn</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">Have a crash call trace as follow:<br>
=C2=A0 ? bit_clear+0x120/0x120<br>
=C2=A0 fbcon_putcs+0xe7/0x100<br>
=C2=A0 fbcon_redraw.isra.20+0xfd/0x1e0<br>
=C2=A0 fbcon_scroll+0x8c9/0xde0<br>
=C2=A0 con_scroll+0x20b/0x220<br>
=C2=A0 ? bit_clear+0x120/0x120<br>
=C2=A0 lf+0xa0/0xb0<br>
=C2=A0 vt_console_print+0x310/0x400<br>
=C2=A0 console_unlock+0x35f/0x4a0<br>
=C2=A0 vprintk_emit+0x14d/0x250<br>
=C2=A0 printk+0x58/0x6f<br>
=C2=A0 dtr_tx_cq_event_handler+0x895/0x8a0 [drbd_transport_rdma]<br>
=C2=A0 ? sched_clock+0x5/0x10<br>
=C2=A0 ? do_IRQ+0x7f/0xd0<br>
=C2=A0 mlx5_eq_comp_int+0xb0/0x1d0 [mlx5_core]<br>
=C2=A0 notifier_call_chain+0x47/0x70<br>
=C2=A0 atomic_notifier_call_chain+0x16/0x20<br>
=C2=A0 irq_int_handler+0x11/0x20 [mlx5_core]<br>
<br>
and the code is:<br>
(gdb) l *dtr_tx_cq_event_handler+0x894<br>
0x3404 is in dtr_tx_cq_event_handler (.../drbd_transport_rdma.c:1935).<br>
1930=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 i=
f (stream_nr !=3D ST_FLOW_CTRL) {<br>
1931=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D dtr_repost_tx_desc(cm, tx_desc);<br>
1932=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!err)<br>
1933=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tx_desc =3D NULL; /=
* it is in the air again! Fly! */<br>
1934=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>
1935=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tr_warn(transport, =
&quot;repost of tx_desc failed! %d\n&quot;, err);<br>
1936=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }=
<br>
<br>
This problem is that too many logs print in irq, cause the kernel crash.<br=
>
<br>
So, we ratelimit error log<br>
<br>
Signed-off-by: zhengbing.huang &lt;<a href=3D"mailto:zhengbing.huang@easyst=
ack.cn" target=3D"_blank">zhengbing.huang@easystack.cn</a>&gt;<br>
---<br>
=C2=A0drbd/drbd_transport_rdma.c | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/drbd/drbd_transport_rdma.c b/drbd/drbd_transport_rdma.c<br>
index 5270e503a..30edfaf96 100644<br>
--- a/drbd/drbd_transport_rdma.c<br>
+++ b/drbd/drbd_transport_rdma.c<br>
@@ -1920,7 +1920,7 @@ static int dtr_handle_tx_cq_event(struct ib_cq *cq, s=
truct dtr_cm *cm)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 err =3D dtr_repost_tx_desc(cm, tx_desc);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (!err)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tx_desc =3D NULL; /* it is in the ai=
r again! Fly! */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0else<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0else if(__ratelimit(&amp;rdma_transport-&gt;rate_limit))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tr_warn(transport, &quot;repost of t=
x_desc failed! %d\n&quot;, err);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-- <br>
2.43.0<br>
<br>
</blockquote></div>

--000000000000a9dec5063b2636df--
