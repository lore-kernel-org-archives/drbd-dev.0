Return-Path: <manowar@gsc-game.com>
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com
	[209.85.217.42])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id E9002420197
	for <drbd-dev@lists.linbit.com>; Sat,  2 Sep 2023 22:31:18 +0200 (CEST)
Received: by mail-vs1-f42.google.com with SMTP id
	ada2fe7eead31-44d4c3fa6a6so98585137.0
	for <drbd-dev@lists.linbit.com>; Sat, 02 Sep 2023 13:31:18 -0700 (PDT)
MIME-Version: 1.0
From: Serguei Ivantsov <manowar@gsc-game.com>
Date: Sat, 2 Sep 2023 22:31:06 +0200
Message-ID: <CAKH+VT2PQc3NoMZ0Lj13-mRu=kqSHJx_OSQtURB=xvo18jXq1g@mail.gmail.com>
To: stable@vger.kernel.org
Content-Type: multipart/alternative; boundary="000000000000ccfb4106046628cc"
Cc: kuba@kernel.org, regressions@lists.linux.dev, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] DRBD broken in kernel 6.5 and 6.5.1
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

--000000000000ccfb4106046628cc
Content-Type: text/plain; charset="UTF-8"

Hello,

After upgrading the kernel to 6.5 the system can't connect to the peer
(6.4.11) anymore.
I checked 6.5.1 - same issue.
All previous kernels including 6.4.14 are working just fine.
Checking the 6.5 changelog, I found commit
9ae440b8fdd6772b6c007fa3d3766530a09c9045 which mentioned some changes to
DRBD.

On the 6.5.X system I have the following in the kernel log (drbd_send_block()
failed):

[    2.473497] drbd: initialized. Version: 8.4.11 (api:1/proto:86-101)

[    2.475394] drbd: built-in

[    2.477254] drbd: registered as block device major 147

[    7.421400] drbd drbd0: Starting worker thread (from drbdsetup-84 [3844])

[    7.421509] drbd drbd0/0 drbd0: disk( Diskless -> Attaching )

[    7.421552] drbd drbd0: Method to ensure write ordering: flush

[    7.421554] drbd drbd0/0 drbd0: max BIO size = 131072

[    7.421557] drbd drbd0/0 drbd0: drbd_bm_resize called with capacity ==
1845173184

[    7.428017] drbd drbd0/0 drbd0: resync bitmap: bits=230646648
words=3603854 pages=7039

[    7.467370] drbd0: detected capacity change from 0 to 1845173184

[    7.467372] drbd drbd0/0 drbd0: size = 880 GB (922586592 KB)

[    7.486005] drbd drbd0/0 drbd0: recounting of set bits took additional 0
jiffies

[    7.486010] drbd drbd0/0 drbd0: 0 KB (0 bits) marked out-of-sync by on
disk bit-map.

[    7.486017] drbd drbd0/0 drbd0: disk( Attaching -> UpToDate )

[    7.486021] drbd drbd0/0 drbd0: attached to UUIDs
32DDB2019708F68A:0000000000000000:7D97648599B446DD:7D96648599B446DD

[    7.486863] drbd drbd0: conn( StandAlone -> Unconnected )

[    7.486871] drbd drbd0: Starting receiver thread (from drbd_w_drbd0
[3847])

[    7.486918] drbd drbd0: receiver (re)started

[    7.486929] drbd drbd0: conn( Unconnected -> WFConnection )

[   12.340212] drbd drbd0: initial packet S crossed

[   22.310856] drbd drbd0: Handshake successful: Agreed network protocol
version 101

[   22.311087] drbd drbd0: Feature flags enabled on protocol level: 0xf
TRIM THIN_RESYNC WRITE_SAME WRITE_ZEROES.

[   22.311425] drbd drbd0: conn( WFConnection -> WFReportParams )

[   22.311621] drbd drbd0: Starting ack_recv thread (from drbd_r_drbd0
[4071])

[   22.400702] drbd drbd0/0 drbd0: drbd_sync_handshake:

[   22.400869] drbd drbd0/0 drbd0: self
32DDB2019708F68A:0000000000000000:7D97648599B446DD:7D96648599B446DD bits:0
flags:0

[   22.401205] drbd drbd0/0 drbd0: peer
32DDB2019708F68A:0000000000000000:7D97648599B446DC:7D96648599B446DD bits:0
flags:0

[   22.401538] drbd drbd0/0 drbd0: uuid_compare()=0 by rule 40

[   22.401709] drbd drbd0/0 drbd0: peer( Unknown -> Secondary ) conn(
WFReportParams -> Connected ) pdsk( DUnknown -> UpToDate )

[   22.415394] drbd drbd0/0 drbd0: role( Secondary -> Primary )

[   22.506540] drbd drbd0/0 drbd0: _drbd_send_page: size=4096 len=4096
sent=-5

[   22.506773] drbd drbd0: peer( Secondary -> Unknown ) conn( Connected ->
NetworkFailure ) pdsk( UpToDate -> DUnknown )

[   22.507109] drbd drbd0/0 drbd0: new current UUID
7F8B15C04AF49C4D:32DDB2019708F68B:7D97648599B446DD:7D96648599B446DD

[   22.507451] drbd drbd0: ack_receiver terminated

[   22.507588] drbd drbd0: Terminating drbd_a_drbd0

[   22.600693] drbd drbd0: Connection closed

