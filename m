Return-Path: <michael.d.labriola@gmail.com>
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com
	[209.85.210.44])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id B5A4C4207CB
	for <drbd-dev@lists.linbit.com>; Mon, 14 Dec 2020 16:35:17 +0100 (CET)
Received: by mail-ot1-f44.google.com with SMTP id a109so16076604otc.1
	for <drbd-dev@lists.linbit.com>; Mon, 14 Dec 2020 07:35:17 -0800 (PST)
MIME-Version: 1.0
References: <20201213055859.3305-1-michael.d.labriola@gmail.com>
	<73f05081-b548-72cd-0068-5b1641f43ca9@linbit.com>
In-Reply-To: <73f05081-b548-72cd-0068-5b1641f43ca9@linbit.com>
From: Michael Labriola <michael.d.labriola@gmail.com>
Date: Mon, 14 Dec 2020 10:35:05 -0500
Message-ID: <CAOQxz3wcPEAsuRzTuyXPsMQ_ZSmuoL_NtXWCrqq759fhQpnMKA@mail.gmail.com>
To: =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Content-Type: multipart/alternative; boundary="0000000000009085ab05b66e63cd"
Cc: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Get drbd-9.0 branch building with Linux 5.9 and 5.10
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

--0000000000009085ab05b66e63cd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks, Christoph.  I've been using DRBD for 15+ years, so it's about time
I officially contributed something other than bug reports.  ;-)

On Mon, Dec 14, 2020 at 5:18 AM Christoph B=C3=B6hmwalder <
christoph.boehmwalder@linbit.com> wrote:

> Hi Michael,
>
> Thanks for this great contribution!
>
> Unfortunately, we duplicated some work here, but neither of us could
> have known that :)
> Over the last few days I fabricated some patches that fix some of the
> same problems, ultimately leading to the same result.
>
> I'll review your patches =E2=80=93 on first glance it seems like some of =
your
> approaches may actually be better than mine. If the patches are exactly
> the same, I'll attribute you since you published your patches first.
> I'll mix and match with my patches, since they are more thorough in some
> places (for example, I did go to the trouble of creating a compat test
> for sched_setscheduler()).
>
> Some of these patches are still under internal review, so this may take
> some time, but I'll let you know which of yours I chose.
>
> Thanks again!
>
> --
> Christoph B=C3=B6hmwalder
> LINBIT | Keeping the Digital World Running
> DRBD HA =E2=80=94  Disaster Recovery =E2=80=94 Software defined Storage
>
> On 12/13/20 6:58 AM, Michael D Labriola wrote:
> > Hey, everyone! I had the chance to try building the latest drbd-9.0
> > code against the 5.9 and 5.10 kernels this afternoon. Things almost
> > built, but not quite.  I made a series of commits to get things
> > compiling.  Most of it is trivial compat test changes and following
> > along w/ what's already been done in the mainline drbd8 module to get
> > it ready for 5.10.
> >
> > I did not create a compat test for the switch from
> > sched_setscheduler() to sched_set_fifo_low() yet.  Mostly, because
> > I've never done that and have to wrap my head around how to add
> > another test. ;-)
> >
> > I tried submitting a pull request via github, but got the auto-close
> > message.  So, here's take two.
> >
> >
> > _______________________________________________
> > drbd-dev mailing list
> > drbd-dev@lists.linbit.com
> > https://lists.linbit.com/mailman/listinfo/drbd-dev
> >
>


--=20
Michael D Labriola
21 Rip Van Winkle Cir
Warwick, RI 02886
401-316-9844 (cell)

--0000000000009085ab05b66e63cd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:arial,sans-serif;font-size:small">Thanks, Christoph.=C2=A0 I&#39;v=
e been using DRBD for 15+ years, so it&#39;s about time I officially contri=
buted something other than bug reports.=C2=A0 ;-)</div></div><div><br></div=
><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, D=
ec 14, 2020 at 5:18 AM Christoph B=C3=B6hmwalder &lt;<a href=3D"mailto:chri=
stoph.boehmwalder@linbit.com">christoph.boehmwalder@linbit.com</a>&gt; wrot=
e:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi Michael,<b=
r>
<br>
Thanks for this great contribution!<br>
<br>
Unfortunately, we duplicated some work here, but neither of us could <br>
have known that :)<br>
Over the last few days I fabricated some patches that fix some of the <br>
same problems, ultimately leading to the same result.<br>
<br>
I&#39;ll review your patches =E2=80=93 on first glance it seems like some o=
f your <br>
approaches may actually be better than mine. If the patches are exactly <br=
>
the same, I&#39;ll attribute you since you published your patches first. <b=
r>
I&#39;ll mix and match with my patches, since they are more thorough in som=
e <br>
places (for example, I did go to the trouble of creating a compat test <br>
for sched_setscheduler()).<br>
<br>
Some of these patches are still under internal review, so this may take <br=
>
some time, but I&#39;ll let you know which of yours I chose.<br>
<br>
Thanks again!<br>
<br>
--<br>
Christoph B=C3=B6hmwalder<br>
LINBIT | Keeping the Digital World Running<br>
DRBD HA =E2=80=94=C2=A0 Disaster Recovery =E2=80=94 Software defined Storag=
e<br>
<br>
On 12/13/20 6:58 AM, Michael D Labriola wrote:<br>
&gt; Hey, everyone! I had the chance to try building the latest drbd-9.0<br=
>
&gt; code against the 5.9 and 5.10 kernels this afternoon. Things almost<br=
>
&gt; built, but not quite.=C2=A0 I made a series of commits to get things<b=
r>
&gt; compiling.=C2=A0 Most of it is trivial compat test changes and followi=
ng<br>
&gt; along w/ what&#39;s already been done in the mainline drbd8 module to =
get<br>
&gt; it ready for 5.10.<br>
&gt; <br>
&gt; I did not create a compat test for the switch from<br>
&gt; sched_setscheduler() to sched_set_fifo_low() yet.=C2=A0 Mostly, becaus=
e<br>
&gt; I&#39;ve never done that and have to wrap my head around how to add<br=
>
&gt; another test. ;-)<br>
&gt; <br>
&gt; I tried submitting a pull request via github, but got the auto-close<b=
r>
&gt; message.=C2=A0 So, here&#39;s take two.<br>
&gt; <br>
&gt; <br>
&gt; _______________________________________________<br>
&gt; drbd-dev mailing list<br>
&gt; <a href=3D"mailto:drbd-dev@lists.linbit.com" target=3D"_blank">drbd-de=
v@lists.linbit.com</a><br>
&gt; <a href=3D"https://lists.linbit.com/mailman/listinfo/drbd-dev" rel=3D"=
noreferrer" target=3D"_blank">https://lists.linbit.com/mailman/listinfo/drb=
d-dev</a><br>
&gt; <br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr">Michael D Labriola<br>21 Rip Van Winkle Ci=
r<br>Warwick, RI 02886<br>401-316-9844 (cell)<br></div></div></div>

--0000000000009085ab05b66e63cd--
