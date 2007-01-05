Return-Path: <Ernest.Montrose@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C73108.C3BA719E"
Date: Fri, 5 Jan 2007 15:33:31 -0500
Message-ID: <BD7042533C2F8943A6A4257A9E31C45439C8B3@EXNA.corp.stratus.com>
From: "Montrose, Ernest" <Ernest.Montrose@stratus.com>
To: <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] DRBD8: Node state stuck in :WFBitMapT on both node.
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C73108.C3BA719E
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Under a xen migration test with moderate I/O we easily get into this
state where both nodes enters: WFBitMapT.
We can recover from this by rebooting one node.  This is broken by som
recent changes.  I can say that it worked=20
Before  these changes:
Broken with these changes:
------------------------------------------------------------------------
r8476 | emontros | 2007-01-03 11:01:31 -0500 (Wed, 03 Jan 2007) | 62
lines

Merged revisions 8360-8456 via svnmerge from
http://svn/vendor/drbd-8/trunk <http://svn/vendor/drbd-8/trunk>=20

........
r8408 | sgraham | 2006-12-28 13:53:59 -0500 (Thu, 28 Dec 2006) | 38
lines

[DRBD-8 @ 2648]
With this patch I try to make DRBD to send more big packets,
and less small packets. Somethimes I experienced that enabling
Jumbo frames decreased DRBD's preformance. Altough, I could
not reproduce this at time of writing the patch, I managed to
measure the distribution of the packet's sizes. This indicates
that the patch has the intended effect:

Distribution of packet sizen when writing 512MB of zeros:

      pkt          old-code        new-code
    sizes      send    recv  send    recv
    ----------  ------------------------------
    1 to  450:  42047  42259  38629  38784
  451 to  900:  4057    4230    2023    2176
  901 to 1350:    112    2919      54    2289
  1351 to 1800:  6697    7439    6698    7368
  1801 to 2250:    11      43      4      8
  2251 to 2700:  1643    1684    1838    2307
  2701 to 3150:      5      43      3      18
  3151 to 3600:      2      70      0      51
  3601 to 4050:    95    218      2    251
  4051 to 4500:  3159    3296      1      58
  4501 to 4950:    45    270      6    176
  4951 to 5400:    75    717      60    453
  5401 to 5850:    867    901    1376    1383
  5851 to 6300:    683    696    245    251
  6301 to 6750:    129    214      44      47
  6751 to 7200:    24      39    266    274
  7201 to 7650:    101    118    256    263
  7651 to 8100:    30    1829      70    2109
  8101 to 8550:    36      48      49      56
  8551 to 9000+: 14971  53657  15755  54992

-Phil

Original author: phil
Date: 2006-12-28 12:07:12.682853+00:00
........
r8409 | sgraham | 2006-12-28 13:54:04 -0500 (Thu, 28 Dec 2006) | 5 lines

[DRBD-8 @ 2649]
Make DRBD compile even on SLES9 (Kernel 2.6.5)

Original author: phil
Date: 2006-12-28 15:54:28.853546+00:00
........
r8455 | sgraham | 2007-01-02 09:04:11 -0500 (Tue, 02 Jan 2007) | 5 lines

[DRBD-8 @ 2650]
Fixed a few error strings...

Original author: phil
Date: 2007-01-02 13:47:28.435731+00:00
........