[   22.600937] drbd drbd0: conn( NetworkFailure -> Unconnected )

[   22.601115] drbd drbd0: receiver terminated

[   22.601238] drbd drbd0: Restarting receiver thread

[   22.601378] drbd drbd0: receiver (re)started

[   22.601508] drbd drbd0: conn( Unconnected -> WFConnection )

[   23.260624] drbd drbd0: Handshake successful: Agreed network protocol
version 101

[   23.260859] drbd drbd0: Feature flags enabled on protocol level: 0xf
TRIM THIN_RESYNC WRITE_SAME WRITE_ZEROES.

[   23.261187] drbd drbd0: conn( WFConnection -> WFReportParams )

[   23.261367] drbd drbd0: Starting ack_recv thread (from drbd_r_drbd0
[4071])

[   23.340593] drbd drbd0/0 drbd0: drbd_sync_handshake:

[   23.340771] drbd drbd0/0 drbd0: self
7F8B15C04AF49C4D:32DDB2019708F68B:7D97648599B446DD:7D96648599B446DD bits:1
flags:0

[   23.341192] drbd drbd0/0 drbd0: peer
32DDB2019708F68A:0000000000000000:7D97648599B446DC:7D96648599B446DD bits:0
flags:0

[   23.341649] drbd drbd0/0 drbd0: uuid_compare()=1 by rule 70

[   23.341824] drbd drbd0/0 drbd0: peer( Unknown -> Secondary ) conn(
WFReportParams -> WFBitMapS ) pdsk( DUnknown -> Consistent )

[   23.344911] drbd drbd0/0 drbd0: send bitmap stats [Bytes(packets)]:
plain 0(0), RLE 23(1), total 23; compression: 100.0%

[   23.396792] drbd drbd0/0 drbd0: receive bitmap stats [Bytes(packets)]:
plain 0(0), RLE 23(1), total 23; compression: 100.0%

[   23.397210] drbd drbd0/0 drbd0: helper command: /sbin/drbdadm
before-resync-source minor-0

[   23.407965] drbd drbd0/0 drbd0: helper command: /sbin/drbdadm
before-resync-source minor-0 exit code 0 (0x0)

[   23.417547] drbd drbd0/0 drbd0: conn( WFBitMapS -> SyncSource ) pdsk(
Consistent -> Inconsistent )

[   23.426697] drbd drbd0/0 drbd0: Began resync as SyncSource (will sync 4
KB [1 bits set]).

[   23.435638] drbd drbd0/0 drbd0: updated sync UUID
7F8B15C04AF49C4D:32DEB2019708F68B:32DDB2019708F68B:7D97648599B446DD

[   23.488608] drbd drbd0/0 drbd0: _drbd_send_page: size=4096 len=4096
sent=-5

[   23.498182] drbd drbd0/0 drbd0: drbd_send_block() failed

[   23.508498] drbd drbd0: peer( Secondary -> Unknown ) conn( SyncSource ->
NetworkFailure )

[   23.517597] drbd drbd0: ack_receiver terminated

[   23.527513] drbd drbd0: Terminating drbd_a_drbd0

[   23.690598] drbd drbd0: Connection closed

[   23.701857] drbd drbd0: conn( NetworkFailure -> Unconnected )

[   23.712017] drbd drbd0: receiver terminated

[   23.721597] drbd drbd0: Restarting receiver thread



On the peer:


[349071.038278] drbd drbd0: conn( Unconnected -> WFConnection )

[349071.558245] drbd drbd0: Handshake successful: Agreed network protocol
version 101

[349071.562105] drbd drbd0: Feature flags enabled on protocol level: 0xf
TRIM THIN_RESYNC WRITE_SAME WRITE_ZEROES.

[349071.569889] drbd drbd0: conn( WFConnection -> WFReportParams )

[349071.573802] drbd drbd0: Starting ack_recv thread (from drbd_r_drbd0
[2660])

[349071.688547] drbd drbd0/0 drbd0: drbd_sync_handshake:

[349071.692323] drbd drbd0/0 drbd0: self
3375B2019708F68A:0000000000000000:7D97648599B446DC:7D96648599B446DD bits:1
flags:0

[349071.699871] drbd drbd0/0 drbd0: peer
7F8B15C04AF49C4D:3375B2019708F68B:3374B2019708F68B:3373B2019708F68B bits:1
flags:0

[349071.707687] drbd drbd0/0 drbd0: uuid_compare()=-1 by rule 50

[349071.711563] drbd drbd0/0 drbd0: Becoming sync target due to disk states.

[349071.715381] drbd drbd0/0 drbd0: peer( Unknown -> Primary ) conn(
WFReportParams -> WFBitMapT ) pdsk( DUnknown -> UpToDate )

[349071.723039] drbd drbd0/0 drbd0: receive bitmap stats [Bytes(packets)]:
plain 0(0), RLE 23(1), total 23; compression: 100.0%

[349071.732489] drbd drbd0/0 drbd0: send bitmap stats [Bytes(packets)]:
plain 0(0), RLE 23(1), total 23; compression: 100.0%

[349071.740178] drbd drbd0/0 drbd0: conn( WFBitMapT -> WFSyncUUID )

[349071.787113] drbd drbd0/0 drbd0: updated sync uuid
3376B2019708F68A:0000000000000000:7D97648599B446DC:7D96648599B446DD

