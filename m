Return-Path: <Ernest.Montrose@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C81A7B.BA97120E"
Date: Mon, 29 Oct 2007 18:33:29 -0400
Message-ID: <BD7042533C2F8943A6A4257A9E31C454F47A25@EXNA.corp.stratus.com>
From: "Montrose, Ernest" <Ernest.Montrose@stratus.com>
To: <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] DRBD8: nodes deadlock in PausedSync{ST]
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C81A7B.BA97120E
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_002_01C81A7B.BA97120E"


------_=_NextPart_002_01C81A7B.BA97120E
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi all,
I have been struggling with a problem here where the nodes enter
PausedSync[T|S] and stay there. =20
This happens when one node come up from a fresh attach, connect
sequence.  I think the issue happens this way. Say we have two volumes
drbd5 and drbd16 and we attempt to connect both of them at roughly the
same time.  Futhermore, drbd5 and 16 will require syncing say as sync
target. What I observe is this:
*	drbd16 is connecting and drbd5 is syncing. So 16 is paused isp=3D1
*	drbd16 enters receive_state() but before acquiring the req_lock
that thread loses the CPU to drbd5 that is finishing syncing.  After_isp
is cleared on 16 giving drbd16 the green light to continue syncing. So
far so good.
*	Now drbd16 resumes with the old peer_isp=3D1=20
*	So now we are paused forever.
=20
So I think receive_state() is just racy but I could be wrong. I am
really not sure how to fix this but I include a patch here that may help
to at least illustrate the problem. It seems close window for this
particular race somewhat.
=20
Below are the original logs on the two nodes:
=3D=3D=3D=3D=3D=3DNode 0 logs=3D=3D=3D=3D=3D
Oct  4 03:38:11 node0 kernel: drbd5: Handshake successful: DRBD Network
Protocol version 86
Oct  4 03:38:12 node0 kernel: drbd5: drbd_sync_handshake:
Oct  4 03:38:12 node0 kernel: drbd5: self
F8152BAF51D9EACC:0000000000000000:4981B7129527F32B:0000000000000006
Oct  4 03:38:12 node0 kernel: drbd5: peer
015A3BE2ED294C8D:F8152BAF51D9EACD:4981B7129527F32A:0000000000000006
Oct  4 03:38:12 node0 kernel: drbd5: uuid_compare()=3D-1 by rule 5
Oct  4 03:38:12 node0 kernel: drbd5: peer( Unknown -> Primary ) conn(
WFReportParams -> WFBitMapT ) pdsk( DUnknown -> UpToDate )
Oct  4 03:38:12 node0 kernel: drbd5: Writing meta data super block now.
Oct  4 03:38:12 node0 kernel: drbd5: conn( WFBitMapT -> WFSyncUUID )
Oct  4 03:38:12 node0 kernel: drbd5:  uuid[Current] now 7C1CB159A4E77906
Oct  4 03:38:12 node0 kernel: drbd5:  uuid[Bitmap] now 0000000000000000
Oct  4 03:38:13 node0 kernel: drbd5: conn( WFSyncUUID -> SyncTarget )
disk( UpToDate -> Inconsistent )
Oct  4 03:38:14 node0 kernel: drbd16: aftr_isp( 0 -> 1 )
Oct  4 03:38:17 node0 kernel: drbd5: Began resync as SyncTarget (will
sync 1444 KB [361 bits set]).
Oct  4 03:38:17 node0 kernel: drbd5: Writing meta data super block now.
Oct  4 03:38:17 node0 kernel: drbd16: conn( StandAlone -> Unconnected )
Oct  4 03:38:17 node0 kernel: drbd16: receiver (re)started
Oct  4 03:38:17 node0 kernel: drbd16: conn( Unconnected -> WFConnection
)
Oct  4 03:38:17 node0 kernel: drbd16: conn( WFConnection ->
WFReportParams )
Oct  4 03:38:17 node0 kernel: drbd16: Handshake successful: DRBD Network
Protocol version 86
Oct  4 03:38:17 node0 kernel: drbd16: Writing meta data super block now.
Oct  4 03:38:17 node0 kernel: drbd5: Resync done (total 1 sec; paused 0
sec; 1444 K/sec)
Oct  4 03:38:17 node0 kernel: drbd5:  uuid[Bitmap] now F8152BAF51D9EACD
Oct  4 03:38:17 node0 kernel: drbd5:  uuid[History_start] now
4981B7129527F32A
Oct  4 03:38:17 node0 kernel: drbd5:  uuid[History_end] now
0000000000000006
Oct  4 03:38:17 node0 kernel: drbd5:  uuid[History_start] now
F8152BAF51D9EACD
Oct  4 03:38:17 node0 kernel: drbd5:  uuid[Bitmap] now 7C1CB159A4E77906
Oct  4 03:38:18 node0 kernel: drbd5:  uuid[Current] now 015A3BE2ED294C8C
Oct  4 03:38:18 node0 kernel: drbd5:  uuid[History_start] now
7C1CB159A4E77906
Oct  4 03:38:18 node0 kernel: drbd5:  uuid[Bitmap] now 0000000000000000
Oct  4 03:38:18 node0 kernel: drbd5: conn( SyncTarget -> Connected )
disk( Inconsistent -> UpToDate )
Oct  4 03:38:18 node0 kernel: drbd16: aftr_isp( 1 -> 0 )
Oct  4 03:38:20 node0 kernel: drbd5: Writing meta data super block now.
Oct  4 03:38:20 node0 kernel: drbd16: writing of bitmap took 1 jiffies
Oct  4 03:38:20 node0 kernel: drbd16: 4095 MB marked out-of-sync by on
disk bit-map.
Oct  4 03:38:20 node0 kernel: drbd16: 4194140 KB now marked out-of-sync
by on disk bit-map.
Oct  4 03:38:20 node0 kernel: drbd16: Writing meta data super block now.
Oct  4 03:38:20 node0 kernel: drbd16: peer( Unknown -> Primary ) conn(
WFReportParams -> WFBitMapT ) pdsk( DUnknown -> UpToDate ) peer_isp( 0
-> 1 )
Oct  4 03:38:21 node0 kernel: drbd16: Writing meta data super block now.
Oct  4 03:38:21 node0 kernel: drbd16: conn( WFBitMapT -> WFSyncUUID )
Oct  4 03:38:21 node0 kernel: drbd16: conn( WFSyncUUID -> PausedSyncT )
disk( UpToDate -> Inconsistent )
Oct  4 03:38:21 node0 kernel: drbd16: Began resync as PausedSyncT (will
sync 4194140 KB [1048535 bits set]).
Oct  4 03:38:21 node0 kernel: drbd16: Writing meta data super block now.


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3DNode1=3D=3D=3D=3D=3D=3D=3D=3D=3D

