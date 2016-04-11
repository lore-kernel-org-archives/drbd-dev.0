Return-Path: <jhkim@mantech.co.kr>
Received: from mail-vk0-f50.google.com (mail-vk0-f50.google.com
	[209.85.213.50]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 5320B105632B
	for <drbd-dev@lists.linbit.com>; Mon, 11 Apr 2016 09:07:19 +0200 (CEST)
Received: by mail-vk0-f50.google.com with SMTP id k1so200851143vkb.0
	for <drbd-dev@lists.linbit.com>; Mon, 11 Apr 2016 00:07:19 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 11 Apr 2016 16:07:18 +0900
Message-ID: <CAF6H8oF37=WnJPQ6EyA8VzuoOb155Y79oP7Gckmjx5=czQ0dcQ@mail.gmail.com>
From: Jaeheon Kim <jhkim@mantech.co.kr>
To: drbd-dev@lists.linbit.com
Content-Type: multipart/alternative; boundary=94eb2c123fccf4000b053030316d
Subject: [Drbd-dev] [CASE-31] Some CLI outputs are wrong.
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

--94eb2c123fccf4000b053030316d
Content-Type: text/plain; charset=UTF-8

Dear Phil.

Please check following CLI stdout outputs.
Something wrong.

1. drbdadm outdate r0 -d
  ==> drbdsetup outdate r0 2


2. drbdadm attach r0 --al-updates=no -d
  ==> drbdmeta 2 v09 j flex-external apply-al --al-updates=no


So, We change you code like this;

1. On drbd-utils/user/v9/drbdadm_main.c file;

#ifdef _WIN32
static struct adm_cmd outdate_cmd = {"outdate", adm_outdate, ACF1_DEFAULT
.backend_res_name = 0};
#else
static struct adm_cmd outdate_cmd = {"outdate", adm_outdate, ACF1_DEFAULT};
#endif


2. On _adm_drbdmeta() function;

#ifdef _WIN32
     if (ctx->cmd->drbdsetup_ctx)
             add_setup_options(argv, &argc);
#else
      add_setup_options(argv, &argc);
#endif


Please check our solution.

Thanks.

--94eb2c123fccf4000b053030316d
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Dear Phil.<br><br>Please check following CLI stdout output=
s.<br>Something wrong.<br><br>1. drbdadm outdate r0 -d<br>=C2=A0 =3D=3D&gt;=
 drbdsetup outdate r0 2<br><br><br>2. drbdadm attach r0 --al-updates=3Dno -=
d<br>=C2=A0 =3D=3D&gt; drbdmeta 2 v09 j flex-external apply-al --al-updates=
=3Dno<br><br><br>So, We change you code like this;<br><br>1. On drbd-utils/=
user/v9/drbdadm_main.c file;<div><br>#ifdef _WIN32<br>static struct adm_cmd=
 outdate_cmd =3D {&quot;outdate&quot;, adm_outdate, ACF1_DEFAULT .backend_r=
es_name =3D 0};<br>#else<br>static struct adm_cmd outdate_cmd =3D {&quot;ou=
tdate&quot;, adm_outdate, ACF1_DEFAULT};<br>#endif<br><br><br>2. On _adm_dr=
bdmeta() function;<br><br>#ifdef _WIN32<br>=C2=A0 =C2=A0 =C2=A0if (ctx-&gt;=
cmd-&gt;drbdsetup_ctx)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0a=
dd_setup_options(argv, &amp;argc);<br>#else<br>=C2=A0 =C2=A0 =C2=A0 add_set=
up_options(argv, &amp;argc);<br>#endif<br><br><br>Please check our solution=
.<br><br>Thanks.
</div></div>

--94eb2c123fccf4000b053030316d--