[349071.794907] drbd drbd0/0 drbd0: helper command: /sbin/drbdadm
before-resync-target minor-0

[349071.800006] drbd drbd0/0 drbd0: helper command: /sbin/drbdadm
before-resync-target minor-0 exit code 0 (0x0)

[349071.807737] drbd drbd0/0 drbd0: conn( WFSyncUUID -> SyncTarget )

[349071.811639] drbd drbd0/0 drbd0: Began resync as SyncTarget (will sync 4
KB [1 bits set]).

[349071.916117] drbd drbd0: sock was shut down by peer

[349071.919955] drbd drbd0: peer( Primary -> Unknown ) conn( SyncTarget ->
BrokenPipe ) pdsk( UpToDate -> DUnknown )

[349071.927796] drbd drbd0: short read (expected size 4096)

[349071.931812] drbd drbd0: error receiving RSDataReply, e: -5 l: 4096!

[349071.935864] drbd drbd0: ack_receiver terminated

[349071.939906] drbd drbd0: Terminating drbd_a_drbd0

[349072.088385] drbd drbd0: Connection closed

[349072.092398] drbd drbd0: conn( BrokenPipe -> Unconnected )

[349072.096436] drbd drbd0: receiver terminated

[349072.100469] drbd drbd0: Restarting receiver thread

[349072.104454] drbd drbd0: receiver (re)started

[349072.108373] drbd drbd0: conn( Unconnected -> WFConnection )


--

 Best Regards,

 Serguei

--000000000000ccfb4106046628cc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello,<div><br></div><div>After upgrading the kernel to 6.=
5 the system can&#39;t connect to the peer (6.4.11) anymore.</div><div>I ch=
ecked 6.5.1 - same issue.</div><div>All previous kernels including=C2=A06.4=
.14 are working just fine.</div><div>Checking the 6.5 changelog, I found co=
mmit 9ae440b8fdd6772b6c007fa3d3766530a09c9045 which mentioned some changes =
to DRBD.</div><div><br></div><div>On the 6.5.X system I have the following =
in the kernel log (<span style=3D"font-family:&quot;Helvetica Neue&quot;;fo=
nt-size:13px">drbd_send_block() failed</span>):</div><div><br></div>





<div>





<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:13px;line-height=
:normal;font-family:&quot;Helvetica Neue&quot;">[<span class=3D"gmail-Apple=
-converted-space">=C2=A0 =C2=A0 </span>2.473497] drbd: initialized. Version=
: 8.4.11 (api:1/proto:86-101)</p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:13px;line-height=
:normal;font-family:&quot;Helvetica Neue&quot;">[<span class=3D"gmail-Apple=
-converted-space">=C2=A0 =C2=A0 </span>2.475394] drbd: built-in</p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:13px;line-height=
:normal;font-family:&quot;Helvetica Neue&quot;">[<span class=3D"gmail-Apple=
-converted-space">=C2=A0 =C2=A0 </span>2.477254] drbd: registered as block =
device major 147</p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:13px;line-height=
:normal;font-family:&quot;Helvetica Neue&quot;">[<span class=3D"gmail-Apple=
-converted-space">=C2=A0 =C2=A0 </span>7.421400] drbd drbd0: Starting worke=
r thread (from drbdsetup-84 [3844])</p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:13px;line-height=
:normal;font-family:&quot;Helvetica Neue&quot;">[<span class=3D"gmail-Apple=
-converted-space">=C2=A0 =C2=A0 </span>7.421509] drbd drbd0/0 drbd0: disk( =
Diskless -&gt; Attaching )</p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:13px;line-height=
:normal;font-family:&quot;Helvetica Neue&quot;">[<span class=3D"gmail-Apple=
-converted-space">=C2=A0 =C2=A0 </span>7.421552] drbd drbd0: Method to ensu=
re write ordering: flush</p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:13px;line-height=
:normal;font-family:&quot;Helvetica Neue&quot;">[<span class=3D"gmail-Apple=
-converted-space">=C2=A0 =C2=A0 </span>7.421554] drbd drbd0/0 drbd0: max BI=
O size =3D 131072</p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:13px;line-height=
:normal;font-family:&quot;Helvetica Neue&quot;">[<span class=3D"gmail-Apple=
-converted-space">=C2=A0 =C2=A0 </span>7.421557] drbd drbd0/0 drbd0: drbd_b=
m_resize called with capacity =3D=3D 1845173184</p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:13px;line-height=
:normal;font-family:&quot;Helvetica Neue&quot;">[<span class=3D"gmail-Apple=
-converted-space">=C2=A0 =C2=A0 </span>7.428017] drbd drbd0/0 drbd0: resync=
 bitmap: bits=3D230646648 words=3D3603854 pages=3D7039</p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:13px;line-height=
