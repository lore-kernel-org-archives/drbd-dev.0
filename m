Return-Path: <nathanfaber@gmail.com>
Received: from mail-bw0-f224.google.com (mail-bw0-f224.google.com
	[209.85.218.224])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 0180B1011BE1
	for <drbd-dev@lists.linbit.com>; Thu, 11 Feb 2010 23:53:46 +0100 (CET)
Received: by bwz24 with SMTP id 24so268599bwz.9
	for <drbd-dev@lists.linbit.com>; Thu, 11 Feb 2010 14:53:46 -0800 (PST)
MIME-Version: 1.0
Date: Thu, 11 Feb 2010 17:46:30 -0500
Message-ID: <785112911002111446i1010e429kf36ae7dcecacaeb3@mail.gmail.com>
From: Nathan Faber <nathanfaber@gmail.com>
To: drbd-dev@lists.linbit.com
Content-Type: multipart/alternative; boundary=00032555a71a0a9c05047f5aecc2
Subject: [Drbd-dev] missing shift in snapshot-resync-target-lvm.sh
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

--00032555a71a0a9c05047f5aecc2
Content-Type: text/plain; charset=ISO-8859-1

Hi,

In 8.3.7 and in 8.3 git the shift on the percent arg is off by one and
causes an infinite loop on before-resync-target execution.

--- snapshot-resync-target-lvm-orig.sh 2010-02-03 18:54:27.000000000 -0500
+++ snapshot-resync-target-lvm.sh 2010-02-11 17:34:46.000000000 -0500
@@ -44,7 +44,7 @@
  case $1 in
  -p|--percent)
  SNAP_PERC="$2"
- shift
+ shift 2
  ;;
  -a|--additional)
  SNAP_ADDITIONAL="$2"

--00032555a71a0a9c05047f5aecc2
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>Hi,</div><div><br></div><div>In 8.3.7 and in 8.3 git the shift on the =
percent arg is off by one and causes an infinite loop on=A0before-resync-ta=
rget execution.</div><div><br></div><div>--- snapshot-resync-target-lvm-ori=
g.sh<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>2010-0=
2-03 18:54:27.000000000 -0500</div>
<div>+++ snapshot-resync-target-lvm.sh<span class=3D"Apple-tab-span" style=
=3D"white-space:pre">	</span>2010-02-11 17:34:46.000000000 -0500</div><div>=
@@ -44,7 +44,7 @@</div><div>=A0<span class=3D"Apple-tab-span" style=3D"whit=
e-space:pre">	</span>case $1 in</div>
<div>=A0<span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>-=
p|--percent)</div><div>=A0<span class=3D"Apple-tab-span" style=3D"white-spa=
ce:pre">			</span>SNAP_PERC=3D&quot;$2&quot;</div><div>-<span class=3D"Appl=
e-tab-span" style=3D"white-space:pre">			</span>shift</div>
<div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">			</span>sh=
ift 2</div><div>=A0<span class=3D"Apple-tab-span" style=3D"white-space:pre"=
>			</span>;;</div><div>=A0<span class=3D"Apple-tab-span" style=3D"white-sp=
ace:pre">		</span>-a|--additional)</div>
<div>=A0<span class=3D"Apple-tab-span" style=3D"white-space:pre">			</span>=
SNAP_ADDITIONAL=3D&quot;$2&quot;</div><div><br></div>

--00032555a71a0a9c05047f5aecc2--
