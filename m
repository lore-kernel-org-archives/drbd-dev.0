Return-Path: <dongsheng081251@gmail.com>
Received: from mail-yb1-f195.google.com (mail-yb1-f195.google.com
	[209.85.219.195])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id EFFED420388
	for <drbd-dev@lists.linbit.com>; Thu,  6 Feb 2020 03:18:36 +0100 (CET)
Received: by mail-yb1-f195.google.com with SMTP id o199so178588ybc.4
	for <drbd-dev@lists.linbit.com>; Wed, 05 Feb 2020 18:18:36 -0800 (PST)
MIME-Version: 1.0
References: <CA+qeAOqyL5fDoFUXxVD0iaYSpY9P1qNH0Hd7eUUyGCg6hznKRQ@mail.gmail.com>
In-Reply-To: <CA+qeAOqyL5fDoFUXxVD0iaYSpY9P1qNH0Hd7eUUyGCg6hznKRQ@mail.gmail.com>
From: Dongsheng Yang <dongsheng081251@gmail.com>
Message-ID: <CA+qeAOpn85PevU6yxKqyt358ZVhdmLfwdaxvcpi4vy32Y4u8Mg@mail.gmail.com>
To: lars.ellenberg@linbit.com, philipp.reisner@linbit.com,
	linux-block@vger.kernel.org, joel.colledge@linbit.com,
	drbd-dev@lists.linbit.com
Content-Type: multipart/alternative; boundary="00000000000054705f059dde691f"
Cc: duan.zhang@easystack.cn
Subject: [Drbd-dev] Fwd: Bug Report : meet an unexcepted WFBitMapS status
 after restarting the primary
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
Date: Thu, 06 Feb 2020 02:18:37 -0000

--00000000000054705f059dde691f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Philipp and Lars,
     Any suggestions?

Thanx
---------- Forwarded message ---------
=E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9A Dongsheng Yang <dongsheng081251@gmail.=
com>
Date: 2020=E5=B9=B42=E6=9C=885=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=
=887:06
Subject: Bug Report : meet an unexcepted WFBitMapS status after restarting
the primary
To: <joel.colledge@linbit.com>
Cc: <drbd-dev@lists.linbit.com>, <duan.zhang@easystack.cn>


Hi guys,

Version: drbd-9.0.21-1

Layout: drbd.res within 3 nodes -- node-1(Secondary), node-2(Primary),
node-3(Secondary)

Description:
a.reboot node-2 when cluster is working.
b.re-up the drbd.res on node-2 after it restarted.
c.an expected resync from node-3 to node-2 happens. When the resync is
done, however,
  node-1 raises an unexpected WFBitMapS repl status and can't recover to
normal anymore.

Status output:

node-1: drbdadm status

drbd6 role:Secondary

disk:UpToDate

hotspare connection:Connecting

node-2 role:Primary

replication:WFBitMapS peer-disk:Consistent

node-3 role:Secondary

peer-disk:UpToDate


node-2: drbdadm status

drbd6 role:Primary

disk:UpToDate

hotspare connection:Connecting

node-1 role:Secondary

peer-disk:UpToDate

node-3 role:Secondary

peer-disk:UpToDate

I assume that there is a process sequence below according to my source code
version:
node-1                                           node-2
                                       node-3
        restarted with CRASHED_PRIMARY
        start sync with node-3 as target
 start sync with node-2 as source
        =E2=80=A6                                                          =
      =E2=80=A6
                                                 end sync with node-3
                                       end sync with node-2
        w_after_state_change
                      loop 1 within for loop against node-1:(a)
receive_uuids10                                  send uuid with
UUID_FLAG_GOT_STABLE&CRASHED_PRIMARY to node-1
receive uuid of node-2 with CRASHED_PRIMARY      loop 2 within for loop
against node-3:
        clear  CRASHED_PRIMARY(b)
send uuid to node-2 with UUID_FLAG_RESYNC        receive uuids10
sync_handshake to SYNC_SOURCE_IF_BOTH_FAILED     sync_handshake to NO_SYNC
change repl state to WFBitMapS

