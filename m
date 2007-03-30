Return-Path: <Ernest.Montrose@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C77316.E7C77495"
Date: Fri, 30 Mar 2007 18:01:01 -0400
Message-ID: <BD7042533C2F8943A6A4257A9E31C45439C944@EXNA.corp.stratus.com>
From: "Montrose, Ernest" <Ernest.Montrose@stratus.com>
To: <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] DRBD8: drbd nodes deadlock in WFBitMapT
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C77316.E7C77495
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi all,
This is another hard to reproduce one but the proofs are in the logs
that the problem is alive and well.
I am hoping for at least some clues that may help reproduce
this...Essentially after one node in=20
Primary state is powered down(Not a graceful shutdown)  both nodes ends
up  In WFBitMapT for a drbd volume.
=20
Here are some logs:
On one =
node=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D


Drbd2: Writing metadata to superblock now.
......
....... This nodes is powered of and came back with:

Mar 23 13:16:53 jerry kernel: drbd2: rct =3D 0 in
/test_logs/builds/SuperNova/trunk/070323/platform/drbd/src/drbd/drbd_rec
eiver.c:1878
Mar 23 13:16:55 [  OK  ]
Mar 23 13:16:54 jerry kernel: drbd2: drbd_sync_handshake:
Mar 23 13:16:54 jerry kernel: drbd2: self
F71E503A8179BC5D:0000000000000000:3F430D4E1D59C3EA:6B0B1DA5CB20689C
Mar 23 13:16:54 jerry kernel: drbd2: peer
F71E503A8179BC5C:0000000000000000:3F430D4E1D59C3EA:6B0B1DA5CB20689C
Mar 23 13:16:55 jerry kernel: drbd2: uuid_compare()=3D0 by rule 4
Mar 23 13:16:55 jerry kernel: drbd2: No resync, but bits in bitmap!

......

Mar 23 13:17:00 jerry kernel: drbd2: drbd_sync_handshake:
Mar 23 13:17:00 jerry kernel: drbd2: self
F71E503A8179BC5D:0000000000000000:3F430D4E1D59C3EA:6B0B1DA5CB20689C
Mar 23 13:17:00 jerry kernel: drbd2: peer
0000000000000000:0000000000000000:F71E503A8179BC5C:3F430D4E1D59C3EA
Mar 23 13:17:00 jerry kernel: drbd2: uuid_compare()=3D-2 by rule 6
Mar 23 13:17:00 jerry kernel: drbd2: Writing meta data super block now.
Mar 23 13:17:01 jerry kernel: drbd2: writing of bitmap took 11 jiffies
Mar 23 13:17:01 jerry kernel: drbd2: 12 GB marked out-of-sync by on disk
bit-map.
Mar 23 13:17:02 jerry kernel: drbd2: 13336132 KB now marked out-of-sync
by on disk bit-map.
Mar 23 13:17:02 jerry kernel: drbd2: Writing meta data super block now.
Mar 23 13:17:02 jerry kernel: drbd2:  uuid[History_start] now
F71E503A8179BC5D
Mar 23 13:17:02 jerry kernel: drbd2:  uuid[Current] now 0000000000000000
Mar 23 13:17:03 jerry kernel: drbd2: conn( Connected -> WFBitMapT )
Mar 23 13:17:03 jerry kernel: drbd2: Writing meta data super block now.

On theh other =
node=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D

Mar 23 13:16:48 ben kernel: drbd2: aftr_isp( 0 -> 1 )
Mar 23 13:16:48 ben kernel: drbd2: Handshake successful: DRBD Network
Protocol version 86
Mar 23 13:16:48 ben kernel: drbd2: peer( Unknown -> Secondary ) conn(
WFReportParams -> Connected ) pdsk( DUnknown -> UpToDate ) peer_isp( 0
-> 1 )
Mar 23 13:16:48 ben kernel: drbd2: Writing meta data super block now.

....

Mar 23 13:16:49 ben kernel: drbd2: rct =3D 2 in
/test_logs/builds/SuperNova/trunk/070323/platform/drbd/src/drbd/drbd_rec
eiver.c:1878
Mar 23 13:16:49 ben kernel: drbd2: drbd_sync_handshake:
Mar 23 13:16:49 ben kernel: drbd2: self
F71E503A8179BC5C:0000000000000000:3F430D4E1D59C3EA:6B0B1DA5CB20689C
Mar 23 13:16:49 ben kernel: drbd2: peer
F71E503A8179BC5D:0000000000000000:3F430D4E1D59C3EA:6B0B1DA5CB20689C
Mar 23 13:16:49 ben kernel: drbd2: uuid_compare()=3D-1 by rule 4
Mar 23 13:16:49 ben kernel: drbd2:  uuid[History_start] now
F71E503A8179BC5C
Mar 23 13:16:49 ben kernel: drbd2:  uuid[Current] now 0000000000000000
Mar 23 13:16:49 ben kernel: drbd2: conn( Connected -> WFBitMapT )
Mar 23 13:16:49 ben kernel: drbd2: Writing meta data super block now.

