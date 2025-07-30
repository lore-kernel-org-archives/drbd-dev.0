Return-Path: <philipp.reisner@linbit.com>
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com
	[209.85.218.46])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id F15F2162253
	for <drbd-dev@lists.linbit.com>; Wed, 30 Jul 2025 16:17:04 +0200 (CEST)
Received: by mail-ej1-f46.google.com with SMTP id
	a640c23a62f3a-af8f5e38a9fso329210266b.0
	for <drbd-dev@lists.linbit.com>; Wed, 30 Jul 2025 07:17:04 -0700 (PDT)
MIME-Version: 1.0
References: <20250708065040.4043169-1-zhengbing.huang@easystack.cn>
In-Reply-To: <20250708065040.4043169-1-zhengbing.huang@easystack.cn>
From: Philipp Reisner <philipp.reisner@linbit.com>
Date: Wed, 30 Jul 2025 16:16:51 +0200
Message-ID: <CADGDV=V98XMcgGXcbnS7NcP2cWcfpnHwy=GgmY1p8EhZr3QCjg@mail.gmail.com>
Subject: Re: [PATCH 1/3] rdma: Fix memory leak in error path
To: "zhengbing.huang" <zhengbing.huang@easystack.cn>
Content-Type: multipart/alternative; boundary="000000000000d7fe3f063b262d79"
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

--000000000000d7fe3f063b262d79
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks, applied

On Tue, Jul 8, 2025 at 12:20=E2=80=AFPM zhengbing.huang <
zhengbing.huang@easystack.cn> wrote:

> In the dtr_send() function, if the __dtr_post_tx_desc() return an error,
> it means that  ib_post_send() has failed.
> Then, we cannot get this tx_desc and release it through ib_poll_cq().
>
> So, we need to release this tx_desc when __dtr_post_tx_desc() fails in
> dtr_send() function.
>
> Signed-off-by: zhengbing.huang <zhengbing.huang@easystack.cn>
> ---
>  drbd/drbd_transport_rdma.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drbd/drbd_transport_rdma.c b/drbd/drbd_transport_rdma.c
> index 6de0ba625..5270e503a 100644
> --- a/drbd/drbd_transport_rdma.c
> +++ b/drbd/drbd_transport_rdma.c
> @@ -581,6 +581,9 @@ static int dtr_send(struct dtr_path *path, void *buf,
> size_t size, gfp_t gfp_mas
>                 { .stream =3D ST_FLOW_CTRL, .sequence =3D 0 };
>
>         err =3D __dtr_post_tx_desc(cm, tx_desc);
> +       if (err)
> +               dtr_free_tx_desc(cm, tx_desc);
> +
>  out_put:
>         kref_put(&cm->kref, dtr_destroy_cm);
>  out:
> --
> 2.43.0
>
>

--000000000000d7fe3f063b262d79
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks, applied</div><br><div class=3D"gmail_quote gmail_q=
uote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jul 8, 2025 a=
t 12:20=E2=80=AFPM zhengbing.huang &lt;<a href=3D"mailto:zhengbing.huang@ea=
systack.cn">zhengbing.huang@easystack.cn</a>&gt; wrote:<br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">In the dtr_send() function, if the =
__dtr_post_tx_desc() return an error,<br>
it means that=C2=A0 ib_post_send() has failed.<br>
Then, we cannot get this tx_desc and release it through ib_poll_cq().<br>
<br>
So, we need to release this tx_desc when __dtr_post_tx_desc() fails in<br>
dtr_send() function.<br>
<br>
Signed-off-by: zhengbing.huang &lt;<a href=3D"mailto:zhengbing.huang@easyst=
ack.cn" target=3D"_blank">zhengbing.huang@easystack.cn</a>&gt;<br>
---<br>
=C2=A0drbd/drbd_transport_rdma.c | 3 +++<br>
=C2=A01 file changed, 3 insertions(+)<br>
<br>
diff --git a/drbd/drbd_transport_rdma.c b/drbd/drbd_transport_rdma.c<br>
index 6de0ba625..5270e503a 100644<br>
--- a/drbd/drbd_transport_rdma.c<br>
+++ b/drbd/drbd_transport_rdma.c<br>
@@ -581,6 +581,9 @@ static int dtr_send(struct dtr_path *path, void *buf, s=
ize_t size, gfp_t gfp_mas<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 { .stream =3D ST_FL=
OW_CTRL, .sequence =3D 0 };<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D __dtr_post_tx_desc(cm, tx_desc);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (err)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dtr_free_tx_desc(cm=
, tx_desc);<br>
+<br>
=C2=A0out_put:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 kref_put(&amp;cm-&gt;kref, dtr_destroy_cm);<br>
=C2=A0out:<br>
-- <br>
2.43.0<br>
<br>
</blockquote></div>

--000000000000d7fe3f063b262d79--