Oct  4 03:38:11 node1 kernel: drbd5: Handshake successful: DRBD Network
Protocol version 86
Oct  4 03:38:11 node1 kernel: drbd5: drbd_sync_handshake:
Oct  4 03:38:11 node1 kernel: drbd5: self
015A3BE2ED294C8D:F8152BAF51D9EACD:4981B7129527F32A:0000000000000006
Oct  4 03:38:11 node1 kernel: drbd5: peer
F8152BAF51D9EACC:0000000000000000:4981B7129527F32B:0000000000000006
Oct  4 03:38:11 node1 kernel: drbd5: uuid_compare()=3D1 by rule 7
Oct  4 03:38:11 node1 kernel: drbd5: peer( Unknown -> Secondary ) conn(
WFReportParams -> WFBitMapS ) pdsk( DUnknown -> UpToDate )
Oct  4 03:38:11 node1 kernel: drbd5: Writing meta data super block now.
Oct  4 03:38:11 node1 kernel: drbd5:  uuid[History_start] now
F8152BAF51D9EACD
Oct  4 03:38:11 node1 kernel: drbd5:  uuid[Bitmap] now 7C1CB159A4E77906
Oct  4 03:38:11 node1 kernel: drbd5: conn( WFBitMapS -> SyncSource )
pdsk( UpToDate -> Inconsistent )
Oct  4 03:38:11 node1 kernel: drbd16: aftr_isp( 0 -> 1 )
Oct  4 03:38:13 node1 kernel: drbd5: Began resync as SyncSource (will
sync 1444 KB [361 bits set]).
Oct  4 03:38:13 node1 kernel: drbd5: Writing meta data super block now.
Oct  4 03:38:13 node1 kernel: drbd16: conn( WFConnection ->
WFReportParams )
Oct  4 03:38:13 node1 kernel: drbd16: Handshake successful: DRBD Network
Protocol version 86
Oct  4 03:38:13 node1 kernel: drbd16: Writing meta data super block now.
Oct  4 03:38:13 node1 kernel: drbd5: Resync done (total 1 sec; paused 0
sec; 1444 K/sec)
Oct  4 03:38:13 node1 kernel: drbd5:  uuid[History_start] now
7C1CB159A4E77906
Oct  4 03:38:13 node1 kernel: drbd5:  uuid[Bitmap] now 0000000000000000
Oct  4 03:38:13 node1 kernel: drbd5: conn( SyncSource -> Connected )
pdsk( Inconsistent -> UpToDate )
Oct  4 03:38:13 node1 kernel: drbd16: aftr_isp( 1 -> 0 )
Oct  4 03:38:15 node1 kernel: drbd5: Writing meta data super block now.
Oct  4 03:38:15 node1 kernel: drbd16: writing of bitmap took 1 jiffies
Oct  4 03:38:15 node1 kernel: drbd16: 4095 MB marked out-of-sync by on
disk bit-map.
Oct  4 03:38:15 node1 kernel: drbd16: 4194140 KB now marked out-of-sync
by on disk bit-map.
Oct  4 03:38:16 node1 kernel: drbd16: Writing meta data super block now.
Oct  4 03:38:16 node1 kernel: drbd16: peer( Unknown -> Secondary ) conn(
WFReportParams -> WFBitMapS ) pdsk( DUnknown -> UpToDate ) peer_isp( 0
-> 1 )
Oct  4 03:38:18 node1 kernel: drbd16: Writing meta data super block now.
Oct  4 03:38:18 node1 kernel: drbd16: conn( WFBitMapS -> PausedSyncS )
pdsk( UpToDate -> Inconsistent )
Oct  4 03:38:18 node1 kernel: drbd16: Began resync as PausedSyncS (will
sync 4194140 KB [1048535 bits set]).
Oct  4 03:38:18 node1 kernel: drbd16: Writing meta data super block now.

