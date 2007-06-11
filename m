Return-Path: <Ernest.Montrose@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C7ABC9.6509933D"
Date: Sun, 10 Jun 2007 21:39:47 -0400
Message-ID: <BD7042533C2F8943A6A4257A9E31C4543D15A9@EXNA.corp.stratus.com>
From: "Montrose, Ernest" <Ernest.Montrose@stratus.com>
To: <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] drbd0: [drbd0_receiver/5740] sock_sendmsg time expired,
	ko = 4294967294
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C7ABC9.6509933D
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi all,
It seems that the mdev->ko_count counter is going negative as evidenced =
by the following message:
drbd0: [drbd0_receiver/5740] sock_sendmsg time expired, ko =3D =
4294967294
=20
Note the rather large ko value.
 STATIC we_should_drop_the_connection(drbd_dev *mdev, struct socket =
*sock) is the place we decrement this unconditionnaly. Should at least =
be this:
Index: drbd/drbd_main.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- drbd/drbd_main.c    (revision 14981)
+++ drbd/drbd_main.c    (working copy)
@@ -1549,7 +1549,7 @@
        if (drop_it)
                return TRUE;
-       drop_it =3D !--mdev->ko_count;
+       drop_it =3D !mdev->ko_count || !--mdev->ko_count;
        if ( !drop_it ) {
                ERR("[%s/%d] sock_sendmsg time expired, ko =3D %u\n",
                       current->comm, current->pid, mdev->ko_count);


------_=_NextPart_001_01C7ABC9.6509933D
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN"><HTML =
DIR=3Dltr><HEAD><META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1"></HEAD><BODY><DIV><FONT face=3D'Arial' =
color=3D#000000 size=3D2>Hi all,</FONT></DIV>=0A=
<DIV><FONT face=3DArial size=3D2>It seems that the mdev-&gt;ko_count =
counter is =0A=
going negative as evidenced by the following message:</FONT></DIV>=0A=
<DIV>drbd0: [drbd0_receiver/5740] sock_sendmsg time expired, ko =3D =0A=
4294967294</DIV>=0A=
<DIV>&nbsp;</DIV>=0A=
<DIV>Note the rather large ko value.</DIV>=0A=
<DIV>&nbsp;STATIC we_should_drop_the_connection(drbd_dev *mdev, struct =
socket =0A=
*sock) is the place we decrement this unconditionnaly. Should at least =
be =0A=
this:</DIV>=0A=
<DIV>Index: =0A=
drbd/drbd_main.c<BR>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<=
BR>--- =0A=
drbd/drbd_main.c&nbsp;&nbsp;&nbsp; (revision 14981)<BR>+++ =0A=
drbd/drbd_main.c&nbsp;&nbsp;&nbsp; (working copy)<BR>@@ -1549,7 +1549,7 =0A=
@@<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =0A=
(drop_it)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
return TRUE;</DIV>=0A=
<DIV>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drop_it =3D =0A=
!--mdev-&gt;ko_count;<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drop_it =
=3D =0A=
!mdev-&gt;ko_count || =0A=
!--mdev-&gt;ko_count;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ( =0A=
!drop_it ) =0A=
{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; =0A=
ERR("[%s/%d] sock_sendmsg time expired, ko =3D =0A=
%u\n",<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
current-&gt;comm, current-&gt;pid, =
mdev-&gt;ko_count);<BR></DIV></BODY></HTML>
------_=_NextPart_001_01C7ABC9.6509933D--
