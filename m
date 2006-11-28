Return-Path: <Ernest.Montrose@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C7131A.322B6CDF"
Date: Tue, 28 Nov 2006 13:22:43 -0500
Message-ID: <BD7042533C2F8943A6A4257A9E31C45439C845@EXNA.corp.stratus.com>
From: "Montrose, Ernest" <Ernest.Montrose@stratus.com>
To: <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] DRBD8: Ooops on reboot after WFBitMaps state deadlock
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C7131A.322B6CDF
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi all,
The two nodes were deadlocked in this WFBitMaps state.  I proceeded to
try to recover with drbdadm() that would hang.
I proceeded to reboot the nodes and I got an Ooops in one of the nodes:
Oops: 0000 [#1]
CPU:    0
EIP is at bd_release+0x9/0x30
eax: f12cbe44  ebx: 00000001  ecx: ec78ac80  edx: 00000000
esi: eebd7400  edi: 00000000  ebp: efc6be50  esp: efc6be50
ds: 007b  es: 007b  ss: 0069
Process cqueue/0 (pid: 776, threadinfo=3Defc6a000 task=3Defc06570)
Stack: <0>efc6bec4 f12c2428 ec78ac80 00000000 00000001 00000002 00000000
00000001
        00000000 00000001 00000004 00000000 00000000 00000001 000000d0
ebd59d80
        00000000 efc6beac c02e03c8 00000000 00000000 240bc3e4 00000000
efc6a000
Call Trace:
[<c010522a>] show_stack_log_lvl+0xaa/0xe0
[<c010543e>] show_registers+0x18e/0x210
[<c0105639>] die+0xd9/0x180
[<c011326c>] do_page_fault+0x3cc/0x6ce
[<c0104e3b>] error_code+0x2b/0x30
[<f12c2428>] drbd_set_role+0x178/0x4d0 [drbd]
[<f12c27ec>] drbd_nl_primary+0x6c/0x80 [drbd]
[<f12c4ff5>] drbd_connector_callback+0xb5/0x1d0 [drbd]
[<c026f3f3>] cn_queue_wrapper+0x13/0x40
[<c012a408>] run_workqueue+0x88/0x120
[<c012a5e8>] worker_thread+0x148/0x170
[<c012dde7>] kthread+0xa7/0xf0
[<c0102d7d>] kernel_thread_helper+0x5/0x18
Code: 00 00 8b 42 3c ff 40 38 c7 40 34 a0 1f 16 c0 89 5a 34 ff 42 38 5b
89 c8 5d c3 90 8d b4 26 00 00 00 00 55 89 e5 8b 4d 08 8b 51 3c <8b> 42
38 48 89 42 38 85 c0 75
=20
This seems to imply that mdev->this_bdev is pointing to an invalid
location.=20
=20

------_=_NextPart_001_01C7131A.322B6CDF
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
<link rel=3DFile-List href=3D"cid:filelist.xml@01C712F0.492EE6D0">
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
font-family:Arial'>The two nodes were deadlocked in this <span =
class=3DSpellE>WFBitMaps</span>
state.<span style=3D'mso-spacerun:yes'>&nbsp; </span>I proceeded to try =
to
recover with <span class=3DSpellE><span =
class=3DGramE>drbdadm</span></span><span
class=3DGramE>(</span>) that would hang.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I proceeded to reboot the nodes and I got an <span
class=3DSpellE>Ooops</span> in one of the =
nodes:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 color=3Dblack face=3DTahoma><span =
style=3D'font-size:
9.0pt;font-family:Tahoma;color:black'>Oops: 0000 [#1]<br>
CPU:&nbsp; &nbsp; 0<br>
EIP is at bd_release+0x9/0x30<br>
<span class=3DSpellE><span class=3DGramE>eax</span></span>: =
f12cbe44&nbsp; <span
class=3DSpellE>ebx</span>: 00000001&nbsp; <span =
class=3DSpellE>ecx</span>:
ec78ac80&nbsp; <span class=3DSpellE>edx</span>: 00000000<br>
<span class=3DSpellE><span class=3DGramE>esi</span></span>: =
eebd7400&nbsp; <span
class=3DSpellE>edi</span>: 00000000&nbsp; <span =
class=3DSpellE>ebp</span>:
efc6be50&nbsp; <span class=3DSpellE>esp</span>: efc6be50<br>
<span class=3DSpellE><span class=3DGramE>ds</span></span>: 007b&nbsp; =
<span
class=3DSpellE>es</span>: 007b&nbsp; <span class=3DSpellE>ss</span>: =
0069<br>
Process cqueue/0 (<span class=3DSpellE><span =
class=3DGramE>pid</span></span>: 776, <span
class=3DSpellE>threadinfo</span>=3Defc6a000 task=3Defc06570)<br>
Stack: &lt;0&gt;efc6bec4 f12c2428 ec78ac80 00000000 00000001 00000002 =
00000000
00000001<br>
&nbsp; &nbsp; &nbsp; &nbsp; 00000000 00000001 00000004 00000000 <span
class=3DSpellE>00000000</span> 00000001 000000d0 ebd59d80<br>
&nbsp; &nbsp; &nbsp; &nbsp; 00000000 efc6beac c02e03c8 00000000 <span
class=3DSpellE>00000000</span> 240bc3e4 00000000 efc6a000<br>
Call Trace:<br>
[&lt;c010522a&gt;] show_stack_log_lvl+0xaa/0xe0<br>
[&lt;c010543e&gt;] show_registers+0x18e/0x210<br>
[&lt;c0105639&gt;] die+0xd9/0x180<br>
[&lt;c011326c&gt;] do_page_fault+0x3cc/0x6ce<br>
[&lt;c0104e3b&gt;] error_code+0x2b/0x30<br>
[&lt;f12c2428&gt;] drbd_set_role+0x178/0x4d0 [<span =
class=3DSpellE>drbd</span>]<br>
[&lt;f12c27ec&gt;] drbd_nl_primary+0x6c/0x80 [<span =
class=3DSpellE>drbd</span>]<br>
[&lt;f12c4ff5&gt;] drbd_connector_callback+0xb5/0x1d0 [<span =
class=3DSpellE>drbd</span>]<br>
[&lt;c026f3f3&gt;] cn_queue_wrapper+0x13/0x40<br>
[&lt;c012a408&gt;] run_workqueue+0x88/0x120<br>
[&lt;c012a5e8&gt;] worker_thread+0x148/0x170<br>
[&lt;c012dde7&gt;] kthread+0xa7/0xf0<br>
[&lt;c0102d7d&gt;] kernel_thread_helper+0x5/0x18<br>
Code: 00 <span class=3DSpellE>00</span> 8b 42 3c ff 40 38 c7 40 34 a0 1f =
16 c0 89
5a 34 ff 42 38 5b 89 c8 5d c3 90 8d b4 26 00 <span =
class=3DSpellE>00</span> <span
class=3DSpellE>00</span> <span class=3DSpellE>00</span> 55 89 e5 8b 4d =
08 8b 51 3c
&lt;8b&gt; 42 38 48 89 42 38 85 c0 75<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 color=3Dblack face=3DTahoma><span =
style=3D'font-size:
9.0pt;font-family:Tahoma;color:black'><o:p>&nbsp;</o:p></span></font></p>=


<p class=3DMsoNormal><font size=3D1 color=3Dblack face=3DTahoma><span =
style=3D'font-size:
9.0pt;font-family:Tahoma;color:black'>This seems to imply that =
</span></font><span
class=3DSpellE><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>mdev</span></font></span><font size=3D2
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-family:"Courier New"'>-&gt;<span
class=3DSpellE>this_bdev</span> is pointing to an invalid location. =
<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C7131A.322B6CDF--
