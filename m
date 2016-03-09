Return-Path: <jhkim@mantech.co.kr>
Received: from mail-vk0-f53.google.com (mail-vk0-f53.google.com
	[209.85.213.53]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id C52BF1056331
	for <drbd-dev@lists.linbit.com>; Wed,  9 Mar 2016 13:51:46 +0100 (CET)
Received: by mail-vk0-f53.google.com with SMTP id e6so53945049vkh.2
	for <drbd-dev@lists.linbit.com>; Wed, 09 Mar 2016 04:51:46 -0800 (PST)
MIME-Version: 1.0
Date: Wed, 9 Mar 2016 21:51:44 +0900
Message-ID: <CAF6H8oHCEQyWo95NPKucO4w=+1jFwJh0aP=AwETWre=cw37s_A@mail.gmail.com>
From: Jaeheon Kim <jhkim@mantech.co.kr>
To: drbd-dev@lists.linbit.com
Content-Type: multipart/alternative; boundary=001a1144084607d575052d9d2933
Subject: Re: [Drbd-dev] [CASE-29] After re-connect,
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

--001a1144084607d575052d9d2933
Content-Type: text/plain; charset=UTF-8

Dear Phil,

Same problem occured at Window DRBD.

Node A:

C:\Windows\System32>drbdadm status r0
r0 role:Primary
  disk:UpToDate blocked:upper
  W7X86-3 role:Secondary
    replication:WFBitMapS peer-disk:Inconsistent


Node B:

C:\Windows\System32>drbdadm status r0
r0 role:Secondary
  disk:Inconsistent blocked:upper
  W7X86-2 role:Primary
    replication:WFBitMapT peer-disk:UpToDate


if you want to see this Windows Log, I can send it to you.
Please check Linux first.

Thanks.



2016-03-03 22:18 GMT+09:00 Jaeheon Kim <jhkim@mantech.co.kr>:

> Dear Phil,
>
> Thank you for your new patch.
>
>      -
> http://git.drbd.org/drbd-9.0.git/commitdiff/ded61af75823ddd96da729c84278f7d26a9b3a7d
>
>
> 1. I think this patch should resolve CASE-14, CASE-20.
>
>     1) CASE-14:
>
>         [DRBD-user] [CASE-14] primary node hang by VM-net-disconnect
> during big file copy
>
> http://lists.linbit.com/pipermail/drbd-user/2016-February/022701.html
>
>          - See  my comments "10) worker thread deadlock" and "11) receiver
> thread deadlock"
>          - This deadlock disappeared.
>          - Not reproduced yet.
>
>     2) CASE-20:
>
>          [DRBD-user] [CASE-20] What is the tail_recursion operation during
> drbd_req_destroy?
>
> http://lists.linbit.com/pipermail/drbd-user/2016-February/022719.html
>
>           - Panic by "tail_recursion" disappeared also.
>
>
> 2. Another problem occurred !!!
>
>    1) Test-step
>
>       - Test scenario is similar as CASE-14.
>       - During big file copy, If you disconnect and connect by VM network
> icon
>         then each node sometimes goes to WFBitMapS-WFBitMapT status
> continuously and file copy command on the primary hangs.
>
>
>    2) Log (/var/log/messages) analysys:
>
>        (1) primary log
>            - Click  http://pastebin.com/3hAWNkHn
>
>        (2) secondary log
>            - Click http://pastebin.com/KK1MUbDT
>
>
> 3. Questions
>
>    1) Why did not start resyn after WFBitMapS-WFBitMapT?
>
>    2) What is this ASSERT?
>          -  "Mar  3 14:38:28 drbd9-02 kernel: drbd r0/0 drbd1: ASSERT
> FAILED cstate = SyncTarget, expected: WFSyncUUID|WFBitMapT|Behind"
>
> Please check my comments in the attached log files.
>
> Thanks.
>
>

