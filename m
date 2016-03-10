Return-Path: <jhkim@mantech.co.kr>
Received: from mail-vk0-f49.google.com (mail-vk0-f49.google.com
	[209.85.213.49]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id D56621056331
	for <drbd-dev@lists.linbit.com>; Thu, 10 Mar 2016 13:39:48 +0100 (CET)
Received: by mail-vk0-f49.google.com with SMTP id e185so93358762vkb.1
	for <drbd-dev@lists.linbit.com>; Thu, 10 Mar 2016 04:39:47 -0800 (PST)
MIME-Version: 1.0
Date: Thu, 10 Mar 2016 21:39:46 +0900
Message-ID: <CAF6H8oHKSrNsOA2UnaT_jOfQgvrBNEQh3B-BUNH=823=a5WhGA@mail.gmail.com>
From: Jaeheon Kim <jhkim@mantech.co.kr>
To: drbd-dev@lists.linbit.com
Content-Type: multipart/alternative; boundary=001a1143da640e97de052db11cc7
Subject: [Drbd-dev] [CASE-30] dec_ap_bio wakeup condition difference between
	V8.4.7 and V9.0.1
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

--001a1143da640e97de052db11cc7
Content-Type: text/plain; charset=UTF-8

Hi,


I have one more question to the case-29.

According to the Windows and Linux DRBD kernel stack, there are a similar
pattern.

1. Stacks

1) Windows Stack dump when the file copy command was pending.

   - Please see "inc_ap_bio"

    nt!KiSwapThread+0x266
    nt!KiCommitThreadWait+0x1df
    nt!KeWaitForMultipleObjects+0x535
    drbd!schedule+0x114
    drbd!inc_ap_bio+0x49
    drbd!drbd_make_request+0x29
    drbd!DoSplitIo+0xfb
    drbd!mvolReadWriteDevice+0x2b0
    drbd!mvolWorkThread+0x114


2) Linux Stack dump when the file copy command was pending.

  - Pleae check previous post.

    [Drbd-dev] [CASE-29] After re-connect, WFBitMapS-WFBitMapT status has
sustained
                                    continuously and copy command hangs
     http://lists.linbit.com/pipermail/drbd-dev/2016-March/003328.html


  - Please see the "7) drbd pending point #1"

    [CASE-29] primary log
     http://pastebin.com/3hAWNkHn

    Mar  3 14:52:04 drbd9-01 kernel: Call Trace:
    Mar  3 14:52:04 drbd9-01 kernel: [<ffffffff816096a9>] schedule+0x29/0x70
    Mar  3 14:52:04 drbd9-01 kernel: [<ffffffffa04a03da>]
drbd_make_request+0x14a/0x360 [drbd]
    Mar  3 14:52:04 drbd9-01 kernel: [<ffffffff812aa56f>] ?
generic_make_request_checks+0x24f/0x380
    Mar  3 14:52:04 drbd9-01 kernel: [<ffffffff81098230>] ?
wake_up_bit+0x30/0x30
    Mar  3 14:52:04 drbd9-01 kernel: [<ffffffff812aa782>]
generic_make_request+0xe2/0x130
    Mar  3 14:52:04 drbd9-01 kernel: [<ffffffff812aa841>]
submit_bio+0x71/0x150
    Mar  3 14:52:04 drbd9-01 kernel: [<ffffffffa0531c55>]
ext4_io_submit+0x25/0x50 [ext4]



2. Sources

1) Ver 9.0.1

    static inline void inc_ap_bio(struct drbd_device *device, int rw)
    {
        wait_event(device->misc_wait, inc_ap_bio_cond(device, rw));
    }

    static inline void dec_ap_bio(struct drbd_device *device, int rw)
    {
         int ap_bio = atomic_dec_return(&device->ap_bio_cnt[rw]);
       .........

         if (ap_bio == 0)
                wake_up(&device->misc_wait);
    }


