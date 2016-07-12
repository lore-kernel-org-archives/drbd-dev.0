Return-Path: <kmpak@mantech.co.kr>
Received: from mail-oi0-f44.google.com (mail-oi0-f44.google.com
	[209.85.218.44]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 77ED1105633A
	for <drbd-dev@lists.linbit.com>; Tue, 12 Jul 2016 11:20:12 +0200 (CEST)
Received: by mail-oi0-f44.google.com with SMTP id j185so7501964oih.0
	for <drbd-dev@lists.linbit.com>; Tue, 12 Jul 2016 02:20:12 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?67CV6rK966+8?= <kmpak@mantech.co.kr>
Date: Tue, 12 Jul 2016 18:12:32 +0900
Message-ID: <CALLFrTQGkpOfP+41paPU2wWF86uACPCoVwvTvpDN9tzxT6Z2Gw@mail.gmail.com>
To: drbd-dev@lists.linbit.com
Content-Type: multipart/related; boundary=001a1141aa2e46efff05376cab13
Subject: [Drbd-dev] Failed to sync initially at different volume's size
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

--001a1141aa2e46efff05376cab13
Content-Type: multipart/alternative; boundary=001a1141aa2e46effd05376cab12

--001a1141aa2e46effd05376cab12
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello.

After 4fe4c96 commit
<http://git.drbd.org/drbd-9.0.git/commit/4fe4c962f41307c2db2846f18f5137082f=
339cd9>
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

=EA=B8=B0=EC=88=A0=EC=97=B0=EA=B5=AC=EC=86=8C                  Mobile : 010=
-4762-0519

*=EB=B0=95 =EA=B2=BD =EB=AF=BC =EC=B0=A8=EC=9E=A5*              kmpak@mante=
ch.co.kr

=EC=84=9C=EC=9A=B8=ED=8A=B9=EB=B3=84=EC=8B=9C =EC=84=B1=EB=8F=99=EA=B5=AC =
=EC=84=B1=EC=88=98=EC=9D=BC=EB=A1=9C4=EA=B8=B8 25 =EC=84=9C=EC=9A=B8=EC=88=
=B2=EC=BD=94=EC=98=A4=EB=A1=B1=EB=94=94=EC=A7=80=ED=84=B8=ED=83=80=EC=9B=8C=
 12=EC=B8=B5

Fax : 02-575-4858 / Tel : (02) 2136-6978 (978)


=E1=90=A7

--001a1141aa2e46effd05376cab12
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello.<div><br><div>After <a href=3D"http://git.drbd.org/d=
rbd-9.0.git/commit/4fe4c962f41307c2db2846f18f5137082f339cd9">4fe4c96 commit=
</a>=C2=A0in DRBD9,=C2=A0<br></div><div>If both volume&#39;s size is differ=
ent, It is not going on progress sync initially, at =C2=A0WFBitmapS/WFBitma=
pT</div><div><br></div><div>When ds is Inconsistent/Inconsistent, then I co=
mmand &quot;primary --force&quot;</div><div>It was stalled at receive_bitma=
p(), because=C2=A0decode_bitmap_c() return err is positive value.</div><div=
>In decoding at recv_bm_rle_bits(), =C2=A0bit_offset can&#39;t arrive bm_bi=
ts&#39; value.<br></div><div><br></div><div>I&#39;m looking for this case m=
ore.</div><div>Plz. help me</div><div><br></div><div>Before 4fe4c96, it wor=
ks between nodes by the minimum volume&#39;s size.<br></div><div><br></div>=
<div><br></div><div><br></div><div>In case 1:1 config, volume 200MB, 210MB =
log below=C2=A0</div><div><br></div><div><div>Jul 12 18:00:04 DRBD9_1 kerne=
l: drbd r0: Starting worker thread (from drbdsetup [102643])</div><div>Jul =
12 18:00:04 DRBD9_1 drbd: Starting DRBD resources: [</div><div>Jul 12 18:00=
:04 DRBD9_1 drbd: create res: r0</div><div>Jul 12 18:00:04 DRBD9_1 systemd-=
udevd: error: /dev/drbd1: Wrong medium type</div><div>Jul 12 18:00:04 DRBD9=
_1 drbd: prepare disk: r0</div><div>Jul 12 18:00:04 DRBD9_1 kernel: drbd r0=
/0 drbd1: disk( Diskless -&gt; Attaching )</div><div>Jul 12 18:00:04 DRBD9_=
1 kernel: drbd r0/0 drbd1: Maximum number of peer devices =3D 1</div><div>J=
ul 12 18:00:04 DRBD9_1 kernel: drbd r0: Method to ensure write ordering: fl=
ush</div><div>Jul 12 18:00:04 DRBD9_1 kernel: drbd r0/0 drbd1: my node_id: =
0</div><div>Jul 12 18:00:04 DRBD9_1 kernel: drbd r0/0 drbd1: Adjusting my r=
a_pages to backing device&#39;s (32 -&gt; 1024)</div><div>Jul 12 18:00:04 D=
RBD9_1 kernel: drbd r0/0 drbd1: my node_id: 0</div><div>Jul 12 18:00:04 DRB=
D9_1 kernel: drbd r0/0 drbd1: drbd_bm_resize called with capacity =3D=3D 43=
0080</div><div>Jul 12 18:00:04 DRBD9_1 kernel: drbd r0/0 drbd1: resync bitm=
ap: bits=3D53760 words=3D840 pages=3D2</div><div>Jul 12 18:00:04 DRBD9_1 ke=
rnel: drbd r0/0 drbd1: recounting of set bits took additional 0ms</div><div=
>Jul 12 18:00:04 DRBD9_1 kernel: drbd r0/0 drbd1: Suspended AL updates</div=
><div>Jul 12 18:00:04 DRBD9_1 kernel: drbd r0/0 drbd1: disk( Attaching -&gt=
; Inconsistent )</div><div>Jul 12 18:00:04 DRBD9_1 kernel: drbd r0/0 drbd1:=
 attached to current UUID: 0000000000000004</div><div>Jul 12 18:00:04 DRBD9=
_1 systemd-udevd: error: /dev/drbd1: Wrong medium type</div><div>Jul 12 18:=
00:04 DRBD9_1 drbd: adjust disk: r0</div><div>Jul 12 18:00:04 DRBD9_1 kerne=
l: drbd r0 DRBD9_2: Starting sender thread (from drbdsetup [102653])</div><=
div>Jul 12 18:00:04 DRBD9_1 drbd: prepare net: r0</div><div>Jul 12 18:00:04=
 DRBD9_1 drbd: attempt to connect: r0</div><div>Jul 12 18:00:04 DRBD9_1 drb=
d: ]</div><div>Jul 12 18:00:04 DRBD9_1 kernel: drbd r0 DRBD9_2: conn( Stand=
Alone -&gt; Unconnected )</div><div>Jul 12 18:00:04 DRBD9_1 kernel: drbd r0=
 DRBD9_2: Starting receiver thread (from drbd_w_r0 [102644])</div><div>Jul =
12 18:00:04 DRBD9_1 kernel: drbd r0 DRBD9_2: conn( Unconnected -&gt; Connec=
ting )</div><div>Jul 12 18:00:04 DRBD9_1 kernel: drbd r0 DRBD9_2: Handshake=
 successful: Agreed network protocol version 111</div><div>Jul 12 18:00:04 =
DRBD9_1 kernel: drbd r0 DRBD9_2: Feature flags enabled on protocol level: 0=
x7 TRIM THIN_RESYNC WRITE_SAME.</div><div>Jul 12 18:00:04 DRBD9_1 kernel: d=
rbd r0 DRBD9_2: Starting ack_recv thread (from drbd_r_r0 [102662])</div><di=
v>Jul 12 18:00:04 DRBD9_1 kernel: drbd r0: Preparing cluster-wide state cha=
nge 480688786 (0-&gt;1 499/146)</div><div>Jul 12 18:00:04 DRBD9_1 kernel: d=
rbd r0: State change 480688786: primary_nodes=3D0, weak_nodes=3D0</div><div=
>Jul 12 18:00:04 DRBD9_1 kernel: drbd r0: Committing cluster-wide state cha=
nge 480688786 (3ms)</div><div>Jul 12 18:00:04 DRBD9_1 kernel: drbd r0 DRBD9=
_2: conn( Connecting -&gt; Connected ) peer( Unknown -&gt; Secondary )</div=
><div>Jul 12 18:00:04 DRBD9_1 kernel: drbd r0/0 drbd1: current_size: 430080=
</div><div>Jul 12 18:00:04 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_2: c_size:=
 450560 u_size: 0 d_size: 450560 max_size: 450560</div><div>Jul 12 18:00:04=
 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_2: la_size: 0 my_usize: 0</div><div>=
Jul 12 18:00:04 DRBD9_1 kernel: drbd r0/0 drbd1: my node_id: 0</div><div>Ju=
l 12 18:00:04 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_2: node_id: 1 idx: 0 bm=
-uuid: 0x0 flags: 0x0 max_size: 450560 (DUnknown)</div><div>Jul 12 18:00:04=
 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_2: calling drbd_determine_dev_size()=
</div><div>Jul 12 18:00:04 DRBD9_1 kernel: drbd r0/0 drbd1: my node_id: 0</=
div><div>Jul 12 18:00:04 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_2: node_id: =
1 idx: 0 bm-uuid: 0x0 flags: 0x0 max_size: 450560 (DUnknown)</div><div>Jul =
12 18:00:04 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_2: drbd_sync_handshake:</=
div><div>Jul 12 18:00:04 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_2: self 0000=
000000000004:0000000000000000:0000000000000000:0000000000000000 bits:53760 =
flags:0</div><div>Jul 12 18:00:04 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_2: =
peer 0000000000000004:0000000000000000:0000000000000000:0000000000000000 bi=
ts:56320 flags:24</div><div>Jul 12 18:00:04 DRBD9_1 kernel: drbd r0/0 drbd1=
 DRBD9_2: uuid_compare()=3D0 by rule 10</div><div>Jul 12 18:00:04 DRBD9_1 k=
ernel: drbd r0/0 drbd1: No resync, but 53760 bits in bitmap!</div><div>Jul =
12 18:00:04 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_2: pdsk( DUnknown -&gt; I=
nconsistent ) repl( Off -&gt; Established )</div><div>Jul 12 18:00:04 DRBD9=
_1 kernel: drbd r0/0 drbd1: Resumed AL updates</div><div>Jul 12 18:00:04 DR=
BD9_1 drbd: WARN: stdin/stdout is not a TTY; using /dev/consoledrbdadm: Unk=
nown command &#39;sh-b-pri&#39;</div><div>Jul 12 18:00:04 DRBD9_1 drbd: .</=
div><div>Jul 12 18:00:40 DRBD9_1 kernel: drbd r0: Preparing cluster-wide st=
ate change 3595219668 (0-&gt;-1 7683/4609)</div><div>Jul 12 18:00:40 DRBD9_=
1 kernel: drbd r0: State change 3595219668: primary_nodes=3D1, weak_nodes=
=3DFFFFFFFFFFFFFFFC</div><div>Jul 12 18:00:40 DRBD9_1 kernel: drbd r0: Comm=
itting cluster-wide state change 3595219668 (1ms)</div><div>Jul 12 18:00:40=
 DRBD9_1 kernel: drbd r0: role( Secondary -&gt; Primary )</div><div>Jul 12 =
18:00:40 DRBD9_1 kernel: drbd r0/0 drbd1: disk( Inconsistent -&gt; UpToDate=
 )</div><div>Jul 12 18:00:40 DRBD9_1 kernel: drbd r0/0 drbd1: size =3D 210 =
MB (215040 KB)</div><div>Jul 12 18:00:40 DRBD9_1 kernel: drbd r0: Forced to=
 consider local data as UpToDate!</div><div>Jul 12 18:00:40 DRBD9_1 kernel:=
 drbd r0/0 drbd1: new current UUID: E33ECAD77287E565 weak: FFFFFFFFFFFFFFFC=
</div><div>Jul 12 18:00:40 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_2: drbd_sy=
nc_handshake:</div><div>Jul 12 18:00:40 DRBD9_1 kernel: drbd r0/0 drbd1 DRB=
D9_2: self E33ECAD77287E565:0000000000000000:0000000000000000:0000000000000=
000 bits:53760 flags:0</div><div>Jul 12 18:00:40 DRBD9_1 kernel: drbd r0/0 =
drbd1 DRBD9_2: peer 0000000000000004:FFFFFFFFFFFFFFFF:0000000000000000:0000=
000000000000 bits:56320 flags:104</div><div>Jul 12 18:00:40 DRBD9_1 kernel:=
 drbd r0/0 drbd1 DRBD9_2: uuid_compare()=3D3 by rule 30</div><div>Jul 12 18=
:00:40 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_2: Writing the whole bitmap, f=
ull sync required after drbd_sync_handshake.</div><div>Jul 12 18:00:40 DRBD=
9_1 kernel: drbd r0/0 drbd1 DRBD9_2: repl( Established -&gt; WFBitMapS )</d=
iv><div>Jul 12 18:00:40 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_2: send bitma=
p stats [Bytes(packets)]: plain 0(0), RLE 21(1), total 21; compression: 99.=
7%</div></div><div><br></div><div><div><br></div><div><br></div><div><br></=
div><div><br></div><div><div>Jul 12 17:59:57 DRBD9_2 drbd: Starting DRBD re=
sources: [</div><div>Jul 12 17:59:57 DRBD9_2 drbd: create res: r0</div><div=
>Jul 12 17:59:57 DRBD9_2 kernel: drbd r0: Starting worker thread (from drbd=
setup [83726])</div><div>Jul 12 17:59:57 DRBD9_2 systemd-udevd: error: /dev=
/drbd1: Wrong medium type</div><div>Jul 12 17:59:57 DRBD9_2 drbd: prepare d=
isk: r0</div><div>Jul 12 17:59:57 DRBD9_2 kernel: drbd r0/0 drbd1: disk( Di=
skless -&gt; Attaching )</div><div>Jul 12 17:59:57 DRBD9_2 kernel: drbd r0/=
0 drbd1: Maximum number of peer devices =3D 1</div><div>Jul 12 17:59:57 DRB=
D9_2 kernel: drbd r0: Method to ensure write ordering: flush</div><div>Jul =
12 17:59:57 DRBD9_2 kernel: drbd r0/0 drbd1: my node_id: 1</div><div>Jul 12=
 17:59:57 DRBD9_2 kernel: drbd r0/0 drbd1: Adjusting my ra_pages to backing=
 device&#39;s (32 -&gt; 1024)</div><div>Jul 12 17:59:57 DRBD9_2 kernel: drb=
d r0/0 drbd1: my node_id: 1</div><div>Jul 12 17:59:57 DRBD9_2 kernel: drbd =
r0/0 drbd1: drbd_bm_resize called with capacity =3D=3D 450560</div><div>Jul=
 12 17:59:57 DRBD9_2 kernel: drbd r0/0 drbd1: resync bitmap: bits=3D56320 w=
ords=3D880 pages=3D2</div><div>Jul 12 17:59:57 DRBD9_2 kernel: drbd r0/0 dr=
bd1: recounting of set bits took additional 0ms</div><div>Jul 12 17:59:57 D=
RBD9_2 kernel: drbd r0/0 drbd1: Suspended AL updates</div><div>Jul 12 17:59=
:57 DRBD9_2 kernel: drbd r0/0 drbd1: disk( Attaching -&gt; Inconsistent )</=
div><div>Jul 12 17:59:57 DRBD9_2 kernel: drbd r0/0 drbd1: attached to curre=
nt UUID: 0000000000000004</div><div>Jul 12 17:59:57 DRBD9_2 drbd: adjust di=
sk: r0</div><div>Jul 12 17:59:57 DRBD9_2 systemd-udevd: error: /dev/drbd1: =
Wrong medium type</div><div>Jul 12 17:59:57 DRBD9_2 kernel: drbd r0 DRBD9_1=
: Starting sender thread (from drbdsetup [83737])</div><div>Jul 12 17:59:57=
 DRBD9_2 drbd: prepare net: r0</div><div>Jul 12 17:59:57 DRBD9_2 drbd: atte=
mpt to connect: r0</div><div>Jul 12 17:59:57 DRBD9_2 drbd: ]</div><div>Jul =
12 17:59:57 DRBD9_2 kernel: drbd r0 DRBD9_1: conn( StandAlone -&gt; Unconne=
cted )</div><div>Jul 12 17:59:57 DRBD9_2 kernel: drbd r0 DRBD9_1: Starting =
receiver thread (from drbd_w_r0 [83727])</div><div>Jul 12 17:59:58 DRBD9_2 =
kernel: drbd r0 DRBD9_1: conn( Unconnected -&gt; Connecting )</div><div>Jul=
 12 18:00:04 DRBD9_2 kernel: drbd r0 DRBD9_1: Handshake successful: Agreed =
network protocol version 111</div><div>Jul 12 18:00:04 DRBD9_2 kernel: drbd=
 r0 DRBD9_1: Feature flags enabled on protocol level: 0x7 TRIM THIN_RESYNC =
WRITE_SAME.</div><div>Jul 12 18:00:04 DRBD9_2 kernel: drbd r0 DRBD9_1: Star=
ting ack_recv thread (from drbd_r_r0 [83745])</div><div>Jul 12 18:00:04 DRB=
D9_2 kernel: drbd r0 DRBD9_1: Preparing remote state change 480688786 (prim=
ary_nodes=3D0, weak_nodes=3D0)</div><div>Jul 12 18:00:04 DRBD9_2 kernel: dr=
bd r0 DRBD9_1: Committing remote state change 480688786</div><div>Jul 12 18=
:00:04 DRBD9_2 kernel: drbd r0 DRBD9_1: conn( Connecting -&gt; Connected ) =
peer( Unknown -&gt; Secondary )</div><div>Jul 12 18:00:04 DRBD9_2 kernel: d=
rbd r0/0 drbd1: current_size: 450560</div><div>Jul 12 18:00:04 DRBD9_2 kern=
el: drbd r0/0 drbd1 DRBD9_1: c_size: 430080 u_size: 0 d_size: 430080 max_si=
ze: 430080</div><div>Jul 12 18:00:04 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_=
1: la_size: 0 my_usize: 0</div><div>Jul 12 18:00:04 DRBD9_2 kernel: drbd r0=
/0 drbd1 DRBD9_1: node_id: 0 idx: 0 bm-uuid: 0x0 flags: 0x0 max_size: 43008=
0 (DUnknown)</div><div>Jul 12 18:00:04 DRBD9_2 kernel: drbd r0/0 drbd1: my =
node_id: 1</div><div>Jul 12 18:00:04 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_=
1: calling drbd_determine_dev_size()</div><div>Jul 12 18:00:04 DRBD9_2 kern=
el: drbd r0/0 drbd1 DRBD9_1: node_id: 0 idx: 0 bm-uuid: 0x0 flags: 0x0 max_=
size: 430080 (DUnknown)</div><div>Jul 12 18:00:04 DRBD9_2 kernel: drbd r0/0=
 drbd1: my node_id: 1</div><div>Jul 12 18:00:04 DRBD9_2 kernel: drbd r0/0 d=
rbd1 DRBD9_1: drbd_sync_handshake:</div><div>Jul 12 18:00:04 DRBD9_2 kernel=
: drbd r0/0 drbd1 DRBD9_1: self 0000000000000004:0000000000000000:000000000=
0000000:0000000000000000 bits:56320 flags:0</div><div>Jul 12 18:00:04 DRBD9=
_2 kernel: drbd r0/0 drbd1 DRBD9_1: peer 0000000000000004:0000000000000000:=
0000000000000000:0000000000000000 bits:53760 flags:24</div><div>Jul 12 18:0=
0:04 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_1: uuid_compare()=3D0 by rule 10=
</div><div>Jul 12 18:00:04 DRBD9_2 kernel: drbd r0/0 drbd1: No resync, but =
56320 bits in bitmap!</div><div>Jul 12 18:00:04 DRBD9_2 kernel: drbd r0/0 d=
rbd1 DRBD9_1: pdsk( DUnknown -&gt; Inconsistent ) repl( Off -&gt; Establish=
ed )</div><div>Jul 12 18:00:04 DRBD9_2 kernel: drbd r0/0 drbd1: Resumed AL =
updates</div><div>Jul 12 18:00:04 DRBD9_2 drbd: WARN: stdin/stdout is not a=
 TTY; using /dev/consoledrbdadm: Unknown command &#39;sh-b-pri&#39;</div><d=
iv>Jul 12 18:00:04 DRBD9_2 drbd: .</div><div>Jul 12 18:00:40 DRBD9_2 kernel=
: drbd r0 DRBD9_1: Preparing remote state change 3595219668 (primary_nodes=
=3D0, weak_nodes=3D0)</div><div>Jul 12 18:00:40 DRBD9_2 kernel: drbd r0 DRB=
D9_1: Committing remote state change 3595219668</div><div>Jul 12 18:00:40 D=
RBD9_2 kernel: drbd r0 DRBD9_1: peer( Secondary -&gt; Primary )</div><div>J=
ul 12 18:00:40 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_1: pdsk( Inconsistent =
-&gt; UpToDate )</div><div>Jul 12 18:00:40 DRBD9_2 kernel: drbd r0/0 drbd1:=
 size =3D 220 MB (225280 KB)</div><div>Jul 12 18:00:40 DRBD9_2 kernel: drbd=
 r0/0 drbd1 DRBD9_1: drbd_sync_handshake:</div><div>Jul 12 18:00:40 DRBD9_2=
 kernel: drbd r0/0 drbd1 DRBD9_1: self 0000000000000004:0000000000000000:00=
00000000000000:0000000000000000 bits:56320 flags:0</div><div>Jul 12 18:00:4=
0 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_1: peer E33ECAD77287E565:FFFFFFFFFF=
FFFFFF:0000000000000000:0000000000000000 bits:53760 flags:120</div><div>Jul=
 12 18:00:40 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_1: uuid_compare()=3D-3 b=
y rule 20</div><div>Jul 12 18:00:40 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_1=
: Writing the whole bitmap, full sync required after drbd_sync_handshake.</=
div><div>Jul 12 18:00:40 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_1: repl( Est=
ablished -&gt; WFBitMapT )</div><div>Jul 12 18:00:40 DRBD9_2 kernel: drbd r=
0/0 drbd1 DRBD9_1: s(53760) bit_offset(53760) word_offset(840) bm_bits(5632=
0)</div><div>Jul 12 18:00:40 DRBD9_2 kernel: drbd r0/0 drbd1: after decode_=
bitmap_c() err(1)</div></div>-- <br><div class=3D"gmail_signature" data-sma=
rtmail=3D"gmail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr"><div><div=
 dir=3D"ltr"><div><div dir=3D"ltr"><div><div dir=3D"ltr"><img src=3D"cid:im=
age001.png@01D0F522.B2A586F0"><br><div><p style=3D"margin:0cm 0cm 0.0001pt;=
background-image:initial;background-repeat:initial"><font face=3D"verdana, =
sans-serif"><span style=3D"font-size:10pt;color:black"><span lang=3D"EN-US"=
>=EA=B8=B0=EC=88=A0=EC=97=B0=EA=B5=AC=EC=86=8C=C2=A0</span><span lang=3D"EN=
-US">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Mobile=
=C2=A0: 010-4762-0519</span></span><span lang=3D"EN-US" style=3D"font-size:=
10.5pt;color:rgb(136,136,136)"></span></font></p><p style=3D"margin:0cm 0cm=
 0pt"></p><p style=3D"margin:0cm 0cm 0.0001pt;background-image:initial;back=
ground-repeat:initial"><font face=3D"verdana, sans-serif"><b><span style=3D=
"font-size:10.5pt;color:black">=EB=B0=95 =EA=B2=BD =EB=AF=BC<span lang=3D"E=
N-US">=C2=A0=EC=B0=A8=EC=9E=A5</span></span></b><span style=3D"font-size:10=
pt;color:black"><span lang=3D"EN-US">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 kmpak</span></span><span lang=3D"EN-US" style=3D"font-size:10pt;=
color:black">@<a href=3D"http://mantech.co.kr/" style=3D"color:rgb(17,85,20=
4)" target=3D"_blank">mantech.co.kr</a></span><span lang=3D"EN-US" style=3D=
"font-size:10.5pt;color:rgb(136,136,136)"></span></font></p><p style=3D"mar=
gin:0cm 0cm 0.0001pt;line-height:21px"><font color=3D"#000000" face=3D"verd=
ana, sans-serif"><span style=3D"font-size:8pt;line-height:16px">=EC=84=9C=
=EC=9A=B8=ED=8A=B9=EB=B3=84=EC=8B=9C =EC=84=B1=EB=8F=99=EA=B5=AC =EC=84=B1=
=EC=88=98=EC=9D=BC=EB=A1=9C<span lang=3D"EN-US">4</span>=EA=B8=B8<span lang=
=3D"EN-US">=C2=A025=C2=A0</span>=EC=84=9C=EC=9A=B8=EC=88=B2=EC=BD=94=EC=98=
=A4=EB=A1=B1=EB=94=94=EC=A7=80=ED=84=B8=ED=83=80=EC=9B=8C<span lang=3D"EN-U=
S">=C2=A012</span>=EC=B8=B5<span lang=3D"EN-US">=C2=A0</span></span><span l=
ang=3D"EN-US" style=3D"font-size:8pt;line-height:16px">=C2=A0 =C2=A0 =C2=A0=
=C2=A0</span></font></p><p style=3D"margin:0cm 0cm 0.0001pt;line-height:21p=
x"><font color=3D"#000000" face=3D"verdana, sans-serif"><span lang=3D"EN-US=
" style=3D"font-size:8pt;line-height:16px">Fax : 02-575-4858 / Tel : (02) 2=
136-6978 (978)</span></font></p><p style=3D"margin:0cm 0cm 0.0001pt;line-he=
ight:21px"><font color=3D"#000000" face=3D"verdana, sans-serif"><span lang=
=3D"EN-US" style=3D"font-size:8pt;line-height:16px"><span></span><span></sp=
an><img src=3D"cid:image002.png@01D126A1.B8986400"><br></span></font></p></=
div></div></div></div></div></div></div></div></div></div></div>
</div></div></div><div hspace=3D"streak-pt-mark" style=3D"max-height:1px"><=
img style=3D"width:0px;max-height:0px;overflow:hidden" src=3D"https://mailf=
oogae.appspot.com/t?sender=3Daa21wYWtAbWFudGVjaC5jby5rcg%3D%3D&amp;type=3Dz=
erocontent&amp;guid=3Db6c752e5-8cb5-44e9-8bf3-b6788a08399a"><font color=3D"=
#ffffff" size=3D"1">=E1=90=A7</font></div>

--001a1141aa2e46effd05376cab12--

--001a1141aa2e46efff05376cab13
Content-Type: image/png; name="image002.png"
Content-Disposition: inline; filename="image002.png"
Content-Transfer-Encoding: base64
Content-ID: <image002.png@01D126A1.B8986400>
X-Attachment-Id: 23ec20a5a925061b_0.2

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
--001a1141aa2e46efff05376cab13
Content-Type: image/png; name="image001.png"
Content-Disposition: inline; filename="image001.png"
Content-Transfer-Encoding: base64
Content-ID: <image001.png@01D0F522.B2A586F0>
X-Attachment-Id: 1b04d787799a09e8_0.0.1

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
--001a1141aa2e46efff05376cab13--