:normal;font-family:&quot;Helvetica Neue&quot;">[<span class=3D"gmail-Apple=
-converted-space">=C2=A0 =C2=A0 </span>7.467370] drbd0: detected capacity c=
hange from 0 to 1845173184</p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:13px;line-height=
:normal;font-family:&quot;Helvetica Neue&quot;">[<span class=3D"gmail-Apple=
-converted-space">=C2=A0 =C2=A0 </span>7.467372] drbd drbd0/0 drbd0: size =
=3D 880 GB (922586592 KB)</p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:13px;line-height=
:normal;font-family:&quot;Helvetica Neue&quot;">[<span class=3D"gmail-Apple=
-converted-space">=C2=A0 =C2=A0 </span>7.486005] drbd drbd0/0 drbd0: recoun=
ting of set bits took additional 0 jiffies</p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:13px;line-height=
:normal;font-family:&quot;Helvetica Neue&quot;">[<span class=3D"gmail-Apple=
-converted-space">=C2=A0 =C2=A0 </span>7.486010] drbd drbd0/0 drbd0: 0 KB (=
0 bits) marked out-of-sync by on disk bit-map.</p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:13px;line-height=
:normal;font-family:&quot;Helvetica Neue&quot;">[<span class=3D"gmail-Apple=
-converted-space">=C2=A0 =C2=A0 </span>7.486017] drbd drbd0/0 drbd0: disk( =
Attaching -&gt; UpToDate )</p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:13px;line-height=
:normal;font-family:&quot;Helvetica Neue&quot;">[<span class=3D"gmail-Apple=
-converted-space">=C2=A0 =C2=A0 </span>7.486021] drbd drbd0/0 drbd0: attach=
ed to UUIDs 32DDB2019708F68A:0000000000000000:7D97648599B446DD:7D96648599B4=
46DD</p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:13px;line-height=
:normal;font-family:&quot;Helvetica Neue&quot;">[<span class=3D"gmail-Apple=
-converted-space">=C2=A0 =C2=A0 </span>7.486863] drbd drbd0: conn( StandAlo=
ne -&gt; Unconnected )</p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:13px;line-height=
:normal;font-family:&quot;Helvetica Neue&quot;">[<span class=3D"gmail-Apple=
-converted-space">=C2=A0 =C2=A0 </span>7.486871] drbd drbd0: Starting recei=
ver thread (from drbd_w_drbd0 [3847])</p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:13px;line-height=
:normal;font-family:&quot;Helvetica Neue&quot;">[<span class=3D"gmail-Apple=
-converted-space">=C2=A0 =C2=A0 </span>7.486918] drbd drbd0: receiver (re)s=
tarted</p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:13px;line-height=
:normal;font-family:&quot;Helvetica Neue&quot;">[<span class=3D"gmail-Apple=
-converted-space">=C2=A0 =C2=A0 </span>7.486929] drbd drbd0: conn( Unconnec=
ted -&gt; WFConnection )</p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:13px;line-height=
:normal;font-family:&quot;Helvetica Neue&quot;">[ <span class=3D"gmail-Appl=
e-converted-space">=C2=A0 </span>12.340212] drbd drbd0: initial packet S cr=
ossed</p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:13px;line-height=
:normal;font-family:&quot;Helvetica Neue&quot;">[ <span class=3D"gmail-Appl=
e-converted-space">=C2=A0 </span>22.310856] drbd drbd0: Handshake successfu=
l: Agreed network protocol version 101</p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:13px;line-height=
:normal;font-family:&quot;Helvetica Neue&quot;">[ <span class=3D"gmail-Appl=
e-converted-space">=C2=A0 </span>22.311087] drbd drbd0: Feature flags enabl=
ed on protocol level: 0xf TRIM THIN_RESYNC WRITE_SAME WRITE_ZEROES.</p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:13px;line-height=
:normal;font-family:&quot;Helvetica Neue&quot;">[ <span class=3D"gmail-Appl=
e-converted-space">=C2=A0 </span>22.311425] drbd drbd0: conn( WFConnection =
-&gt; WFReportParams )</p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:13px;line-height=
:normal;font-family:&quot;Helvetica Neue&quot;">[ <span class=3D"gmail-Appl=
e-converted-space">=C2=A0 </span>22.311621] drbd drbd0: Starting ack_recv t=
hread (from drbd_r_drbd0 [4071])</p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:13px;line-height=
:normal;font-family:&quot;Helvetica Neue&quot;">[ <span class=3D"gmail-Appl=
e-converted-space">=C2=A0 </span>22.400702] drbd drbd0/0 drbd0: drbd_sync_h=
andshake:</p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:13px;line-height=
:normal;font-family:&quot;Helvetica Neue&quot;">[ <span class=3D"gmail-Appl=
e-converted-space">=C2=A0 </span>22.400869] drbd drbd0/0 drbd0: self 32DDB2=
019708F68A:0000000000000000:7D97648599B446DD:7D96648599B446DD bits:0 flags:=
0</p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:13px;line-height=
:normal;font-family:&quot;Helvetica Neue&quot;">[ <span class=3D"gmail-Appl=
e-converted-space">=C2=A0 </span>22.401205] drbd drbd0/0 drbd0: peer 32DDB2=
019708F68A:0000000000000000:7D97648599B446DC:7D96648599B446DD bits:0 flags:=
0</p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:13px;line-height=
:normal;font-family:&quot;Helvetica Neue&quot;">[ <span class=3D"gmail-Appl=
e-converted-space">=C2=A0 </span>22.401538] drbd drbd0/0 drbd0: uuid_compar=
e()=3D0 by rule 40</p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:13px;line-height=
:normal;font-family:&quot;Helvetica Neue&quot;">[ <span class=3D"gmail-Appl=
e-converted-space">=C2=A0 </span>22.401709] drbd drbd0/0 drbd0: peer( Unkno=
wn -&gt; Secondary ) conn( WFReportParams -&gt; Connected ) pdsk( DUnknown =
-&gt; UpToDate )</p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:13px;line-height=
:normal;font-family:&quot;Helvetica Neue&quot;">[ <span class=3D"gmail-Appl=
e-converted-space">=C2=A0 </span>22.415394] drbd drbd0/0 drbd0: role( Secon=
dary -&gt; Primary )</p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:13px;line-height=
:normal;font-family:&quot;Helvetica Neue&quot;">[ <span class=3D"gmail-Appl=
e-converted-space">=C2=A0 </span>22.506540] drbd drbd0/0 drbd0: _drbd_send_=
page: size=3D4096 len=3D4096 sent=3D-5</p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:13px;line-height=
:normal;font-family:&quot;Helvetica Neue&quot;">[ <span class=3D"gmail-Appl=
e-converted-space">=C2=A0 </span>22.506773] drbd drbd0: peer( Secondary -&g=
t; Unknown ) conn( Connected -&gt; NetworkFailure ) pdsk( UpToDate -&gt; DU=
nknown )</p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:13px;line-height=
:normal;font-family:&quot;Helvetica Neue&quot;">[ <span class=3D"gmail-Appl=
e-converted-space">=C2=A0 </span>22.507109] drbd drbd0/0 drbd0: new current=
 UUID 7F8B15C04AF49C4D:32DDB2019708F68B:7D97648599B446DD:7D96648599B446DD</=
