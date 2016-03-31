Return-Path: <jhkim@mantech.co.kr>
Received: from mail-vk0-f48.google.com (mail-vk0-f48.google.com
	[209.85.213.48]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id E7A1E105632B
	for <drbd-dev@lists.linbit.com>; Thu, 31 Mar 2016 04:13:11 +0200 (CEST)
Received: by mail-vk0-f48.google.com with SMTP id z68so86023882vkg.3
	for <drbd-dev@lists.linbit.com>; Wed, 30 Mar 2016 19:13:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160330121519.GG15462@rck.sh>
References: <CAF6H8oGE3dsx89dD_z7gM=h4HuOeHQbSt9ET-6BpV5Hvows7RQ@mail.gmail.com>
	<20160330121519.GG15462@rck.sh>
Date: Thu, 31 Mar 2016 11:13:09 +0900
Message-ID: <CAF6H8oF9_1J9FqOWFBdW2VRnfXQfOq3oRAFBubE+YzU6+Buz8Q@mail.gmail.com>
From: Jaeheon Kim <jhkim@mantech.co.kr>
To: Roland Kammerer <roland.kammerer@linbit.com>
Content-Type: multipart/alternative; boundary=94eb2c048abcc983df052f4ecd27
Cc: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [CASE-38] self uuid may be crashed beacuse of
 garbage bitmap_index value.
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

--94eb2c048abcc983df052f4ecd27
Content-Type: text/plain; charset=UTF-8

Dear Roland,

Let me send test-steps for reproduce of  SyncSource/SyncSource.

1. make resync situation with primary/inconsistent - secondary/uptodate.
2. copy big file during resyncing.
3. stop the secondary node network by disabling secondary node's VMware
network icon during copying.
4. wait until copy finished
5. reconnect network by enabling secondary.
6. connect by --discard-my-data connect on the secondary node.
7. at this time, the each node status is  SyncSource/SyncSource

Thanks.

2016-03-30 21:15 GMT+09:00 Roland Kammerer <roland.kammerer@linbit.com>:

> On Wed, Mar 30, 2016 at 06:18:50PM +0900, Jaeheon Kim wrote:
> > Hi,
> >
> > There is some suspicious code.
> > Please check following code in drbd_uuid_compare.
> >
> >  --- code snip start ---
> > *rule_nr = 70;
> > self = drbd_bitmap_uuid(peer_device) & ~UUID_PRIMARY;
> > peer = peer_device->current_uuid & ~UUID_PRIMARY;
> > if (self == peer)
> > return 2;
> >
> > *rule_nr = 72;
> > for (i = 0; i < DRBD_NODE_ID_MAX; i++) {
> >     if (i == peer_device->node_id)
> >           continue;
> >     if (i == device->ldev->md.node_id)
> >           continue;
> >
> > #ifdef
> >
> _WIN32_V9_INSERT!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
> > /* Skip bitmap indexes which are not assigned to a peer. */
> >       if (device->ldev->md.peers[i].bitmap_index == -1)
> >            continue;
> > #endif //
> >
> !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
> >
> >      self = device->ldev->md.peers[i].bitmap_uuid & ~UUID_PRIMARY;
> >      if (self == peer) {
> >           *peer_node_id = i;
> >            return 4;
> >       }
> > }
> > ------ code done --------
> >
> > If you don't skip undefnded bitmap_index, self uuid will get crashed
> data.
> > So, we insert this skip logic.
> > What do you think about it?
>
> on a first look this seems reasonable, but I have to further think about
> it and discuss it with my colleagues.
>
> Would be great if you could provide the steps how to trigger that
> specific scenario.
>
> Regards, rck
> _______________________________________________
> drbd-dev mailing list
> drbd-dev@lists.linbit.com
> http://lists.linbit.com/mailman/listinfo/drbd-dev

--94eb2c048abcc983df052f4ecd27
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><span style=3D"font-size:14px">Dear Roland,</span><div sty=
le=3D"font-size:14px"><br></div><div style=3D"font-size:14px">Let me send t=
est-steps for reproduce of =C2=A0SyncSource/SyncSource.</div><div style=3D"=
font-size:14px"><br></div><div style=3D"font-size:14px">1. make resync situ=
ation with primary/inconsistent - secondary/uptodate.</div><div style=3D"fo=
nt-size:14px">2. copy big file during resyncing.</div><div style=3D"font-si=
ze:14px">3. stop the secondary node network by disabling secondary node&#39=
;s VMware network icon during copying.</div><div style=3D"font-size:14px">4=
. wait until copy finished</div><div style=3D"font-size:14px">5. reconnect =
network by enabling secondary.=C2=A0</div><div style=3D"font-size:14px">6. =
connect by --discard-my-data connect on the secondary node.</div><div style=
=3D"font-size:14px">7. at this time, the each node status is=C2=A0=C2=A0Syn=
cSource/SyncSource</div><div style=3D"font-size:14px"><br></div><div style=
=3D"font-size:14px">Thanks.</div><div class=3D"gmail_extra"><br><div class=
=3D"gmail_quote">2016-03-30 21:15 GMT+09:00 Roland Kammerer <span dir=3D"lt=
r">&lt;<a href=3D"mailto:roland.kammerer@linbit.com" target=3D"_blank">rola=
nd.kammerer@linbit.com</a>&gt;</span>:<br><blockquote class=3D"gmail_quote"=
 style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><d=
iv class=3D"HOEnZb"><div class=3D"h5">On Wed, Mar 30, 2016 at 06:18:50PM +0=
900, Jaeheon Kim wrote:<br>
&gt; Hi,<br>
&gt;<br>
&gt; There is some suspicious code.<br>
&gt; Please check following code in drbd_uuid_compare.<br>
&gt;<br>
&gt;=C2=A0 --- code snip start ---<br>
&gt; *rule_nr =3D 70;<br>
&gt; self =3D drbd_bitmap_uuid(peer_device) &amp; ~UUID_PRIMARY;<br>
&gt; peer =3D peer_device-&gt;current_uuid &amp; ~UUID_PRIMARY;<br>
&gt; if (self =3D=3D peer)<br>
&gt; return 2;<br>
&gt;<br>
&gt; *rule_nr =3D 72;<br>
&gt; for (i =3D 0; i &lt; DRBD_NODE_ID_MAX; i++) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0if (i =3D=3D peer_device-&gt;node_id)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0continue;<br>
&gt;=C2=A0 =C2=A0 =C2=A0if (i =3D=3D device-&gt;ldev-&gt;md.node_id)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0continue;<br>
&gt;<br>
&gt; #ifdef<br>
&gt; _WIN32_V9_INSERT!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!=
!!!!!<br>
&gt; /* Skip bitmap indexes which are not assigned to a peer. */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (device-&gt;ldev-&gt;md.peers[i].bitmap_i=
ndex =3D=3D -1)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
&gt; #endif //<br>
&gt; !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!=
!!!!!!!!!!!!!!!!!<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 self =3D device-&gt;ldev-&gt;md.peers[i].bitmap_uu=
id &amp; ~UUID_PRIMARY;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (self =3D=3D peer) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*peer_node_id =3D i;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 4;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; }<br>
&gt; ------ code done --------<br>
&gt;<br>
&gt; If you don&#39;t skip undefnded bitmap_index, self uuid will get crash=
ed data.<br>
&gt; So, we insert this skip logic.<br>
&gt; What do you think about it?<br>
<br>
</div></div>on a first look this seems reasonable, but I have to further th=
ink about<br>
it and discuss it with my colleagues.<br>
<br>
Would be great if you could provide the steps how to trigger that<br>
specific scenario.<br>
<br>
Regards, rck<br>
_______________________________________________<br>
drbd-dev mailing list<br>
<a href=3D"mailto:drbd-dev@lists.linbit.com">drbd-dev@lists.linbit.com</a><=
br>
<a href=3D"http://lists.linbit.com/mailman/listinfo/drbd-dev" rel=3D"norefe=
rrer" target=3D"_blank">http://lists.linbit.com/mailman/listinfo/drbd-dev</=
a></blockquote></div>
</div></div>

--94eb2c048abcc983df052f4ecd27--
