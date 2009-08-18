Return-Path: <gui@moolfreet.com>
Received: from mail-yw0-f187.google.com (mail-yw0-f187.google.com
	[209.85.211.187])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 3A98D10003F3
	for <drbd-dev@lists.linbit.com>; Tue, 18 Aug 2009 23:17:09 +0200 (CEST)
Received: by ywh17 with SMTP id 17so5427931ywh.3
	for <drbd-dev@lists.linbit.com>; Tue, 18 Aug 2009 14:17:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <200908182259.10699.philipp.reisner@linbit.com>
References: <479b87b70908160900ue855e71l8212d7f6936064c4@mail.gmail.com>
	<200908182259.10699.philipp.reisner@linbit.com>
From: Guillaume Plessis <gui@moolfreet.com>
Date: Tue, 18 Aug 2009 23:16:48 +0200
Message-ID: <479b87b70908181416x32ff9912g98a6f39c1cd52fca@mail.gmail.com>
To: drbd-dev@lists.linbit.com
Content-Type: multipart/alternative; boundary=0050450295a67eced60471710a6c
Subject: Re: [Drbd-dev] Patch for an up-to-date script/patch-kernel
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

--0050450295a67eced60471710a6c
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,
I use the patch method to avoid CONFIG_MODULES to be set.
That's one more way to prevent malicious kernel modules to be loaded on
risky machines (web servers with unsecure PHP application => www-data shell
access => privilege escalation => malicious module loaded).

Thanks for the patch having been applyed and good news that DRBD is getting
merged to Linux upstream!

--
Guillaume Plessis



2009/8/18 Philipp Reisner <philipp.reisner@linbit.com>

>
> Whow the second patch of this kind within a few days. I never expected
> that people actually patch DRBD into their kernels...
>
> I have applied it.
>
> Other than that we aim to get DRBD merged to Linux upstream with the
> 2.6.32 release. You can track out integration work from here:
>
> git://git.drbd.org/linux-2.6-drbd.git
>
> -Phil
>
>

--0050450295a67eced60471710a6c
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello,<div><br></div><div>I use the patch method to avoid=C2=A0CONFIG_MODUL=
ES to be set.</div><div>That&#39;s one more way to prevent malicious kernel=
 modules to be loaded on risky machines (web servers with unsecure PHP appl=
ication =3D&gt; www-data shell access =3D&gt; privilege escalation =3D&gt; =
malicious module loaded).</div>

<div><br></div><div>Thanks for the patch having been applyed and good news =
that DRBD is getting merged to Linux upstream!</div><div><br clear=3D"all">=
--<br>Guillaume Plessis<br><br>
<br><br><div class=3D"gmail_quote">2009/8/18 Philipp Reisner <span dir=3D"l=
tr">&lt;<a href=3D"mailto:philipp.reisner@linbit.com">philipp.reisner@linbi=
t.com</a>&gt;</span><br><blockquote class=3D"gmail_quote" style=3D"margin:0=
 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex;">

<div><div class=3D"h5"><br>
</div></div>Whow the second patch of this kind within a few days. I never e=
xpected<br>
that people actually patch DRBD into their kernels...<br>
<br>
I have applied it.<br>
<br>
Other than that we aim to get DRBD merged to Linux upstream with the<br>
2.6.32 release. You can track out integration work from here:<br>
<br>
git://<a href=3D"http://git.drbd.org/linux-2.6-drbd.git" target=3D"_blank">=
git.drbd.org/linux-2.6-drbd.git</a><br>
<br>
-Phil<br>
<br>
</blockquote></div><br></div>

--0050450295a67eced60471710a6c--