p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:13px;line-height=
:normal;font-family:&quot;Helvetica Neue&quot;">[ <span class=3D"gmail-Appl=
e-converted-space">=C2=A0 </span>22.507451] drbd drbd0: ack_receiver termin=
ated</p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:13px;line-height=
:normal;font-family:&quot;Helvetica Neue&quot;">[ <span class=3D"gmail-Appl=
e-converted-space">=C2=A0 </span>22.507588] drbd drbd0: Terminating drbd_a_=
drbd0</p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:13px;line-height=
:normal;font-family:&quot;Helvetica Neue&quot;">[ <span class=3D"gmail-Appl=
e-converted-space">=C2=A0 </span>22.600693] drbd drbd0: Connection closed</=
p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:13px;line-height=
:normal;font-family:&quot;Helvetica Neue&quot;">[ <span class=3D"gmail-Appl=
e-converted-space">=C2=A0 </span>22.600937] drbd drbd0: conn( NetworkFailur=
e -&gt; Unconnected )</p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:13px;line-height=
:normal;font-family:&quot;Helvetica Neue&quot;">[ <span class=3D"gmail-Appl=
e-converted-space">=C2=A0 </span>22.601115] drbd drbd0: receiver terminated=
</p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:13px;line-height=
:normal;font-family:&quot;Helvetica Neue&quot;">[ <span class=3D"gmail-Appl=
e-converted-space">=C2=A0 </span>22.601238] drbd drbd0: Restarting receiver=
 thread</p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:13px;line-height=
:normal;font-family:&quot;Helvetica Neue&quot;">[ <span class=3D"gmail-Appl=
e-converted-space">=C2=A0 </span>22.601378] drbd drbd0: receiver (re)starte=
d</p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:13px;line-height=
:normal;font-family:&quot;Helvetica Neue&quot;">[ <span class=3D"gmail-Appl=
e-converted-space">=C2=A0 </span>22.601508] drbd drbd0: conn( Unconnected -=
&gt; WFConnection )</p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:13px;line-height=
:normal;font-family:&quot;Helvetica Neue&quot;">[ <span class=3D"gmail-Appl=
e-converted-space">=C2=A0 </span>23.260624] drbd drbd0: Handshake successfu=
l: Agreed network protocol version 101</p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:13px;line-height=
:normal;font-family:&quot;Helvetica Neue&quot;">[ <span class=3D"gmail-Appl=
e-converted-space">=C2=A0 </span>23.260859] drbd drbd0: Feature flags enabl=
ed on protocol level: 0xf TRIM THIN_RESYNC WRITE_SAME WRITE_ZEROES.</p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:13px;line-height=
:normal;font-family:&quot;Helvetica Neue&quot;">[ <span class=3D"gmail-Appl=
e-converted-space">=C2=A0 </span>23.261187] drbd drbd0: conn( WFConnection =
-&gt; WFReportParams )</p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:13px;line-height=
:normal;font-family:&quot;Helvetica Neue&quot;">[ <span class=3D"gmail-Appl=
e-converted-space">=C2=A0 </span>23.261367] drbd drbd0: Starting ack_recv t=
hread (from drbd_r_drbd0 [4071])</p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:13px;line-height=
:normal;font-family:&quot;Helvetica Neue&quot;">[ <span class=3D"gmail-Appl=
e-converted-space">=C2=A0 </span>23.340593] drbd drbd0/0 drbd0: drbd_sync_h=
andshake:</p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:13px;line-height=
:normal;font-family:&quot;Helvetica Neue&quot;">[ <span class=3D"gmail-Appl=
e-converted-space">=C2=A0 </span>23.340771] drbd drbd0/0 drbd0: self 7F8B15=
C04AF49C4D:32DDB2019708F68B:7D97648599B446DD:7D96648599B446DD bits:1 flags:=
0</p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:13px;line-height=
:normal;font-family:&quot;Helvetica Neue&quot;">[ <span class=3D"gmail-Appl=
e-converted-space">=C2=A0 </span>23.341192] drbd drbd0/0 drbd0: peer 32DDB2=
019708F68A:0000000000000000:7D97648599B446DC:7D96648599B446DD bits:0 flags:=
0</p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:13px;line-height=
:normal;font-family:&quot;Helvetica Neue&quot;">[ <span class=3D"gmail-Appl=
e-converted-space">=C2=A0 </span>23.341649] drbd drbd0/0 drbd0: uuid_compar=
e()=3D1 by rule 70</p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:13px;line-height=
:normal;font-family:&quot;Helvetica Neue&quot;">[ <span class=3D"gmail-Appl=
e-converted-space">=C2=A0 </span>23.341824] drbd drbd0/0 drbd0: peer( Unkno=
wn -&gt; Secondary ) conn( WFReportParams -&gt; WFBitMapS ) pdsk( DUnknown =
-&gt; Consistent )</p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:13px;line-height=
:normal;font-family:&quot;Helvetica Neue&quot;">[ <span class=3D"gmail-Appl=
e-converted-space">=C2=A0 </span>23.344911] drbd drbd0/0 drbd0: send bitmap=
 stats [Bytes(packets)]: plain 0(0), RLE 23(1), total 23; compression: 100.=