------------------------------------------------------------------------
=20
Here the state traces:
=20
Here is the log for JErry:
drbd2: disk( Diskless -> Attaching )
drbd2: Found 6 transactions (267 active extents) in activity log.
drbd2: max_segment_size ( =3D BIO size ) =3D 32768
drbd2: drbd_bm_resize called with capacity =3D=3D 30735368
drbd2: resync bitmap: bits=3D3841921 words=3D120062
drbd2: size =3D 14 GB (15367684 KB)
drbd2: reading of bitmap took 18 jiffies
drbd2: recounting of set bits took additional 1 jiffies
drbd2: 0 KB marked out-of-sync by on disk bit-map.
drbd2: disk( Attaching -> UpToDate )
drbd2: Writing meta data super block now.
drbd2: conn( StandAlone -> Unconnected )
drbd2: receiver (re)started
drbd2: conn( Unconnected -> WFConnection )
drbd2: conn( WFConnection -> WFReportParams )
drbd2: Handshake successful: DRBD Network Protocol version 85
drbd2: drbd_sync_handshake:
drbd2: self
1999C2A90658DA42:0000000000000000:30A5702D832E1702:0000000000000004
drbd2: peer
1999C2A90658DA43:0000000000000000:30A5702D832E1702:0000000000000004
drbd2: uuid_compare()=3D-1
drbd2:  uuid[History_start] now 1999C2A90658DA42
drbd2:  uuid[Current] now 0000000000000000
drbd2: peer( Unknown -> Secondary ) conn( WFReportParams -> WFBitMapT )
pdsk( DUnknown -> UpToDate )
drbd2: Writing meta data super block now.
drbd2: aftr_isp( 0 -> 1 )
drbd2: conn( WFBitMapT -> WFSyncUUID )
drbd2: peer_isp( 0 -> 1 )
drbd2:  uuid[Current] now FC968953A6746EEC
drbd2:  uuid[Bitmap] now 0000000000000000
drbd2: conn( WFSyncUUID -> PausedSyncT ) disk( UpToDate -> Inconsistent
)
drbd2: Began resync as PausedSyncT (will sync 1052672 KB [263168 bits
set]).
drbd2: Writing meta data super block now.
drbd2: peer( Secondary -> Primary )
drbd2: peer_isp( 1 -> 0 )
drbd2: conn( PausedSyncT -> SyncTarget ) aftr_isp( 1 -> 0 )
drbd2: Syncer continues.
drbd2: Resync done (total 225 sec; paused 61 sec; 6416 K/sec)
drbd2:  uuid[Bitmap] now 0000000000000000
drbd2:  uuid[History_start] now 30A5702D832E1702
drbd2:  uuid[History_end] now 0000000000000004
drbd2:  uuid[Bitmap] now FC968953A6746EEC
drbd2:  uuid[Current] now 1999C2A90658DA42
drbd2:  uuid[History_start] now FC968953A6746EEC
drbd2:  uuid[Bitmap] now 0000000000000000
drbd2: conn( SyncTarget -> Connected ) disk( Inconsistent -> UpToDate )
drbd2: Writing meta data super block now.
drbd2: drbd_open: Allowing open in Secondary state
drbd2: drbd_sync_handshake:
drbd2: self
1999C2A90658DA42:0000000000000000:FC968953A6746EEC:30A5702D832E1702
drbd2: peer
1999C2A90658DA42:0000000000000000:FC968953A6746EEC:30A5702D832E1702
drbd2: uuid_compare()=3D-1
drbd2:  uuid[History_start] now 1999C2A90658DA42
drbd2:  uuid[Current] now 0000000000000000
drbd2: peer( Primary -> Secondary ) conn( Connected -> WFBitMapT )
drbd2: Writing meta data super block now.
drbd2: role( Secondary -> Primary )
drbd2: Writing meta data super block now.


On ben the other node we have:

drbd2: disk( Diskless -> Attaching )
drbd2: Found 6 transactions (324 active extents) in activity log.
drbd2: max_segment_size ( =3D BIO size ) =3D 32768
drbd2: drbd_bm_resize called with capacity =3D=3D 30735368
drbd2: resync bitmap: bits=3D3841921 words=3D120062
drbd2: size =3D 14 GB (15367684 KB)
drbd2: reading of bitmap took 26 jiffies
drbd2: recounting of set bits took additional 1 jiffies
drbd2: 0 KB marked out-of-sync by on disk bit-map.
drbd2: Marked additional 1028 MB as out-of-sync based on AL.
drbd2: disk( Attaching -> UpToDate )
drbd2: Writing meta data super block now.
drbd2: conn( StandAlone -> Unconnected )
drbd2: receiver (re)started
drbd2: conn( Unconnected -> WFConnection )
drbd2: conn( WFConnection -> WFReportParams )
drbd2: Handshake successful: DRBD Network Protocol version 85
drbd2: drbd_sync_handshake:
drbd2: self
1999C2A90658DA43:0000000000000000:30A5702D832E1702:0000000000000004
drbd2: peer
1999C2A90658DA42:0000000000000000:30A5702D832E1702:0000000000000004
drbd2: uuid_compare()=3D1
drbd2: peer( Unknown -> Secondary ) conn( WFReportParams -> WFBitMapS )
pdsk( DUnknown -> UpToDate )
drbd2: aftr_isp( 0 -> 1 )
drbd2: Writing meta data super block now.
drbd2: peer_isp( 0 -> 1 )
drbd2:  uuid[Bitmap] now FC968953A6746EEC
drbd2: conn( WFBitMapS -> PausedSyncS ) pdsk( UpToDate -> Inconsistent )
drbd2: Began resync as PausedSyncS (will sync 1052672 KB [263168 bits
set]).
drbd2: Writing meta data super block now.
drbd2: role( Secondary -> Primary )
drbd2: Writing meta data super block now.
drbd2: aftr_isp( 1 -> 0 )
drbd2: conn( PausedSyncS -> SyncSource ) peer_isp( 1 -> 0 )
drbd2: Syncer continues.
drbd2: Resync done (total 225 sec; paused 61 sec; 6416 K/sec)
drbd2:  uuid[History_start] now FC968953A6746EEC
drbd2:  uuid[Bitmap] now 0000000000000000
drbd2: conn( SyncSource -> Connected ) pdsk( Inconsistent -> UpToDate )
drbd2: Writing meta data super block now.
drbd2: role( Primary -> Secondary )
drbd2: Writing meta data super block now.
drbd2: drbd_sync_handshake:
drbd2: self
1999C2A90658DA43:0000000000000000:FC968953A6746EEC:30A5702D832E1702
drbd2: peer
0000000000000000:0000000000000000:1999C2A90658DA42:FC968953A6746EEC
drbd2: uuid_compare()=3D-2
drbd2: Writing meta data super block now.
drbd2: writing of bitmap took 59 jiffies
drbd2: 14 GB marked out-of-sync by on disk bit-map.
drbd2: 15367684 KB now marked out-of-sync by on disk bit-map.
drbd2: Writing meta data super block now.
drbd2:  uuid[History_start] now 1999C2A90658DA43
drbd2:  uuid[Current] now 0000000000000000
drbd2: conn( Connected -> WFBitMapT )
drbd2: Writing meta data super block now.
drbd2: peer( Secondary -> Primary )
=20