------_=_NextPart_001_01C77316.E7C77495
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
<link rel=3DFile-List href=3D"cid:filelist.xml@01C772F5.6091A460">
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
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;
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
font-family:Arial'>Hi all,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>This is another hard to reproduce one but the proofs =
are in
the logs that the problem is alive and =
well.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I am hoping for at least some clues that may help =
reproduce
this&#8230;Essentially after one node in <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Primary state is powered <span =
class=3DGramE>down(</span>Not a
graceful shutdown) <span style=3D'mso-spacerun:yes'>&nbsp;</span>both =
nodes ends
up <span style=3D'mso-spacerun:yes'>&nbsp;</span>In </span></font><span
class=3DSpellE><font size=3D1 color=3Dblack face=3DTahoma><span =
style=3D'font-size:9.0pt;
font-family:Tahoma;color:black'>WFBitMapT</span></font></span><font =
size=3D1
color=3Dblack face=3DTahoma><span =
style=3D'font-size:9.0pt;font-family:Tahoma;
color:black'> for a <span class=3DSpellE>drbd</span> =
volume.</span></font><font
size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'><o:p></o:p></span></font></p=
>

<p class=3DMsoNormal><font size=3D1 color=3Dblack face=3DTahoma><span =
style=3D'font-size:
9.0pt;font-family:Tahoma;color:black'><o:p>&nbsp;</o:p></span></font></p>=


<p class=3DMsoNormal><font size=3D1 color=3Dblack face=3DTahoma><span =
style=3D'font-size:
9.0pt;font-family:Tahoma;color:black'>Here are some =
logs:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 color=3Dblack face=3DTahoma><span =
style=3D'font-size:
9.0pt;font-family:Tahoma;color:black'>On one =
node=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D<br
style=3D'mso-special-character:line-break'>
<![if !supportLineBreakNewLine]><br =
style=3D'mso-special-character:line-break'>
<![endif]><o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 color=3Dblack face=3DTahoma><span =
style=3D'font-size:
9.0pt;font-family:Tahoma;color:black'>Drbd2: Writing metadata to <span
class=3DSpellE>superblock</span> now.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 color=3Dblack face=3DTahoma><span =
style=3D'font-size:
9.0pt;font-family:Tahoma;color:black'>&#8230;...<o:p></o:p></span></font>=
</p>