0%</p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:13px;line-height=
:normal;font-family:&quot;Helvetica Neue&quot;">[ <span class=3D"gmail-Appl=
e-converted-space">=C2=A0 </span>23.396792] drbd drbd0/0 drbd0: receive bit=
map stats [Bytes(packets)]: plain 0(0), RLE 23(1), total 23; compression: 1=
00.0%</p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:13px;line-height=
:normal;font-family:&quot;Helvetica Neue&quot;">[ <span class=3D"gmail-Appl=
e-converted-space">=C2=A0 </span>23.397210] drbd drbd0/0 drbd0: helper comm=
and: /sbin/drbdadm before-resync-source minor-0</p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:13px;line-height=
:normal;font-family:&quot;Helvetica Neue&quot;">[ <span class=3D"gmail-Appl=
e-converted-space">=C2=A0 </span>23.407965] drbd drbd0/0 drbd0: helper comm=
and: /sbin/drbdadm before-resync-source minor-0 exit code 0 (0x0)</p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:13px;line-height=
:normal;font-family:&quot;Helvetica Neue&quot;">[ <span class=3D"gmail-Appl=
e-converted-space">=C2=A0 </span>23.417547] drbd drbd0/0 drbd0: conn( WFBit=
MapS -&gt; SyncSource ) pdsk( Consistent -&gt; Inconsistent )</p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:13px;line-height=
:normal;font-family:&quot;Helvetica Neue&quot;">[ <span class=3D"gmail-Appl=
e-converted-space">=C2=A0 </span>23.426697] drbd drbd0/0 drbd0: Began resyn=
c as SyncSource (will sync 4 KB [1 bits set]).</p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:13px;line-height=
:normal;font-family:&quot;Helvetica Neue&quot;">[ <span class=3D"gmail-Appl=
e-converted-space">=C2=A0 </span>23.435638] drbd drbd0/0 drbd0: updated syn=
c UUID 7F8B15C04AF49C4D:32DEB2019708F68B:32DDB2019708F68B:7D97648599B446DD<=
/p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:13px;line-height=
:normal;font-family:&quot;Helvetica Neue&quot;">[ <span class=3D"gmail-Appl=
e-converted-space">=C2=A0 </span>23.488608] drbd drbd0/0 drbd0: _drbd_send_=
page: size=3D4096 len=3D4096 sent=3D-5</p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:13px;line-height=
:normal;font-family:&quot;Helvetica Neue&quot;">[ <span class=3D"gmail-Appl=
e-converted-space">=C2=A0 </span>23.498182] drbd drbd0/0 drbd0: drbd_send_b=
lock() failed</p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:13px;line-height=
:normal;font-family:&quot;Helvetica Neue&quot;">[ <span class=3D"gmail-Appl=
e-converted-space">=C2=A0 </span>23.508498] drbd drbd0: peer( Secondary -&g=
t; Unknown ) conn( SyncSource -&gt; NetworkFailure )</p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:13px;line-height=
:normal;font-family:&quot;Helvetica Neue&quot;">[ <span class=3D"gmail-Appl=
e-converted-space">=C2=A0 </span>23.517597] drbd drbd0: ack_receiver termin=
ated</p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:13px;line-height=
:normal;font-family:&quot;Helvetica Neue&quot;">[ <span class=3D"gmail-Appl=
e-converted-space">=C2=A0 </span>23.527513] drbd drbd0: Terminating drbd_a_=
drbd0</p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:13px;line-height=
:normal;font-family:&quot;Helvetica Neue&quot;">[ <span class=3D"gmail-Appl=
e-converted-space">=C2=A0 </span>23.690598] drbd drbd0: Connection closed</=
p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:13px;line-height=
:normal;font-family:&quot;Helvetica Neue&quot;">[ <span class=3D"gmail-Appl=
e-converted-space">=C2=A0 </span>23.701857] drbd drbd0: conn( NetworkFailur=
e -&gt; Unconnected )</p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:13px;line-height=
:normal;font-family:&quot;Helvetica Neue&quot;">[ <span class=3D"gmail-Appl=
e-converted-space">=C2=A0 </span>23.712017] drbd drbd0: receiver terminated=
</p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:13px;line-height=
:normal;font-family:&quot;Helvetica Neue&quot;">[ <span class=3D"gmail-Appl=
e-converted-space">=C2=A0 </span>23.721597] drbd drbd0: Restarting receiver=
 thread</p><p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:n=