2) Ver 8.4.7

    static inline void inc_ap_bio(struct drbd_device *device)
    {
         wait_event(device->misc_wait, inc_ap_bio_cond(device));
    }

    static inline void dec_ap_bio(struct drbd_device *device)
    {
         int mxb = drbd_get_max_buffers(device);
         int ap_bio = atomic_dec_return(&device->ap_bio_cnt);

        .............


         /* this currently does wake_up for every dec_ap_bio!
          * maybe rather introduce some type of hysteresis?
          * e.g. (ap_bio == mxb/2 || ap_bio == 0) ? */

          if (ap_bio < mxb)
                 wake_up(&device->misc_wait);
    }



3. Questions

1) See "1. Stacks".
    I think, The Linux "drbd_make_request+0x14a/0x360 [drbd]" will probably
    mean the same thing as the Windows "drbd!inc_ap_bio+0x49".
    What do you think about it?

2) In version 8.4.7, dec_ap_bio wakes up misc_wait when condition is
"ap_bio < max".
    I mean, this version has greater tolerance than version 9.0.1.
    My question is Why do you change this condition from "ap_bio < max" to
"ap_bio == 0"  in version 9.0.1?


Thanks.

--001a1143da640e97de052db11cc7
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br><br>I have one more question to the case-29.<b=
r><br>According to the Windows and Linux DRBD kernel stack, there are a sim=
ilar pattern.<br><br>1. Stacks<br><br>1) Windows Stack dump when the file c=
opy command was pending.<br><br>=C2=A0 =C2=A0- Please see &quot;inc_ap_bio&=
quot;<br><br>=C2=A0 =C2=A0 nt!KiSwapThread+0x266<br>=C2=A0 =C2=A0 nt!KiComm=
itThreadWait+0x1df<br>=C2=A0 =C2=A0 nt!KeWaitForMultipleObjects+0x535<br>=
=C2=A0 =C2=A0 drbd!schedule+0x114<br>=C2=A0 =C2=A0 drbd!inc_ap_bio+0x49<br>=
=C2=A0 =C2=A0 drbd!drbd_make_request+0x29<br>=C2=A0 =C2=A0 drbd!DoSplitIo+0=
xfb<br>=C2=A0 =C2=A0 drbd!mvolReadWriteDevice+0x2b0<br>=C2=A0 =C2=A0 drbd!m=
volWorkThread+0x114<br><br><br>2) Linux Stack dump when the file copy comma=
nd was pending.<br><br>=C2=A0 - Pleae check previous post.<br><br>=C2=A0 =
=C2=A0 [Drbd-dev] [CASE-29] After re-connect, WFBitMapS-WFBitMapT status ha=
s sustained=C2=A0</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 continuously and copy command hangs<br>=C2=A0 =C2=A0 =C2=A0<a href=
=3D"http://lists.linbit.com/pipermail/drbd-dev/2016-March/003328.html">http=
://lists.linbit.com/pipermail/drbd-dev/2016-March/003328.html</a><br><br><b=
r>=C2=A0 - Please see the &quot;7) drbd pending point #1&quot;<br>=C2=A0 =
=C2=A0<br>=C2=A0 =C2=A0 [CASE-29] primary log<br>=C2=A0 =C2=A0 =C2=A0<a hre=
f=3D"http://pastebin.com/3hAWNkHn">http://pastebin.com/3hAWNkHn</a><br><br>=
=C2=A0 =C2=A0 Mar =C2=A03 14:52:04 drbd9-01 kernel: Call Trace:<br>=C2=A0 =
=C2=A0 Mar =C2=A03 14:52:04 drbd9-01 kernel: [&lt;ffffffff816096a9&gt;] sch=
edule+0x29/0x70<br>=C2=A0 =C2=A0 Mar =C2=A03 14:52:04 drbd9-01 kernel: [&lt=
;ffffffffa04a03da&gt;] drbd_make_request+0x14a/0x360 [drbd]<br>=C2=A0 =C2=
=A0 Mar =C2=A03 14:52:04 drbd9-01 kernel: [&lt;ffffffff812aa56f&gt;] ? gene=
ric_make_request_checks+0x24f/0x380<br>=C2=A0 =C2=A0 Mar =C2=A03 14:52:04 d=
rbd9-01 kernel: [&lt;ffffffff81098230&gt;] ? wake_up_bit+0x30/0x30<br>=C2=
=A0 =C2=A0 Mar =C2=A03 14:52:04 drbd9-01 kernel: [&lt;ffffffff812aa782&gt;]=
 generic_make_request+0xe2/0x130<br>=C2=A0 =C2=A0 Mar =C2=A03 14:52:04 drbd=
