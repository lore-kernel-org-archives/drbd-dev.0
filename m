Return-Path: <tjyang2001@gmail.com>
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com
	[209.85.208.48])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 990DE420005
	for <drbd-dev@lists.linbit.com>; Sun, 22 Mar 2020 17:34:22 +0100 (CET)
Received: by mail-ed1-f48.google.com with SMTP id a43so13545125edf.6
	for <drbd-dev@lists.linbit.com>; Sun, 22 Mar 2020 09:34:22 -0700 (PDT)
MIME-Version: 1.0
From: "T.J. Yang" <tjyang2001@gmail.com>
Message-ID: <CAD2GW8q5meBoNG+ewcWNLZKA7zS6-C2Ubzw9O5_n=p3fgZ83jQ@mail.gmail.com>
To: drbd-dev@lists.linbit.com
Content-Type: multipart/alternative; boundary="00000000000057eb6a05a173f4e1"
Subject: [Drbd-dev] spatch error message is not accurate
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
Date: Sun, 22 Mar 2020 16:34:22 -0000

--00000000000057eb6a05a173f4e1
Content-Type: text/plain; charset="UTF-8"

Hi

I tried to compile drbd9 master branch  on centos 8 which come with spatch
1.0.7 only.

following is one-liner patch to make error message match the checks(if hash
spatch && spatch_is_recent; then)  in drbd-kernel-compat/gen_compat_patch.sh

diff --git a/drbd/drbd-kernel-compat/gen_compat_patch.sh
b/drbd/drbd-kernel-compat/gen_compat_patch.sh
index 19466081..d6f34286 100644
--- a/drbd/drbd-kernel-compat/gen_compat_patch.sh
+++ b/drbd/drbd-kernel-compat/gen_compat_patch.sh
@@ -105,6 +105,6 @@ elif test ! -e ../.git && [[ $SPAAS = true ]]; then
     echo "  You can create a new .tgz including this pre-computed compat
patch"
     echo "  by calling \"echo drbd-$REL_VERSION/drbd/$compat_patch
>>.filelist ; make tgz\""
 else
-   echo "ERROR: spatch not found in \$PATH. Install package 'coccinelle'!"
+   echo "ERROR: spatch is older than version $MIN_SPATCH_VERSION OR spatch
not found in \$PATH. Install package 'coccinelle'!"
    exit 1
 fi

Regards

-- 
T.J. Yang

--00000000000057eb6a05a173f4e1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi</div><div><br></div><div>I tried to compile drbd9 =
master branch=C2=A0 on centos 8 which come with spatch 1.0.7 only.</div><di=
v><br></div><div>following is one-liner patch to make error message match t=
he checks(if hash spatch &amp;&amp; spatch_is_recent; then)=C2=A0 in=C2=A0d=
rbd-kernel-compat/gen_compat_patch.sh</div><div><br></div>diff --git a/drbd=
/drbd-kernel-compat/gen_compat_patch.sh b/drbd/drbd-kernel-compat/gen_compa=
t_patch.sh<br>index 19466081..d6f34286 100644<br>--- a/drbd/drbd-kernel-com=
pat/gen_compat_patch.sh<br>+++ b/drbd/drbd-kernel-compat/gen_compat_patch.s=
h<br>@@ -105,6 +105,6 @@ elif test ! -e ../.git &amp;&amp; [[ $SPAAS =3D tr=
ue ]]; then<br>=C2=A0 =C2=A0 =C2=A0echo &quot; =C2=A0You can create a new .=
tgz including this pre-computed compat patch&quot;<br>=C2=A0 =C2=A0 =C2=A0e=
cho &quot; =C2=A0by calling \&quot;echo drbd-$REL_VERSION/drbd/$compat_patc=
h &gt;&gt;.filelist ; make tgz\&quot;&quot;<br>=C2=A0else<br>- =C2=A0 echo =
&quot;ERROR: spatch not found in \$PATH. Install package &#39;coccinelle&#3=
9;!&quot;<br>+ =C2=A0 echo &quot;ERROR: spatch is older than version $MIN_S=
PATCH_VERSION OR spatch not found in \$PATH. Install package &#39;coccinell=
e&#39;!&quot;<br>=C2=A0 =C2=A0 exit 1<br>=C2=A0fi<br><div><br></div><div>Re=
gards</div><div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature"=
 data-smartmail=3D"gmail_signature">T.J. Yang</div></div>

--00000000000057eb6a05a173f4e1--