<p class=3DMsoNormal><font size=3D1 color=3Dblack face=3DTahoma><span =
style=3D'font-size:
9.0pt;font-family:Tahoma;color:black'>&#8230;&#8230;. This <span =
class=3DGramE>nodes</span>
is powered of and came back with:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 color=3Dblack face=3DTahoma><span =
style=3D'font-size:
9.0pt;font-family:Tahoma;color:black'><br>
Mar 23 13:16:53 jerry kernel: drbd2: <span class=3DSpellE>rct</span> =3D =
0 in
/test_logs/builds/SuperNova/trunk/070323/platform/drbd/src/drbd/drbd_rece=
iver.c:1878<br>
Mar 23 13:16:55 <span class=3DGramE>[&nbsp; OK</span>&nbsp; ]<br>
Mar 23 13:16:54 jerry kernel: drbd2: <span =
class=3DSpellE>drbd_sync_handshake</span>:<br>
Mar 23 13:16:54 jerry kernel: drbd2: self
F71E503A8179BC5D:0000000000000000:3F430D4E1D59C3EA:6B0B1DA5CB20689C<br>
Mar 23 13:16:54 jerry kernel: drbd2: peer
F71E503A8179BC5C:0000000000000000:3F430D4E1D59C3EA:6B0B1DA5CB20689C<br>
Mar 23 13:16:55 jerry kernel: drbd2: <span class=3DSpellE>uuid_<span =
class=3DGramE>compare</span></span><span
class=3DGramE>(</span>)=3D0 by rule 4<br>
Mar 23 13:16:55 jerry kernel: drbd2: No <span =
class=3DSpellE>resync</span>, but
bits in bitmap!<br>
<br>
......<br>
<br>
Mar 23 13:17:00 jerry kernel: drbd2: <span =
class=3DSpellE>drbd_sync_handshake</span>:<br>
Mar 23 13:17:00 jerry kernel: drbd2: self =
F71E503A8179BC5D:0000000000000000:3F430D4E1D59C3EA:6B0B1DA5CB20689C<br>
Mar 23 13:17:00 jerry kernel: drbd2: peer
0000000000000000:0000000000000000:F71E503A8179BC5C:3F430D4E1D59C3EA<br>
Mar 23 13:17:00 jerry kernel: drbd2: <span class=3DSpellE>uuid_<span =
class=3DGramE>compare</span></span><span
class=3DGramE>(</span>)=3D-2 by rule 6<br>
Mar 23 13:17:00 jerry kernel: drbd2: Writing <span =
class=3DGramE>meta</span> data
super block now.<br>
Mar 23 13:17:01 jerry kernel: drbd2: writing of bitmap took 11 =
jiffies<br>
Mar 23 13:17:01 jerry kernel: drbd2: 12 GB marked out-of-sync by on disk
bit-map.<br>
Mar 23 13:17:02 jerry kernel: drbd2: 13336132 KB now marked out-of-sync =
by on
disk bit-map.<br>
Mar 23 13:17:02 jerry kernel: drbd2: Writing <span =
class=3DGramE>meta</span> data
super block now.<br>
Mar 23 13:17:02 jerry kernel: drbd2:&nbsp; <span class=3DSpellE><span
class=3DGramE>uuid</span></span><span class=3DGramE>[</span><span =
class=3DSpellE>History_start</span>]
now F71E503A8179BC5D<br>
Mar 23 13:17:02 jerry kernel: drbd2:&nbsp; <span class=3DSpellE><span
class=3DGramE>uuid</span></span><span class=3DGramE>[</span>Current] now =
0000000000000000<br>
Mar 23 13:17:03 jerry kernel: drbd2: <span class=3DSpellE><span =
class=3DGramE>conn</span></span><span
class=3DGramE>(</span> Connected -&gt; <span =
class=3DSpellE>WFBitMapT</span> )<br>
Mar 23 13:17:03 jerry kernel: drbd2: Writing <span =
class=3DGramE>meta</span> data
super block now.<br>
<br>
On <span class=3DSpellE>theh</span> other =
node=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D<br>
<br>
Mar 23 13:16:48 <span class=3DSpellE>ben</span> kernel: drbd2: <span
class=3DSpellE>aftr_<span class=3DGramE>isp</span></span><span =
class=3DGramE>(</span>
0 -&gt; 1 )<br>
Mar 23 13:16:48 <span class=3DSpellE>ben</span> kernel: drbd2: Handshake
successful: DRBD Network Protocol version 86<br>
Mar 23 13:16:48 <span class=3DSpellE>ben</span> kernel: drbd2: peer( =
Unknown
-&gt; Secondary ) <span class=3DSpellE>conn</span>( <span =
class=3DSpellE>WFReportParams</span>
-&gt; Connected ) <span class=3DSpellE>pdsk</span>( <span =
class=3DSpellE>DUnknown</span>
-&gt; <span class=3DSpellE>UpToDate</span> ) <span =
class=3DSpellE>peer_isp</span>(
0 -&gt; 1 )<br>
Mar 23 13:16:48 <span class=3DSpellE>ben</span> kernel: drbd2: Writing =
<span
class=3DGramE>meta</span> data super block now.<br>
<br>
....<br>
<br>
Mar 23 13:16:49 <span class=3DSpellE>ben</span> kernel: drbd2: <span
class=3DSpellE>rct</span> =3D 2 in
/test_logs/builds/SuperNova/trunk/070323/platform/drbd/src/drbd/drbd_rece=
iver.c:1878<br>
Mar 23 13:16:49 <span class=3DSpellE>ben</span> kernel: drbd2: <span
class=3DSpellE>drbd_sync_handshake</span>:<br>
Mar 23 13:16:49 <span class=3DSpellE>ben</span> kernel: drbd2: self
F71E503A8179BC5C:0000000000000000:3F430D4E1D59C3EA:6B0B1DA5CB20689C<br>
Mar 23 13:16:49 <span class=3DSpellE>ben</span> kernel: drbd2: peer
F71E503A8179BC5D:0000000000000000:3F430D4E1D59C3EA:6B0B1DA5CB20689C<br>
Mar 23 13:16:49 <span class=3DSpellE>ben</span> kernel: drbd2: <span
class=3DSpellE>uuid_<span class=3DGramE>compare</span></span><span =
class=3DGramE>(</span>)=3D-1
by rule 4<br>
Mar 23 13:16:49 <span class=3DSpellE>ben</span> kernel: drbd2:&nbsp; =
<span
class=3DSpellE><span class=3DGramE>uuid</span></span><span =
class=3DGramE>[</span><span
class=3DSpellE>History_start</span>] now F71E503A8179BC5C<br>
Mar 23 13:16:49 <span class=3DSpellE>ben</span> kernel: drbd2:&nbsp; =
<span
class=3DSpellE><span class=3DGramE>uuid</span></span><span =
class=3DGramE>[</span>Current]
now 0000000000000000<br>
Mar 23 13:16:49 <span class=3DSpellE>ben</span> kernel: drbd2: <span
class=3DSpellE><span class=3DGramE>conn</span></span><span =
class=3DGramE>(</span>
Connected -&gt; <span class=3DSpellE>WFBitMapT</span> )<br>
Mar 23 13:16:49 <span class=3DSpellE>ben</span> kernel: drbd2: Writing =
<span
class=3DGramE>meta</span> data super block now.</span></font><font =
size=3D2
face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'><o:p></o:p></span></font></p=
>

</div>

</body>

</html>

------_=_NextPart_001_01C77316.E7C77495--
