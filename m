Return-Path: <jhkim@mantech.co.kr>
Received: from mail-vk0-f41.google.com (mail-vk0-f41.google.com
	[209.85.213.41]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id DB234105632B
	for <drbd-dev@lists.linbit.com>; Thu,  3 Mar 2016 14:18:07 +0100 (CET)
Received: by mail-vk0-f41.google.com with SMTP id e6so20759193vkh.2
	for <drbd-dev@lists.linbit.com>; Thu, 03 Mar 2016 05:18:07 -0800 (PST)
MIME-Version: 1.0
Date: Thu, 3 Mar 2016 22:18:06 +0900
Message-ID: <CAF6H8oEuwi9V+PxJ69-+2socArhqj9CLQxhDX5kOCOozr_Q3_Q@mail.gmail.com>
From: Jaeheon Kim <jhkim@mantech.co.kr>
To: drbd-dev@lists.linbit.com
Content-Type: multipart/alternative; boundary=001a114408da3cf84d052d24d43c
Subject: [Drbd-dev] [CASE-29] After re-connect,
 WFBitMapS-WFBitMapT status has sustained continuously and copy
 command hangs
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

--001a114408da3cf84d052d24d43c
Content-Type: text/plain; charset=UTF-8

Dear Phil,

Thank you for your new patch.

     -
http://git.drbd.org/drbd-9.0.git/commitdiff/ded61af75823ddd96da729c84278f7d26a9b3a7d


1. I think this patch should resolve CASE-14, CASE-20.

    1) CASE-14:

        [DRBD-user] [CASE-14] primary node hang by VM-net-disconnect during
big file copy

http://lists.linbit.com/pipermail/drbd-user/2016-February/022701.html

         - See  my comments "10) worker thread deadlock" and "11) receiver
thread deadlock"
         - This deadlock disappeared.
         - Not reproduced yet.

    2) CASE-20:

         [DRBD-user] [CASE-20] What is the tail_recursion operation during
drbd_req_destroy?

http://lists.linbit.com/pipermail/drbd-user/2016-February/022719.html

          - Panic by "tail_recursion" disappeared also.


2. Another problem occurred !!!

   1) Test-step

      - Test scenario is similar as CASE-14.
      - During big file copy, If you disconnect and connect by VM network
icon
        then each node sometimes goes to WFBitMapS-WFBitMapT status
continuously and file copy command on the primary hangs.


   2) Log (/var/log/messages) analysys:

       (1) primary log
           - Click  http://pastebin.com/3hAWNkHn

       (2) secondary log
           - Click http://pastebin.com/KK1MUbDT


3. Questions

   1) Why did not start resyn after WFBitMapS-WFBitMapT?

   2) What is this ASSERT?
         -  "Mar  3 14:38:28 drbd9-02 kernel: drbd r0/0 drbd1: ASSERT
FAILED cstate = SyncTarget, expected: WFSyncUUID|WFBitMapT|Behind"

Please check my comments in the attached log files.

Thanks.

--001a114408da3cf84d052d24d43c
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Dear Phil,<br><br>Thank you for your new patch.<div><br>=
=C2=A0 =C2=A0 =C2=A0- <a href=3D"http://git.drbd.org/drbd-9.0.git/commitdif=
f/ded61af75823ddd96da729c84278f7d26a9b3a7d">http://git.drbd.org/drbd-9.0.gi=
t/commitdiff/ded61af75823ddd96da729c84278f7d26a9b3a7d</a><br><br><br>1. I t=
hink this patch should resolve CASE-14, CASE-20.<br><br>=C2=A0 =C2=A0 1) CA=
SE-14: =C2=A0<br><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 [DRBD-user] [CASE-14] prim=
ary node hang by VM-net-disconnect during big file copy<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"http://lists.linbit.com/pipermail/drb=
d-user/2016-February/022701.html">http://lists.linbit.com/pipermail/drbd-us=
er/2016-February/022701.html</a><br><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-=
 See =C2=A0my comments &quot;10) worker thread deadlock&quot; and &quot;11)=
 receiver thread deadlock&quot;=C2=A0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
- This deadlock disappeared.=C2=A0</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0- Not reproduced yet.</div><div><br>=C2=A0 =C2=A0 2) CASE-20:<br><br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[DRBD-user] [CASE-20] What is the tail_re=
cursion operation during drbd_req_destroy?<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 <a href=3D"http://lists.linbit.com/pipermail/drbd-user/2016-F=
ebruary/022719.html">http://lists.linbit.com/pipermail/drbd-user/2016-Febru=
ary/022719.html</a><br><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - Panic by &q=
uot;tail_recursion&quot; disappeared also.<br><br><br>2. Another problem oc=
curred !!!<br><br>=C2=A0 =C2=A01) Test-step<br><br>=C2=A0 =C2=A0 =C2=A0 - T=
est scenario is similar as CASE-14.<br>=C2=A0 =C2=A0 =C2=A0 - During big fi=
le copy, If you disconnect and connect by VM network icon<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 then each node sometimes goes to WFBitMapS-WFBitMapT status c=
ontinuously and file copy command on the primary hangs.<br><br><br>=C2=A0 =
=C2=A02) Log (/var/log/messages) analysys:<div><br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0(1) primary log<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- Click =C2=
=A0<a href=3D"http://pastebin.com/3hAWNkHn">http://pastebin.com/3hAWNkHn</a=
><br><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0(2) secondary log<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0- Click <a href=3D"http://pastebin.com/KK1MUbDT">ht=
tp://pastebin.com/KK1MUbDT</a><br><br><br>3. Questions<br><br>=C2=A0 =C2=A0=
1) Why did not start resyn after=C2=A0WFBitMapS-WFBitMapT?<br><br>=C2=A0 =
=C2=A02) What is this ASSERT?<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- =C2=A0=
&quot;Mar =C2=A03 14:38:28 drbd9-02 kernel: drbd r0/0 drbd1: ASSERT FAILED =
cstate =3D SyncTarget, expected: WFSyncUUID|WFBitMapT|Behind&quot;<br><br>P=
lease check my comments in the attached log files.<br><br>Thanks.<br>
<div><br></div></div></div></div>

--001a114408da3cf84d052d24d43c--
