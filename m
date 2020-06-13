Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
	[209.85.128.66])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id C40564203EA
	for <drbd-dev@lists.linbit.com>; Sat, 13 Jun 2020 11:56:22 +0200 (CEST)
Received: by mail-wm1-f66.google.com with SMTP id q25so10174274wmj.0
	for <drbd-dev@lists.linbit.com>; Sat, 13 Jun 2020 02:56:22 -0700 (PDT)
Received: from soda.linbit (62-99-137-214.static.upcbusiness.at.
	[62.99.137.214]) by smtp.gmail.com with ESMTPSA id
	j16sm16459416wre.21.2020.06.13.02.56.21
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
	Sat, 13 Jun 2020 02:56:21 -0700 (PDT)
Resent-Message-ID: <20200613095619.GE4222@soda.linbit>
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com
	[209.85.166.172])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id A533942000B
	for <drbd-dev@lists.linbit.com>; Fri, 24 Apr 2020 15:23:09 +0200 (CEST)
Received: by mail-il1-f172.google.com with SMTP id u5so9248875ilb.5
	for <drbd-dev@lists.linbit.com>; Fri, 24 Apr 2020 06:23:09 -0700 (PDT)
MIME-Version: 1.0
From: Sooth Sayuh <soothsayuh@gmail.com>
Message-ID: <CAJY+Dk84F0rtQb6tp+MgT_Ch=Scst0dyJYFN1d6Ng3Tn7i_hwA@mail.gmail.com>
To: drbd-dev@lists.linbit.com
Content-Type: multipart/alternative; boundary="00000000000022b80a05a4094451"
Subject: [Drbd-dev] error during ./configure of drbd-utils-9.12.2
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
Date: Sat, 13 Jun 2020 09:57:15 -0000

--00000000000022b80a05a4094451
Content-Type: text/plain; charset="UTF-8"

running ./configure for drbd-utils-9.12.2 i get this:

checking for stdint.h... yes
checking for unistd.h... yes
checking linux/genetlink.h usability... no
checking linux/genetlink.h presence... yes
configure: WARNING: linux/genetlink.h: present but cannot be compiled
configure: WARNING: linux/genetlink.h:     check for missing prerequisite
headers?
configure: WARNING: linux/genetlink.h: see the Autoconf documentation
configure: WARNING: linux/genetlink.h:     section "Present But Cannot Be
Compiled"
configure: WARNING: linux/genetlink.h: proceeding with the compiler's result
configure: WARNING:     ## ---------------------------------------- ##
configure: WARNING:     ## Report this to drbd-dev@lists.linbit.com ##
configure: WARNING:     ## ---------------------------------------- ##
checking for linux/genetlink.h... no
configure: error: Could not find linux/genetlink.h

kernel is 4.1.12-124.26.12.el6uek.x86_64
---------------------------------------------------------------
also this is a special system with certain packages installed with hard
dependencies.  I had to force install libdtrace-ctf-0.8.0-1.el6.x86_64 to
get drbd to compile.
---------------------------------------------------------------
lastly - now when i run most drbdadm commands i see this:
[root@ct-broom-03 drbd.d]# drbdadm up r0
API mismatch!
        API version drbdsetup: 1 kernel: 2
        header size drbdsetup: 8 kernel: 8
Command 'drbdsetup new-resource r0 0' terminated with exit code 20
drbdadm: new-minor r0: skipped due to earlier error

I cannot seem to find a solution to that...could it be my forced rpm
install?

--00000000000022b80a05a4094451
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">running ./configure for drbd-utils-9.12.2 i get this:<div>=
<br></div><div>checking for stdint.h... yes<br>checking for unistd.h... yes=
<br>checking linux/genetlink.h usability... no<br>checking linux/genetlink.=
h presence... yes<br>configure: WARNING: linux/genetlink.h: present but can=
not be compiled<br>configure: WARNING: linux/genetlink.h: =C2=A0 =C2=A0 che=
ck for missing prerequisite headers?<br>configure: WARNING: linux/genetlink=
.h: see the Autoconf documentation<br>configure: WARNING: linux/genetlink.h=
: =C2=A0 =C2=A0 section &quot;Present But Cannot Be Compiled&quot;<br>confi=
gure: WARNING: linux/genetlink.h: proceeding with the compiler&#39;s result=
<br>configure: WARNING: =C2=A0 =C2=A0 ## ----------------------------------=
------ ##<br>configure: WARNING: =C2=A0 =C2=A0 ## Report this to <a href=3D=
"mailto:drbd-dev@lists.linbit.com">drbd-dev@lists.linbit.com</a> ##<br>conf=
igure: WARNING: =C2=A0 =C2=A0 ## ---------------------------------------- #=
#<br>checking for linux/genetlink.h... no<br>configure: error: Could not fi=
nd linux/genetlink.h<br></div><div><br></div><div>kernel is 4.1.12-124.26.1=
2.el6uek.x86_64</div><div>-------------------------------------------------=
--------------</div><div>also this is a special system with certain package=
s installed with hard dependencies.=C2=A0 I had to force install=C2=A0libdt=
race-ctf-0.8.0-1.el6.x86_64 to get drbd to compile.</div><div><div>--------=
-------------------------------------------------------</div><div></div></d=
iv><div>lastly - now when i run most drbdadm commands i see this:</div><div=
>[root@ct-broom-03 drbd.d]# drbdadm up r0<br>API mismatch!<br>=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 API version drbdsetup: 1 kernel: 2<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 header size drbdsetup: 8 kernel: 8<br>Command &#39;drbdsetup new-res=
ource r0 0&#39; terminated with exit code 20<br>drbdadm: new-minor r0: skip=
ped due to earlier error<br></div><div><br></div><div>I cannot seem to find=
 a solution to that...could it be my forced rpm install?</div><div><br></di=
v></div>

--00000000000022b80a05a4094451--
