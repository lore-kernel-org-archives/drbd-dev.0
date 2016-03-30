Return-Path: <jhkim@mantech.co.kr>
Received: from mail-vk0-f52.google.com (mail-vk0-f52.google.com
	[209.85.213.52]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 676F21011BA2
	for <drbd-dev@lists.linbit.com>; Wed, 30 Mar 2016 11:18:52 +0200 (CEST)
Received: by mail-vk0-f52.google.com with SMTP id e185so52683016vkb.1
	for <drbd-dev@lists.linbit.com>; Wed, 30 Mar 2016 02:18:52 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 30 Mar 2016 18:18:50 +0900
Message-ID: <CAF6H8oGE3dsx89dD_z7gM=h4HuOeHQbSt9ET-6BpV5Hvows7RQ@mail.gmail.com>
From: Jaeheon Kim <jhkim@mantech.co.kr>
To: drbd-dev@lists.linbit.com
Content-Type: multipart/alternative; boundary=94eb2c1239944e45f5052f40a235
Subject: [Drbd-dev] [CASE-38] self uuid may be crashed beacuse of garbage
	bitmap_index value.
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

--94eb2c1239944e45f5052f40a235
Content-Type: text/plain; charset=UTF-8

Hi,

There is some suspicious code.
Please check following code in drbd_uuid_compare.

 --- code snip start ---
*rule_nr = 70;
self = drbd_bitmap_uuid(peer_device) & ~UUID_PRIMARY;
peer = peer_device->current_uuid & ~UUID_PRIMARY;
if (self == peer)
return 2;

*rule_nr = 72;
for (i = 0; i < DRBD_NODE_ID_MAX; i++) {
    if (i == peer_device->node_id)
          continue;
    if (i == device->ldev->md.node_id)
          continue;

#ifdef
_WIN32_V9_INSERT!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
/* Skip bitmap indexes which are not assigned to a peer. */
      if (device->ldev->md.peers[i].bitmap_index == -1)
           continue;
#endif //
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

     self = device->ldev->md.peers[i].bitmap_uuid & ~UUID_PRIMARY;
     if (self == peer) {
          *peer_node_id = i;
           return 4;
      }
}
------ code done --------

If you don't skip undefnded bitmap_index, self uuid will get crashed data.
So, we insert this skip logic.
What do you think about it?

Thanks.

--94eb2c1239944e45f5052f40a235
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><br>There is some suspicious code.<br>Please check =
following code in drbd_uuid_compare.<br><br>=C2=A0--- code snip start ---<b=
r>*rule_nr =3D 70;<br>self =3D drbd_bitmap_uuid(peer_device) &amp; ~UUID_PR=
IMARY;<br>peer =3D peer_device-&gt;current_uuid &amp; ~UUID_PRIMARY;<br>if =
(self =3D=3D peer)<br>return 2;<br><br>*rule_nr =3D 72;<br>for (i =3D 0; i =
&lt; DRBD_NODE_ID_MAX; i++) {<br>=C2=A0 =C2=A0 if (i =3D=3D peer_device-&gt=
;node_id)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>=C2=A0 =C2=A0 =
if (i =3D=3D device-&gt;ldev-&gt;md.node_id)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 continue;<br><br><div>#ifdef _WIN32_V9_INSERT!!!!!!!!!!!!!!!!!!!!!!=
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!<br>/* Skip bitmap indexes which are n=
ot assigned to a peer. */<br>=C2=A0 =C2=A0 =C2=A0 if (device-&gt;ldev-&gt;m=
d.peers[i].bitmap_index =3D=3D -1)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0continue;<br>#endif // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!=
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!<div><br>=C2=A0 =C2=A0 =C2=A0self =
=3D device-&gt;ldev-&gt;md.peers[i].bitmap_uuid &amp; ~UUID_PRIMARY;<br>=C2=
=A0 =C2=A0 =C2=A0if (self =3D=3D peer) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 *peer_node_id =3D i;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return=
 4;<br>=C2=A0 =C2=A0 =C2=A0 }<br>}<div>------ code done --------<div><br></=
div></div></div></div><div>If you don&#39;t skip undefnded bitmap_index, se=
lf uuid will get crashed data.</div><div>So, we insert this skip logic.</di=
v><div>What do you think about it?</div><div><br></div><div>Thanks.</div><d=
iv><br></div></div>

--94eb2c1239944e45f5052f40a235--
