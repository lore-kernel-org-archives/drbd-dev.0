Return-Path: <jhkim@mantech.co.kr>
Received: from mail-vk0-f41.google.com (mail-vk0-f41.google.com
	[209.85.213.41]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id AA5A21056331
	for <drbd-dev@lists.linbit.com>; Sun, 10 Apr 2016 15:47:09 +0200 (CEST)
Received: by mail-vk0-f41.google.com with SMTP id c4so184486160vkb.3
	for <drbd-dev@lists.linbit.com>; Sun, 10 Apr 2016 06:47:09 -0700 (PDT)
MIME-Version: 1.0
Date: Sun, 10 Apr 2016 22:47:07 +0900
Message-ID: <CAF6H8oERRtqT+1N073fiJdg+xm=9R4FkgiUb7JbJv6WzL6UQFA@mail.gmail.com>
From: Jaeheon Kim <jhkim@mantech.co.kr>
To: drbd-dev@lists.linbit.com
Content-Type: multipart/alternative; boundary=001a1143da64fe3656053021a97d
Subject: [Drbd-dev] [CASE-41] After re-connected,
 despite of OOS remaining primary does not start re-synchronization
 or continues AHEAD mode.
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

--001a1143da64fe3656053021a97d
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Dear Phil,

We are verifying your patch for CASE-17;

     -
http://git.drbd.org/drbd-9.0.git/commitdiff/db0534012b16cb6708aeb57b8cca298=
16c4e5b52

It's good for resolution of "sync progress percentage unchanged at 100.00."=
.
But another problem occurred.


1. Test Env.

 - Version: lasted  [86e4439]
 - 2 nodes (drbd.conf sets for multi node, but we test just 2 nodes)
 - protocol A; sndbuf-size 10M;on-congestion pull-ahead;congestion-fill 5M;


2. Test-steps

 1) make primary/secondary
 2) copy big file
 3) drbdadm disconnect at the beginning of copying
 4) drbdadm connect r0
 5) sometimes, UpToDate/UpToDate without resync despite of OOS remaining.


3. primary status

[root@drbd9-01 =EB=B0=94=ED=83=95=ED=99=94=EB=A9=B4]# drbdsetup status --ve=
rbose --statistics
r0 node-id:0 role:Primary suspended:no
    write-ordering:flush
  volume:0 minor:1 disk:UpToDate
      size:4998328 read:6662461 written:3878932 al-writes:250 bm-writes:0
      upper-pending:0 lower-pending:0 al-suspended:no blocked:no
  drbd9-02 node-id:1 connection:Connected role:Secondary congested:no
    volume:0 replication:Established peer-disk:UpToDate
        resync-suspended:no
        received:0 sent:6661324 out-of-sync:1931560 pending:0 unacked:0


4. Log
  - primary log :
      -  http://pastebin.com/LKt0bmR5

  - Please check my comments in the attached log files.


5. Quesstions

 1) Why does the resync stop despite of OOS remaining?

 2) Sometimes, AHEAD mode continues, why?

 3) On Windows DRBD, sometimes the following messages occur.  Linux as
well, I think.

Mon Apr  4 19:15:05.555 2016 (UTC + 9:00):
Mon Apr  4 19:15:32.595 2016 (UTC + 9:00): WDRBD_INFO: [receive_state] drbd
r0/0 drbd2 2008r2-x64-pas1: SyncSource still sees bits set!! FIXME
Mon Apr  4 19:15:32.595 2016 (UTC + 9:00):
Mon Apr  4 19:15:32.612 2016 (UTC + 9:00): WDRBD_INFO:
[drbd_resync_finished] drbd r0/0 drbd2 2008r2-x64-pas1: Resync done (total
34 sec; paused 0 sec; 52524 K/sec)
Mon Apr  4 19:15:32.612 2016 (UTC + 9:00):
Mon Apr  4 19:15:32.626 2016 (UTC + 9:00): _WIN32_v9_CHECK: n_oos=3D396551
rs_failed=3D0. Ignore assert


 3-1)  On receive_state(), Is "FIXME" no problem?

         /* TODO: Since DRBD9 we experience that SyncSource still
            has  bits set... NEED TO UNDERSTAND AND FIX! */
          drbd_warn(peer_device, "SyncSource still sees bits set!!
FIXME\n");


 3-2)  On drbd_resync_finished(), Why does this ASSERT occure?

         D_ASSERT(peer_device, (n_oos - peer_device->rs_failed) =3D=3D 0);


Thanks.

