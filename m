Return-Path: <Ernest.Montrose@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C7884E.0EEE70F2"
Date: Thu, 26 Apr 2007 17:58:44 -0400
Message-ID: <BD7042533C2F8943A6A4257A9E31C45439C994@EXNA.corp.stratus.com>
From: "Montrose, Ernest" <Ernest.Montrose@stratus.com>
To: <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] Panic in _drbd_send_page() again.
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C7884E.0EEE70F2
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi all,
I think we have seen this panic before.  I am not sure if there was a
fix then a regression of sort.
I am looking for a clue to help narrow this down. It seems a
bvec->bv_page is freed and is being used later.  Here is the panic
message:
=20
Apr 21 05:05:53 chogs kernel: CPU:    0
Apr 21 05:05:53 chogs kernel: EIP:    0061:[<ee2853c1>]    Tainted: GF
VLI
Apr 21 05:05:53 chogs kernel: EFLAGS: 00010296  (2.6.16.38-xen #1)
Apr 21 05:05:53 chogs kernel: EIP is at _drbd_send_page+0x21/0x120
[drbd]
Apr 21 05:05:53 chogs kernel: eax: ffffffff  ebx: c05958fc  ecx:
eb024000  edx: 6b6b6b6b
Apr 21 05:05:53 chogs kernel: esi: 6b6b6b6b  edi: a56b6b6b  ebp:
eb025eec  esp: eb025ebc
Apr 21 05:05:53 chogs kernel: ds: 007b  es: 007b  ss: 0069
Apr 21 05:05:53 chogs kernel: Process drbd3_worker (pid: 5739,
threadinfo=3Deb024000 task=3Ded440570)
Apr 21 05:05:53 chogs kernel: Stack: <0>00001000 00004000 00000000
eb024000 00000020 ec64b26c ffffffff 6b6b6b6b
Apr 21 05:05:53 chogs kernel:        ec64b26c c05958fc 00000003 c7a5c6d0
eb025f08 ee2854f3 6b6b6b6b ec64b26c
Apr 21 05:05:54 chogs kernel:        eb025f30 00000000 ec64b26c eb025f5c
ee285643 00000020 00008000 00000000
Apr 21 05:05:54 chogs kernel: Call Trace:
Apr 21 05:05:54 chogs kernel:  [<c0105a01>] show_stack_log_lvl+0xa1/0xe0
Apr 21 05:05:54 chogs kernel:  [<c0105bf1>] show_registers+0x181/0x200
Apr 21 05:05:54 chogs kernel:  [<c0105e10>] die+0x100/0x1b0
Apr 21 05:05:54 chogs kernel:  [<c01168f6>] do_page_fault+0x3c6/0x8c1
Apr 21 05:05:54 chogs kernel:  [<c010565f>] error_code+0x2b/0x30
Apr 21 05:05:54 chogs kernel:  [<ee2854f3>] _drbd_send_zc_bio+0x33/0x50
[drbd]
Apr 21 05:05:55 chogs kernel:  [<ee285643>] drbd_send_dblock+0x133/0x1f0
[drbd]
Apr 21 05:05:55 chogs kernel:  [<ee2703da>] w_send_dblock+0x1a/0xe0
[drbd]
Apr 21 05:05:55 chogs kernel:  [<ee270e5e>] drbd_worker+0x2de/0x4b5
[drbd]
Apr 21 05:05:55 chogs kernel:  [<ee283f8c>] drbd_thread_setup+0x8c/0x100
[drbd]
Apr 21 05:05:55 chogs kernel:  [<c0103485>]
kernel_thread_helper+0x5/0x10
Apr 21 05:05:55 chogs kernel: Code: 5d f4 8b 7d fc 89 ec 5d c3 90 55 89
e5 57 89 cf b9 00 e0 ff ff 56 53 83 ec 24 8b 75 08 89 45 f0 89 55 ec 21
e1 8b 41 18 89 45 e8 <8b> 02 f6 c4 40 74 03 8b 52 0c 8b 42 04 40 85 c0
7e 09 8b 55 ec
Apr 21 05:05:55 chogs kernel:  <0>Fatal exception: panic in 5 seconds
=20
Thanks,
=20
EM--

------_=_NextPart_001_01C7884E.0EEE70F2
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
<link rel=3DFile-List href=3D"cid:filelist.xml@01C7882C.87721E10">
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
font-family:Arial'>I think we have seen this panic before. <span
style=3D'mso-spacerun:yes'>&nbsp;</span>I am not sure if there was a fix =
then a
regression of sort.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I am looking for a clue to help narrow this down. It =
seems a
<span class=3DSpellE>bvec</span>-&gt;<span class=3DSpellE>bv_page</span> =
is freed
and is being used later. <span =
style=3D'mso-spacerun:yes'>&nbsp;</span>Here is the
panic message:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 color=3Dblack face=3DTahoma><span =
style=3D'font-size:
9.0pt;font-family:Tahoma;color:black'>Apr 21 05:05:53 <span =
class=3DSpellE>chogs</span>
kernel: CPU:&nbsp; &nbsp; 0<br>
Apr 21 05:05:53 <span class=3DSpellE>chogs</span> kernel: EIP:&nbsp; =
&nbsp; <span
class=3DGramE>0061:</span>[&lt;ee2853c1&gt;]&nbsp; &nbsp; Tainted: =
GF&nbsp;
&nbsp; VLI<br>
Apr 21 05:05:53 <span class=3DSpellE>chogs</span> kernel: EFLAGS: =
00010296<span
class=3DGramE>&nbsp; (</span>2.6.16.38-xen #1)<br>
Apr 21 05:05:53 <span class=3DSpellE>chogs</span> kernel: EIP is at
_drbd_send_page+0x21/0x120 [<span class=3DSpellE>drbd</span>]<br>
Apr 21 05:05:53 <span class=3DSpellE>chogs</span> kernel: <span =
class=3DSpellE>eax</span>:
<span class=3DSpellE>ffffffff</span><span class=3DGramE>&nbsp; <span =
class=3DSpellE>ebx</span></span>:
c05958fc&nbsp; <span class=3DSpellE>ecx</span>: eb024000&nbsp; <span
class=3DSpellE>edx</span>: 6b6b6b6b<br>
Apr 21 05:05:53 <span class=3DSpellE>chogs</span> kernel: <span =
class=3DSpellE>esi</span>:
6b6b6b6b<span class=3DGramE>&nbsp; <span =
class=3DSpellE>edi</span></span>:
a56b6b6b&nbsp; <span class=3DSpellE>ebp</span>: eb025eec&nbsp; <span
class=3DSpellE>esp</span>: eb025ebc<br>
Apr 21 05:05:53 <span class=3DSpellE>chogs</span> kernel: <span =
class=3DSpellE>ds</span>:
007b<span class=3DGramE>&nbsp; <span class=3DSpellE>es</span></span>: =
007b&nbsp; <span
class=3DSpellE>ss</span>: 0069<br>
Apr 21 05:05:53 <span class=3DSpellE>chogs</span> kernel: Process =
drbd3_worker (<span
class=3DSpellE><span class=3DGramE>pid</span></span>: 5739, <span =
class=3DSpellE>threadinfo</span>=3Deb024000
task=3Ded440570)<br>
Apr 21 05:05:53 <span class=3DSpellE>chogs</span> kernel: Stack:
&lt;0&gt;00001000 00004000 00000000 eb024000 00000020 ec64b26c <span
class=3DSpellE>ffffffff</span> 6b6b6b6b<br>
Apr 21 05:05:53 <span class=3DSpellE>chogs</span> kernel:&nbsp; &nbsp; =
&nbsp;
&nbsp; ec64b26c c05958fc 00000003 c7a5c6d0 eb025f08 ee2854f3 6b6b6b6b =
ec64b26c<br>
Apr 21 05:05:54 <span class=3DSpellE>chogs</span> kernel:&nbsp; &nbsp; =
&nbsp;
&nbsp; eb025f30 00000000 ec64b26c eb025f5c ee285643 00000020 00008000 =
00000000<br>
Apr 21 05:05:54 <span class=3DSpellE>chogs</span> kernel: Call =
Trace:<br>
Apr 21 05:05:54 <span class=3DSpellE>chogs</span> kernel:&nbsp;
[&lt;c0105a01&gt;] show_stack_log_lvl+0xa1/0xe0<br>
Apr 21 05:05:54 <span class=3DSpellE>chogs</span> kernel:&nbsp;
[&lt;c0105bf1&gt;] show_registers+0x181/0x200<br>
Apr 21 05:05:54 <span class=3DSpellE>chogs</span> kernel:&nbsp;
[&lt;c0105e10&gt;] die+0x100/0x1b0<br>
Apr 21 05:05:54 <span class=3DSpellE>chogs</span> kernel:&nbsp; =
[&lt;c01168f6&gt;]
do_page_fault+0x3c6/0x8c1<br>
Apr 21 05:05:54 <span class=3DSpellE>chogs</span> kernel:&nbsp;
[&lt;c010565f&gt;] error_code+0x2b/0x30<br>
Apr 21 05:05:54 <span class=3DSpellE>chogs</span> kernel:&nbsp;
[&lt;ee2854f3&gt;] _drbd_send_zc_bio+0x33/0x50 [<span =
class=3DSpellE>drbd</span>]<br>
Apr 21 05:05:55 <span class=3DSpellE>chogs</span> kernel:&nbsp;
[&lt;ee285643&gt;] drbd_send_dblock+0x133/0x1f0 [<span =
class=3DSpellE>drbd</span>]<br>
Apr 21 05:05:55 <span class=3DSpellE>chogs</span> kernel:&nbsp;
[&lt;ee2703da&gt;] w_send_dblock+0x1a/0xe0 [<span =
class=3DSpellE>drbd</span>]<br>
Apr 21 05:05:55 <span class=3DSpellE>chogs</span> kernel:&nbsp;
[&lt;ee270e5e&gt;] drbd_worker+0x2de/0x4b5 [<span =
class=3DSpellE>drbd</span>]<br>
Apr 21 05:05:55 <span class=3DSpellE>chogs</span> kernel:&nbsp;
[&lt;ee283f8c&gt;] drbd_thread_setup+0x8c/0x100 [<span =
class=3DSpellE>drbd</span>]<br>
Apr 21 05:05:55 <span class=3DSpellE>chogs</span> kernel:&nbsp;
[&lt;c0103485&gt;] kernel_thread_helper+0x5/0x10<br>
Apr 21 05:05:55 <span class=3DSpellE>chogs</span> kernel: Code: 5d f4 8b =
7d <span
class=3DSpellE>fc</span> 89 <span class=3DSpellE>ec</span> 5d c3 90 55 =
89 e5 57 89 <span
class=3DSpellE>cf</span> b9 00 e0 ff <span class=3DSpellE>ff</span> 56 =
53 83 <span
class=3DSpellE>ec</span> 24 8b 75 08 89 45 f0 89 55 <span =
class=3DSpellE>ec</span>
21 e1 8b 41 18 89 45 e8 &lt;8b&gt; 02 f6 c4 40 74 03 8b 52 0c 8b 42 04 =
40 85 c0
7e 09 8b 55 <span class=3DSpellE>ec</span><br>
Apr 21 05:05:55 <span class=3DSpellE>chogs</span> kernel:&nbsp; =
&lt;0&gt;<span
class=3DGramE>Fatal</span> exception: panic in 5 =
seconds<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 color=3Dblack face=3DTahoma><span =
style=3D'font-size:
9.0pt;font-family:Tahoma;color:black'><o:p>&nbsp;</o:p></span></font></p>=


<p class=3DMsoNormal><font size=3D1 color=3Dblack face=3DTahoma><span =
style=3D'font-size:
9.0pt;font-family:Tahoma;color:black'>Thanks,<o:p></o:p></span></font></p=
>

<p class=3DMsoNormal><font size=3D1 color=3Dblack face=3DTahoma><span =
style=3D'font-size:
9.0pt;font-family:Tahoma;color:black'><o:p>&nbsp;</o:p></span></font></p>=


<p class=3DMsoNormal><font size=3D1 color=3Dblack face=3DTahoma><span =
style=3D'font-size:
9.0pt;font-family:Tahoma;color:black'>EM--</span></font><font size=3D2
face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'><o:p></o:p></span></font></p=
>

</div>

</body>

</html>

------_=_NextPart_001_01C7884E.0EEE70F2--