9-01 kernel: [&lt;ffffffff812aa841&gt;] submit_bio+0x71/0x150<br>=C2=A0 =C2=
=A0 Mar =C2=A03 14:52:04 drbd9-01 kernel: [&lt;ffffffffa0531c55&gt;] ext4_i=
o_submit+0x25/0x50 [ext4]<br><br><br><br>2. Sources<br><br>1) Ver 9.0.1<br>=
<br>=C2=A0 =C2=A0 static inline void inc_ap_bio(struct drbd_device *device,=
 int rw)<br>=C2=A0 =C2=A0 {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 wait_event(devic=
e-&gt;misc_wait, inc_ap_bio_cond(device, rw));<br>=C2=A0 =C2=A0 }<br><br>=
=C2=A0 =C2=A0 static inline void dec_ap_bio(struct drbd_device *device, int=
 rw)<br>=C2=A0 =C2=A0 {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int ap_bio =3D=
 atomic_dec_return(&amp;device-&gt;ap_bio_cnt[rw]);<br>=C2=A0 =C2=A0 =C2=A0=
 =C2=A0.........</div><div><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ap_bio=
 =3D=3D 0)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 wake_=
up(&amp;device-&gt;misc_wait);<br>=C2=A0 =C2=A0 }<br><br><br>2) Ver 8.4.7<b=
r><br>=C2=A0 =C2=A0 static inline void inc_ap_bio(struct drbd_device *devic=
e)<br>=C2=A0 =C2=A0 {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0wait_event(devic=
e-&gt;misc_wait, inc_ap_bio_cond(device));<br>=C2=A0 =C2=A0 }<br><br>=C2=A0=
 =C2=A0 static inline void dec_ap_bio(struct drbd_device *device)<br>=C2=A0=
 =C2=A0 {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int mxb =3D drbd_get_max_buf=
fers(device);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int ap_bio =3D atomic_de=
c_return(&amp;device-&gt;ap_bio_cnt);<br><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 ..=
...........</div><div><br></div><div><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
/* this currently does wake_up for every dec_ap_bio!<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 * maybe rather introduce some type of hysteresis?<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * e.g. (ap_bio =3D=3D mxb/2 || ap_bio =3D=
=3D 0) ? */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0</div><div>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 if (ap_bio &lt; mxb)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0wake_up(&amp;device-&gt;misc_wait);<br>=C2=A0 =
=C2=A0 }<br><br><br><br>3. Questions<br><br>1) See &quot;1. Stacks&quot;.<b=
r>=C2=A0 =C2=A0 I think, The Linux &quot;drbd_make_request+0x14a/0x360 [drb=
d]&quot; will probably<br>=C2=A0 =C2=A0 mean the same thing as the Windows =
&quot;drbd!inc_ap_bio+0x49&quot;.<br>=C2=A0 =C2=A0 What do you think about =
it?<br><br>2) In version 8.4.7, dec_ap_bio wakes up misc_wait when conditio=
n is &quot;ap_bio &lt; max&quot;.<br>=C2=A0 =C2=A0 I mean, this version has=
 greater tolerance than version 9.0.1.<br>=C2=A0 =C2=A0 My question is Why =
do you change this condition from &quot;ap_bio &lt; max&quot; to &quot;ap_b=
io =3D=3D 0&quot; =C2=A0in version 9.0.1?</div><div><br><br>Thanks.</div><d=
iv><br></div><div><br></div></div>

--001a1143da640e97de052db11cc7--