--001a1144084607d575052d9d2933
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Dear Phil,<div><br></div><div>Same problem occured at Wind=
ow DRBD.</div><div><br>Node A:<br>=C2=A0<br>C:\Windows\System32&gt;drbdadm =
status r0<br>r0 role:Primary<br>=C2=A0 disk:UpToDate blocked:upper<br>=C2=
=A0 W7X86-3 role:Secondary<br>=C2=A0 =C2=A0 replication:WFBitMapS peer-disk=
:Inconsistent<br><br><br>Node B:<br><br>C:\Windows\System32&gt;drbdadm stat=
us r0<br>r0 role:Secondary<br>=C2=A0 disk:Inconsistent blocked:upper<br>=C2=
=A0 W7X86-2 role:Primary<br>=C2=A0 =C2=A0 replication:WFBitMapT peer-disk:U=
pToDate<br><br><br>if you want to see this Windows Log, I can send it to yo=
u.</div><div>Please check Linux first.</div><div><br></div><div>Thanks.</di=
v><div><br></div><div><br><div class=3D"gmail_extra"><br><div class=3D"gmai=
l_quote">2016-03-03 22:18 GMT+09:00 Jaeheon Kim <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:jhkim@mantech.co.kr" target=3D"_blank">jhkim@mantech.co.kr</a>=
&gt;</span>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);border-le=
ft-style:solid;padding-left:1ex"><div dir=3D"ltr">Dear Phil,<br><br>Thank y=
ou for your new patch.<div><br>=C2=A0 =C2=A0 =C2=A0- <a href=3D"http://git.=
drbd.org/drbd-9.0.git/commitdiff/ded61af75823ddd96da729c84278f7d26a9b3a7d" =
target=3D"_blank">http://git.drbd.org/drbd-9.0.git/commitdiff/ded61af75823d=
dd96da729c84278f7d26a9b3a7d</a><br><br><br>1. I think this patch should res=
olve CASE-14, CASE-20.<br><br>=C2=A0 =C2=A0 1) CASE-14: =C2=A0<br><br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 [DRBD-user] [CASE-14] primary node hang by VM-net-=
disconnect during big file copy<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0<a href=3D"http://lists.linbit.com/pipermail/drbd-user/2016-February/022=
701.html" target=3D"_blank">http://lists.linbit.com/pipermail/drbd-user/201=
6-February/022701.html</a><br><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- See =
=C2=A0my comments &quot;10) worker thread deadlock&quot; and &quot;11) rece=
iver thread deadlock&quot;=C2=A0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- Thi=
s deadlock disappeared.=C2=A0</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-=
 Not reproduced yet.</div><div><br>=C2=A0 =C2=A0 2) CASE-20:<br><br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0[DRBD-user] [CASE-20] What is the tail_recursion=
 operation during drbd_req_destroy?<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 <a href=3D"http://lists.linbit.com/pipermail/drbd-user/2016-February=
/022719.html" target=3D"_blank">http://lists.linbit.com/pipermail/drbd-user=
/2016-February/022719.html</a><br><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - =
Panic by &quot;tail_recursion&quot; disappeared also.<br><br><br>2. Another=
 problem occurred !!!<br><br>=C2=A0 =C2=A01) Test-step<br><br>=C2=A0 =C2=A0=
 =C2=A0 - Test scenario is similar as CASE-14.<br>=C2=A0 =C2=A0 =C2=A0 - Du=
ring big file copy, If you disconnect and connect by VM network icon<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 then each node sometimes goes to WFBitMapS-WFBitMa=
pT status continuously and file copy command on the primary hangs.<br><br><=
br>=C2=A0 =C2=A02) Log (/var/log/messages) analysys:<div><br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0(1) primary log<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- =
Click =C2=A0<a href=3D"http://pastebin.com/3hAWNkHn" target=3D"_blank">http=
://pastebin.com/3hAWNkHn</a><br><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0(2) secondar=
y log<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- Click <a href=3D"http:/=
/pastebin.com/KK1MUbDT" target=3D"_blank">http://pastebin.com/KK1MUbDT</a><=
br><br><br>3. Questions<br><br>=C2=A0 =C2=A01) Why did not start resyn afte=
r=C2=A0WFBitMapS-WFBitMapT?<br><br>=C2=A0 =C2=A02) What is this ASSERT?<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- =C2=A0&quot;Mar =C2=A03 14:38:28 drbd9-=
02 kernel: drbd r0/0 drbd1: ASSERT FAILED cstate =3D SyncTarget, expected: =
WFSyncUUID|WFBitMapT|Behind&quot;<br><br>Please check my comments in the at=
tached log files.<br><br>Thanks.<br>
<div><br></div></div></div></div>
</blockquote></div><div class=3D"gmail_signature"><div dir=3D"ltr"><div><di=
v dir=3D"ltr"><div><div dir=3D"ltr"><p style=3D"margin:0cm 0cm 0.0001pt;lin=
e-height:21px"><span lang=3D"EN-US" style=3D"font-size:8pt;line-height:16px=
;font-family:&#39;\00b9d1\00c740  \00ace0\00b515&#39;;color:rgb(127,127,127=
)"><br></span></p></div></div></div></div></div></div>
</div></div></div>

--001a1144084607d575052d9d2933--