------_=_NextPart_001_01C73108.C3BA719E
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:st1=3D"urn:schemas-microsoft-com:office:smarttags" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DProgId content=3DWord.Document>
<meta name=3DGenerator content=3D"Microsoft Word 11">
<meta name=3DOriginator content=3D"Microsoft Word 11">
<link rel=3DFile-List href=3D"cid:filelist.xml@01C730DE.DAD62A10">
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"State"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"place"/>
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
</xml><![endif]--><!--[if !mso]>
<style>
st1\:*{behavior:url(#default#ieooui) }
</style>
<![endif]-->
<style>
<!--
 /* Font Definitions */
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
font-family:Arial'>Under a <span class=3DSpellE>xen</span> migration =
test with
moderate I/O we easily get into this state where both nodes <span =
class=3DGramE>enters</span>:
<span class=3DSpellE>WFBitMapT</span>.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>We can recover from this by rebooting one node. <span
style=3D'mso-spacerun:yes'>&nbsp;</span>This is broken by <span =
class=3DSpellE>som</span>
recent changes. <span style=3D'mso-spacerun:yes'>&nbsp;</span>I can say =
that it worked
<o:p></o:p></span></font></p>

<p class=3DMsoNormal><span class=3DGramE><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>Before <span
style=3D'mso-spacerun:yes'>&nbsp;</span>these</span></font></span><font =
size=3D2
face=3DArial><span style=3D'font-size:10.0pt;font-family:Arial'> =
changes:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 color=3Dblack face=3DTahoma><span =
style=3D'font-size:
9.0pt;font-family:Tahoma;color:black'>Broken with these changes:<br>
------------------------------------------------------------------------<=
br>
r8476 | <span class=3DSpellE>emontros</span> | 2007-01-03 11:01:31 -0500 =
(Wed, 03
Jan 2007) | 62 lines<br>
<br>
Merged revisions 8360-8456 via <span class=3DSpellE>svnmerge</span> =
from<br>
<a href=3D"http://svn/vendor/drbd-8/trunk"><font color=3D"#0000b4"><span
style=3D'color:#0000B4'>http://svn/vendor/drbd-8/trunk</span></font></a><=
br>
<br>
........<br>
r8408 | <span class=3DSpellE>sgraham</span> | 2006-12-28 13:53:59 -0500 =
(Thu, 28
Dec 2006) | 38 lines<br>
<br>
[DRBD-8 @ 2648]<br>
With this patch I try to make DRBD to send more big packets,<br>
<span class=3DGramE>and</span> less small packets. <span =
class=3DSpellE>Somethimes</span>
I experienced that enabling<br>
Jumbo frames decreased <span class=3DSpellE>DRBD's</span> <span =
class=3DSpellE>preformance</span>.
<span class=3DSpellE>Altough</span>, I could<br>
<span class=3DGramE>not</span> reproduce this at time of writing the =
patch, I
managed to<br>
<span class=3DGramE>measure</span> the distribution of the packet's =
sizes. This
indicates<br>
<span class=3DGramE>that</span> the patch has the intended effect:<br>
<br>
Distribution of packet <span class=3DSpellE>sizen</span> when writing =
512MB of
zeros:<br>
<br>
&nbsp; &nbsp; &nbsp; <span class=3DSpellE><span =
class=3DGramE>pkt</span></span>&nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; old-code&nbsp; &nbsp; &nbsp; &nbsp; =
new-code<br>
&nbsp; &nbsp; <span class=3DGramE>sizes</span>&nbsp; &nbsp; &nbsp; =
send&nbsp;
&nbsp; <span class=3DSpellE>recv</span>&nbsp; send&nbsp; &nbsp; <span
class=3DSpellE>recv</span><br>
&nbsp; &nbsp; ----------&nbsp; ------------------------------<br>
&nbsp; &nbsp; 1 to<span class=3DGramE>&nbsp; 450</span>:&nbsp; =
42047&nbsp;
42259&nbsp; 38629&nbsp; 38784<br>
&nbsp; 451 to<span class=3DGramE>&nbsp; 900</span>:&nbsp; 4057&nbsp; =
&nbsp;
4230&nbsp; &nbsp; 2023&nbsp; &nbsp; 2176<br>
&nbsp; 901 to 1350:&nbsp; &nbsp; 112&nbsp; &nbsp; 2919&nbsp; &nbsp; =
&nbsp;
54&nbsp; &nbsp; 2289<br>
&nbsp; 1351 to 1800:&nbsp; 6697&nbsp; &nbsp; 7439&nbsp; &nbsp; =
6698&nbsp;
&nbsp; 7368<br>
&nbsp; 1801 to 2250:&nbsp; &nbsp; 11&nbsp; &nbsp; &nbsp; 43&nbsp; &nbsp; =
&nbsp;
4&nbsp; &nbsp; &nbsp; 8<br>
&nbsp; 2251 to 2700:&nbsp; 1643&nbsp; &nbsp; 1684&nbsp; &nbsp; =
1838&nbsp;
&nbsp; 2307<br>
&nbsp; 2701 to 3150:&nbsp; &nbsp; &nbsp; 5&nbsp; &nbsp; &nbsp; 43&nbsp; =
&nbsp;
&nbsp; 3&nbsp; &nbsp; &nbsp; 18<br>
&nbsp; 3151 to 3600:&nbsp; &nbsp; &nbsp; 2&nbsp; &nbsp; &nbsp; 70&nbsp; =
&nbsp;
&nbsp; 0&nbsp; &nbsp; &nbsp; 51<br>
&nbsp; 3601 to 4050:&nbsp; &nbsp; 95&nbsp; &nbsp; 218&nbsp; &nbsp; =
&nbsp;
2&nbsp; &nbsp; 251<br>
&nbsp; 4051 to 4500:&nbsp; 3159&nbsp; &nbsp; 3296&nbsp; &nbsp; &nbsp; =
1&nbsp;
&nbsp; &nbsp; 58<br>
&nbsp; 4501 to 4950:&nbsp; &nbsp; 45&nbsp; &nbsp; 270&nbsp; &nbsp; =
&nbsp;
6&nbsp; &nbsp; 176<br>
&nbsp; 4951 to 5400:&nbsp; &nbsp; 75&nbsp; &nbsp; 717&nbsp; &nbsp; =
&nbsp;
60&nbsp; &nbsp; 453<br>
&nbsp; 5401 to 5850:&nbsp; &nbsp; 867&nbsp; &nbsp; 901&nbsp; &nbsp; =
1376&nbsp;
&nbsp; 1383<br>
&nbsp; 5851 to 6300:&nbsp; &nbsp; 683&nbsp; &nbsp; 696&nbsp; &nbsp; =
245&nbsp;
&nbsp; 251<br>
&nbsp; 6301 to 6750:&nbsp; &nbsp; 129&nbsp; &nbsp; 214&nbsp; &nbsp; =
&nbsp;
44&nbsp; &nbsp; &nbsp; 47<br>
&nbsp; 6751 to 7200:&nbsp; &nbsp; 24&nbsp; &nbsp; &nbsp; 39&nbsp; &nbsp;
266&nbsp; &nbsp; 274<br>
&nbsp; 7201 to 7650:&nbsp; &nbsp; 101&nbsp; &nbsp; 118&nbsp; &nbsp; =
256&nbsp;
&nbsp; 263<br>
&nbsp; 7651 to 8100:&nbsp; &nbsp; 30&nbsp; &nbsp; 1829&nbsp; &nbsp; =
&nbsp;
70&nbsp; &nbsp; 2109<br>
&nbsp; 8101 to 8550:&nbsp; &nbsp; 36&nbsp; &nbsp; &nbsp; 48&nbsp; &nbsp; =
&nbsp;
49&nbsp; &nbsp; &nbsp; 56<br>
&nbsp; 8551 to 9000+: 14971<span class=3DGramE>&nbsp; 53657</span>&nbsp;
15755&nbsp; 54992<br>
<br>
-Phil<br>
<br>
Original author: <span class=3DSpellE><span =
class=3DGramE>phil</span></span><br>
Date: 2006-12-28 12:07:12.682853+00:00<br>
........<br>
r8409 | <span class=3DSpellE>sgraham</span> | 2006-12-28 13:54:04 -0500 =
(Thu, 28
Dec 2006) | 5 lines<br>
<br>
[DRBD-8 @ 2649]<br>
Make DRBD compile even on SLES9 (Kernel 2.6.5)<br>
<br>
Original author: <span class=3DSpellE><span =
class=3DGramE>phil</span></span><br>
Date: 2006-12-28 15:54:28.853546+00:00<br>
........<br>
r8455 | <span class=3DSpellE>sgraham</span> | 2007-01-02 09:04:11 -0500 =
(Tue, 02
Jan 2007) | 5 lines<br>
<br>
[DRBD-8 @ 2650]<br>
Fixed a few error strings...<br>
<br>
Original author: <span class=3DSpellE><span =
class=3DGramE>phil</span></span><br>
Date: 2007-01-02 13:47:28.435731+00:00<br>
........<br>
<br>
------------------------------------------------------------------------<=
o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 color=3Dblack face=3DTahoma><span =
style=3D'font-size:
9.0pt;font-family:Tahoma;color:black'><o:p>&nbsp;</o:p></span></font></p>=


<p class=3DMsoNormal><font size=3D1 color=3Dblack face=3DTahoma><span =
style=3D'font-size:
9.0pt;font-family:Tahoma;color:black'>Here the state =
traces:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 color=3Dblack face=3DTahoma><span =
style=3D'font-size:
9.0pt;font-family:Tahoma;color:black'><o:p>&nbsp;</o:p></span></font></p>=


<p class=3DMsoNormal><font size=3D1 color=3Dblack face=3DTahoma><span =
style=3D'font-size:
9.0pt;font-family:Tahoma;color:black'>Here is the log for <span =
class=3DSpellE>JErry</span>:<br>
drbd2: <span class=3DGramE>disk(</span> Diskless -&gt; Attaching )<br>
drbd2: Found 6 transactions (267 active extents) in activity log.<br>
drbd2: <span class=3DSpellE>max_segment_size</span> <span =
class=3DGramE>( =3D</span>
BIO size ) =3D 32768<br>
drbd2: <span class=3DSpellE>drbd_bm_resize</span> called with capacity =
=3D=3D
30735368<br>
drbd2: <span class=3DSpellE>resync</span> bitmap: bits=3D3841921 =
words=3D120062<br>
drbd2: size =3D 14 GB (15367684 KB)<br>
drbd2: reading of bitmap took 18 jiffies<br>
drbd2: recounting of set bits took additional 1 <span =
class=3DGramE>jiffies</span><br>
drbd2: 0 KB marked out-of-sync by on disk bit-map.<br>
drbd2: <span class=3DGramE>disk(</span> Attaching -&gt; <span =
class=3DSpellE>UpToDate</span>
)<br>
drbd2: Writing <span class=3DGramE>meta</span> data super block now.<br>
drbd2: <span class=3DSpellE><span class=3DGramE>conn</span></span><span
class=3DGramE>(</span> <span class=3DSpellE>StandAlone</span> -&gt; =
Unconnected )<br>
drbd2: receiver (re)started<br>
drbd2: <span class=3DSpellE><span class=3DGramE>conn</span></span><span
class=3DGramE>(</span> Unconnected -&gt; <span =
class=3DSpellE>WFConnection</span> )<br>
drbd2: <span class=3DSpellE><span class=3DGramE>conn</span></span><span
class=3DGramE>(</span> <span class=3DSpellE>WFConnection</span> -&gt; =
<span
class=3DSpellE>WFReportParams</span> )<br>
drbd2: Handshake successful: DRBD Network Protocol version 85<br>
drbd2: <span class=3DSpellE>drbd_sync_handshake</span>:<br>
drbd2: self =
1999C2A90658DA42:0000000000000000:30A5702D832E1702:0000000000000004<br>
drbd2: peer =
1999C2A90658DA43:0000000000000000:30A5702D832E1702:0000000000000004<br>
drbd2: <span class=3DSpellE>uuid_<span =
class=3DGramE>compare</span></span><span
class=3DGramE>(</span>)=3D-1<br>
drbd2:&nbsp; <span class=3DSpellE><span =
class=3DGramE>uuid</span></span><span
class=3DGramE>[</span><span class=3DSpellE>History_start</span>] now
1999C2A90658DA42<br>
drbd2:&nbsp; <span class=3DSpellE><span =
class=3DGramE>uuid</span></span><span
class=3DGramE>[</span>Current] now 0000000000000000<br>
drbd2: <span class=3DGramE>peer(</span> Unknown -&gt; Secondary ) <span
class=3DSpellE>conn</span>( <span class=3DSpellE>WFReportParams</span> =
-&gt; <span
class=3DSpellE>WFBitMapT</span> ) <span class=3DSpellE>pdsk</span>( =
<span
class=3DSpellE>DUnknown</span> -&gt; <span =
class=3DSpellE>UpToDate</span> )<br>
drbd2: Writing <span class=3DGramE>meta</span> data super block now.<br>
drbd2: <span class=3DSpellE>aftr_<span =
class=3DGramE>isp</span></span><span
class=3DGramE>(</span> 0 -&gt; 1 )<br>
drbd2: <span class=3DSpellE><span class=3DGramE>conn</span></span><span
class=3DGramE>(</span> <span class=3DSpellE>WFBitMapT</span> -&gt; <span
class=3DSpellE>WFSyncUUID</span> )<br>
drbd2: <span class=3DSpellE>peer_<span =
class=3DGramE>isp</span></span><span
class=3DGramE>(</span> 0 -&gt; 1 )<br>
drbd2:&nbsp; <span class=3DSpellE><span =
class=3DGramE>uuid</span></span><span
class=3DGramE>[</span>Current] now FC968953A6746EEC<br>
drbd2:&nbsp; <span class=3DSpellE><span =
class=3DGramE>uuid</span></span><span
class=3DGramE>[</span>Bitmap] now 0000000000000000<br>
drbd2: <span class=3DSpellE><span class=3DGramE>conn</span></span><span
class=3DGramE>(</span> <span class=3DSpellE>WFSyncUUID</span> -&gt; =
<span
class=3DSpellE>PausedSyncT</span> ) disk( <span =
class=3DSpellE>UpToDate</span>
-&gt; Inconsistent )<br>
drbd2: Began <span class=3DSpellE>resync</span> as <span =
class=3DSpellE>PausedSyncT</span>
(will sync 1052672 KB [263168 bits set]).<br>
drbd2: Writing <span class=3DGramE>meta</span> data super block now.<br>
drbd2: <span class=3DGramE>peer(</span> Secondary -&gt; Primary )<br>
drbd2: <span class=3DSpellE>peer_<span =
class=3DGramE>isp</span></span><span
class=3DGramE>(</span> 1 -&gt; 0 )<br>
drbd2: <span class=3DSpellE><span class=3DGramE>conn</span></span><span
class=3DGramE>(</span> <span class=3DSpellE>PausedSyncT</span> -&gt; =
<span
class=3DSpellE>SyncTarget</span> ) <span class=3DSpellE>aftr_isp</span>( =
1 -&gt; 0
)<br>
drbd2: <span class=3DSpellE>Syncer</span> continues.<br>
drbd2: <span class=3DSpellE>Resync</span> done (total 225 sec; paused 61 =
sec;
6416 K/sec)<br>
drbd2:&nbsp; <span class=3DSpellE><span =
class=3DGramE>uuid</span></span><span
class=3DGramE>[</span>Bitmap] now 0000000000000000<br>
drbd2:&nbsp; <span class=3DSpellE><span =
class=3DGramE>uuid</span></span><span
class=3DGramE>[</span><span class=3DSpellE>History_start</span>] now
30A5702D832E1702<br>
drbd2:&nbsp; <span class=3DSpellE><span =
class=3DGramE>uuid</span></span><span
class=3DGramE>[</span><span class=3DSpellE>History_end</span>] now =
0000000000000004<br>
drbd2:&nbsp; <span class=3DSpellE><span =
class=3DGramE>uuid</span></span><span
class=3DGramE>[</span>Bitmap] now FC968953A6746EEC<br>
drbd2:&nbsp; <span class=3DSpellE><span =
class=3DGramE>uuid</span></span><span
class=3DGramE>[</span>Current] now 1999C2A90658DA42<br>
drbd2:&nbsp; <span class=3DSpellE><span =
class=3DGramE>uuid</span></span><span
class=3DGramE>[</span><span class=3DSpellE>History_start</span>] now
FC968953A6746EEC<br>
drbd2:&nbsp; <span class=3DSpellE><span =
class=3DGramE>uuid</span></span><span
class=3DGramE>[</span>Bitmap] now 0000000000000000<br>
drbd2: <span class=3DSpellE><span class=3DGramE>conn</span></span><span
class=3DGramE>(</span> <span class=3DSpellE>SyncTarget</span> -&gt; =
Connected )
disk( Inconsistent -&gt; <span class=3DSpellE>UpToDate</span> )<br>
drbd2: Writing <span class=3DGramE>meta</span> data super block now.<br>
drbd2: <span class=3DSpellE>drbd_open</span>: Allowing open in Secondary =
state<br>
drbd2: <span class=3DSpellE>drbd_sync_handshake</span>:<br>
drbd2: self =
1999C2A90658DA42:0000000000000000:FC968953A6746EEC:30A5702D832E1702<br>
drbd2: peer =
1999C2A90658DA42:0000000000000000:FC968953A6746EEC:30A5702D832E1702<br>
drbd2: <span class=3DSpellE>uuid_<span =
class=3DGramE>compare</span></span><span
class=3DGramE>(</span>)=3D-1<br>
drbd2:&nbsp; <span class=3DSpellE><span =
class=3DGramE>uuid</span></span><span
class=3DGramE>[</span><span class=3DSpellE>History_start</span>] now
1999C2A90658DA42<br>
drbd2:&nbsp; <span class=3DSpellE><span =
class=3DGramE>uuid</span></span><span
class=3DGramE>[</span>Current] now 0000000000000000<br>
drbd2: <span class=3DGramE>peer(</span> Primary -&gt; Secondary ) <span
class=3DSpellE>conn</span>( Connected -&gt; <span =
class=3DSpellE>WFBitMapT</span> )<br>
drbd2: Writing <span class=3DGramE>meta</span> data super block now.<br>
drbd2: <span class=3DGramE>role(</span> Secondary -&gt; Primary )<br>
drbd2: Writing <span class=3DGramE>meta</span> data super block now.<br>
<br>
<br>
On <span class=3DSpellE>ben</span> the other node we have:<br>
<br>
drbd2: <span class=3DGramE>disk(</span> Diskless -&gt; Attaching )<br>
drbd2: Found 6 transactions (324 active extents) in activity log.<br>
drbd2: <span class=3DSpellE>max_segment_size</span> <span =
class=3DGramE>( =3D</span>
BIO size ) =3D 32768<br>
drbd2: <span class=3DSpellE>drbd_bm_resize</span> called with capacity =
=3D=3D 30735368<br>
drbd2: <span class=3DSpellE>resync</span> bitmap: bits=3D3841921 =
words=3D120062<br>
drbd2: size =3D 14 GB (15367684 KB)<br>
drbd2: reading of bitmap took 26 jiffies<br>
drbd2: recounting of set bits took additional 1 <span =
class=3DGramE>jiffies</span><br>
drbd2: 0 KB marked out-of-sync by on disk bit-map.<br>
drbd2: Marked additional 1028 MB as out-of-sync based on <st1:State =
w:st=3D"on"><st1:place
 w:st=3D"on">AL</st1:place></st1:State>.<br>
drbd2: <span class=3DGramE>disk(</span> Attaching -&gt; <span =
class=3DSpellE>UpToDate</span>
)<br>
drbd2: Writing <span class=3DGramE>meta</span> data super block now.<br>
drbd2: <span class=3DSpellE><span class=3DGramE>conn</span></span><span
class=3DGramE>(</span> <span class=3DSpellE>StandAlone</span> -&gt; =
Unconnected )<br>
drbd2: receiver (re)started<br>
drbd2: <span class=3DSpellE><span class=3DGramE>conn</span></span><span
class=3DGramE>(</span> Unconnected -&gt; <span =
class=3DSpellE>WFConnection</span> )<br>
drbd2: <span class=3DSpellE><span class=3DGramE>conn</span></span><span
class=3DGramE>(</span> <span class=3DSpellE>WFConnection</span> -&gt; =
<span
class=3DSpellE>WFReportParams</span> )<br>
drbd2: Handshake successful: DRBD Network Protocol version 85<br>
drbd2: <span class=3DSpellE>drbd_sync_handshake</span>:<br>
drbd2: self =
1999C2A90658DA43:0000000000000000:30A5702D832E1702:0000000000000004<br>
drbd2: peer =
1999C2A90658DA42:0000000000000000:30A5702D832E1702:0000000000000004<br>
drbd2: <span class=3DSpellE>uuid_<span =
class=3DGramE>compare</span></span><span
class=3DGramE>(</span>)=3D1<br>
drbd2: <span class=3DGramE>peer(</span> Unknown -&gt; Secondary ) <span
class=3DSpellE>conn</span>( <span class=3DSpellE>WFReportParams</span> =
-&gt; <span
class=3DSpellE>WFBitMapS</span> ) <span class=3DSpellE>pdsk</span>( =
<span
class=3DSpellE>DUnknown</span> -&gt; <span =
class=3DSpellE>UpToDate</span> )<br>
drbd2: <span class=3DSpellE>aftr_<span =
class=3DGramE>isp</span></span><span
class=3DGramE>(</span> 0 -&gt; 1 )<br>
drbd2: Writing <span class=3DGramE>meta</span> data super block now.<br>
drbd2: <span class=3DSpellE>peer_<span =
class=3DGramE>isp</span></span><span
class=3DGramE>(</span> 0 -&gt; 1 )<br>
drbd2:&nbsp; <span class=3DSpellE><span =
class=3DGramE>uuid</span></span><span
class=3DGramE>[</span>Bitmap] now FC968953A6746EEC<br>
drbd2: <span class=3DSpellE><span class=3DGramE>conn</span></span><span
class=3DGramE>(</span> <span class=3DSpellE>WFBitMapS</span> -&gt; <span
class=3DSpellE>PausedSyncS</span> ) <span class=3DSpellE>pdsk</span>( =
<span
class=3DSpellE>UpToDate</span> -&gt; Inconsistent )<br>
drbd2: Began <span class=3DSpellE>resync</span> as <span =
class=3DSpellE>PausedSyncS</span>
(will sync 1052672 KB [263168 bits set]).<br>
drbd2: Writing <span class=3DGramE>meta</span> data super block now.<br>
drbd2: <span class=3DGramE>role(</span> Secondary -&gt; Primary )<br>
drbd2: Writing <span class=3DGramE>meta</span> data super block now.<br>
drbd2: <span class=3DSpellE>aftr_<span =
class=3DGramE>isp</span></span><span
class=3DGramE>(</span> 1 -&gt; 0 )<br>
drbd2: <span class=3DSpellE><span class=3DGramE>conn</span></span><span
class=3DGramE>(</span> <span class=3DSpellE>PausedSyncS</span> -&gt; =
<span
class=3DSpellE>SyncSource</span> ) <span class=3DSpellE>peer_isp</span>( =
1 -&gt; 0
)<br>
drbd2: <span class=3DSpellE>Syncer</span> continues.<br>
drbd2: <span class=3DSpellE>Resync</span> done (total 225 sec; paused 61 =
sec;
6416 K/sec)<br>
drbd2:&nbsp; <span class=3DSpellE><span =
class=3DGramE>uuid</span></span><span
class=3DGramE>[</span><span class=3DSpellE>History_start</span>] now
FC968953A6746EEC<br>
drbd2:&nbsp; <span class=3DSpellE><span =
class=3DGramE>uuid</span></span><span
class=3DGramE>[</span>Bitmap] now 0000000000000000<br>
drbd2: <span class=3DSpellE><span class=3DGramE>conn</span></span><span
class=3DGramE>(</span> <span class=3DSpellE>SyncSource</span> -&gt; =
Connected ) <span
class=3DSpellE>pdsk</span>( Inconsistent -&gt; <span =
class=3DSpellE>UpToDate</span>
)<br>
drbd2: Writing <span class=3DGramE>meta</span> data super block now.<br>
drbd2: <span class=3DGramE>role(</span> Primary -&gt; Secondary )<br>
drbd2: Writing <span class=3DGramE>meta</span> data super block now.<br>
drbd2: <span class=3DSpellE>drbd_sync_handshake</span>:<br>
drbd2: self =
1999C2A90658DA43:0000000000000000:FC968953A6746EEC:30A5702D832E1702<br>
drbd2: peer =
0000000000000000:0000000000000000:1999C2A90658DA42:FC968953A6746EEC<br>
drbd2: <span class=3DSpellE>uuid_<span =
class=3DGramE>compare</span></span><span
class=3DGramE>(</span>)=3D-2<br>
drbd2: Writing <span class=3DGramE>meta</span> data super block now.<br>
drbd2: writing of bitmap took 59 jiffies<br>
drbd2: 14 GB marked out-of-sync by on disk bit-map.<br>
drbd2: 15367684 KB now marked out-of-sync by on disk bit-map.<br>
drbd2: Writing <span class=3DGramE>meta</span> data super block now.<br>
drbd2:&nbsp; <span class=3DSpellE><span =
class=3DGramE>uuid</span></span><span
class=3DGramE>[</span><span class=3DSpellE>History_start</span>] now
1999C2A90658DA43<br>
drbd2:&nbsp; <span class=3DSpellE><span =
class=3DGramE>uuid</span></span><span
class=3DGramE>[</span>Current] now 0000000000000000<br>
drbd2: <span class=3DSpellE><span class=3DGramE>conn</span></span><span
class=3DGramE>(</span> Connected -&gt; <span =
class=3DSpellE>WFBitMapT</span> )<br>
drbd2: Writing <span class=3DGramE>meta</span> data super block now.<br>
drbd2: <span class=3DGramE>peer(</span> Secondary -&gt; Primary =
)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C73108.C3BA719E--
