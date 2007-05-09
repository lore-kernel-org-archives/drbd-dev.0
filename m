Return-Path: <Ernest.Montrose@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C7927F.AA8A4D4D"
Date: Wed, 9 May 2007 17:19:02 -0400
Message-ID: <BD7042533C2F8943A6A4257A9E31C454F478EB@EXNA.corp.stratus.com>
From: "Montrose, Ernest" <Ernest.Montrose@stratus.com>
To: <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] DRBD8: conn state stuck in SyncSource while target is
	connected.
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C7927F.AA8A4D4D
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi all,
We have seen a problem where essentially the resync is reported done
from a suspended state.  There was no invalidate done in our test.  So
it is weird the resync got suspended in the first place. But assume that
somehow we get suspended.  The end result is that the syncSource conn
state get stuck in "SyncSource" while the Target is happily connected.
The logs below shows
the problem.  Any clue?
=20
On the syncSource we see:
May  8 03:50:12 bruce kernel: drbd0: Began resync as SyncSource (will
sync 840 KB [210 bits set]).
May  8 03:50:12 bruce kernel: drbd0: Writing meta data super block now.
May  8 03:50:13 bruce kernel: drbd0: conn( SyncSource -> PausedSyncS )
aftr_isp( 0 -> 1 )
May  8 03:50:13 bruce kernel: drbd0: Resync suspended   <<<< We are in
paused state
May  8 03:50:13 bruce kernel: drbd0: Resync done (total 1 sec; paused 0
sec; 840 K/sec)  <<<We are done?????
May  8 03:50:13 bruce kernel: drbd0:  uuid[History_start] now
1DCA5DA245F96038
May  8 03:50:13 bruce kernel: drbd0:  uuid[Bitmap] now 0000000000000000
May  8 03:50:13 bruce kernel: drbd0: conn( PausedSyncS -> Connected )
pdsk( Inconsistent -> UpToDate ) <<<Paused to connected!!!!
May  8 03:50:13 bruce kernel: drbd0: conn( Connected -> PausedSyncS )
peer_isp( 0 -> 1 )
May  8 03:50:13 bruce kernel: drbd0: Writing meta data super block now.
May  8 03:50:13 bruce kernel: drbd0: peer_isp( 1 -> 0 )
May  8 03:50:13 bruce kernel: drbd0: conn( PausedSyncS -> SyncSource )
aftr_isp( 1 -> 0 )
May  8 03:50:13 bruce kernel: drbd0: Syncer continues.

=20
On the SyncTarget all seems to be normal:
May  8 03:50:13 dick kernel: drbd0: conn( WFSyncUUID -> SyncTarget )
disk( UpToDate -> Inconsistent )
May  8 03:50:13 dick kernel: drbd0: Began resync as SyncTarget (will
sync 840 KB [210 bits set]).
May  8 03:50:13 dick kernel: drbd0: Writing meta data super block now.
May  8 03:50:14 dick kernel: drbd0: Resync done (total 1 sec; paused 0
sec; 840 K/sec)
May  8 03:50:14 dick kernel: drbd0:  uuid[Bitmap] now A10989D4FAD4C4BB
May  8 03:50:14 dick kernel: drbd0:  uuid[History_start] now
B2E9873EF8AC35CB
May  8 03:50:14 dick kernel: drbd0:  uuid[History_end] now
161E8961AB2B5473
May  8 03:50:14 dick kernel: drbd0:  uuid[History_start] now
A10989D4FAD4C4BB
May  8 03:50:14 dick kernel: drbd0:  uuid[Bitmap] now 1DCA5DA245F96038
May  8 03:50:14 dick kernel: drbd0:  uuid[Current] now 8B19AE5BFEDF83D4
May  8 03:50:14 dick kernel: drbd0:  uuid[History_start] now
1DCA5DA245F96038
May  8 03:50:14 dick kernel: drbd0:  uuid[Bitmap] now 0000000000000000
May  8 03:50:14 dick kernel: drbd0: conn( SyncTarget -> Connected )
disk( Inconsistent -> UpToDate )
May  8 03:50:14 dick kernel: drbd0: Writing meta data super block now.


