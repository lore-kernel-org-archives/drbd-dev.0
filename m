Return-Path: <yannis.milios@gmail.com>
Received: from mail-oi0-f41.google.com (mail-oi0-f41.google.com
	[209.85.218.41])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id EB5B61057315
	for <drbd-dev@lists.linbit.com>; Fri,  6 Apr 2018 22:36:18 +0200 (CEST)
Received: by mail-oi0-f41.google.com with SMTP id f63-v6so2239630oic.4
	for <drbd-dev@lists.linbit.com>; Fri, 06 Apr 2018 13:36:18 -0700 (PDT)
MIME-Version: 1.0
From: Yannis Milios <yannis.milios@gmail.com>
Date: Fri, 6 Apr 2018 21:29:56 +0100
Message-ID: <CAFiF2OrzSO1DHLEqibK=mpid_Xfx3hdkmMjWEf=pgo4NYA=jkA@mail.gmail.com>
To: drbd-dev@lists.linbit.com
Content-Type: multipart/alternative; boundary="0000000000006c1ac6056933eb27"
Subject: [Drbd-dev] [drbdmanage-proxmox] cannot create/restore lxc container
 on non-leader nodes
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

--0000000000006c1ac6056933eb27
Content-Type: text/plain; charset="UTF-8"

Hello,

Sorry if this is not the right ML to report this, but thought it might good
to report it just in case that you are not already aware of it.

I'm using a 3 node Proxmox cluster backed by DRBD9 over ZFS.
All seem to work pretty well, apart from an issue with LXC containers.

The facts:
====================
cat /proc/drbd
version: 9.0.12-1 (api:2/proto:86-112)
GIT-hash: 7eb4aef4abbfba8ebb1afbcc30574df74db0063e build by root@pve2,
2018-03-14 08:23:43
Transports (api:16): tcp (9.0.12-1)

drbdmanage --version
drbdmanage 0.99.16; GIT-hash: a51c4e7858da69c4f56fc5b945c0ef586aae318b

drbdmanage-proxmox        2.1-1

drbd-utils                9.3.0-1