ormal;font-variant-east-asian:normal;font-variant-alternates:normal;font-ke=
rning:auto;font-feature-settings:normal;font-stretch:normal;font-size:13px;=
line-height:normal;font-family:&quot;Helvetica Neue&quot;"><br></p><p class=
=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-variant-=
east-asian:normal;font-variant-alternates:normal;font-kerning:auto;font-fea=
ture-settings:normal;font-stretch:normal;font-size:13px;line-height:normal;=
font-family:&quot;Helvetica Neue&quot;"><br></p><p class=3D"gmail-p1" style=
=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:normal;f=
ont-variant-alternates:normal;font-kerning:auto;font-feature-settings:norma=
l;font-stretch:normal;font-size:13px;line-height:normal;font-family:&quot;H=
elvetica Neue&quot;">On the peer:</p><p class=3D"gmail-p1" style=3D"margin:=
0px;font-variant-numeric:normal;font-variant-east-asian:normal;font-variant=
-alternates:normal;font-kerning:auto;font-feature-settings:normal;font-stre=
tch:normal;font-size:13px;line-height:normal;font-family:&quot;Helvetica Ne=
ue&quot;"><br></p><p class=3D"gmail-p1" style=3D"margin:0px;font:13px &quot=
;Helvetica Neue&quot;">[349071.038278] drbd drbd0: conn( Unconnected -&gt; =
WFConnection )</p><p class=3D"gmail-p1" style=3D"margin:0px;font:13px &quot=
;Helvetica Neue&quot;">[349071.558245] drbd drbd0: Handshake successful: Ag=
reed network protocol version 101</p><p class=3D"gmail-p1" style=3D"margin:=
0px;font:13px &quot;Helvetica Neue&quot;">[349071.562105] drbd drbd0: Featu=
re flags enabled on protocol level: 0xf TRIM THIN_RESYNC WRITE_SAME WRITE_Z=
EROES.</p><p class=3D"gmail-p1" style=3D"margin:0px;font:13px &quot;Helveti=
ca Neue&quot;">[349071.569889] drbd drbd0: conn( WFConnection -&gt; WFRepor=
tParams )</p><p class=3D"gmail-p1" style=3D"margin:0px;font:13px &quot;Helv=
etica Neue&quot;">[349071.573802] drbd drbd0: Starting ack_recv thread (fro=
m drbd_r_drbd0 [2660])</p><p class=3D"gmail-p1" style=3D"margin:0px;font:13=
px &quot;Helvetica Neue&quot;">[349071.688547] drbd drbd0/0 drbd0: drbd_syn=
c_handshake:</p><p class=3D"gmail-p1" style=3D"margin:0px;font:13px &quot;H=
elvetica Neue&quot;">[349071.692323] drbd drbd0/0 drbd0: self 3375B2019708F=
68A:0000000000000000:7D97648599B446DC:7D96648599B446DD bits:1 flags:0</p><p=
 class=3D"gmail-p1" style=3D"margin:0px;font:13px &quot;Helvetica Neue&quot=
;">[349071.699871] drbd drbd0/0 drbd0: peer 7F8B15C04AF49C4D:3375B2019708F6=
8B:3374B2019708F68B:3373B2019708F68B bits:1 flags:0</p><p class=3D"gmail-p1=
" style=3D"margin:0px;font:13px &quot;Helvetica Neue&quot;">[349071.707687]=
 drbd drbd0/0 drbd0: uuid_compare()=3D-1 by rule 50</p><p class=3D"gmail-p1=
" style=3D"margin:0px;font:13px &quot;Helvetica Neue&quot;">[349071.711563]=
 drbd drbd0/0 drbd0: Becoming sync target due to disk states.</p><p class=
=3D"gmail-p1" style=3D"margin:0px;font:13px &quot;Helvetica Neue&quot;">[34=
9071.715381] drbd drbd0/0 drbd0: peer( Unknown -&gt; Primary ) conn( WFRepo=
rtParams -&gt; WFBitMapT ) pdsk( DUnknown -&gt; UpToDate )</p><p class=3D"g=
mail-p1" style=3D"margin:0px;font:13px &quot;Helvetica Neue&quot;">[349071.=
723039] drbd drbd0/0 drbd0: receive bitmap stats [Bytes(packets)]: plain 0(=
0), RLE 23(1), total 23; compression: 100.0%</p><p class=3D"gmail-p1" style=
=3D"margin:0px;font:13px &quot;Helvetica Neue&quot;">[349071.732489] drbd d=
rbd0/0 drbd0: send bitmap stats [Bytes(packets)]: plain 0(0), RLE 23(1), to=
tal 23; compression: 100.0%</p><p class=3D"gmail-p1" style=3D"margin:0px;fo=
nt:13px &quot;Helvetica Neue&quot;">[349071.740178] drbd drbd0/0 drbd0: con=
n( WFBitMapT -&gt; WFSyncUUID )</p><p class=3D"gmail-p1" style=3D"margin:0p=
x;font:13px &quot;Helvetica Neue&quot;">[349071.787113] drbd drbd0/0 drbd0:=
 updated sync uuid 3376B2019708F68A:0000000000000000:7D97648599B446DC:7D966=