------_=_NextPart_001_01C7927F.AA8A4D4D
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.5730.11" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D541175720-09052007>Hi=20
all,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D541175720-09052007>We =
have seen a=20
problem where essentially the resync is reported done from a suspended=20
state.&nbsp; There was no invalidate done in our test.&nbsp; So it is =
weird the=20
resync got suspended in the first place. But assume that somehow we get=20
suspended.&nbsp; </SPAN></FONT><FONT face=3DArial size=3D2><SPAN=20
class=3D541175720-09052007>The end result is that the syncSource conn =
state get=20
stuck in "SyncSource" while the Target is happily connected.&nbsp; The =
logs=20
below shows</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D541175720-09052007>the =
problem.&nbsp;=20
Any clue?</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D541175720-09052007></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D541175720-09052007>On the =
syncSource we=20
see:</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D541175720-09052007><FONT=20
face=3D"Times New Roman" size=3D3>May&nbsp; 8 03:50:12 bruce kernel: =
drbd0: Began=20
resync as SyncSource (will sync 840 KB [210 bits set]).<BR>May&nbsp; 8 =
03:50:12=20
bruce kernel: drbd0: Writing meta data super block now.<BR>May&nbsp; 8 =
03:50:13=20
bruce kernel: drbd0: conn( SyncSource -&gt; PausedSyncS ) aftr_isp( 0 =
-&gt; 1=20
)<BR>May&nbsp; 8 03:50:13 bruce kernel: drbd0: Resync =
suspended&nbsp;&nbsp;=20
&lt;&lt;&lt;&lt; We are in paused state<BR>May&nbsp; 8 03:50:13 bruce =
kernel:=20
drbd0: Resync done (total 1 sec; paused 0 sec; 840 K/sec)&nbsp; =
&lt;&lt;&lt;We=20
are done?????<BR>May&nbsp; 8 03:50:13 bruce kernel: drbd0:&nbsp;=20
uuid[History_start] now 1DCA5DA245F96038<BR>May&nbsp; 8 03:50:13 bruce =
kernel:=20
drbd0:&nbsp; uuid[Bitmap] now 0000000000000000<BR>May&nbsp; 8 03:50:13 =
bruce=20
kernel: drbd0: conn( PausedSyncS -&gt; Connected ) pdsk( Inconsistent =
-&gt;=20
UpToDate ) &lt;&lt;&lt;Paused to connected!!!!<BR>May&nbsp; 8 03:50:13 =
bruce=20
kernel: drbd0: conn( Connected -&gt; PausedSyncS ) peer_isp( 0 -&gt; 1=20
)<BR>May&nbsp; 8 03:50:13 bruce kernel: drbd0: Writing meta data super =
block=20
now.<BR>May&nbsp; 8 03:50:13 bruce kernel: drbd0: peer_isp( 1 -&gt; 0=20
)<BR>May&nbsp; 8 03:50:13 bruce kernel: drbd0: conn( PausedSyncS -&gt;=20
SyncSource ) aftr_isp( 1 -&gt; 0 )<BR>May&nbsp; 8 03:50:13 bruce kernel: =
drbd0:=20
Syncer continues.</FONT><BR></SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D541175720-09052007></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D541175720-09052007>On the =
SyncTarget=20
all seems to be normal:</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D541175720-09052007><FONT=20
face=3D"Times New Roman" size=3D3>May&nbsp; 8 03:50:13 dick kernel: =
drbd0: conn(=20
WFSyncUUID -&gt; SyncTarget ) disk( UpToDate -&gt; Inconsistent =
)<BR>May&nbsp; 8=20
03:50:13 dick kernel: drbd0: Began resync as SyncTarget (will sync 840 =
KB [210=20
bits set]).<BR>May&nbsp; 8 03:50:13 dick kernel: drbd0: Writing meta =
data super=20
block now.<BR>May&nbsp; 8 03:50:14 dick kernel: drbd0: Resync done =
(total 1 sec;=20
paused 0 sec; 840 K/sec)<BR>May&nbsp; 8 03:50:14 dick kernel: =
drbd0:&nbsp;=20
uuid[Bitmap] now A10989D4FAD4C4BB<BR>May&nbsp; 8 03:50:14 dick kernel:=20
drbd0:&nbsp; uuid[History_start] now B2E9873EF8AC35CB<BR>May&nbsp; 8 =
03:50:14=20
dick kernel: drbd0:&nbsp; uuid[History_end] now =
161E8961AB2B5473<BR>May&nbsp; 8=20
03:50:14 dick kernel: drbd0:&nbsp; uuid[History_start] now=20
A10989D4FAD4C4BB<BR>May&nbsp; 8 03:50:14 dick kernel: drbd0:&nbsp; =
uuid[Bitmap]=20
now 1DCA5DA245F96038<BR>May&nbsp; 8 03:50:14 dick kernel: drbd0:&nbsp;=20
uuid[Current] now 8B19AE5BFEDF83D4<BR>May&nbsp; 8 03:50:14 dick kernel:=20
drbd0:&nbsp; uuid[History_start] now 1DCA5DA245F96038<BR>May&nbsp; 8 =
03:50:14=20
dick kernel: drbd0:&nbsp; uuid[Bitmap] now 0000000000000000<BR>May&nbsp; =
8=20
03:50:14 dick kernel: drbd0: conn( SyncTarget -&gt; Connected ) disk(=20
Inconsistent -&gt; UpToDate )<BR>May&nbsp; 8 03:50:14 dick kernel: =
drbd0:=20
Writing meta data super block =
now.</FONT><BR></DIV></SPAN></FONT></BODY></HTML>

------_=_NextPart_001_01C7927F.AA8A4D4D--