The key problem is about the order of step(a) and step(b), that is, node-2
sends the
unexpected  CRASHED_PRIMARY to node-1 though it's actually no longer a
crashed primary
after syncing with node-3.
So may I have the below questions:
a.Is this really a BUG or just an expected result?
b.If there's already a patch fix within the newest verion?
c.If there's some workaround method against this kind of unexcepted status,
since I really
  meet so many other problems like that :(

--00000000000054705f059dde691f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Philipp and Lars,</div><div>=C2=A0 =C2=A0 =C2=A0An=
y suggestions?</div><div><br></div>Thanx<br><div class=3D"gmail_quote"><div=
 dir=3D"ltr" class=3D"gmail_attr">---------- Forwarded message ---------<br=
>=E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9A <strong class=3D"gmail_sendername" di=
r=3D"auto">Dongsheng Yang</strong> <span dir=3D"auto">&lt;<a href=3D"mailto=
:dongsheng081251@gmail.com">dongsheng081251@gmail.com</a>&gt;</span><br>Dat=
e: 2020=E5=B9=B42=E6=9C=885=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=887:=
06<br>Subject: Bug Report : meet an unexcepted WFBitMapS status after resta=
rting the primary<br>To:  &lt;<a href=3D"mailto:joel.colledge@linbit.com">j=
oel.colledge@linbit.com</a>&gt;<br>Cc:  &lt;<a href=3D"mailto:drbd-dev@list=
s.linbit.com">drbd-dev@lists.linbit.com</a>&gt;,  &lt;<a href=3D"mailto:dua=
n.zhang@easystack.cn">duan.zhang@easystack.cn</a>&gt;<br></div><br><br><div=
 dir=3D"ltr"><div>Hi guys,</div><div><br></div>Version: drbd-9.0.21-1<br><b=
r>Layout: drbd.res within 3 nodes -- node-1(Secondary), node-2(Primary), no=
de-3(Secondary)<br><br>Description: <br>a.reboot node-2 when cluster is wor=
king.<br>b.re-up the drbd.res on node-2 after it restarted.<br><a href=3D"h=
ttp://c.an" target=3D"_blank">c.an</a> expected resync from node-3 to node-=
2 happens. When the resync is done, however,<br>=C2=A0 node-1 raises an une=
xpected WFBitMapS repl status and can&#39;t recover to normal anymore.<br><=
br>Status output:<br><br>node-1: drbdadm status<br><br>drbd6 role:Secondary=
<br><br>disk:UpToDate<br><br>hotspare connection:Connecting<br><br>node-2 r=
ole:Primary<br><br>replication:WFBitMapS peer-disk:Consistent<br><br>node-3=
 role:Secondary<br><br>peer-disk:UpToDate<br><br><br>node-2: drbdadm status=
<br><br>drbd6 role:Primary<br><br>disk:UpToDate<br><br>hotspare connection:=
Connecting<br><br>node-1 role:Secondary<br><br>peer-disk:UpToDate<br><br>no=
de-3 role:Secondary<br><br>peer-disk:UpToDate<br><br>I assume that there is=
 a process sequence below according to my source code version:<br>node-1 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 n=
ode-2 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0node-3<br=
>					 =C2=A0 =C2=A0 =C2=A0 =C2=A0 restarted with CRASHED_PRIMARY =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <br>					 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 start sync with node-3 as target =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0start sync with node-2 as source<br>					 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =E2=80=A6 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0=E2=80=A6<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0end sync with no=
de-3 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0end sync with node-2<br>					 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
w_after_state_change<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0			=
	 =C2=A0 =C2=A0 =C2=A0 =C2=A0 loop 1 within for loop against node-1:(a)<br>=
receive_uuids10 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0send uuid with U=
UID_FLAG_GOT_STABLE&amp;CRASHED_PRIMARY to node-1<br>receive uuid of node-2=
 with CRASHED_PRIMARY =C2=A0 =C2=A0 =C2=A0loop 2 within for loop against no=
de-3:<br>					 =C2=A0 =C2=A0 =C2=A0 =C2=A0 clear =C2=A0CRASHED_PRIMARY(b)<b=
r>send uuid to node-2 with UUID_FLAG_RESYNC =C2=A0 =C2=A0 =C2=A0 =C2=A0rece=
ive uuids10<br>sync_handshake to SYNC_SOURCE_IF_BOTH_FAILED =C2=A0 =C2=A0 s=
ync_handshake to NO_SYNC<br>change repl state to WFBitMapS<br><br>The key p=
roblem is about the order of step(a) and step(b), that is, node-2 sends the=
<br>unexpected =C2=A0CRASHED_PRIMARY to node-1 though it&#39;s actually no =
longer a crashed primary<br>after syncing with node-3.<br>So may I have the=
 below questions:<br>a.Is this really a BUG or just an expected result?<br>=
b.If there&#39;s already a patch fix within the newest verion?<br>c.If ther=
e&#39;s some workaround method against this kind of unexcepted status, sinc=
e I really<br>=C2=A0 meet so many other problems like that :(=C2=A0<br></di=
v>
</div></div>

--00000000000054705f059dde691f--