------_=_NextPart_002_01C81A7B.BA97120E
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DProgId content=3DWord.Document>
<meta name=3DGenerator content=3D"Microsoft Word 11">
<meta name=3DOriginator content=3D"Microsoft Word 11">
<link rel=3DFile-List href=3D"cid:filelist.xml@01C81A5A.337F78F0">
<!--[if gte mso 9]><xml>
 <o:OfficeDocumentSettings>
  <o:DoNotRelyOnCSS/>
 </o:OfficeDocumentSettings>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:WordDocument>
  <w:SpellingState>Clean</w:SpellingState>
  <w:GrammarState>Clean</w:GrammarState>
  <w:DocumentKind>DocumentEmail</w:DocumentKind>
  <w:EnvelopeVis/>
  <w:ValidateAgainstSchemas/>
  <w:SaveIfXMLInvalid>false</w:SaveIfXMLInvalid>
  <w:IgnoreMixedContent>false</w:IgnoreMixedContent>
  <w:AlwaysShowPlaceholderText>false</w:AlwaysShowPlaceholderText>
  <w:Compatibility>
   <w:BreakWrappedTables/>
   <w:SnapToGridInCell/>
   <w:WrapTextWithPunct/>
   <w:UseAsianBreakRules/>
   <w:UseWord2002TableStyleRules/>
  </w:Compatibility>
  <w:BrowserLevel>MicrosoftInternetExplorer4</w:BrowserLevel>
 </w:WordDocument>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:LatentStyles DefLockedState=3D"false" LatentStyleCount=3D"156">
 </w:LatentStyles>
</xml><![endif]-->
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;
	mso-font-charset:2;
	mso-generic-font-family:auto;
	mso-font-pitch:variable;
	mso-font-signature:0 268435456 0 0 -2147483648 0;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;
	mso-font-alt:"?l?r ?????????????????????????";
	mso-font-charset:0;
	mso-generic-font-family:swiss;
	mso-font-pitch:variable;
	mso-font-signature:1627421319 -2147483648 8 0 66047 0;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{mso-style-parent:"";
	margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:12.0pt;
	font-family:"Times New Roman";
	mso-fareast-font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;
	text-underline:single;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;
	text-underline:single;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	mso-style-noshow:yes;
	mso-ansi-font-size:10.0pt;
	mso-bidi-font-size:10.0pt;
	font-family:Arial;
	mso-ascii-font-family:Arial;
	mso-hansi-font-family:Arial;
	mso-bidi-font-family:Arial;
	color:windowtext;}
span.SpellE
	{mso-style-name:"";
	mso-spl-e:yes;}
span.GramE
	{mso-style-name:"";
	mso-gram-e:yes;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;
	mso-paper-source:0;}
