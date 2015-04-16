Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id ABC731050584
	for <drbd-dev@lists.linbit.com>; Thu, 16 Apr 2015 17:22:56 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id A5BA4455828
	for <drbd-dev@lists.linbit.com>; Thu, 16 Apr 2015 17:22:56 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id cECXCAfPAWYA for <drbd-dev@lists.linbit.com>;
	Thu, 16 Apr 2015 17:22:56 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 5683845617B
	for <drbd-dev@lists.linbit.com>; Thu, 16 Apr 2015 17:22:56 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id kXrL3NJh7g3g for <drbd-dev@lists.linbit.com>;
	Thu, 16 Apr 2015 17:22:56 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 267D4455828
	for <drbd-dev@lists.linbit.com>; Thu, 16 Apr 2015 17:22:56 +0200 (CEST)
Resent-Message-ID: <20150416152255.GD18767@soda.linbit>
Received: from mail-ob0-f182.google.com (mail-ob0-f182.google.com
	[209.85.214.182]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 194F91028A59
	for <drbd-dev@lists.linbit.com>; Thu, 16 Apr 2015 16:19:10 +0200 (CEST)
Received: by obbeb7 with SMTP id eb7so43628338obb.3
	for <drbd-dev@lists.linbit.com>; Thu, 16 Apr 2015 07:19:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150416134644.GB18767@soda.linbit>
References: <CAEBniQ5wGKGuTpQ3OR3eobqYJStc+3zfrqKup3X2rARHwTGGcw@mail.gmail.com>
	<CAEBniQ506H3-wwBfYMSNv3hDyd3Pg1OwR3QXqQ4GE6rfL49NHA@mail.gmail.com>
	<20150416134644.GB18767@soda.linbit>
Date: Thu, 16 Apr 2015 09:55:39 -0400
Message-ID: <CAFGHznKdrwop8tywQuEKEFTR0yD2Dsw5LpSmJw3yvfinMUaCHA@mail.gmail.com>
From: David Pfarrer <dpfarrer@gnubio.com>
To: drbd-user@lists.linbit.com, drbd-dev@lists.linbit.com
Content-Type: multipart/alternative; boundary=047d7b2e502c9c26770513d7d1cc
Subject: Re: [Drbd-dev] [DRBD-user] A question about drbd hang in
	conn_disconnect
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

--047d7b2e502c9c26770513d7d1cc
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

unsubscribe

-------------------------------------------------------------
David Pfarrer| Sr IT Support Tech | Bio-Rad Laboratories, Inc.
1 Kendall Square, Suite B14201
Cambridge, MA 02139
E-Mail: dpfarrer@gnubio.com
*TEL*: *617-500-1838*
-------------------------------------------------------------

On Thu, Apr 16, 2015 at 9:46 AM, Lars Ellenberg <lars.ellenberg@linbit.com>
wrote:

> On Mon, Apr 13, 2015 at 05:45:25PM -0600, Fang Sun wrote:
> > Hi drbd developers,
> >
> > After some research and tests I feel I found the reason of this problem
> and
> > a possible fix in drbd.
> > Would you please check if my theory is correct?
> >
> >
> > Let me use 8.4.6 as the code base when I explain it.
> > When conn_disconnect hang it is hanging at line drbd_receiver.c:5178
> > static int drbd_disconnected(struct drbd_peer_device *peer_device)
> > {
> > ........
> > wait_event(device->misc_wait, !test_bit(BITMAP_IO, &device->flags));
> > }
> >
> > The reason is device has flag BITMAP_IO set.
> >
> >
> > The reason why flag BITMAP_IO is set and not clear is:
> > Disk state changes when network is disconnected and after_state_ch is
> > called.
> >
> > At drbd_state.c line 1949 drbd_queue_bitmap_io is called
> inafter_state_ch()
> > .
> >
> > I think the real reason is in drbd_queue_bitmap_io. drbd_main.c line
> 3641.
> > void drbd_queue_bitmap_io(struct drbd_device *device,
> >   int (*io_fn)(struct drbd_device *),
> >   void (*done)(struct drbd_device *, int),
> >   char *why, enum bm_flag flags)
> > {
> > .........
> > set_bit(BITMAP_IO, &device->flags);
> > if (atomic_read(&device->ap_bio_cnt) =3D=3D 0) {
> > if (!test_and_set_bit(BITMAP_IO_QUEUED, &device->flags))
> > drbd_queue_work(&first_peer_device(device)->connection->sender_work,
> > &device->bm_io_work.w);
> > }
> > ........
> > }
> >
> > In the code the only code to clear BITMAP_IO is in
> > device->bm_io_work.w(w_bitmap_io). But when
> > atomic_read(&device->ap_bio_cnt) !=3D 0 the flag BITMAP_IO  is set, how=
ever
> > bm_io_work.w is not called.
> > Then drbd_disconnected() is blocked.
> >
> > Should we move set_bit(BITMAP_IO, &device->flags) to the front of
> > drbd_queue_work()?
>
> No.  That would be the wrong fix,
> and cause potential inconsistencies later.
>
> It may need to be fixed, but in a different way.
>
> Let me (reproduce locally ... and) think about that for a bit.
>
> Thanks,
>
> --
> : Lars Ellenberg
> : http://www.LINBIT.com | Your Way to High Availability
> : DRBD, Linux-HA  and  Pacemaker support and consulting
>
> DRBD=C2=AE and LINBIT=C2=AE are registered trademarks of LINBIT, Austria.
> __
> please don't Cc me, but send to list   --   I'm subscribed
> _______________________________________________
> drbd-user mailing list
> drbd-user@lists.linbit.com
> http://lists.linbit.com/mailman/listinfo/drbd-user
>

--047d7b2e502c9c26770513d7d1cc
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">unsubscribe<br></div><div class=3D"gmail_extra"><br clear=
=3D"all"><div><div class=3D"gmail_signature"><div dir=3D"ltr"><div><div>---=
----------------------------------------------------------<br></div><font s=
ize=3D"1" color=3D"#808080" face=3D"Verdana">David Pfarrer| Sr IT Support T=
ech </font><font size=3D"1" color=3D"#808080" face=3D"Verdana">| Bio-Rad La=
boratories, Inc.<br>
1 Kendall Square, Suite B14201</font><font style=3D"font-family:arial,sans-=
serif" size=3D"3" color=3D"#8f8f8f">=C2=A0</font><font size=3D"1" color=3D"=
#808080" face=3D"Verdana"><br>Cambridge, MA 02139</font><font style=3D"font=
-family:arial,sans-serif" size=3D"3" color=3D"#8f8f8f">=C2=A0</font><font s=
ize=3D"1" color=3D"#808080" face=3D"Verdana"><br>
E-Mail: <a href=3D"mailto:dpfarrer@gnubio.com" target=3D"_blank">dpfarrer@g=
nubio.com</a></font><font style=3D"font-family:arial,sans-serif" size=3D"3"=
 color=3D"#8f8f8f">=C2=A0</font><font size=3D"1" color=3D"#808080" face=3D"=
Arial"><b><br>TEL</b></font><font size=3D"1" color=3D"#808080" face=3D"Verd=
ana">:=C2=A0</font><font size=3D"1" color=3D"#0000ff" face=3D"Verdana"><u>6=
17-500-1838</u></font><font style=3D"font-family:arial,sans-serif" size=3D"=
3" color=3D"#8f8f8f"> <br></font></div>------------------------------------=
-------------------------<br></div></div></div>
<br><div class=3D"gmail_quote">On Thu, Apr 16, 2015 at 9:46 AM, Lars Ellenb=
erg <span dir=3D"ltr">&lt;<a href=3D"mailto:lars.ellenberg@linbit.com" targ=
et=3D"_blank">lars.ellenberg@linbit.com</a>&gt;</span> wrote:<br><blockquot=
e class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc sol=
id;padding-left:1ex">On Mon, Apr 13, 2015 at 05:45:25PM -0600, Fang Sun wro=
te:<br>
&gt; Hi drbd developers,<br>
&gt;<br>
&gt; After some research and tests I feel I found the reason of this proble=
m and<br>
&gt; a possible fix in drbd.<br>
&gt; Would you please check if my theory is correct?<br>
&gt;<br>
&gt;<br>
&gt; Let me use 8.4.6 as the code base when I explain it.<br>
&gt; When conn_disconnect hang it is hanging at line drbd_receiver.c:5178<b=
r>
&gt; static int drbd_disconnected(struct drbd_peer_device *peer_device)<br>
&gt; {<br>
&gt; ........<br>
&gt; wait_event(device-&gt;misc_wait, !test_bit(BITMAP_IO, &amp;device-&gt;=
flags));<br>
&gt; }<br>
&gt;<br>
&gt; The reason is device has flag BITMAP_IO set.<br>
&gt;<br>
&gt;<br>
&gt; The reason why flag BITMAP_IO is set and not clear is:<br>
&gt; Disk state changes when network is disconnected and after_state_ch is<=
br>
&gt; called.<br>
&gt;<br>
&gt; At drbd_state.c line 1949 drbd_queue_bitmap_io is called inafter_state=
_ch()<br>
&gt; .<br>
&gt;<br>
&gt; I think the real reason is in drbd_queue_bitmap_io. drbd_main.c line 3=
641.<br>
&gt; void drbd_queue_bitmap_io(struct drbd_device *device,<br>
&gt;=C2=A0 =C2=A0int (*io_fn)(struct drbd_device *),<br>
&gt;=C2=A0 =C2=A0void (*done)(struct drbd_device *, int),<br>
&gt;=C2=A0 =C2=A0char *why, enum bm_flag flags)<br>
&gt; {<br>
&gt; .........<br>
&gt; set_bit(BITMAP_IO, &amp;device-&gt;flags);<br>
&gt; if (atomic_read(&amp;device-&gt;ap_bio_cnt) =3D=3D 0) {<br>
&gt; if (!test_and_set_bit(BITMAP_IO_QUEUED, &amp;device-&gt;flags))<br>
&gt; drbd_queue_work(&amp;first_peer_device(device)-&gt;connection-&gt;send=
er_work,<br>
&gt; &amp;device-&gt;bm_io_work.w);<br>
&gt; }<br>
&gt; ........<br>
&gt; }<br>
&gt;<br>
&gt; In the code the only code to clear BITMAP_IO is in<br>
&gt; device-&gt;bm_io_work.w(w_bitmap_io). But when<br>
&gt; atomic_read(&amp;device-&gt;ap_bio_cnt) !=3D 0 the flag BITMAP_IO=C2=
=A0 is set, however<br>
&gt; bm_io_work.w is not called.<br>
&gt; Then drbd_disconnected() is blocked.<br>
&gt;<br>
&gt; Should we move set_bit(BITMAP_IO, &amp;device-&gt;flags) to the front =
of<br>
&gt; drbd_queue_work()?<br>
<br>
No.=C2=A0 That would be the wrong fix,<br>
and cause potential inconsistencies later.<br>
<br>
It may need to be fixed, but in a different way.<br>
<br>
Let me (reproduce locally ... and) think about that for a bit.<br>
<br>
Thanks,<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
: Lars Ellenberg<br>
: <a href=3D"http://www.LINBIT.com" target=3D"_blank">http://www.LINBIT.com=
</a> | Your Way to High Availability<br>
: DRBD, Linux-HA=C2=A0 and=C2=A0 Pacemaker support and consulting<br>
<br>
DRBD=C2=AE and LINBIT=C2=AE are registered trademarks of LINBIT, Austria.<b=
r>
__<br>
please don&#39;t Cc me, but send to list=C2=A0 =C2=A0--=C2=A0 =C2=A0I&#39;m=
 subscribed<br>
_______________________________________________<br>
drbd-user mailing list<br>
<a href=3D"mailto:drbd-user@lists.linbit.com">drbd-user@lists.linbit.com</a=
><br>
<a href=3D"http://lists.linbit.com/mailman/listinfo/drbd-user" target=3D"_b=
lank">http://lists.linbit.com/mailman/listinfo/drbd-user</a><br>
</font></span></blockquote></div><br></div>

--047d7b2e502c9c26770513d7d1cc--