--001a1143da64fe3656053021a97d
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Dear Phil,<br><br>We are verifying your patch for CASE-17;=
<div><br>=C2=A0 =C2=A0 =C2=A0- <a href=3D"http://git.drbd.org/drbd-9.0.git/=
commitdiff/db0534012b16cb6708aeb57b8cca29816c4e5b52">http://git.drbd.org/dr=
bd-9.0.git/commitdiff/db0534012b16cb6708aeb57b8cca29816c4e5b52</a><br><br>I=
t&#39;s good for resolution of &quot;sync progress percentage unchanged at =
100.00.&quot;.<br>But another problem occurred.<br><br><br>1. Test Env.<br>=
<br>=C2=A0- Version: lasted =C2=A0[86e4439]<br>=C2=A0- 2 nodes (drbd.conf s=
ets for multi node, but we test just 2 nodes)<br>=C2=A0- protocol A; sndbuf=
-size 10M;on-congestion pull-ahead;congestion-fill 5M;<br><br><br>2. Test-s=
teps<br><br>=C2=A01) make primary/secondary<br>=C2=A02) copy big file<br>=
=C2=A03) drbdadm disconnect at the beginning of copying<br>=C2=A04) drbdadm=
 connect r0<br>=C2=A05) sometimes, UpToDate/UpToDate without resync despite=
 of OOS remaining.<br><br><br>3. primary status<br><br>[root@drbd9-01 =EB=
=B0=94=ED=83=95=ED=99=94=EB=A9=B4]# drbdsetup status --verbose --statistics=
<br>r0 node-id:0 role:Primary suspended:no<br>=C2=A0 =C2=A0 write-ordering:=
flush<br>=C2=A0 volume:0 minor:1 disk:UpToDate<br>=C2=A0 =C2=A0 =C2=A0 size=
:4998328 read:6662461 written:3878932 al-writes:250 bm-writes:0<br>=C2=A0 =
=C2=A0 =C2=A0 upper-pending:0 lower-pending:0 al-suspended:no blocked:no<br=
>=C2=A0 drbd9-02 node-id:1 connection:Connected role:Secondary congested:no=
<br>=C2=A0 =C2=A0 volume:0 replication:Established peer-disk:UpToDate<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 resync-suspended:no<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 received:0 sent:6661324 out-of-sync:1931560 pending:0 unacked:0<br><br>=
<br>4. Log<br>=C2=A0 - primary log :=C2=A0</div><div>=C2=A0 =C2=A0 =C2=A0 -=
 =C2=A0<a href=3D"http://pastebin.com/LKt0bmR5">http://pastebin.com/LKt0bmR=
5</a></div><div><br>=C2=A0 - Please check my comments in the attached log f=
iles.<br><br><br>5. Quesstions<br><br>=C2=A01) Why does the resync stop des=
pite of OOS remaining?</div><div><br></div><div>=C2=A02) Sometimes, AHEAD m=
ode continues, why?</div><div><br>=C2=A03) On Windows DRBD, sometimes the f=
ollowing messages occur.=C2=A0 Linux as well, I think.<br><br>Mon Apr =C2=
=A04 19:15:05.555 2016 (UTC + 9:00): <br>Mon Apr =C2=A04 19:15:32.595 2016 =
(UTC + 9:00): WDRBD_INFO: [receive_state] drbd r0/0 drbd2 2008r2-x64-pas1: =
SyncSource still sees bits set!! FIXME<br>Mon Apr =C2=A04 19:15:32.595 2016=
 (UTC + 9:00): <br>Mon Apr =C2=A04 19:15:32.612 2016 (UTC + 9:00): WDRBD_IN=
FO: [drbd_resync_finished] drbd r0/0 drbd2 2008r2-x64-pas1: Resync done (to=
tal 34 sec; paused 0 sec; 52524 K/sec)<br>Mon Apr =C2=A04 19:15:32.612 2016=
 (UTC + 9:00): <br>Mon Apr =C2=A04 19:15:32.626 2016 (UTC + 9:00): _WIN32_v=
9_CHECK: n_oos=3D396551 rs_failed=3D0. Ignore assert=C2=A0<br><br><br>=C2=
=A03-1) =C2=A0On receive_state(), Is &quot;FIXME&quot; no problem?</div><di=
v><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* TODO: Since DRBD9 we experience =
that SyncSource still=C2=A0</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 has =C2=A0bits set... NEED TO UNDERSTAND AND FIX! */</div><div>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 drbd_warn(peer_device, &quot;SyncSource sti=
ll sees bits set!! FIXME\n&quot;);<br><br><br>=C2=A03-2) =C2=A0On drbd_resy=
nc_finished(), Why does this ASSERT occure?</div><div><br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0D_ASSERT(peer_device, (n_oos - peer_device-&gt;rs_failed) =
=3D=3D 0);<br><br><br>Thanks.</div><div><br></div><div><div class=3D"gmail_=
signature"><div dir=3D"ltr"><div><div dir=3D"ltr"><div><div dir=3D"ltr"><di=
v><br></div></div></div></div></div></div></div>
</div></div>

--001a1143da64fe3656053021a97d--