48599B446DD</p><p class=3D"gmail-p1" style=3D"margin:0px;font:13px &quot;He=
lvetica Neue&quot;">[349071.794907] drbd drbd0/0 drbd0: helper command: /sb=
in/drbdadm before-resync-target minor-0</p><p class=3D"gmail-p1" style=3D"m=
argin:0px;font:13px &quot;Helvetica Neue&quot;">[349071.800006] drbd drbd0/=
0 drbd0: helper command: /sbin/drbdadm before-resync-target minor-0 exit co=
de 0 (0x0)</p><p class=3D"gmail-p1" style=3D"margin:0px;font:13px &quot;Hel=
vetica Neue&quot;">[349071.807737] drbd drbd0/0 drbd0: conn( WFSyncUUID -&g=
t; SyncTarget )</p><p class=3D"gmail-p1" style=3D"margin:0px;font:13px &quo=
t;Helvetica Neue&quot;">[349071.811639] drbd drbd0/0 drbd0: Began resync as=
 SyncTarget (will sync 4 KB [1 bits set]).</p><p class=3D"gmail-p1" style=
=3D"margin:0px;font:13px &quot;Helvetica Neue&quot;">[349071.916117] drbd d=
rbd0: sock was shut down by peer</p><p class=3D"gmail-p1" style=3D"margin:0=
px;font:13px &quot;Helvetica Neue&quot;">[349071.919955] drbd drbd0: peer( =
Primary -&gt; Unknown ) conn( SyncTarget -&gt; BrokenPipe ) pdsk( UpToDate =
-&gt; DUnknown )</p><p class=3D"gmail-p1" style=3D"margin:0px;font:13px &qu=
ot;Helvetica Neue&quot;">[349071.927796] drbd drbd0: short read (expected s=
ize 4096)</p><p class=3D"gmail-p1" style=3D"margin:0px;font:13px &quot;Helv=
etica Neue&quot;">[349071.931812] drbd drbd0: error receiving RSDataReply, =
e: -5 l: 4096!</p><p class=3D"gmail-p1" style=3D"margin:0px;font:13px &quot=
;Helvetica Neue&quot;">[349071.935864] drbd drbd0: ack_receiver terminated<=
/p><p class=3D"gmail-p1" style=3D"margin:0px;font:13px &quot;Helvetica Neue=
&quot;">[349071.939906] drbd drbd0: Terminating drbd_a_drbd0</p><p class=3D=
"gmail-p1" style=3D"margin:0px;font:13px &quot;Helvetica Neue&quot;">[34907=
2.088385] drbd drbd0: Connection closed</p><p class=3D"gmail-p1" style=3D"m=
argin:0px;font:13px &quot;Helvetica Neue&quot;">[349072.092398] drbd drbd0:=
 conn( BrokenPipe -&gt; Unconnected )</p><p class=3D"gmail-p1" style=3D"mar=
gin:0px;font:13px &quot;Helvetica Neue&quot;">[349072.096436] drbd drbd0: r=
eceiver terminated</p><p class=3D"gmail-p1" style=3D"margin:0px;font:13px &=
quot;Helvetica Neue&quot;">[349072.100469] drbd drbd0: Restarting receiver =
thread</p><p class=3D"gmail-p1" style=3D"margin:0px;font:13px &quot;Helveti=
ca Neue&quot;">[349072.104454] drbd drbd0: receiver (re)started</p><p class=
=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-variant-=
east-asian:normal;font-variant-alternates:normal;font-kerning:auto;font-fea=
ture-settings:normal;font-stretch:normal;font-size:13px;line-height:normal;=
font-family:&quot;Helvetica Neue&quot;">



































</p><p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;f=
ont-variant-east-asian:normal;font-variant-alternates:normal;font-kerning:a=
uto;font-feature-settings:normal;font-stretch:normal;font-size:13px;line-he=
ight:normal;font-family:&quot;Helvetica Neue&quot;">[349072.108373] drbd dr=
bd0: conn( Unconnected -&gt; WFConnection )</p><p class=3D"gmail-p1" style=
=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:normal;f=
ont-variant-alternates:normal;font-kerning:auto;font-feature-settings:norma=
l;font-stretch:normal;font-size:13px;line-height:normal;font-family:&quot;H=
elvetica Neue&quot;"><br></p><p class=3D"gmail-p1" style=3D"margin:0px;font=
-variant-numeric:normal;font-variant-east-asian:normal;font-variant-alterna=
tes:normal;font-kerning:auto;font-feature-settings:normal;font-stretch:norm=
al;font-size:13px;line-height:normal;font-family:&quot;Helvetica Neue&quot;=
">--</p><p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:norm=
al;font-variant-east-asian:normal;font-variant-alternates:normal;font-kerni=
ng:auto;font-feature-settings:normal;font-stretch:normal;font-size:13px;lin=
e-height:normal;font-family:&quot;Helvetica Neue&quot;">=C2=A0Best Regards,=
</p><p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;f=
ont-variant-east-asian:normal;font-variant-alternates:normal;font-kerning:a=
uto;font-feature-settings:normal;font-stretch:normal;font-size:13px;line-he=
ight:normal;font-family:&quot;Helvetica Neue&quot;">=C2=A0Serguei</p><br></=
div></div>

--000000000000ccfb4106046628cc--