pveversion
pve-manager/5.1-46/ae8241d4 (running kernel: 4.13.13-6-pve
======================


The issue:
====================

When creating a new LXC container (or restoring from a LXC backup) on a
*non-leader* DRBD9 node, the process is failing with the following error:



> pong
> Operation completed successfully
> Operation completed successfully
> pong
> Operation completed successfully
> Operation completed successfully
> pong
> Operation completed successfully
> pong
> Operation completed successfully
> Operation completed successfully
> Waiting for server: ..
> mke2fs 1.43.4 (31-Jan-2017)
> Discarding device blocks:    4096/3932160 528384/3932160 1052672/3932160
> 1576960/3932160 2101248/3932160 2625536/3932160 3149824/3932160
> 3674112/3932160                 done
> Creating filesystem with 3932160 4k blocks and 983040 inodes
> Filesystem UUID: e2255445-4aca-4bfc-b130-c0f2d1324b17
> Superblock backups stored on blocks:
> 32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632, 2654208
> Allocating group tables:   0/120         done
> Writing inode tables:   0/120         done
> Creating journal (16384 blocks): done
> Multiple mount protection is enabled with update interval 5 seconds.
> Writing superblocks and filesystem accounting information:   0/120
> done
> pong
> Operation completed successfully
> Operation completed successfully
> pong
> Operation completed successfully
> Operation completed successfully
> pong
> Operation completed successfully
> pong
> Operation completed successfully
> Operation completed successfully
> Waiting for server: .
> mke2fs 1.43.4 (31-Jan-2017)
> The file /dev/drbd/by-res/vm-100-disk-2/0 does not exist and no size was
> specified.
> pong
> Operation completed successfully
> Operation completed successfully
> TASK ERROR: command 'mkfs.ext4 -O mmp -E 'root_owner=0:0'
> /dev/drbd/by-res/vm-100-disk-2/0' failed: exit code 1


When executing the same task on a leader node, everything works perfectly.

I remember this same issue when creating qemu vms in the past, but
eventually it was fixed. Would it be possible to do the same for LXCs
please?

Regards,
Yannis

--0000000000006c1ac6056933eb27
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello,<div><br></div><div>Sorry if this is not the right M=
L to report this, but thought it might good to report it just in case that =
you are not already aware of it.</div><div><br></div><div>I&#39;m using a 3=
 node Proxmox cluster backed by DRBD9 over ZFS.=C2=A0</div><div>All seem to=
 work pretty well, apart from an issue with LXC containers.</div><div><br><=
/div><div>The facts:</div><div>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D</div><div><div>cat /proc/drbd</div><div>version: 9.0.12-=
1 (api:2/proto:86-112)</div><div>GIT-hash: 7eb4aef4abbfba8ebb1afbcc30574df7=
4db0063e build by root@pve2, 2018-03-14 08:23:43</div><div>Transports (api:=
16): tcp (9.0.12-1)</div><div><br></div><div>drbdmanage --version</div><div=
>drbdmanage 0.99.16; GIT-hash: a51c4e7858da69c4f56fc5b945c0ef586aae318b</di=
v></div><div><br></div><div>drbdmanage-proxmox=C2=A0 =C2=A0 =C2=A0 =C2=A0 2=
.1-1=C2=A0=C2=A0<br></div><div><br></div><div>drbd-utils=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 9.3.0-1=C2=A0<br></div><div><br></di=
v><div><div>pveversion</div><div>pve-manager/5.1-46/ae8241d4 (running kerne=
l: 4.13.13-6-pve</div></div><div>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D</div><div><br></div><div><br></div><div>The issue:=
</div><div>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</di=
v><div><br></div><div>When creating a new LXC container (or restoring from =
a LXC backup) on a *non-leader* DRBD9 node, the process is failing with the=
 following error:</div><div><br></div><div><br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex"><br>pong<br>Operation completed successfully<br=
>Operation completed successfully<br>pong<br>Operation completed successful=
ly<br>Operation completed successfully<br>pong<br>Operation completed succe=
ssfully<br>pong<br>Operation completed successfully<br>Operation completed =
successfully<br>Waiting for server: ..<br>mke2fs 1.43.4 (31-Jan-2017)<br>Di=
scarding device blocks:=C2=A0 =C2=A0 4096/3932160                528384/393=
2160               1052672/3932160               1576960/3932160           =
    2101248/3932160               2625536/3932160               3149824/393=
2160               3674112/3932160               =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0               done=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
=C2=A0<br>Creating filesystem with 3932160 4k blocks and 983040 inodes<br>F=
ilesystem UUID: e2255445-4aca-4bfc-b130-c0f2d1324b17<br>Superblock backups =
stored on blocks:=C2=A0<br><span style=3D"white-space:pre">	</span>32768, 9=
8304, 163840, 229376, 294912, 819200, 884736, 1605632, 2654208<br>Allocatin=
g group tables:=C2=A0 =C2=A00/120       =C2=A0 =C2=A0 =C2=A0 =C2=A0       d=
one=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0<br>Writing inode tables:=C2=A0 =C2=A00/12=
0       =C2=A0 =C2=A0 =C2=A0 =C2=A0       done=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0=
<br>Creating journal (16384 blocks): done<br>Multiple mount protection is e=
nabled with update interval 5 seconds.<br>Writing superblocks and filesyste=
m accounting information:=C2=A0 =C2=A00/120       =C2=A0 =C2=A0 =C2=A0 =C2=
=A0       done<br>pong<br>Operation completed successfully<br>Operation com=
pleted successfully<br>pong<br>Operation completed successfully<br>Operatio=
n completed successfully<br>pong<br>Operation completed successfully<br>pon=
g<br>Operation completed successfully<br>Operation completed successfully<b=
r>Waiting for server: .<br>mke2fs 1.43.4 (31-Jan-2017)<br>The file /dev/drb=
d/by-res/vm-100-disk-2/0 does not exist and no size was specified.<br>pong<=
br>Operation completed successfully<br>Operation completed successfully<br>=
TASK ERROR: command &#39;mkfs.ext4 -O mmp -E &#39;root_owner=3D0:0&#39; /de=
v/drbd/by-res/vm-100-disk-2/0&#39; failed: exit code 1</blockquote><div><br=
></div><div>When executing the same task on a leader node, everything works=
 perfectly.</div><div><br></div><div>I remember this same issue when creati=
ng qemu vms in the past, but eventually it was fixed. Would it be possible =
to do the same for LXCs please?</div><div><br></div><div>Regards,</div><div=
>Yannis=C2=A0</div></div>

--0000000000006c1ac6056933eb27--
