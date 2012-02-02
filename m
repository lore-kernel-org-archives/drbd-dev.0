Return-Path: <1988wzc@gmail.com>
Received: from mail-we0-f182.google.com (mail-we0-f182.google.com
	[74.125.82.182]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 4B63A1056C4D
	for <drbd-dev@lists.linbit.com>; Thu,  2 Feb 2012 16:12:38 +0100 (CET)
Received: by werm13 with SMTP id m13so3373439wer.27
	for <drbd-dev@lists.linbit.com>; Thu, 02 Feb 2012 07:12:36 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAPkhwwRYNwmv7B--Whaz8Nrpfc9XDMxqVw8J5V8qObfroVF2qw@mail.gmail.com>
References: <CAPkhwwRYNwmv7B--Whaz8Nrpfc9XDMxqVw8J5V8qObfroVF2qw@mail.gmail.com>
Date: Thu, 2 Feb 2012 23:12:36 +0800
Message-ID: <CAPkhwwRUvGsmQCAO+UJJL2CXG-Xa=DemzV2q1_4Ztkn5ZwHKEg@mail.gmail.com>
From: carlos_wang <1988wzc@gmail.com>
To: "drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>
Content-Type: multipart/alternative; boundary=0016e6d99b4552133604b7fca00b
Subject: Re: [Drbd-dev] Why does resync-cache uses LRU, rather than a queue,
	as its mechanism.
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

--0016e6d99b4552133604b7fca00b
Content-Type: text/plain; charset=ISO-8859-1

2012/1/29 carlos_wang <1988wzc@gmail.com>

> Hi all:
>         I got a problem in understanding why resync-cache uses LRU as its
> mechanism. I think that a queue is enough to realize the LRU functions. Why
> does it use LRU anyway?
>
>         Thanks in advance.
>
>         Carlos.
>
Blocks may be "resynced" by new application writes as well.

Thanks, but according to the code, Once application writes on a DRBD
device, act_log will cache the active sector in al_extent, writes the last
extent in lru list on the disk, And never known by resync extent, of course
in right connection. How blocks know "resynced" by new application
writes? When drbd begin resyncing, the sector will start from the first
sector to last sector, so I think it's no need to use LRU as its resync
mechanism.

--0016e6d99b4552133604b7fca00b
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">2012/1/29 carlos_wang <span dir=3D"ltr">&lt;<a h=
ref=3D"mailto:1988wzc@gmail.com">1988wzc@gmail.com</a>&gt;</span><br>
<blockquote style=3D"BORDER-LEFT:#ccc 1px solid;MARGIN:0px 0px 0px 0.8ex;PA=
DDING-LEFT:1ex" class=3D"gmail_quote">
<p>Hi all: <br>=A0=A0=A0=A0=A0=A0=A0 I got a problem in understanding why r=
esync-cache uses LRU as its mechanism. I think that a queue is enough to re=
alize the LRU functions. Why does it use LRU anyway? </p>
<p>=A0=A0=A0=A0=A0=A0=A0 Thanks in advance. </p><span class=3D"HOEnZb"><fon=
t color=3D"#888888">
<p>=A0=A0=A0=A0=A0=A0=A0 Carlos.</p></font></span></blockquote></div>
<div><font color=3D"#888888">Blocks may be &quot;resynced&quot; by new appl=
ication writes as well.</font></div>
<div><font color=3D"#888888"></font>=A0</div>
<div>Thanks, but=A0according to=A0the code,=A0Once application writes on a=
=A0DRBD device, act_log will cache the active sector in=A0al_extent,=A0writ=
es the=A0last extent=A0in lru list=A0on the=A0disk, And never known by resy=
nc extent, of course in right connection. How blocks know &quot;resynced&qu=
ot; by new application writes?=A0When drbd begin=A0resyncing, the sector wi=
ll start from the first sector to=A0last sector, so I think it&#39;s no nee=
d to use LRU as its resync mechanism.</div>

--0016e6d99b4552133604b7fca00b--