div.Section1
	{page:Section1;}
 /* List Definitions */
 @list l0
	{mso-list-id:1568297688;
	mso-list-type:hybrid;
	mso-list-template-ids:897870234 -1494862896 67698691 67698693 67698689 =
67698691 67698693 67698689 67698691 67698693;}
@list l0:level1
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Symbol;
	mso-fareast-font-family:"Times New Roman";
	mso-bidi-font-family:Arial;}
ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
-->
</style>
<!--[if gte mso 10]>
<style>
 /* Style Definitions */=20
 table.MsoNormalTable
	{mso-style-name:"Table Normal";
	mso-tstyle-rowband-size:0;
	mso-tstyle-colband-size:0;
	mso-style-noshow:yes;
	mso-style-parent:"";
	mso-padding-alt:0in 5.4pt 0in 5.4pt;
	mso-para-margin:0in;
	mso-para-margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	font-family:"Times New Roman";
	mso-ansi-language:#0400;
	mso-fareast-language:#0400;
	mso-bidi-language:#0400;}
</style>
<![endif]-->
</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple =
style=3D'tab-interval:.5in'>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Hi all,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I have been struggling with a problem here where the =
nodes
enter <span class=3DSpellE><span =
class=3DGramE>PausedSync</span></span><span
class=3DGramE>[</span>T|S] and stay there. <span
style=3D'mso-spacerun:yes'>&nbsp;</span><o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>This happens when one node <span =
class=3DGramE>come</span> up
from a fresh attach, connect sequence. <span
style=3D'mso-spacerun:yes'>&nbsp;</span>I think the issue happens this =
way. Say
we have two volumes drbd5 and drbd16 and we attempt to connect both of =
them at
roughly the same time. <span =
style=3D'mso-spacerun:yes'>&nbsp;</span><span
class=3DSpellE>Futhermore</span>, drbd5 and 16 will require syncing say =
as sync
target. What I observe is this:<o:p></o:p></span></font></p>

<ul style=3D'margin-top:0in' type=3Ddisc>
 <li class=3DMsoNormal style=3D'mso-list:l0 level1 lfo1;tab-stops:list =
.5in'><span
     class=3DGramE><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
     font-family:Arial'>drbd16</span></font></span><font size=3D2 =
face=3DArial><span
     style=3D'font-size:10.0pt;font-family:Arial'> is connecting and =
drbd5 is
     syncing. So 16 is paused <span =
class=3DSpellE>isp</span>=3D1<o:p></o:p></span></font></li>
 <li class=3DMsoNormal style=3D'mso-list:l0 level1 lfo1;tab-stops:list =
.5in'><span
     class=3DGramE><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
     font-family:Arial'>drbd16</span></font></span><font size=3D2 =
face=3DArial><span
     style=3D'font-size:10.0pt;font-family:Arial'> enters <span =
class=3DSpellE>receive_state</span>()
     but before acquiring the <span class=3DSpellE>req_lock</span> that =
thread
     loses the CPU to drbd5 that is finishing syncing.<span
     style=3D'mso-spacerun:yes'>&nbsp; </span><span =
class=3DSpellE>After_isp</span>
     is cleared on 16 giving drbd16 the green light to continue syncing. =
So far
     so good.<o:p></o:p></span></font></li>
 <li class=3DMsoNormal style=3D'mso-list:l0 level1 lfo1;tab-stops:list =
.5in'><font
     size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>Now
     drbd16 resumes with the old <span =
class=3DSpellE>peer_isp</span>=3D1 <o:p></o:p></span></font></li>
 <li class=3DMsoNormal style=3D'mso-list:l0 level1 lfo1;tab-stops:list =
.5in'><font
     size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>So now
     we are paused forever.<o:p></o:p></span></font></li>
</ul>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></fo=
nt></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>So I think <span =
class=3DSpellE>receive_<span
class=3DGramE>state</span></span><span class=3DGramE>(</span>) is just =
racy but I
could be wrong. I am really not sure how to fix this but I include a =
patch here
that may help to at least illustrate the problem. It seems close window =
for
this particular race somewhat.<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></fo=
nt></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>Below are the original logs =
on the
two nodes:<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D1 =
color=3Dblack
face=3DTahoma><span =
style=3D'font-size:9.0pt;font-family:Tahoma;color:black'>=3D=3D=3D=3D=3D=3D=
Node
0 logs=3D=3D=3D=3D=3D<br>
Oct<span class=3DGramE>&nbsp; 4</span> 03:38:11 node0 kernel: drbd5: =
Handshake
successful: DRBD Network Protocol version 86<br>
Oct<span class=3DGramE>&nbsp; 4</span> 03:38:12 node0 kernel: drbd5: =
<span
class=3DSpellE>drbd_sync_handshake</span>:<br>
Oct<span class=3DGramE>&nbsp; 4</span> 03:38:12 node0 kernel: drbd5: =
self
F8152BAF51D9EACC:0000000000000000:4981B7129527F32B:0000000000000006<br>
Oct<span class=3DGramE>&nbsp; 4</span> 03:38:12 node0 kernel: drbd5: =
peer
015A3BE2ED294C8D:F8152BAF51D9EACD:4981B7129527F32A:0000000000000006<br>
Oct<span class=3DGramE>&nbsp; 4</span> 03:38:12 node0 kernel: drbd5: =
<span
class=3DSpellE>uuid_compare</span>()=3D-1 by rule 5<br>
Oct&nbsp; 4 03:38:12 node0 kernel: drbd5: peer( Unknown -&gt; Primary ) =
<span
class=3DSpellE>conn</span>( <span class=3DSpellE>WFReportParams</span> =
-&gt; <span
class=3DSpellE>WFBitMapT</span> ) <span class=3DSpellE>pdsk</span>( =
<span
class=3DSpellE>DUnknown</span> -&gt; <span =
class=3DSpellE>UpToDate</span> )<br>
Oct<span class=3DGramE>&nbsp; 4</span> 03:38:12 node0 kernel: drbd5: =
Writing meta
data super block now.<br>
Oct<span class=3DGramE>&nbsp; 4</span> 03:38:12 node0 kernel: drbd5: =
<span
class=3DSpellE>conn</span>( <span class=3DSpellE>WFBitMapT</span> -&gt; =
<span
class=3DSpellE>WFSyncUUID</span> )<br>
Oct<span class=3DGramE>&nbsp; 4</span> 03:38:12 node0 kernel: =
drbd5:&nbsp; <span
class=3DSpellE>uuid</span>[Current] now 7C1CB159A4E77906<br>
Oct<span class=3DGramE>&nbsp; 4</span> 03:38:12 node0 kernel: =
drbd5:&nbsp; <span
class=3DSpellE>uuid</span>[Bitmap] now 0000000000000000<br>
Oct<span class=3DGramE>&nbsp; 4</span> 03:38:13 node0 kernel: drbd5: =
<span
class=3DSpellE>conn</span>( <span class=3DSpellE>WFSyncUUID</span> -&gt; =
<span
class=3DSpellE>SyncTarget</span> ) disk( <span =
class=3DSpellE>UpToDate</span> -&gt;
Inconsistent )<br>
Oct<span class=3DGramE>&nbsp; 4</span> 03:38:14 node0 kernel: drbd16: =
<span
class=3DSpellE>aftr_isp</span>( 0 -&gt; 1 )<br>
Oct<span class=3DGramE>&nbsp; 4</span> 03:38:17 node0 kernel: drbd5: =
Began <span
class=3DSpellE>resync</span> as <span class=3DSpellE>SyncTarget</span> =
(will sync
1444 KB [361 bits set]).<br>
Oct<span class=3DGramE>&nbsp; 4</span> 03:38:17 node0 kernel: drbd5: =
Writing meta
data super block now.<br>
Oct<span class=3DGramE>&nbsp; 4</span> 03:38:17 node0 kernel: drbd16: =
<span
class=3DSpellE>conn</span>( <span class=3DSpellE>StandAlone</span> -&gt;
Unconnected )<br>
Oct<span class=3DGramE>&nbsp; 4</span> 03:38:17 node0 kernel: drbd16: =
receiver
(re)started<br>
Oct<span class=3DGramE>&nbsp; 4</span> 03:38:17 node0 kernel: drbd16: =
<span
class=3DSpellE>conn</span>( Unconnected -&gt; <span =
class=3DSpellE>WFConnection</span>
)<br>
Oct<span class=3DGramE>&nbsp; 4</span> 03:38:17 node0 kernel: drbd16: =
<span
class=3DSpellE>conn</span>( <span class=3DSpellE>WFConnection</span> =
-&gt; <span
class=3DSpellE>WFReportParams</span> )<br>
Oct<span class=3DGramE>&nbsp; 4</span> 03:38:17 node0 kernel: drbd16: =
Handshake
successful: DRBD Network Protocol version 86<br>
Oct<span class=3DGramE>&nbsp; 4</span> 03:38:17 node0 kernel: drbd16: =
Writing
meta data super block now.<br>
Oct<span class=3DGramE>&nbsp; 4</span> 03:38:17 node0 kernel: drbd5: =
<span
class=3DSpellE>Resync</span> done (total 1 sec; paused 0 sec; 1444 =
K/sec)<br>
Oct<span class=3DGramE>&nbsp; 4</span> 03:38:17 node0 kernel: =
drbd5:&nbsp; <span
class=3DSpellE>uuid</span>[Bitmap] now F8152BAF51D9EACD<br>
Oct<span class=3DGramE>&nbsp; 4</span> 03:38:17 node0 kernel: =
drbd5:&nbsp; <span
class=3DSpellE>uuid</span>[<span class=3DSpellE>History_start</span>] =
now
4981B7129527F32A<br>
Oct<span class=3DGramE>&nbsp; 4</span> 03:38:17 node0 kernel: =
drbd5:&nbsp; <span
class=3DSpellE>uuid</span>[<span class=3DSpellE>History_end</span>] now
0000000000000006<br>
Oct<span class=3DGramE>&nbsp; 4</span> 03:38:17 node0 kernel: =
drbd5:&nbsp; <span
class=3DSpellE>uuid</span>[<span class=3DSpellE>History_start</span>] =
now
F8152BAF51D9EACD<br>
Oct<span class=3DGramE>&nbsp; 4</span> 03:38:17 node0 kernel: =
drbd5:&nbsp; <span
class=3DSpellE>uuid</span>[Bitmap] now 7C1CB159A4E77906<br>
Oct<span class=3DGramE>&nbsp; 4</span> 03:38:18 node0 kernel: =
drbd5:&nbsp; <span
class=3DSpellE>uuid</span>[Current] now 015A3BE2ED294C8C<br>
Oct<span class=3DGramE>&nbsp; 4</span> 03:38:18 node0 kernel: =
drbd5:&nbsp; <span
class=3DSpellE>uuid</span>[<span class=3DSpellE>History_start</span>] =
now
7C1CB159A4E77906<br>
Oct<span class=3DGramE>&nbsp; 4</span> 03:38:18 node0 kernel: =
drbd5:&nbsp; <span
class=3DSpellE>uuid</span>[Bitmap] now 0000000000000000<br>
Oct<span class=3DGramE>&nbsp; 4</span> 03:38:18 node0 kernel: drbd5: =
<span
class=3DSpellE>conn</span>( <span class=3DSpellE>SyncTarget</span> -&gt; =
Connected
) disk( Inconsistent -&gt; <span class=3DSpellE>UpToDate</span> )<br>
Oct<span class=3DGramE>&nbsp; 4</span> 03:38:18 node0 kernel: drbd16: =
<span
class=3DSpellE>aftr_isp</span>( 1 -&gt; 0 )<br>
Oct<span class=3DGramE>&nbsp; 4</span> 03:38:20 node0 kernel: drbd5: =
Writing meta
data super block now.<br>
Oct<span class=3DGramE>&nbsp; 4</span> 03:38:20 node0 kernel: drbd16: =
writing of
bitmap took 1 jiffies<br>
Oct<span class=3DGramE>&nbsp; 4</span> 03:38:20 node0 kernel: drbd16: =
4095 MB
marked out-of-sync by on disk bit-map.<br>
Oct<span class=3DGramE>&nbsp; 4</span> 03:38:20 node0 kernel: drbd16: =
4194140 KB
now marked out-of-sync by on disk bit-map.<br>
Oct<span class=3DGramE>&nbsp; 4</span> 03:38:20 node0 kernel: drbd16: =
Writing
meta data super block now.<br>
Oct&nbsp; 4 03:38:20 node0 kernel: drbd16: peer( Unknown -&gt; Primary ) =
<span
class=3DSpellE>conn</span>( <span class=3DSpellE>WFReportParams</span> =
-&gt; <span
class=3DSpellE>WFBitMapT</span> ) <span class=3DSpellE>pdsk</span>( =
<span
class=3DSpellE>DUnknown</span> -&gt; <span =
class=3DSpellE>UpToDate</span> ) <span
class=3DSpellE>peer_isp</span>( 0 -&gt; 1 )<br>
Oct<span class=3DGramE>&nbsp; 4</span> 03:38:21 node0 kernel: drbd16: =
Writing
meta data super block now.<br>
Oct<span class=3DGramE>&nbsp; 4</span> 03:38:21 node0 kernel: drbd16: =
<span
class=3DSpellE>conn</span>( <span class=3DSpellE>WFBitMapT</span> -&gt; =
<span
class=3DSpellE>WFSyncUUID</span> )<br>
Oct<span class=3DGramE>&nbsp; 4</span> 03:38:21 node0 kernel: drbd16: =
<span
class=3DSpellE>conn</span>( <span class=3DSpellE>WFSyncUUID</span> -&gt; =
<span
class=3DSpellE>PausedSyncT</span> ) disk( <span =
class=3DSpellE>UpToDate</span>
-&gt; Inconsistent )<br>
Oct<span class=3DGramE>&nbsp; 4</span> 03:38:21 node0 kernel: drbd16: =
Began <span
class=3DSpellE>resync</span> as <span class=3DSpellE>PausedSyncT</span> =
(will sync
4194140 KB [1048535 bits set]).<br>
Oct<span class=3DGramE>&nbsp; 4</span> 03:38:21 node0 kernel: drbd16: =
Writing
meta data super block now.<br>
<br>
<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3DNode1=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
<br>
Oct<span class=3DGramE>&nbsp; 4</span> 03:38:11 node1 kernel: drbd5: =
Handshake
successful: DRBD Network Protocol version 86<br>
Oct<span class=3DGramE>&nbsp; 4</span> 03:38:11 node1 kernel: drbd5: =
<span
class=3DSpellE>drbd_sync_handshake</span>:<br>
Oct<span class=3DGramE>&nbsp; 4</span> 03:38:11 node1 kernel: drbd5: =
self
015A3BE2ED294C8D:F8152BAF51D9EACD:4981B7129527F32A:0000000000000006<br>
Oct<span class=3DGramE>&nbsp; 4</span> 03:38:11 node1 kernel: drbd5: =
peer
F8152BAF51D9EACC:0000000000000000:4981B7129527F32B:0000000000000006<br>
Oct<span class=3DGramE>&nbsp; 4</span> 03:38:11 node1 kernel: drbd5: =
<span
class=3DSpellE>uuid_compare</span>()=3D1 by rule 7<br>
Oct&nbsp; 4 03:38:11 node1 kernel: drbd5: peer( Unknown -&gt; Secondary =
) <span
class=3DSpellE>conn</span>( <span class=3DSpellE>WFReportParams</span> =
-&gt; <span
class=3DSpellE>WFBitMapS</span> ) <span class=3DSpellE>pdsk</span>( =
<span
class=3DSpellE>DUnknown</span> -&gt; <span =
class=3DSpellE>UpToDate</span> )<br>
Oct<span class=3DGramE>&nbsp; 4</span> 03:38:11 node1 kernel: drbd5: =
Writing meta
data super block now.<br>
Oct<span class=3DGramE>&nbsp; 4</span> 03:38:11 node1 kernel: =
drbd5:&nbsp; <span
class=3DSpellE>uuid</span>[<span class=3DSpellE>History_start</span>] =
now
F8152BAF51D9EACD<br>
Oct<span class=3DGramE>&nbsp; 4</span> 03:38:11 node1 kernel: =
drbd5:&nbsp; <span
class=3DSpellE>uuid</span>[Bitmap] now 7C1CB159A4E77906<br>
Oct<span class=3DGramE>&nbsp; 4</span> 03:38:11 node1 kernel: drbd5: =
<span
class=3DSpellE>conn</span>( <span class=3DSpellE>WFBitMapS</span> -&gt; =
<span
class=3DSpellE>SyncSource</span> ) <span class=3DSpellE>pdsk</span>( =
<span
class=3DSpellE>UpToDate</span> -&gt; Inconsistent )<br>
Oct<span class=3DGramE>&nbsp; 4</span> 03:38:11 node1 kernel: drbd16: =
<span
class=3DSpellE>aftr_isp</span>( 0 -&gt; 1 )<br>
Oct<span class=3DGramE>&nbsp; 4</span> 03:38:13 node1 kernel: drbd5: =
Began <span
class=3DSpellE>resync</span> as <span class=3DSpellE>SyncSource</span> =
(will sync
1444 KB [361 bits set]).<br>
Oct<span class=3DGramE>&nbsp; 4</span> 03:38:13 node1 kernel: drbd5: =
Writing meta
data super block now.<br>
Oct<span class=3DGramE>&nbsp; 4</span> 03:38:13 node1 kernel: drbd16: =
<span
class=3DSpellE>conn</span>( <span class=3DSpellE>WFConnection</span> =
-&gt; <span
class=3DSpellE>WFReportParams</span> )<br>
Oct<span class=3DGramE>&nbsp; 4</span> 03:38:13 node1 kernel: drbd16: =
Handshake
successful: DRBD Network Protocol version 86<br>
Oct<span class=3DGramE>&nbsp; 4</span> 03:38:13 node1 kernel: drbd16: =
Writing
meta data super block now.<br>
Oct<span class=3DGramE>&nbsp; 4</span> 03:38:13 node1 kernel: drbd5: =
<span
class=3DSpellE>Resync</span> done (total 1 sec; paused 0 sec; 1444 =
K/sec)<br>
Oct<span class=3DGramE>&nbsp; 4</span> 03:38:13 node1 kernel: =
drbd5:&nbsp; <span
class=3DSpellE>uuid</span>[<span class=3DSpellE>History_start</span>] =
now 7C1CB159A4E77906<br>
Oct<span class=3DGramE>&nbsp; 4</span> 03:38:13 node1 kernel: =
drbd5:&nbsp; <span
class=3DSpellE>uuid</span>[Bitmap] now 0000000000000000<br>
Oct<span class=3DGramE>&nbsp; 4</span> 03:38:13 node1 kernel: drbd5: =
<span
class=3DSpellE>conn</span>( <span class=3DSpellE>SyncSource</span> -&gt; =
Connected
) <span class=3DSpellE>pdsk</span>( Inconsistent -&gt; <span =
class=3DSpellE>UpToDate</span>
)<br>
Oct<span class=3DGramE>&nbsp; 4</span> 03:38:13 node1 kernel: drbd16: =
<span
class=3DSpellE>aftr_isp</span>( 1 -&gt; 0 )<br>
Oct<span class=3DGramE>&nbsp; 4</span> 03:38:15 node1 kernel: drbd5: =
Writing meta
data super block now.<br>
Oct<span class=3DGramE>&nbsp; 4</span> 03:38:15 node1 kernel: drbd16: =
writing of
bitmap took 1 jiffies<br>
Oct<span class=3DGramE>&nbsp; 4</span> 03:38:15 node1 kernel: drbd16: =
4095 MB
marked out-of-sync by on disk bit-map.<br>
Oct<span class=3DGramE>&nbsp; 4</span> 03:38:15 node1 kernel: drbd16: =
4194140 KB
now marked out-of-sync by on disk bit-map.<br>
Oct<span class=3DGramE>&nbsp; 4</span> 03:38:16 node1 kernel: drbd16: =
Writing
meta data super block now.<br>
Oct&nbsp; 4 03:38:16 node1 kernel: drbd16: peer( Unknown -&gt; Secondary =
) <span
class=3DSpellE>conn</span>( <span class=3DSpellE>WFReportParams</span> =
-&gt; <span
class=3DSpellE>WFBitMapS</span> ) <span class=3DSpellE>pdsk</span>( =
<span
class=3DSpellE>DUnknown</span> -&gt; <span =
class=3DSpellE>UpToDate</span> ) <span
class=3DSpellE>peer_isp</span>( 0 -&gt; 1 )<br>
Oct<span class=3DGramE>&nbsp; 4</span> 03:38:18 node1 kernel: drbd16: =
Writing
meta data super block now.<br>
Oct<span class=3DGramE>&nbsp; 4</span> 03:38:18 node1 kernel: drbd16: =
<span
class=3DSpellE>conn</span>( <span class=3DSpellE>WFBitMapS</span> -&gt; =
<span
class=3DSpellE>PausedSyncS</span> ) <span class=3DSpellE>pdsk</span>( =
<span
class=3DSpellE>UpToDate</span> -&gt; Inconsistent )<br>
Oct<span class=3DGramE>&nbsp; 4</span> 03:38:18 node1 kernel: drbd16: =
Began <span
class=3DSpellE>resync</span> as <span class=3DSpellE>PausedSyncS</span> =
(will sync
4194140 KB [1048535 bits set]).<br>
Oct<span class=3DGramE>&nbsp; 4</span> 03:38:18 node1 kernel: drbd16: =
Writing
meta data super block now.</span></font><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'><o:p></o:p></span></font></p=
>

</div>

</body>

</html>

------_=_NextPart_002_01C81A7B.BA97120E--

------_=_NextPart_001_01C81A7B.BA97120E
Content-Type: application/octet-stream;
	name="stuck_in_pausesynct.patch"
Content-Transfer-Encoding: base64
Content-Description: stuck_in_pausesynct.patch
Content-Disposition: attachment;
	filename="stuck_in_pausesynct.patch"

SW5kZXg6IGRyYmQvZHJiZF9tYWluLmMKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQotLS0gZHJiZC9kcmJkX21haW4uYwko
cmV2aXNpb24gMTkzODEpCisrKyBkcmJkL2RyYmRfbWFpbi5jCSh3b3JraW5nIGNvcHkpCkBAIC05
NTUsNyArOTU1LDcgQEAKIAl9CiAKIAkvKiBXZSB3YW50IHRvIHBhdXNlL2NvbnRpbnVlIHJlc3lu
YywgdGVsbCBwZWVyLiAqLwotCWlmICggbnMuY29ubiA+PSBDb25uZWN0ZWQgJiYgCisJaWYgKCBu
cy5jb25uID49IFdGUmVwb3J0UGFyYW1zICYmIAogCSAgICAgKCggb3MuYWZ0cl9pc3AgIT0gbnMu
YWZ0cl9pc3AgKSB8fAogCSAgICAgICggb3MudXNlcl9pc3AgIT0gbnMudXNlcl9pc3AgKSkgKSB7
CiAJCWRyYmRfc2VuZF9zdGF0ZShtZGV2KTsK

------_=_NextPart_001_01C81A7B.BA97120E--
