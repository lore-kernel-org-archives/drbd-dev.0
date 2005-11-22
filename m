Return-Path: <roger.tsang@gmail.com>
Received: from zproxy.gmail.com (zproxy.gmail.com [64.233.162.201])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 59BFC15E50
	for <drbd-dev@lists.linbit.com>; Tue, 22 Nov 2005 15:30:01 +0100 (CET)
Received: by zproxy.gmail.com with SMTP id 18so1011976nzp
	for <drbd-dev@lists.linbit.com>; Tue, 22 Nov 2005 06:29:57 -0800 (PST)
Message-ID: <498263350511220629n64066afft9f7f8119b6e057e3@mail.gmail.com>
Date: Tue, 22 Nov 2005 09:29:57 -0500
From: Roger Tsang <roger.tsang@gmail.com>
To: drbd-dev@lists.linbit.com
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_10226_12268958.1132669797604"
Subject: [Drbd-dev] DRBD-0.7.14 drbd0: drbd_set_state:
	(mdev->this_bdev->bd_contains == 0) in
	/openssi/drbd/drbd/drbd_fs.c:742
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

------=_Part_10226_12268958.1132669797604
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi guys,

I'm running into this hidden bug quite often while doing failover. How
critical is this bug? Can someone clarify the FIXME comment? Like any clues
to where this "hidden" bug is or where you think it could be? Thanks.

I'm doing these DRBD-0.7.14 fs failovers in OpenSSI, but OpenSSI hasn't
modified drbd_fs.c

Roger


node3 login: drbd3: PingAck did not arrive in time.
drbd3: short read expecting header on sock: r=3D-512
drbd1: PingAck did not arrive in time.
drbd1: short read expecting header on sock: r=3D-512
drbd0: PingAck did not arrive in time.
drbd0: short read expecting header on sock: r=3D-512
Taking over master from node 1.
Node 1 has gone down!!!
write handler down off 150000 len 516
write handler down off 40000 len 460
passed the first scan in ipcname_pull_data
num_objects[MSG] =3D 0
num_objects[SEM] =3D 4
num_objects[SHM] =3D 10
ipcnameserver ready completed
drbd0: drbd_nodedown: Node 1 has gone down!
drbd0: drbd_nodedown: Signaling receiver thread.
drbd0: drbd_nodedown: Node 1 has gone down!
drbd1: drbd_nodedown: Node 1 has gone down!
drbd1: drbd_nodedown: Signaling receiver thread.
drbd0: drbd_nodedown: Node 1 has gone down!
drbd1: drbd_nodedown: Node 1 has gone down!
drbd3: drbd_nodedown: Node 1 has gone down!
drbd3: drbd_nodedown: Signaling receiver thread.
drbd0: drbd_set_state: (mdev->this_bdev->bd_contains =3D=3D 0) in
/openssi/drbd/drbd/drbd_fs.c:742
drbd1: drbd_set_state: (mdev->this_bdev->bd_contains =3D=3D 0) in
/openssi/drbd/drbd/drbd_fs.c:742
drbd3: drbd_set_state: (mdev->this_bdev->bd_contains =3D=3D 0) in
/openssi/drbd/drbd/drbd_fs.c:742
drbd0: Doing CLMS nodedown callback for service 9
drbd1: Doing CLMS nodedown callback for service 10
drbd3: Doing CLMS nodedown callback for service 11
fsck 1.35 (28-Feb-2004)

#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
smp_rmb();
if ( (newstate & Secondary) &&
(test_bit(WRITER_PRESENT,&mdev->flags) ||
drbd_is_mounted(minor) =3D=3D MountedRW))
return -EBUSY;
#else
ERR_IF (mdev->this_bdev->bd_contains =3D=3D 0) {
// FIXME this masks a bug somewhere else!
mdev->this_bdev->bd_contains =3D mdev->this_bdev;
}

if ( newstate & Secondary ) {

------=_Part_10226_12268958.1132669797604
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi guys,<br>
<br>
I'm running into this hidden bug quite often while doing
failover.&nbsp; How critical is this bug?&nbsp; Can someone clarify the
FIXME comment?&nbsp; Like any clues to where this &quot;hidden&quot; bug is=
 or
where you think it could be?&nbsp; Thanks.<br>
<br>
I'm doing these DRBD-0.7.14 fs failovers in OpenSSI, but OpenSSI hasn't mod=
ified drbd_fs.c<br>
<br>
Roger<br>
<br>
<br>
node3 login: drbd3: PingAck did not arrive in time.<br>
drbd3: short read expecting header on sock: r=3D-512<br>
drbd1: PingAck did not arrive in time.<br>
drbd1: short read expecting header on sock: r=3D-512<br>
drbd0: PingAck did not arrive in time.<br>
drbd0: short read expecting header on sock: r=3D-512<br>
Taking over master from node 1.<br>
Node 1 has gone down!!!<br>
write handler down off 150000 len 516<br>
write handler down off 40000 len 460<br>
passed the first scan in ipcname_pull_data<br>
num_objects[MSG] =3D 0<br>
num_objects[SEM] =3D 4<br>
num_objects[SHM] =3D 10<br>
ipcnameserver ready completed<br>
drbd0: drbd_nodedown: Node 1 has gone down!<br>
drbd0: drbd_nodedown: Signaling receiver thread.<br>
drbd0: drbd_nodedown: Node 1 has gone down!<br>
drbd1: drbd_nodedown: Node 1 has gone down!<br>
drbd1: drbd_nodedown: Signaling receiver thread.<br>
drbd0: drbd_nodedown: Node 1 has gone down!<br>
drbd1: drbd_nodedown: Node 1 has gone down!<br>
drbd3: drbd_nodedown: Node 1 has gone down!<br>
drbd3: drbd_nodedown: Signaling receiver thread.<br>
drbd0: drbd_set_state: (mdev-&gt;this_bdev-&gt;bd_contains =3D=3D 0) in /op=
enssi/drbd/drbd/drbd_fs.c:742<br>
drbd1: drbd_set_state: (mdev-&gt;this_bdev-&gt;bd_contains =3D=3D 0) in /op=
enssi/drbd/drbd/drbd_fs.c:742<br>
drbd3: drbd_set_state: (mdev-&gt;this_bdev-&gt;bd_contains =3D=3D 0) in /op=
enssi/drbd/drbd/drbd_fs.c:742<br>
drbd0: Doing CLMS nodedown callback for service 9<br>
drbd1: Doing CLMS nodedown callback for service 10<br>
drbd3: Doing CLMS nodedown callback for service 11<br>
fsck 1.35 (28-Feb-2004)<br>
<br>
#if LINUX_VERSION_CODE &lt; KERNEL_VERSION(2,5,0)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smp_rmb();<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ( (newstate &amp; Secondary) =
&amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (test_bit(WRIT=
ER_PRESENT,&amp;mdev-&gt;flags) ||<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drbd_is_=
mounted(minor) =3D=3D MountedRW))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return -EBUSY;<br>
#else&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ERR_IF (mdev-&gt;this_bdev-&gt;b=
d_contains =3D=3D 0) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;
// FIXME this masks a bug somewhere else!<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;
mdev-&gt;this_bdev-&gt;bd_contains =3D mdev-&gt;this_bdev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ( newstate &amp; Secondary ) =
{<br>

------=_Part_10226_12268958.1132669797604--
