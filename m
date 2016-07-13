Return-Path: <kmpak@mantech.co.kr>
Received: from mail-oi0-f52.google.com (mail-oi0-f52.google.com
	[209.85.218.52]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id BF7611056444
	for <drbd-dev@lists.linbit.com>; Wed, 13 Jul 2016 08:56:58 +0200 (CEST)
Received: by mail-oi0-f52.google.com with SMTP id r2so57094892oih.2
	for <drbd-dev@lists.linbit.com>; Tue, 12 Jul 2016 23:56:57 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?67CV6rK966+8?= <kmpak@mantech.co.kr>
Date: Wed, 13 Jul 2016 15:56:55 +0900
Message-ID: <CALLFrTQTyBH8oy4+17-REd=WG7r7ZAmzwVTbwfyrtby-wA1vJg@mail.gmail.com>
To: drbd-dev@lists.linbit.com
Content-Type: multipart/alternative; boundary=001a1141aa2e1c928405377ee482
Subject: [Drbd-dev] How to handle repl_state is L_OFF in
	get_max_agreeable_size()
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

--001a1141aa2e1c928405377ee482
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

I think get_max_agreeable_size() function return a agreeable size but first
connected repl_state

So, then will not call bm_resize through the agreeable size.

How's your opinion replacing in the get_max_agreeable_size()
if (peer_device->repl_state[NOW] >=3D L_ESTABLISHED) {
to
if (peer_device->repl_state[NOW] >=3D L_OFF) {

What am I concenred about any other things?

Thank you.
--=20

Message: 3
Date: Tue, 12 Jul 2016 18:12:32 +0900
From: ??? <kmpak@mantech.co.kr>
Subject: [Drbd-dev] Failed to sync initially at different volume's
        size
To: drbd-dev@lists.linbit.com
Message-ID:
        <CALLFrTQGkpOfP+41paPU2wWF86uACPCoVwvTvpDN9tzxT6Z2Gw@mail.gmail.com=
>
Content-Type: text/plain; charset=3D"utf-8"

Hello.

After 4fe4c96 commit
<
http://git.drbd.org/drbd-9.0.git/commit/4fe4c962f41307c2db2846f18f5137082f3=
39cd9
>
in
DRBD9,
If both volume's size is different, It is not going on progress sync
initially, at  WFBitmapS/WFBitmapT

When ds is Inconsistent/Inconsistent, then I command "primary --force"
It was stalled at receive_bitmap(), because decode_bitmap_c() return err is
positive value.
In decoding at recv_bm_rle_bits(),  bit_offset can't arrive bm_bits' value.

I'm looking for this case more.
Plz. help me

Before 4fe4c96, it works between nodes by the minimum volume's size.



In case 1:1 config, volume 200MB, 210MB log below

Jul 12 18:00:04 DRBD9_1 kernel: drbd r0: Starting worker thread (from
drbdsetup [102643])
Jul 12 18:00:04 DRBD9_1 drbd: Starting DRBD resources: [
Jul 12 18:00:04 DRBD9_1 drbd: create res: r0
Jul 12 18:00:04 DRBD9_1 systemd-udevd: error: /dev/drbd1: Wrong medium type
Jul 12 18:00:04 DRBD9_1 drbd: prepare disk: r0
Jul 12 18:00:04 DRBD9_1 kernel: drbd r0/0 drbd1: disk( Diskless ->
Attaching )
Jul 12 18:00:04 DRBD9_1 kernel: drbd r0/0 drbd1: Maximum number of peer
devices =3D 1
Jul 12 18:00:04 DRBD9_1 kernel: drbd r0: Method to ensure write ordering:
flush
Jul 12 18:00:04 DRBD9_1 kernel: drbd r0/0 drbd1: my node_id: 0
Jul 12 18:00:04 DRBD9_1 kernel: drbd r0/0 drbd1: Adjusting my ra_pages to
backing device's (32 -> 1024)
Jul 12 18:00:04 DRBD9_1 kernel: drbd r0/0 drbd1: my node_id: 0
Jul 12 18:00:04 DRBD9_1 kernel: drbd r0/0 drbd1: drbd_bm_resize called with
capacity =3D=3D 430080
Jul 12 18:00:04 DRBD9_1 kernel: drbd r0/0 drbd1: resync bitmap: bits=3D5376=
0
words=3D840 pages=3D2
Jul 12 18:00:04 DRBD9_1 kernel: drbd r0/0 drbd1: recounting of set bits
took additional 0ms
Jul 12 18:00:04 DRBD9_1 kernel: drbd r0/0 drbd1: Suspended AL updates
Jul 12 18:00:04 DRBD9_1 kernel: drbd r0/0 drbd1: disk( Attaching ->
Inconsistent )
Jul 12 18:00:04 DRBD9_1 kernel: drbd r0/0 drbd1: attached to current UUID:
0000000000000004
Jul 12 18:00:04 DRBD9_1 systemd-udevd: error: /dev/drbd1: Wrong medium type
Jul 12 18:00:04 DRBD9_1 drbd: adjust disk: r0
Jul 12 18:00:04 DRBD9_1 kernel: drbd r0 DRBD9_2: Starting sender thread
(from drbdsetup [102653])
Jul 12 18:00:04 DRBD9_1 drbd: prepare net: r0
Jul 12 18:00:04 DRBD9_1 drbd: attempt to connect: r0
Jul 12 18:00:04 DRBD9_1 drbd: ]
Jul 12 18:00:04 DRBD9_1 kernel: drbd r0 DRBD9_2: conn( StandAlone ->
Unconnected )
Jul 12 18:00:04 DRBD9_1 kernel: drbd r0 DRBD9_2: Starting receiver thread
(from drbd_w_r0 [102644])
Jul 12 18:00:04 DRBD9_1 kernel: drbd r0 DRBD9_2: conn( Unconnected ->
Connecting )
Jul 12 18:00:04 DRBD9_1 kernel: drbd r0 DRBD9_2: Handshake successful:
Agreed network protocol version 111
Jul 12 18:00:04 DRBD9_1 kernel: drbd r0 DRBD9_2: Feature flags enabled on
protocol level: 0x7 TRIM THIN_RESYNC WRITE_SAME.
Jul 12 18:00:04 DRBD9_1 kernel: drbd r0 DRBD9_2: Starting ack_recv thread
(from drbd_r_r0 [102662])
Jul 12 18:00:04 DRBD9_1 kernel: drbd r0: Preparing cluster-wide state
change 480688786 (0->1 499/146)
Jul 12 18:00:04 DRBD9_1 kernel: drbd r0: State change 480688786:
primary_nodes=3D0, weak_nodes=3D0
Jul 12 18:00:04 DRBD9_1 kernel: drbd r0: Committing cluster-wide state
change 480688786 (3ms)
Jul 12 18:00:04 DRBD9_1 kernel: drbd r0 DRBD9_2: conn( Connecting ->
Connected ) peer( Unknown -> Secondary )
Jul 12 18:00:04 DRBD9_1 kernel: drbd r0/0 drbd1: current_size: 430080
Jul 12 18:00:04 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_2: c_size: 450560
u_size: 0 d_size: 450560 max_size: 450560
Jul 12 18:00:04 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_2: la_size: 0
my_usize: 0
Jul 12 18:00:04 DRBD9_1 kernel: drbd r0/0 drbd1: my node_id: 0
Jul 12 18:00:04 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_2: node_id: 1 idx: 0
bm-uuid: 0x0 flags: 0x0 max_size: 450560 (DUnknown)
Jul 12 18:00:04 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_2: calling
drbd_determine_dev_size()
Jul 12 18:00:04 DRBD9_1 kernel: drbd r0/0 drbd1: my node_id: 0
Jul 12 18:00:04 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_2: node_id: 1 idx: 0
bm-uuid: 0x0 flags: 0x0 max_size: 450560 (DUnknown)
Jul 12 18:00:04 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_2:
drbd_sync_handshake:
Jul 12 18:00:04 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_2: self
0000000000000004:0000000000000000:0000000000000000:0000000000000000
bits:53760 flags:0
Jul 12 18:00:04 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_2: peer
0000000000000004:0000000000000000:0000000000000000:0000000000000000
bits:56320 flags:24
Jul 12 18:00:04 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_2: uuid_compare()=3D0
by rule 10
Jul 12 18:00:04 DRBD9_1 kernel: drbd r0/0 drbd1: No resync, but 53760 bits
in bitmap!
Jul 12 18:00:04 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_2: pdsk( DUnknown ->
Inconsistent ) repl( Off -> Established )
Jul 12 18:00:04 DRBD9_1 kernel: drbd r0/0 drbd1: Resumed AL updates
Jul 12 18:00:04 DRBD9_1 drbd: WARN: stdin/stdout is not a TTY; using
/dev/consoledrbdadm: Unknown command 'sh-b-pri'
Jul 12 18:00:04 DRBD9_1 drbd: .
Jul 12 18:00:40 DRBD9_1 kernel: drbd r0: Preparing cluster-wide state
change 3595219668 (0->-1 7683/4609)
Jul 12 18:00:40 DRBD9_1 kernel: drbd r0: State change 3595219668:
primary_nodes=3D1, weak_nodes=3DFFFFFFFFFFFFFFFC
Jul 12 18:00:40 DRBD9_1 kernel: drbd r0: Committing cluster-wide state
change 3595219668 (1ms)
Jul 12 18:00:40 DRBD9_1 kernel: drbd r0: role( Secondary -> Primary )
Jul 12 18:00:40 DRBD9_1 kernel: drbd r0/0 drbd1: disk( Inconsistent ->
UpToDate )
Jul 12 18:00:40 DRBD9_1 kernel: drbd r0/0 drbd1: size =3D 210 MB (215040 KB=
)
Jul 12 18:00:40 DRBD9_1 kernel: drbd r0: Forced to consider local data as
UpToDate!
Jul 12 18:00:40 DRBD9_1 kernel: drbd r0/0 drbd1: new current UUID:
E33ECAD77287E565 weak: FFFFFFFFFFFFFFFC
Jul 12 18:00:40 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_2:
drbd_sync_handshake:
Jul 12 18:00:40 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_2: self
E33ECAD77287E565:0000000000000000:0000000000000000:0000000000000000
bits:53760 flags:0
Jul 12 18:00:40 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_2: peer
0000000000000004:FFFFFFFFFFFFFFFF:0000000000000000:0000000000000000
bits:56320 flags:104
Jul 12 18:00:40 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_2: uuid_compare()=3D3
by rule 30
Jul 12 18:00:40 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_2: Writing the whole
bitmap, full sync required after drbd_sync_handshake.
Jul 12 18:00:40 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_2: repl( Established
-> WFBitMapS )
Jul 12 18:00:40 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_2: send bitmap stats
[Bytes(packets)]: plain 0(0), RLE 21(1), total 21; compression: 99.7%





Jul 12 17:59:57 DRBD9_2 drbd: Starting DRBD resources: [
Jul 12 17:59:57 DRBD9_2 drbd: create res: r0
Jul 12 17:59:57 DRBD9_2 kernel: drbd r0: Starting worker thread (from
drbdsetup [83726])
Jul 12 17:59:57 DRBD9_2 systemd-udevd: error: /dev/drbd1: Wrong medium type
Jul 12 17:59:57 DRBD9_2 drbd: prepare disk: r0
Jul 12 17:59:57 DRBD9_2 kernel: drbd r0/0 drbd1: disk( Diskless ->
Attaching )
Jul 12 17:59:57 DRBD9_2 kernel: drbd r0/0 drbd1: Maximum number of peer
devices =3D 1
Jul 12 17:59:57 DRBD9_2 kernel: drbd r0: Method to ensure write ordering:
flush
Jul 12 17:59:57 DRBD9_2 kernel: drbd r0/0 drbd1: my node_id: 1
Jul 12 17:59:57 DRBD9_2 kernel: drbd r0/0 drbd1: Adjusting my ra_pages to
backing device's (32 -> 1024)
Jul 12 17:59:57 DRBD9_2 kernel: drbd r0/0 drbd1: my node_id: 1
Jul 12 17:59:57 DRBD9_2 kernel: drbd r0/0 drbd1: drbd_bm_resize called with
capacity =3D=3D 450560
Jul 12 17:59:57 DRBD9_2 kernel: drbd r0/0 drbd1: resync bitmap: bits=3D5632=
0
words=3D880 pages=3D2
Jul 12 17:59:57 DRBD9_2 kernel: drbd r0/0 drbd1: recounting of set bits
took additional 0ms
Jul 12 17:59:57 DRBD9_2 kernel: drbd r0/0 drbd1: Suspended AL updates
Jul 12 17:59:57 DRBD9_2 kernel: drbd r0/0 drbd1: disk( Attaching ->
Inconsistent )
Jul 12 17:59:57 DRBD9_2 kernel: drbd r0/0 drbd1: attached to current UUID:
0000000000000004
Jul 12 17:59:57 DRBD9_2 drbd: adjust disk: r0
Jul 12 17:59:57 DRBD9_2 systemd-udevd: error: /dev/drbd1: Wrong medium type
Jul 12 17:59:57 DRBD9_2 kernel: drbd r0 DRBD9_1: Starting sender thread
(from drbdsetup [83737])
Jul 12 17:59:57 DRBD9_2 drbd: prepare net: r0
Jul 12 17:59:57 DRBD9_2 drbd: attempt to connect: r0
Jul 12 17:59:57 DRBD9_2 drbd: ]
Jul 12 17:59:57 DRBD9_2 kernel: drbd r0 DRBD9_1: conn( StandAlone ->
Unconnected )
Jul 12 17:59:57 DRBD9_2 kernel: drbd r0 DRBD9_1: Starting receiver thread
(from drbd_w_r0 [83727])
Jul 12 17:59:58 DRBD9_2 kernel: drbd r0 DRBD9_1: conn( Unconnected ->
Connecting )
Jul 12 18:00:04 DRBD9_2 kernel: drbd r0 DRBD9_1: Handshake successful:
Agreed network protocol version 111
Jul 12 18:00:04 DRBD9_2 kernel: drbd r0 DRBD9_1: Feature flags enabled on
protocol level: 0x7 TRIM THIN_RESYNC WRITE_SAME.
Jul 12 18:00:04 DRBD9_2 kernel: drbd r0 DRBD9_1: Starting ack_recv thread
(from drbd_r_r0 [83745])
Jul 12 18:00:04 DRBD9_2 kernel: drbd r0 DRBD9_1: Preparing remote state
change 480688786 (primary_nodes=3D0, weak_nodes=3D0)
Jul 12 18:00:04 DRBD9_2 kernel: drbd r0 DRBD9_1: Committing remote state
change 480688786
Jul 12 18:00:04 DRBD9_2 kernel: drbd r0 DRBD9_1: conn( Connecting ->
Connected ) peer( Unknown -> Secondary )
Jul 12 18:00:04 DRBD9_2 kernel: drbd r0/0 drbd1: current_size: 450560
Jul 12 18:00:04 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_1: c_size: 430080
u_size: 0 d_size: 430080 max_size: 430080
Jul 12 18:00:04 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_1: la_size: 0
my_usize: 0
Jul 12 18:00:04 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_1: node_id: 0 idx: 0
bm-uuid: 0x0 flags: 0x0 max_size: 430080 (DUnknown)
Jul 12 18:00:04 DRBD9_2 kernel: drbd r0/0 drbd1: my node_id: 1
Jul 12 18:00:04 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_1: calling
drbd_determine_dev_size()
Jul 12 18:00:04 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_1: node_id: 0 idx: 0
bm-uuid: 0x0 flags: 0x0 max_size: 430080 (DUnknown)
Jul 12 18:00:04 DRBD9_2 kernel: drbd r0/0 drbd1: my node_id: 1
Jul 12 18:00:04 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_1:
drbd_sync_handshake:
Jul 12 18:00:04 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_1: self
0000000000000004:0000000000000000:0000000000000000:0000000000000000
bits:56320 flags:0
Jul 12 18:00:04 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_1: peer
0000000000000004:0000000000000000:0000000000000000:0000000000000000
bits:53760 flags:24
Jul 12 18:00:04 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_1: uuid_compare()=3D0
by rule 10
Jul 12 18:00:04 DRBD9_2 kernel: drbd r0/0 drbd1: No resync, but 56320 bits
in bitmap!
Jul 12 18:00:04 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_1: pdsk( DUnknown ->
Inconsistent ) repl( Off -> Established )
Jul 12 18:00:04 DRBD9_2 kernel: drbd r0/0 drbd1: Resumed AL updates
Jul 12 18:00:04 DRBD9_2 drbd: WARN: stdin/stdout is not a TTY; using
/dev/consoledrbdadm: Unknown command 'sh-b-pri'
Jul 12 18:00:04 DRBD9_2 drbd: .
Jul 12 18:00:40 DRBD9_2 kernel: drbd r0 DRBD9_1: Preparing remote state
change 3595219668 (primary_nodes=3D0, weak_nodes=3D0)
Jul 12 18:00:40 DRBD9_2 kernel: drbd r0 DRBD9_1: Committing remote state
change 3595219668
Jul 12 18:00:40 DRBD9_2 kernel: drbd r0 DRBD9_1: peer( Secondary -> Primary
)
Jul 12 18:00:40 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_1: pdsk( Inconsistent
-> UpToDate )
Jul 12 18:00:40 DRBD9_2 kernel: drbd r0/0 drbd1: size =3D 220 MB (225280 KB=
)
Jul 12 18:00:40 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_1:
drbd_sync_handshake:
Jul 12 18:00:40 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_1: self
0000000000000004:0000000000000000:0000000000000000:0000000000000000
bits:56320 flags:0
Jul 12 18:00:40 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_1: peer
E33ECAD77287E565:FFFFFFFFFFFFFFFF:0000000000000000:0000000000000000
bits:53760 flags:120
Jul 12 18:00:40 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_1: uuid_compare()=3D-=
3
by rule 20
Jul 12 18:00:40 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_1: Writing the whole
bitmap, full sync required after drbd_sync_handshake.
Jul 12 18:00:40 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_1: repl( Established
-> WFBitMapT )
Jul 12 18:00:40 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_1: s(53760)
bit_offset(53760) word_offset(840) bm_bits(56320)
Jul 12 18:00:40 DRBD9_2 kernel: drbd r0/0 drbd1: after decode_bitmap_c()
err(1)
--=20


=E1=90=A7

--001a1141aa2e1c928405377ee482
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br clear=3D"all"><div><div style=3D"font-size:14px">I thi=
nk get_max_agreeable_size() function return a agreeable size but first conn=
ected repl_state<br></div><div style=3D"font-size:14px"><br></div><div styl=
e=3D"font-size:14px">So, then will not call bm_resize through the agreeable=
 size.<br></div><div style=3D"font-size:14px"><br></div><div style=3D"font-=
size:14px">How&#39;s your opinion replacing in the get_max_agreeable_size()=
</div><div style=3D"font-size:14px">if (peer_device-&gt;repl_state[NOW] &gt=
;=3D L_ESTABLISHED) {<br></div><div style=3D"font-size:14px">to=C2=A0</div>=
<div style=3D"font-size:14px">if (peer_device-&gt;repl_state[NOW] &gt;=3D L=
_OFF) {<br></div><div style=3D"font-size:14px"><br></div><div style=3D"font=
-size:14px">What am I concenred about any other things?</div><div style=3D"=
font-size:14px"><br></div><div style=3D"font-size:14px">Thank you.</div><sp=
an style=3D"font-size:14px">--=C2=A0</span><br style=3D"font-size:14px"><di=
v data-smartmail=3D"gmail_signature" style=3D"font-size:14px"><div dir=3D"l=
tr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><br=
><div><p style=3D"margin:0cm 0cm 0.0001pt;line-height:21px"><span style=3D"=
line-height:normal">Message: 3</span><br style=3D"line-height:normal"><span=
 style=3D"line-height:normal">Date: Tue, 12 Jul 2016 18:12:32 +0900</span><=
br style=3D"line-height:normal"><span style=3D"line-height:normal">From: ??=
? &lt;</span><a href=3D"mailto:kmpak@mantech.co.kr" target=3D"_blank" style=
=3D"line-height:normal">kmpak@mantech.co.kr</a><span style=3D"line-height:n=
ormal">&gt;</span><br style=3D"line-height:normal"><span style=3D"line-heig=
ht:normal">Subject: [Drbd-dev] Failed to sync initially at different volume=
&#39;s</span><br style=3D"line-height:normal"><span style=3D"line-height:no=
rmal">=C2=A0 =C2=A0 =C2=A0 =C2=A0 size</span><br style=3D"line-height:norma=
l"><span style=3D"line-height:normal">To:=C2=A0</span><a href=3D"mailto:drb=
d-dev@lists.linbit.com" target=3D"_blank" style=3D"line-height:normal">drbd=
-dev@lists.linbit.com</a><br style=3D"line-height:normal"><span style=3D"li=
ne-height:normal">Message-ID:</span><br style=3D"line-height:normal"><span =
style=3D"line-height:normal">=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;</span><a href=
=3D"mailto:CALLFrTQGkpOfP%2B41paPU2wWF86uACPCoVwvTvpDN9tzxT6Z2Gw@mail.gmail=
.com" target=3D"_blank" style=3D"line-height:normal">CALLFrTQGkpOfP+41paPU2=
wWF86uACPCoVwvTvpDN9tzxT6Z2Gw@mail.gmail.com</a><span style=3D"line-height:=
normal">&gt;</span><br style=3D"line-height:normal"><span style=3D"line-hei=
ght:normal">Content-Type: text/plain; charset=3D&quot;utf-8&quot;</span><br=
 style=3D"line-height:normal"><br style=3D"line-height:normal"><span style=
=3D"line-height:normal">Hello.</span><br style=3D"line-height:normal"><br s=
tyle=3D"line-height:normal"><span style=3D"line-height:normal">After 4fe4c9=
6 commit</span><br style=3D"line-height:normal"><span style=3D"line-height:=
normal">&lt;</span><a href=3D"http://git.drbd.org/drbd-9.0.git/commit/4fe4c=
962f41307c2db2846f18f5137082f339cd9" rel=3D"noreferrer" target=3D"_blank" s=
tyle=3D"line-height:normal">http://git.drbd.org/drbd-9.0.git/commit/4fe4c96=
2f41307c2db2846f18f5137082f339cd9</a><span style=3D"line-height:normal">&gt=
;</span><br style=3D"line-height:normal"><span style=3D"line-height:normal"=
>in</span><br style=3D"line-height:normal"><span style=3D"line-height:norma=
l">DRBD9,</span><br style=3D"line-height:normal"><span style=3D"line-height=
:normal">If both volume&#39;s size is different, It is not going on progres=
s sync</span><br style=3D"line-height:normal"><span style=3D"line-height:no=
rmal">initially, at=C2=A0 WFBitmapS/WFBitmapT</span><br style=3D"line-heigh=
t:normal"><br style=3D"line-height:normal"><span style=3D"line-height:norma=
l">When ds is Inconsistent/Inconsistent, then I command &quot;primary --for=
ce&quot;</span><br style=3D"line-height:normal"><span style=3D"line-height:=
normal">It was stalled at receive_bitmap(), because decode_bitmap_c() retur=
n err is</span><br style=3D"line-height:normal"><span style=3D"line-height:=
normal">positive value.</span><br style=3D"line-height:normal"><span style=
=3D"line-height:normal">In decoding at recv_bm_rle_bits(),=C2=A0 bit_offset=
 can&#39;t arrive bm_bits&#39; value.</span><br style=3D"line-height:normal=
"><br style=3D"line-height:normal"><span style=3D"line-height:normal">I&#39=
;m looking for this case more.</span><br style=3D"line-height:normal"><span=
 style=3D"line-height:normal">Plz. help me</span><br style=3D"line-height:n=
ormal"><br style=3D"line-height:normal"><span style=3D"line-height:normal">=
Before 4fe4c96, it works between nodes by the minimum volume&#39;s size.</s=
pan><br style=3D"line-height:normal"><br style=3D"line-height:normal"><br s=
tyle=3D"line-height:normal"><br style=3D"line-height:normal"><span style=3D=
"line-height:normal">In case 1:1 config, volume 200MB, 210MB log below</spa=
n><br style=3D"line-height:normal"><br style=3D"line-height:normal"><span s=
tyle=3D"line-height:normal">Jul 12 18:00:04 DRBD9_1 kernel: drbd r0: Starti=
ng worker thread (from</span><br style=3D"line-height:normal"><span style=
=3D"line-height:normal">drbdsetup [102643])</span><br style=3D"line-height:=
normal"><span style=3D"line-height:normal">Jul 12 18:00:04 DRBD9_1 drbd: St=
arting DRBD resources: [</span><br style=3D"line-height:normal"><span style=
=3D"line-height:normal">Jul 12 18:00:04 DRBD9_1 drbd: create res: r0</span>=
<br style=3D"line-height:normal"><span style=3D"line-height:normal">Jul 12 =
18:00:04 DRBD9_1 systemd-udevd: error: /dev/drbd1: Wrong medium type</span>=
<br style=3D"line-height:normal"><span style=3D"line-height:normal">Jul 12 =
18:00:04 DRBD9_1 drbd: prepare disk: r0</span><br style=3D"line-height:norm=
al"><span style=3D"line-height:normal">Jul 12 18:00:04 DRBD9_1 kernel: drbd=
 r0/0 drbd1: disk( Diskless -&gt;</span><br style=3D"line-height:normal"><s=
pan style=3D"line-height:normal">Attaching )</span><br style=3D"line-height=
:normal"><span style=3D"line-height:normal">Jul 12 18:00:04 DRBD9_1 kernel:=
 drbd r0/0 drbd1: Maximum number of peer</span><br style=3D"line-height:nor=
mal"><span style=3D"line-height:normal">devices =3D 1</span><br style=3D"li=
ne-height:normal"><span style=3D"line-height:normal">Jul 12 18:00:04 DRBD9_=
1 kernel: drbd r0: Method to ensure write ordering:</span><br style=3D"line=
-height:normal"><span style=3D"line-height:normal">flush</span><br style=3D=
"line-height:normal"><span style=3D"line-height:normal">Jul 12 18:00:04 DRB=
D9_1 kernel: drbd r0/0 drbd1: my node_id: 0</span><br style=3D"line-height:=
normal"><span style=3D"line-height:normal">Jul 12 18:00:04 DRBD9_1 kernel: =
drbd r0/0 drbd1: Adjusting my ra_pages to</span><br style=3D"line-height:no=
rmal"><span style=3D"line-height:normal">backing device&#39;s (32 -&gt; 102=
4)</span><br style=3D"line-height:normal"><span style=3D"line-height:normal=
">Jul 12 18:00:04 DRBD9_1 kernel: drbd r0/0 drbd1: my node_id: 0</span><br =
style=3D"line-height:normal"><span style=3D"line-height:normal">Jul 12 18:0=
0:04 DRBD9_1 kernel: drbd r0/0 drbd1: drbd_bm_resize called with</span><br =
style=3D"line-height:normal"><span style=3D"line-height:normal">capacity =
=3D=3D 430080</span><br style=3D"line-height:normal"><span style=3D"line-he=
ight:normal">Jul 12 18:00:04 DRBD9_1 kernel: drbd r0/0 drbd1: resync bitmap=
: bits=3D53760</span><br style=3D"line-height:normal"><span style=3D"line-h=
eight:normal">words=3D840 pages=3D2</span><br style=3D"line-height:normal">=
<span style=3D"line-height:normal">Jul 12 18:00:04 DRBD9_1 kernel: drbd r0/=
0 drbd1: recounting of set bits</span><br style=3D"line-height:normal"><spa=
n style=3D"line-height:normal">took additional 0ms</span><br style=3D"line-=
height:normal"><span style=3D"line-height:normal">Jul 12 18:00:04 DRBD9_1 k=
ernel: drbd r0/0 drbd1: Suspended AL updates</span><br style=3D"line-height=
:normal"><span style=3D"line-height:normal">Jul 12 18:00:04 DRBD9_1 kernel:=
 drbd r0/0 drbd1: disk( Attaching -&gt;</span><br style=3D"line-height:norm=
al"><span style=3D"line-height:normal">Inconsistent )</span><br style=3D"li=
ne-height:normal"><span style=3D"line-height:normal">Jul 12 18:00:04 DRBD9_=
1 kernel: drbd r0/0 drbd1: attached to current UUID:</span><br style=3D"lin=
e-height:normal"><span style=3D"line-height:normal">0000000000000004</span>=
<br style=3D"line-height:normal"><span style=3D"line-height:normal">Jul 12 =
18:00:04 DRBD9_1 systemd-udevd: error: /dev/drbd1: Wrong medium type</span>=
<br style=3D"line-height:normal"><span style=3D"line-height:normal">Jul 12 =
18:00:04 DRBD9_1 drbd: adjust disk: r0</span><br style=3D"line-height:norma=
l"><span style=3D"line-height:normal">Jul 12 18:00:04 DRBD9_1 kernel: drbd =
r0 DRBD9_2: Starting sender thread</span><br style=3D"line-height:normal"><=
span style=3D"line-height:normal">(from drbdsetup [102653])</span><br style=
=3D"line-height:normal"><span style=3D"line-height:normal">Jul 12 18:00:04 =
DRBD9_1 drbd: prepare net: r0</span><br style=3D"line-height:normal"><span =
style=3D"line-height:normal">Jul 12 18:00:04 DRBD9_1 drbd: attempt to conne=
ct: r0</span><br style=3D"line-height:normal"><span style=3D"line-height:no=
rmal">Jul 12 18:00:04 DRBD9_1 drbd: ]</span><br style=3D"line-height:normal=
"><span style=3D"line-height:normal">Jul 12 18:00:04 DRBD9_1 kernel: drbd r=
0 DRBD9_2: conn( StandAlone -&gt;</span><br style=3D"line-height:normal"><s=
pan style=3D"line-height:normal">Unconnected )</span><br style=3D"line-heig=
ht:normal"><span style=3D"line-height:normal">Jul 12 18:00:04 DRBD9_1 kerne=
l: drbd r0 DRBD9_2: Starting receiver thread</span><br style=3D"line-height=
:normal"><span style=3D"line-height:normal">(from drbd_w_r0 [102644])</span=
><br style=3D"line-height:normal"><span style=3D"line-height:normal">Jul 12=
 18:00:04 DRBD9_1 kernel: drbd r0 DRBD9_2: conn( Unconnected -&gt;</span><b=
r style=3D"line-height:normal"><span style=3D"line-height:normal">Connectin=
g )</span><br style=3D"line-height:normal"><span style=3D"line-height:norma=
l">Jul 12 18:00:04 DRBD9_1 kernel: drbd r0 DRBD9_2: Handshake successful:</=
span><br style=3D"line-height:normal"><span style=3D"line-height:normal">Ag=
reed network protocol version 111</span><br style=3D"line-height:normal"><s=
pan style=3D"line-height:normal">Jul 12 18:00:04 DRBD9_1 kernel: drbd r0 DR=
BD9_2: Feature flags enabled on</span><br style=3D"line-height:normal"><spa=
n style=3D"line-height:normal">protocol level: 0x7 TRIM THIN_RESYNC WRITE_S=
AME.</span><br style=3D"line-height:normal"><span style=3D"line-height:norm=
al">Jul 12 18:00:04 DRBD9_1 kernel: drbd r0 DRBD9_2: Starting ack_recv thre=
ad</span><br style=3D"line-height:normal"><span style=3D"line-height:normal=
">(from drbd_r_r0 [102662])</span><br style=3D"line-height:normal"><span st=
yle=3D"line-height:normal">Jul 12 18:00:04 DRBD9_1 kernel: drbd r0: Prepari=
ng cluster-wide state</span><br style=3D"line-height:normal"><span style=3D=
"line-height:normal">change 480688786 (0-&gt;1 499/146)</span><br style=3D"=
line-height:normal"><span style=3D"line-height:normal">Jul 12 18:00:04 DRBD=
9_1 kernel: drbd r0: State change 480688786:</span><br style=3D"line-height=
:normal"><span style=3D"line-height:normal">primary_nodes=3D0, weak_nodes=
=3D0</span><br style=3D"line-height:normal"><span style=3D"line-height:norm=
al">Jul 12 18:00:04 DRBD9_1 kernel: drbd r0: Committing cluster-wide state<=
/span><br style=3D"line-height:normal"><span style=3D"line-height:normal">c=
hange 480688786 (3ms)</span><br style=3D"line-height:normal"><span style=3D=
"line-height:normal">Jul 12 18:00:04 DRBD9_1 kernel: drbd r0 DRBD9_2: conn(=
 Connecting -&gt;</span><br style=3D"line-height:normal"><span style=3D"lin=
e-height:normal">Connected ) peer( Unknown -&gt; Secondary )</span><br styl=
e=3D"line-height:normal"><span style=3D"line-height:normal">Jul 12 18:00:04=
 DRBD9_1 kernel: drbd r0/0 drbd1: current_size: 430080</span><br style=3D"l=
ine-height:normal"><span style=3D"line-height:normal">Jul 12 18:00:04 DRBD9=
_1 kernel: drbd r0/0 drbd1 DRBD9_2: c_size: 450560</span><br style=3D"line-=
height:normal"><span style=3D"line-height:normal">u_size: 0 d_size: 450560 =
max_size: 450560</span><br style=3D"line-height:normal"><span style=3D"line=
-height:normal">Jul 12 18:00:04 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_2: la=
_size: 0</span><br style=3D"line-height:normal"><span style=3D"line-height:=
normal">my_usize: 0</span><br style=3D"line-height:normal"><span style=3D"l=
ine-height:normal">Jul 12 18:00:04 DRBD9_1 kernel: drbd r0/0 drbd1: my node=
_id: 0</span><br style=3D"line-height:normal"><span style=3D"line-height:no=
rmal">Jul 12 18:00:04 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_2: node_id: 1 i=
dx: 0</span><br style=3D"line-height:normal"><span style=3D"line-height:nor=
mal">bm-uuid: 0x0 flags: 0x0 max_size: 450560 (DUnknown)</span><br style=3D=
"line-height:normal"><span style=3D"line-height:normal">Jul 12 18:00:04 DRB=
D9_1 kernel: drbd r0/0 drbd1 DRBD9_2: calling</span><br style=3D"line-heigh=
t:normal"><span style=3D"line-height:normal">drbd_determine_dev_size()</spa=
n><br style=3D"line-height:normal"><span style=3D"line-height:normal">Jul 1=
2 18:00:04 DRBD9_1 kernel: drbd r0/0 drbd1: my node_id: 0</span><br style=
=3D"line-height:normal"><span style=3D"line-height:normal">Jul 12 18:00:04 =
DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_2: node_id: 1 idx: 0</span><br style=
=3D"line-height:normal"><span style=3D"line-height:normal">bm-uuid: 0x0 fla=
gs: 0x0 max_size: 450560 (DUnknown)</span><br style=3D"line-height:normal">=
<span style=3D"line-height:normal">Jul 12 18:00:04 DRBD9_1 kernel: drbd r0/=
0 drbd1 DRBD9_2:</span><br style=3D"line-height:normal"><span style=3D"line=
-height:normal">drbd_sync_handshake:</span><br style=3D"line-height:normal"=
><span style=3D"line-height:normal">Jul 12 18:00:04 DRBD9_1 kernel: drbd r0=
/0 drbd1 DRBD9_2: self</span><br style=3D"line-height:normal"><span style=
=3D"line-height:normal">0000000000000004:</span><span style=3D"line-height:=
normal">0000000000000000:</span><span style=3D"line-height:normal">00000000=
00000000:</span><span style=3D"line-height:normal">0000000000000000</span><=
br style=3D"line-height:normal"><span style=3D"line-height:normal">bits:537=
60 flags:0</span><br style=3D"line-height:normal"><span style=3D"line-heigh=
t:normal">Jul 12 18:00:04 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_2: peer</sp=
an><br style=3D"line-height:normal"><span style=3D"line-height:normal">0000=
000000000004:</span><span style=3D"line-height:normal">0000000000000000:</s=
pan><span style=3D"line-height:normal">0000000000000000:</span><span style=
=3D"line-height:normal">0000000000000000</span><br style=3D"line-height:nor=
mal"><span style=3D"line-height:normal">bits:56320 flags:24</span><br style=
=3D"line-height:normal"><span style=3D"line-height:normal">Jul 12 18:00:04 =
DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_2: uuid_compare()=3D0</span><br style=
=3D"line-height:normal"><span style=3D"line-height:normal">by rule 10</span=
><br style=3D"line-height:normal"><span style=3D"line-height:normal">Jul 12=
 18:00:04 DRBD9_1 kernel: drbd r0/0 drbd1: No resync, but 53760 bits</span>=
<br style=3D"line-height:normal"><span style=3D"line-height:normal">in bitm=
ap!</span><br style=3D"line-height:normal"><span style=3D"line-height:norma=
l">Jul 12 18:00:04 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_2: pdsk( DUnknown =
-&gt;</span><br style=3D"line-height:normal"><span style=3D"line-height:nor=
mal">Inconsistent ) repl( Off -&gt; Established )</span><br style=3D"line-h=
eight:normal"><span style=3D"line-height:normal">Jul 12 18:00:04 DRBD9_1 ke=
rnel: drbd r0/0 drbd1: Resumed AL updates</span><br style=3D"line-height:no=
rmal"><span style=3D"line-height:normal">Jul 12 18:00:04 DRBD9_1 drbd: WARN=
: stdin/stdout is not a TTY; using</span><br style=3D"line-height:normal"><=
span style=3D"line-height:normal">/dev/consoledrbdadm: Unknown command &#39=
;sh-b-pri&#39;</span><br style=3D"line-height:normal"><span style=3D"line-h=
eight:normal">Jul 12 18:00:04 DRBD9_1 drbd: .</span><br style=3D"line-heigh=
t:normal"><span style=3D"line-height:normal">Jul 12 18:00:40 DRBD9_1 kernel=
: drbd r0: Preparing cluster-wide state</span><br style=3D"line-height:norm=
al"><span style=3D"line-height:normal">change 3595219668 (0-&gt;-1 7683/460=
9)</span><br style=3D"line-height:normal"><span style=3D"line-height:normal=
">Jul 12 18:00:40 DRBD9_1 kernel: drbd r0: State change 3595219668:</span><=
br style=3D"line-height:normal"><span style=3D"line-height:normal">primary_=
nodes=3D1, weak_nodes=3DFFFFFFFFFFFFFFFC</span><br style=3D"line-height:nor=
mal"><span style=3D"line-height:normal">Jul 12 18:00:40 DRBD9_1 kernel: drb=
d r0: Committing cluster-wide state</span><br style=3D"line-height:normal">=
<span style=3D"line-height:normal">change 3595219668 (1ms)</span><br style=
=3D"line-height:normal"><span style=3D"line-height:normal">Jul 12 18:00:40 =
DRBD9_1 kernel: drbd r0: role( Secondary -&gt; Primary )</span><br style=3D=
"line-height:normal"><span style=3D"line-height:normal">Jul 12 18:00:40 DRB=
D9_1 kernel: drbd r0/0 drbd1: disk( Inconsistent -&gt;</span><br style=3D"l=
ine-height:normal"><span style=3D"line-height:normal">UpToDate )</span><br =
style=3D"line-height:normal"><span style=3D"line-height:normal">Jul 12 18:0=
0:40 DRBD9_1 kernel: drbd r0/0 drbd1: size =3D 210 MB (215040 KB)</span><br=
 style=3D"line-height:normal"><span style=3D"line-height:normal">Jul 12 18:=
00:40 DRBD9_1 kernel: drbd r0: Forced to consider local data as</span><br s=
tyle=3D"line-height:normal"><span style=3D"line-height:normal">UpToDate!</s=
pan><br style=3D"line-height:normal"><span style=3D"line-height:normal">Jul=
 12 18:00:40 DRBD9_1 kernel: drbd r0/0 drbd1: new current UUID:</span><br s=
tyle=3D"line-height:normal"><span style=3D"line-height:normal">E33ECAD77287=
E565 weak: FFFFFFFFFFFFFFFC</span><br style=3D"line-height:normal"><span st=
yle=3D"line-height:normal">Jul 12 18:00:40 DRBD9_1 kernel: drbd r0/0 drbd1 =
DRBD9_2:</span><br style=3D"line-height:normal"><span style=3D"line-height:=
normal">drbd_sync_handshake:</span><br style=3D"line-height:normal"><span s=
tyle=3D"line-height:normal">Jul 12 18:00:40 DRBD9_1 kernel: drbd r0/0 drbd1=
 DRBD9_2: self</span><br style=3D"line-height:normal"><span style=3D"line-h=
eight:normal">E33ECAD77287E565:</span><span style=3D"line-height:normal">00=
00000000000000:</span><span style=3D"line-height:normal">0000000000000000:<=
/span><span style=3D"line-height:normal">0000000000000000</span><br style=
=3D"line-height:normal"><span style=3D"line-height:normal">bits:53760 flags=
:0</span><br style=3D"line-height:normal"><span style=3D"line-height:normal=
">Jul 12 18:00:40 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_2: peer</span><br s=
tyle=3D"line-height:normal"><span style=3D"line-height:normal">000000000000=
0004:</span><span style=3D"line-height:normal">FFFFFFFFFFFFFFFF:</span><spa=
n style=3D"line-height:normal">0000000000000000:</span><span style=3D"line-=
height:normal">0000000000000000</span><br style=3D"line-height:normal"><spa=
n style=3D"line-height:normal">bits:56320 flags:104</span><br style=3D"line=
-height:normal"><span style=3D"line-height:normal">Jul 12 18:00:40 DRBD9_1 =
kernel: drbd r0/0 drbd1 DRBD9_2: uuid_compare()=3D3</span><br style=3D"line=
-height:normal"><span style=3D"line-height:normal">by rule 30</span><br sty=
le=3D"line-height:normal"><span style=3D"line-height:normal">Jul 12 18:00:4=
0 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_2: Writing the whole</span><br styl=
e=3D"line-height:normal"><span style=3D"line-height:normal">bitmap, full sy=
nc required after drbd_sync_handshake.</span><br style=3D"line-height:norma=
l"><span style=3D"line-height:normal">Jul 12 18:00:40 DRBD9_1 kernel: drbd =
r0/0 drbd1 DRBD9_2: repl( Established</span><br style=3D"line-height:normal=
"><span style=3D"line-height:normal">-&gt; WFBitMapS )</span><br style=3D"l=
ine-height:normal"><span style=3D"line-height:normal">Jul 12 18:00:40 DRBD9=
_1 kernel: drbd r0/0 drbd1 DRBD9_2: send bitmap stats</span><br style=3D"li=
ne-height:normal"><span style=3D"line-height:normal">[Bytes(packets)]: plai=
n 0(0), RLE 21(1), total 21; compression: 99.7%</span><br style=3D"line-hei=
ght:normal"><br style=3D"line-height:normal"><br style=3D"line-height:norma=
l"><br style=3D"line-height:normal"><br style=3D"line-height:normal"><br st=
yle=3D"line-height:normal"><span style=3D"line-height:normal">Jul 12 17:59:=
57 DRBD9_2 drbd: Starting DRBD resources: [</span><br style=3D"line-height:=
normal"><span style=3D"line-height:normal">Jul 12 17:59:57 DRBD9_2 drbd: cr=
eate res: r0</span><br style=3D"line-height:normal"><span style=3D"line-hei=
ght:normal">Jul 12 17:59:57 DRBD9_2 kernel: drbd r0: Starting worker thread=
 (from</span><br style=3D"line-height:normal"><span style=3D"line-height:no=
rmal">drbdsetup [83726])</span><br style=3D"line-height:normal"><span style=
=3D"line-height:normal">Jul 12 17:59:57 DRBD9_2 systemd-udevd: error: /dev/=
drbd1: Wrong medium type</span><br style=3D"line-height:normal"><span style=
=3D"line-height:normal">Jul 12 17:59:57 DRBD9_2 drbd: prepare disk: r0</spa=
n><br style=3D"line-height:normal"><span style=3D"line-height:normal">Jul 1=
2 17:59:57 DRBD9_2 kernel: drbd r0/0 drbd1: disk( Diskless -&gt;</span><br =
style=3D"line-height:normal"><span style=3D"line-height:normal">Attaching )=
</span><br style=3D"line-height:normal"><span style=3D"line-height:normal">=
Jul 12 17:59:57 DRBD9_2 kernel: drbd r0/0 drbd1: Maximum number of peer</sp=
an><br style=3D"line-height:normal"><span style=3D"line-height:normal">devi=
ces =3D 1</span><br style=3D"line-height:normal"><span style=3D"line-height=
:normal">Jul 12 17:59:57 DRBD9_2 kernel: drbd r0: Method to ensure write or=
dering:</span><br style=3D"line-height:normal"><span style=3D"line-height:n=
ormal">flush</span><br style=3D"line-height:normal"><span style=3D"line-hei=
ght:normal">Jul 12 17:59:57 DRBD9_2 kernel: drbd r0/0 drbd1: my node_id: 1<=
/span><br style=3D"line-height:normal"><span style=3D"line-height:normal">J=
ul 12 17:59:57 DRBD9_2 kernel: drbd r0/0 drbd1: Adjusting my ra_pages to</s=
pan><br style=3D"line-height:normal"><span style=3D"line-height:normal">bac=
king device&#39;s (32 -&gt; 1024)</span><br style=3D"line-height:normal"><s=
pan style=3D"line-height:normal">Jul 12 17:59:57 DRBD9_2 kernel: drbd r0/0 =
drbd1: my node_id: 1</span><br style=3D"line-height:normal"><span style=3D"=
line-height:normal">Jul 12 17:59:57 DRBD9_2 kernel: drbd r0/0 drbd1: drbd_b=
m_resize called with</span><br style=3D"line-height:normal"><span style=3D"=
line-height:normal">capacity =3D=3D 450560</span><br style=3D"line-height:n=
ormal"><span style=3D"line-height:normal">Jul 12 17:59:57 DRBD9_2 kernel: d=
rbd r0/0 drbd1: resync bitmap: bits=3D56320</span><br style=3D"line-height:=
normal"><span style=3D"line-height:normal">words=3D880 pages=3D2</span><br =
style=3D"line-height:normal"><span style=3D"line-height:normal">Jul 12 17:5=
9:57 DRBD9_2 kernel: drbd r0/0 drbd1: recounting of set bits</span><br styl=
e=3D"line-height:normal"><span style=3D"line-height:normal">took additional=
 0ms</span><br style=3D"line-height:normal"><span style=3D"line-height:norm=
al">Jul 12 17:59:57 DRBD9_2 kernel: drbd r0/0 drbd1: Suspended AL updates</=
span><br style=3D"line-height:normal"><span style=3D"line-height:normal">Ju=
l 12 17:59:57 DRBD9_2 kernel: drbd r0/0 drbd1: disk( Attaching -&gt;</span>=
<br style=3D"line-height:normal"><span style=3D"line-height:normal">Inconsi=
stent )</span><br style=3D"line-height:normal"><span style=3D"line-height:n=
ormal">Jul 12 17:59:57 DRBD9_2 kernel: drbd r0/0 drbd1: attached to current=
 UUID:</span><br style=3D"line-height:normal"><span style=3D"line-height:no=
rmal">0000000000000004</span><br style=3D"line-height:normal"><span style=
=3D"line-height:normal">Jul 12 17:59:57 DRBD9_2 drbd: adjust disk: r0</span=
><br style=3D"line-height:normal"><span style=3D"line-height:normal">Jul 12=
 17:59:57 DRBD9_2 systemd-udevd: error: /dev/drbd1: Wrong medium type</span=
><br style=3D"line-height:normal"><span style=3D"line-height:normal">Jul 12=
 17:59:57 DRBD9_2 kernel: drbd r0 DRBD9_1: Starting sender thread</span><br=
 style=3D"line-height:normal"><span style=3D"line-height:normal">(from drbd=
setup [83737])</span><br style=3D"line-height:normal"><span style=3D"line-h=
eight:normal">Jul 12 17:59:57 DRBD9_2 drbd: prepare net: r0</span><br style=
=3D"line-height:normal"><span style=3D"line-height:normal">Jul 12 17:59:57 =
DRBD9_2 drbd: attempt to connect: r0</span><br style=3D"line-height:normal"=
><span style=3D"line-height:normal">Jul 12 17:59:57 DRBD9_2 drbd: ]</span><=
br style=3D"line-height:normal"><span style=3D"line-height:normal">Jul 12 1=
7:59:57 DRBD9_2 kernel: drbd r0 DRBD9_1: conn( StandAlone -&gt;</span><br s=
tyle=3D"line-height:normal"><span style=3D"line-height:normal">Unconnected =
)</span><br style=3D"line-height:normal"><span style=3D"line-height:normal"=
>Jul 12 17:59:57 DRBD9_2 kernel: drbd r0 DRBD9_1: Starting receiver thread<=
/span><br style=3D"line-height:normal"><span style=3D"line-height:normal">(=
from drbd_w_r0 [83727])</span><br style=3D"line-height:normal"><span style=
=3D"line-height:normal">Jul 12 17:59:58 DRBD9_2 kernel: drbd r0 DRBD9_1: co=
nn( Unconnected -&gt;</span><br style=3D"line-height:normal"><span style=3D=
"line-height:normal">Connecting )</span><br style=3D"line-height:normal"><s=
pan style=3D"line-height:normal">Jul 12 18:00:04 DRBD9_2 kernel: drbd r0 DR=
BD9_1: Handshake successful:</span><br style=3D"line-height:normal"><span s=
tyle=3D"line-height:normal">Agreed network protocol version 111</span><br s=
tyle=3D"line-height:normal"><span style=3D"line-height:normal">Jul 12 18:00=
:04 DRBD9_2 kernel: drbd r0 DRBD9_1: Feature flags enabled on</span><br sty=
le=3D"line-height:normal"><span style=3D"line-height:normal">protocol level=
: 0x7 TRIM THIN_RESYNC WRITE_SAME.</span><br style=3D"line-height:normal"><=
span style=3D"line-height:normal">Jul 12 18:00:04 DRBD9_2 kernel: drbd r0 D=
RBD9_1: Starting ack_recv thread</span><br style=3D"line-height:normal"><sp=
an style=3D"line-height:normal">(from drbd_r_r0 [83745])</span><br style=3D=
"line-height:normal"><span style=3D"line-height:normal">Jul 12 18:00:04 DRB=
D9_2 kernel: drbd r0 DRBD9_1: Preparing remote state</span><br style=3D"lin=
e-height:normal"><span style=3D"line-height:normal">change 480688786 (prima=
ry_nodes=3D0, weak_nodes=3D0)</span><br style=3D"line-height:normal"><span =
style=3D"line-height:normal">Jul 12 18:00:04 DRBD9_2 kernel: drbd r0 DRBD9_=
1: Committing remote state</span><br style=3D"line-height:normal"><span sty=
le=3D"line-height:normal">change 480688786</span><br style=3D"line-height:n=
ormal"><span style=3D"line-height:normal">Jul 12 18:00:04 DRBD9_2 kernel: d=
rbd r0 DRBD9_1: conn( Connecting -&gt;</span><br style=3D"line-height:norma=
l"><span style=3D"line-height:normal">Connected ) peer( Unknown -&gt; Secon=
dary )</span><br style=3D"line-height:normal"><span style=3D"line-height:no=
rmal">Jul 12 18:00:04 DRBD9_2 kernel: drbd r0/0 drbd1: current_size: 450560=
</span><br style=3D"line-height:normal"><span style=3D"line-height:normal">=
Jul 12 18:00:04 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_1: c_size: 430080</sp=
an><br style=3D"line-height:normal"><span style=3D"line-height:normal">u_si=
ze: 0 d_size: 430080 max_size: 430080</span><br style=3D"line-height:normal=
"><span style=3D"line-height:normal">Jul 12 18:00:04 DRBD9_2 kernel: drbd r=
0/0 drbd1 DRBD9_1: la_size: 0</span><br style=3D"line-height:normal"><span =
style=3D"line-height:normal">my_usize: 0</span><br style=3D"line-height:nor=
mal"><span style=3D"line-height:normal">Jul 12 18:00:04 DRBD9_2 kernel: drb=
d r0/0 drbd1 DRBD9_1: node_id: 0 idx: 0</span><br style=3D"line-height:norm=
al"><span style=3D"line-height:normal">bm-uuid: 0x0 flags: 0x0 max_size: 43=
0080 (DUnknown)</span><br style=3D"line-height:normal"><span style=3D"line-=
height:normal">Jul 12 18:00:04 DRBD9_2 kernel: drbd r0/0 drbd1: my node_id:=
 1</span><br style=3D"line-height:normal"><span style=3D"line-height:normal=
">Jul 12 18:00:04 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_1: calling</span><b=
r style=3D"line-height:normal"><span style=3D"line-height:normal">drbd_dete=
rmine_dev_size()</span><br style=3D"line-height:normal"><span style=3D"line=
-height:normal">Jul 12 18:00:04 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_1: no=
de_id: 0 idx: 0</span><br style=3D"line-height:normal"><span style=3D"line-=
height:normal">bm-uuid: 0x0 flags: 0x0 max_size: 430080 (DUnknown)</span><b=
r style=3D"line-height:normal"><span style=3D"line-height:normal">Jul 12 18=
:00:04 DRBD9_2 kernel: drbd r0/0 drbd1: my node_id: 1</span><br style=3D"li=
ne-height:normal"><span style=3D"line-height:normal">Jul 12 18:00:04 DRBD9_=
2 kernel: drbd r0/0 drbd1 DRBD9_1:</span><br style=3D"line-height:normal"><=
span style=3D"line-height:normal">drbd_sync_handshake:</span><br style=3D"l=
ine-height:normal"><span style=3D"line-height:normal">Jul 12 18:00:04 DRBD9=
_2 kernel: drbd r0/0 drbd1 DRBD9_1: self</span><br style=3D"line-height:nor=
mal"><span style=3D"line-height:normal">0000000000000004:</span><span style=
=3D"line-height:normal">0000000000000000:</span><span style=3D"line-height:=
normal">0000000000000000:</span><span style=3D"line-height:normal">00000000=
00000000</span><br style=3D"line-height:normal"><span style=3D"line-height:=
normal">bits:56320 flags:0</span><br style=3D"line-height:normal"><span sty=
le=3D"line-height:normal">Jul 12 18:00:04 DRBD9_2 kernel: drbd r0/0 drbd1 D=
RBD9_1: peer</span><br style=3D"line-height:normal"><span style=3D"line-hei=
ght:normal">0000000000000004:</span><span style=3D"line-height:normal">0000=
000000000000:</span><span style=3D"line-height:normal">0000000000000000:</s=
pan><span style=3D"line-height:normal">0000000000000000</span><br style=3D"=
line-height:normal"><span style=3D"line-height:normal">bits:53760 flags:24<=
/span><br style=3D"line-height:normal"><span style=3D"line-height:normal">J=
ul 12 18:00:04 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_1: uuid_compare()=3D0<=
/span><br style=3D"line-height:normal"><span style=3D"line-height:normal">b=
y rule 10</span><br style=3D"line-height:normal"><span style=3D"line-height=
:normal">Jul 12 18:00:04 DRBD9_2 kernel: drbd r0/0 drbd1: No resync, but 56=
320 bits</span><br style=3D"line-height:normal"><span style=3D"line-height:=
normal">in bitmap!</span><br style=3D"line-height:normal"><span style=3D"li=
ne-height:normal">Jul 12 18:00:04 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_1: =
pdsk( DUnknown -&gt;</span><br style=3D"line-height:normal"><span style=3D"=
line-height:normal">Inconsistent ) repl( Off -&gt; Established )</span><br =
style=3D"line-height:normal"><span style=3D"line-height:normal">Jul 12 18:0=
0:04 DRBD9_2 kernel: drbd r0/0 drbd1: Resumed AL updates</span><br style=3D=
"line-height:normal"><span style=3D"line-height:normal">Jul 12 18:00:04 DRB=
D9_2 drbd: WARN: stdin/stdout is not a TTY; using</span><br style=3D"line-h=
eight:normal"><span style=3D"line-height:normal">/dev/consoledrbdadm: Unkno=
wn command &#39;sh-b-pri&#39;</span><br style=3D"line-height:normal"><span =
style=3D"line-height:normal">Jul 12 18:00:04 DRBD9_2 drbd: .</span><br styl=
e=3D"line-height:normal"><span style=3D"line-height:normal">Jul 12 18:00:40=
 DRBD9_2 kernel: drbd r0 DRBD9_1: Preparing remote state</span><br style=3D=
"line-height:normal"><span style=3D"line-height:normal">change 3595219668 (=
primary_nodes=3D0, weak_nodes=3D0)</span><br style=3D"line-height:normal"><=
span style=3D"line-height:normal">Jul 12 18:00:40 DRBD9_2 kernel: drbd r0 D=
RBD9_1: Committing remote state</span><br style=3D"line-height:normal"><spa=
n style=3D"line-height:normal">change 3595219668</span><br style=3D"line-he=
ight:normal"><span style=3D"line-height:normal">Jul 12 18:00:40 DRBD9_2 ker=
nel: drbd r0 DRBD9_1: peer( Secondary -&gt; Primary</span><br style=3D"line=
-height:normal"><span style=3D"line-height:normal">)</span><br style=3D"lin=
e-height:normal"><span style=3D"line-height:normal">Jul 12 18:00:40 DRBD9_2=
 kernel: drbd r0/0 drbd1 DRBD9_1: pdsk( Inconsistent</span><br style=3D"lin=
e-height:normal"><span style=3D"line-height:normal">-&gt; UpToDate )</span>=
<br style=3D"line-height:normal"><span style=3D"line-height:normal">Jul 12 =
18:00:40 DRBD9_2 kernel: drbd r0/0 drbd1: size =3D 220 MB (225280 KB)</span=
><br style=3D"line-height:normal"><span style=3D"line-height:normal">Jul 12=
 18:00:40 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_1:</span><br style=3D"line-=
height:normal"><span style=3D"line-height:normal">drbd_sync_handshake:</spa=
n><br style=3D"line-height:normal"><span style=3D"line-height:normal">Jul 1=
2 18:00:40 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_1: self</span><br style=3D=
"line-height:normal"><span style=3D"line-height:normal">0000000000000004:</=
span><span style=3D"line-height:normal">0000000000000000:</span><span style=
=3D"line-height:normal">0000000000000000:</span><span style=3D"line-height:=
normal">0000000000000000</span><br style=3D"line-height:normal"><span style=
=3D"line-height:normal">bits:56320 flags:0</span><br style=3D"line-height:n=
ormal"><span style=3D"line-height:normal">Jul 12 18:00:40 DRBD9_2 kernel: d=
rbd r0/0 drbd1 DRBD9_1: peer</span><br style=3D"line-height:normal"><span s=
tyle=3D"line-height:normal">E33ECAD77287E565:</span><span style=3D"line-hei=
ght:normal">FFFFFFFFFFFFFFFF:</span><span style=3D"line-height:normal">0000=
000000000000:</span><span style=3D"line-height:normal">0000000000000000</sp=
an><br style=3D"line-height:normal"><span style=3D"line-height:normal">bits=
:53760 flags:120</span><br style=3D"line-height:normal"><span style=3D"line=
-height:normal">Jul 12 18:00:40 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_1: uu=
id_compare()=3D-3</span><br style=3D"line-height:normal"><span style=3D"lin=
e-height:normal">by rule 20</span><br style=3D"line-height:normal"><span st=
yle=3D"line-height:normal">Jul 12 18:00:40 DRBD9_2 kernel: drbd r0/0 drbd1 =
DRBD9_1: Writing the whole</span><br style=3D"line-height:normal"><span sty=
le=3D"line-height:normal">bitmap, full sync required after drbd_sync_handsh=
ake.</span><br style=3D"line-height:normal"><span style=3D"line-height:norm=
al">Jul 12 18:00:40 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_1: repl( Establis=
hed</span><br style=3D"line-height:normal"><span style=3D"line-height:norma=
l">-&gt; WFBitMapT )</span><br style=3D"line-height:normal"><span style=3D"=
line-height:normal">Jul 12 18:00:40 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_1=
: s(53760)</span><br style=3D"line-height:normal"><span style=3D"line-heigh=
t:normal">bit_offset(53760) word_offset(840) bm_bits(56320)</span><br style=
=3D"line-height:normal"><span style=3D"line-height:normal">Jul 12 18:00:40 =
DRBD9_2 kernel: drbd r0/0 drbd1: after decode_bitmap_c()</span><br style=3D=
"line-height:normal"><span style=3D"line-height:normal">err(1)</span></p></=
div></div></div></div></div></div></div></div>-- <br><div class=3D"gmail_si=
gnature" data-smartmail=3D"gmail_signature"><div dir=3D"ltr"><div><div dir=
=3D"ltr"><div><div dir=3D"ltr"><div><div dir=3D"ltr"><div><div dir=3D"ltr">=
<br><div><p style=3D"margin:0cm 0cm 0.0001pt;background-image:initial;backg=
round-repeat:initial"><br></p></div></div></div></div></div></div></div></d=
iv></div></div></div>
</div><div hspace=3D"streak-pt-mark" style=3D"max-height:1px"><img style=3D=
"width:0px;max-height:0px;overflow:hidden" src=3D"https://mailfoogae.appspo=
t.com/t?sender=3Daa21wYWtAbWFudGVjaC5jby5rcg%3D%3D&amp;type=3Dzerocontent&a=
mp;guid=3D9c3296f3-4b70-4826-b659-c0f4f208f2f7"><font color=3D"#ffffff" siz=
e=3D"1">=E1=90=A7</font></div>

--001a1141aa2e1c928405377ee482--
