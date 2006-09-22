Return-Path: <Ernest.Montrose@stratus.com>
Received: from EXNAR.corp.stratus.com (exnar.corp.stratus.com
	[134.111.200.165])
	by mailhub4.stratus.com (8.12.11/8.12.11) with ESMTP id k8ML89W1005863
	for <drbd-dev@lists.linbit.com>; Fri, 22 Sep 2006 17:08:10 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6DE8C.4D01D5C9"
Date: Fri, 22 Sep 2006 17:15:59 -0400
Message-ID: <BD7042533C2F8943A6A4257A9E31C45439C7D5@EXNA.corp.stratus.com>
From: "Montrose, Ernest" <Ernest.Montrose@stratus.com>
To: <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] DRBD-8 causes a panic in kernel proper.
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C6DE8C.4D01D5C9
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi all,
As of the changes from Wednesday Sep 20, 2006, I see a panic in kernel
proper with the drbd driver loaded and io attempted.=20
I am investigating but I am hoping that some lights might go on and a
quick fix provided.   Thanks.  Below is the stack trace.
=20
Two node cluster:
 =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3DOn the first node

 Sep 22 12:26:12 jerry kernel: Unable to handle kernel NULL pointer
dereference at virtual
 address
 00000000
 Sep 22 12:26:12 jerry kernel:  printing eip:
 Sep 22 12:26:12 jerry kernel: 00000000
 Sep 22 12:26:12 jerry kernel: *pde =3D ma 00000000 pa fffff000
 Sep 22 12:26:12 jerry kernel: Oops: 0000 [#1]
 Sep 22 12:26:12 jerry kernel: Modules linked in: drbd ipmi_devintf
ipmi_si ipmi_msghandler video
 thermal processor fan button battery ac e1000
 Sep 22 12:26:12 jerry kernel: CPU:    0
 Sep 22 12:26:12 jerry kernel: EIP:    0061:[<00000000>]    Not tainted
VLI
 Sep 22 12:26:12 jerry kernel: EFLAGS: 00010206  (2.6.16.13-xen0 #1)
 Sep 22 12:26:12 jerry kernel: EIP is at _stext+0x3fefe000/0x40
 Sep 22 12:26:12 jerry kernel: eax: eda412c0  ebx: 00000000  ecx:
00001000  edx: ead80734
 Sep 22 12:26:12 jerry kernel: esi: 00006000  edi: ef859800  ebp:
e6195c80  esp: e6195c60
 Sep 22 12:26:12 jerry kernel: ds: 007b  es: 007b  ss: 0069
 Sep 22 12:26:12 jerry kernel: Process xvd 1 93:00 (pid: 31717,
threadinfo=3De6194000
 task=3Deaa20030)
 Sep 22 12:26:12 jerry kernel: Stack: <0>f12c522f ead80734 e56aba40
e6fd4f90 c0780bc0 e56aba40
 00001000 e6fd4f90
 Sep 22 12:26:12 jerry kernel:        e6195cc0 c015ed68 ead80734
e56aba40 e6fd4f90 c012da5c
 efd0fe6c 00000000
 Sep 22 12:26:12 jerry kernel:        e56aba40 00000000 e6195ccc
c015e762 c093a760 00000000
 00000000 e56aba40
 Sep 22 12:26:12 jerry kernel: Call Trace:
 Sep 22 12:26:12 jerry kernel:  [<c010515a>]
show_stack_log_lvl+0xaa/0xe0
 Sep 22 12:26:12 jerry kernel:  [<c010536e>] show_registers+0x18e/0x210
 Sep 22 12:26:12 jerry kernel:  [<c0105569>] die+0xd9/0x180
 Sep 22 12:26:12 jerry kernel:  [<c0112ccc>] do_page_fault+0x3cc/0x68e
 Sep 22 12:26:12 jerry kernel:  [<c0104d7f>] error_code+0x2b/0x30
 Sep 22 12:26:12 jerry kernel:  [<c015ed68>] __bio_add_page+0x268/0x2d0
 Sep 22 12:26:12 jerry kernel:  [<c015ee4e>] bio_add_page+0x3e/0x40
 Sep 22 12:26:12 jerry kernel:  [<c02de086>]
dispatch_rw_block_io+0x3a6/0x4c0
 Sep 22 12:26:12 jerry kernel:  [<c02ddcbe>] do_block_io_op+0xce/0xf0
 Sep 22 12:26:12 jerry kernel:  [<c02dd8c3>] blkif_schedule+0x73/0x290
 Sep 22 12:26:12 jerry kernel:  [<c012d517>] kthread+0xa7/0xf0
 Sep 22 12:26:12 jerry kernel:  [<c0102d9d>]
kernel_thread_helper+0x5/0x18
 Sep 22 12:26:12 jerry kernel: Code:  Bad EIP value.
 Sep 22 12:26:12 jerry kernel:  <0>Fatal exception: panic in 5 seconds =20
=20

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3DOn the next node
 Sep 22 12:33:02 jerry kernel: Unable to handle kernel NULL pointer
dereference at virtual
 address
 00000000
 Sep 22 12:33:02 jerry kernel:  printing eip:
 Sep 22 12:33:02 jerry kernel: 00000000
 Sep 22 12:33:02 jerry kernel: *pde =3D ma 00000000 pa fffff000
 Sep 22 12:33:02 jerry kernel: Oops: 0000 [#1]
 Sep 22 12:33:02 jerry kernel: Modules linked in: drbd ipmi_devintf
ipmi_si ipmi_msghandler video
 thermal processor fan button battery ac e1000
 Sep 22 12:33:02 jerry kernel: CPU:    0
 Sep 22 12:33:02 jerry kernel: EIP:    0061:[<00000000>]    Not tainted
VLI
 Sep 22 12:33:02 jerry kernel: EFLAGS: 00010206  (2.6.16.13-xen0 #1)
 Sep 22 12:33:02 jerry kernel: EIP is at _stext+0x3fefe000/0x40
 Sep 22 12:33:02 jerry kernel: eax: ed45e200  ebx: 00000000  ecx:
00001000  edx: ec8a6ab8
 Sep 22 12:33:02 jerry kernel: esi: 00008000  edi: efe8e800  ebp:
ee369b28  esp: ee369b08
 Sep 22 12:33:02 jerry kernel: ds: 007b  es: 007b  ss: 0069
 Sep 22 12:33:02 jerry kernel: Process java (pid: 6091,
threadinfo=3Dee368000 task=3Dea9045b0)
 Sep 22 12:33:02 jerry kernel: Stack: <0>f12c522f ec8a6ab8 e98d1b00
c0763fb0 00011000 e98d1b00
 00001000 c0763fb0
 Sep 22 12:33:03 jerry kernel:        ee369b68 c015ed68 ec8a6ab8
e98d1b00 c0763fb0 c015e762
 c093a760 000000d0
 Sep 22 12:33:03 jerry kernel:        0000000c 00000000 00000001
000000d0 00000001 00001000
 00000001 00000001
 Sep 22 12:33:03 jerry kernel: Call Trace:
 Sep 22 12:33:03 jerry kernel:  [<c010515a>]
show_stack_log_lvl+0xaa/0xe0
 Sep 22 12:33:03 jerry kernel:  [<c010536e>] show_registers+0x18e/0x210
 Sep 22 12:33:03 jerry kernel:  [<c0105569>] die+0xd9/0x180
 Sep 22 12:33:03 jerry kernel:  [<c0112ccc>] do_page_fault+0x3cc/0x68e
 Sep 22 12:33:03 jerry kernel:  [<c0104d7f>] error_code+0x2b/0x30
 Sep 22 12:33:03 jerry kernel:  [<c015ed68>] __bio_add_page+0x268/0x2d0
 Sep 22 12:33:03 jerry kernel:  [<c015ee4e>] bio_add_page+0x3e/0x40
 Sep 22 12:33:03 jerry kernel:  [<c017d622>]
do_mpage_readpage+0x182/0x320
 Sep 22 12:33:03 jerry kernel:  [<c017d86c>] mpage_readpages+0xac/0x140
 Sep 22 12:33:03 jerry kernel:  [<c01c21b8>] ext3_readpages+0x28/0x30
 Sep 22 12:33:03 jerry kernel:  [<c013fced>] read_pages+0xfd/0x110
 Sep 22 12:33:03 jerry kernel:  [<c013fe48>]
__do_page_cache_readahead+0x148/0x190
 Sep 22 12:33:03 jerry kernel:  [<c013ffdf>]
blockable_page_cache_readahead+0x4f/0xd0
 Sep 22 12:33:03 jerry kernel:  [<c014021d>]
page_cache_readahead+0xfd/0x1a0
 Sep 22 12:33:03 jerry kernel:  [<c0138de2>]
do_generic_mapping_read+0x442/0x620
 Sep 22 12:33:03 jerry kernel:  [<c013924c>]
__generic_file_aio_read+0x19c/0x220
 Sep 22 12:33:03 jerry kernel:  [<c0139323>]
generic_file_aio_read+0x53/0x70
 Sep 22 12:33:03 jerry kernel:  [<c015951a>] do_sync_read+0xba/0x110
 Sep 22 12:33:03 jerry kernel:  [<c0159611>] vfs_read+0xa1/0x190
 Sep 22 12:33:03 jerry kernel:  [<c01599eb>] sys_read+0x4b/0x80
 Sep 22 12:33:03 jerry kernel:  [<c0104c09>] syscall_call+0x7/0xb
 Sep 22 12:33:03 jerry kernel: Code:  Bad EIP value.
 Sep 22 12:33:03 jerry kernel:  <0>Fatal exception: panic in 5 seconds
=20
EM--

------_=_NextPart_001_01C6DE8C.4D01D5C9
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
<link rel=3DFile-List href=3D"cid:filelist.xml@01C6DE6A.C5F141A0">
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
	{mso-style-type:personal;
	mso-style-noshow:yes;
	mso-ansi-font-size:10.0pt;
	mso-bidi-font-size:10.0pt;
	font-family:Arial;
	mso-ascii-font-family:Arial;
	mso-hansi-font-family:Arial;
	mso-bidi-font-family:Arial;
	color:windowtext;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	mso-style-noshow:yes;
	mso-ansi-font-size:10.0pt;
	mso-bidi-font-size:10.0pt;
	font-family:Arial;
	mso-ascii-font-family:Arial;
	mso-hansi-font-family:Arial;
	mso-bidi-font-family:Arial;
	color:navy;}
span.bugeventheader1
	{mso-style-name:bugeventheader1;
	mso-ansi-font-size:9.0pt;
	mso-bidi-font-size:9.0pt;
	font-family:Tahoma;
	mso-ascii-font-family:Tahoma;
	mso-hansi-font-family:Tahoma;
	mso-bidi-font-family:Tahoma;
	font-weight:bold;}
span.bugeventdate1
	{mso-style-name:bugeventdate1;
	mso-ansi-font-size:8.5pt;
	mso-bidi-font-size:8.5pt;
	font-family:Tahoma;
	mso-ascii-font-family:Tahoma;
	mso-hansi-font-family:Tahoma;
	mso-bidi-font-family:Tahoma;
	color:#555555;
	mso-text-animation:none;
	text-decoration:none;
	text-underline:none;
	text-decoration:none;
	text-line-through:none;}
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

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Hi =
all,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>As of the changes from Wednesday =
Sep 20,
2006, I see a panic in kernel proper with the <span =
class=3DSpellE>drbd</span>
driver loaded and <span class=3DSpellE><span =
class=3DGramE>io</span></span>
attempted. <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>I am investigating but I am hoping =
that
some lights might go on and a quick fix provided. <span
style=3D'mso-spacerun:yes'>&nbsp;&nbsp;</span>Thanks.<span
style=3D'mso-spacerun:yes'>&nbsp; </span>Below is the stack =
trace.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'margin-bottom:12.0pt;line-height:11.25pt'><font
size=3D1 color=3Dblack face=3DTahoma><span =
style=3D'font-size:9.0pt;font-family:Tahoma;
color:black'>Two node cluster:<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'margin-bottom:12.0pt;line-height:11.25pt'><font
size=3D1 color=3Dblack face=3DTahoma><span =
style=3D'font-size:9.0pt;font-family:Tahoma;
color:black'>&nbsp;=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<span class=3DGramE>On</span> the
first node<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'line-height:11.25pt'><font size=3D1 =
color=3Dblack
face=3DTahoma><span =
style=3D'font-size:9.0pt;font-family:Tahoma;color:black'><br>
&nbsp;Sep 22 12:26:12 jerry kernel: Unable to handle kernel NULL pointer
dereference at virtual<br>
&nbsp;<span class=3DGramE>address</span><br>
&nbsp;00000000<br>
&nbsp;Sep 22 12:26:12 jerry kernel:&nbsp; printing <span =
class=3DSpellE>eip</span>:<br>
&nbsp;Sep 22 12:26:12 jerry kernel: 00000000<br>
&nbsp;Sep 22 12:26:12 jerry kernel: *<span class=3DSpellE>pde</span> =3D =
ma
00000000 pa fffff000<br>
&nbsp;Sep 22 12:26:12 jerry kernel: Oops: 0000 [#1]<br>
&nbsp;Sep 22 12:26:12 jerry kernel: Modules linked in: <span =
class=3DSpellE>drbd</span>
<span class=3DSpellE>ipmi_devintf</span> <span =
class=3DSpellE>ipmi_si</span> <span
class=3DSpellE>ipmi_msghandler</span> video<br>
&nbsp;<span class=3DGramE>thermal</span> processor fan button battery ac =
e1000<br>
&nbsp;Sep 22 12:26:12 jerry kernel: CPU:&nbsp; &nbsp; 0<br>
&nbsp;Sep 22 12:26:12 jerry kernel: EIP:&nbsp; &nbsp; <span =
class=3DGramE>0061:</span>[&lt;00000000&gt;]&nbsp;
&nbsp; Not tainted VLI<br>
&nbsp;Sep 22 12:26:12 jerry kernel: EFLAGS: 00010206<span =
class=3DGramE>&nbsp; (</span>2.6.16.13-xen0
#1)<br>
&nbsp;Sep 22 12:26:12 jerry kernel: EIP is at _stext+0x3fefe000/0x40<br>
&nbsp;Sep 22 12:26:12 jerry kernel: <span class=3DSpellE>eax</span>: =
eda412c0<span
class=3DGramE>&nbsp; <span class=3DSpellE>ebx</span></span>: =
00000000&nbsp; <span
class=3DSpellE>ecx</span>: 00001000&nbsp; <span =
class=3DSpellE>edx</span>: ead80734<br>
&nbsp;Sep 22 12:26:12 jerry kernel: <span class=3DSpellE>esi</span>: =
00006000<span
class=3DGramE>&nbsp; <span class=3DSpellE>edi</span></span>: =
ef859800&nbsp; <span
class=3DSpellE>ebp</span>: e6195c80&nbsp; <span =
class=3DSpellE>esp</span>: e6195c60<br>
&nbsp;Sep 22 12:26:12 jerry kernel: <span class=3DSpellE>ds</span>: =
007b<span
class=3DGramE>&nbsp; <span class=3DSpellE>es</span></span>: 007b&nbsp; =
<span
class=3DSpellE>ss</span>: 0069<br>
&nbsp;Sep 22 12:26:12 jerry kernel: Process <span =
class=3DSpellE>xvd</span> 1
93:00 (<span class=3DSpellE><span class=3DGramE>pid</span></span>: =
31717, <span
class=3DSpellE>threadinfo</span>=3De6194000<br>
&nbsp;<span class=3DGramE>task=3D</span>eaa20030)<br>
&nbsp;Sep 22 12:26:12 jerry kernel: Stack: &lt;0&gt;f12c522f ead80734 =
e56aba40
e6fd4f90 c0780bc0 e56aba40<br>
&nbsp;00001000 e6fd4f90<br>
&nbsp;Sep 22 12:26:12 jerry kernel:&nbsp; &nbsp; &nbsp; &nbsp; e6195cc0
c015ed68 ead80734 e56aba40 e6fd4f90 c012da5c<br>
&nbsp;efd0fe6c 00000000<br>
&nbsp;Sep 22 12:26:12 jerry kernel:&nbsp; &nbsp; &nbsp; &nbsp; e56aba40
00000000 e6195ccc c015e762 c093a760 00000000<br>
&nbsp;00000000 e56aba40<br>
&nbsp;Sep 22 12:26:12 jerry kernel: Call Trace:<br>
&nbsp;Sep 22 12:26:12 jerry kernel:&nbsp; [&lt;c010515a&gt;]
show_stack_log_lvl+0xaa/0xe0<br>
&nbsp;Sep 22 12:26:12 jerry kernel:&nbsp; [&lt;c010536e&gt;]
show_registers+0x18e/0x210<br>
&nbsp;Sep 22 12:26:12 jerry kernel:&nbsp; [&lt;c0105569&gt;] =
die+0xd9/0x180<br>
&nbsp;Sep 22 12:26:12 jerry kernel:&nbsp; [&lt;c0112ccc&gt;]
do_page_fault+0x3cc/0x68e<br>
&nbsp;Sep 22 12:26:12 jerry kernel:&nbsp; [&lt;c0104d7f&gt;]
error_code+0x2b/0x30<br>
&nbsp;Sep 22 12:26:12 jerry kernel:&nbsp; [&lt;c015ed68&gt;]
__bio_add_page+0x268/0x2d0<br>
&nbsp;Sep 22 12:26:12 jerry kernel:&nbsp; [&lt;c015ee4e&gt;]
bio_add_page+0x3e/0x40<br>
&nbsp;Sep 22 12:26:12 jerry kernel:&nbsp; [&lt;c02de086&gt;]
dispatch_rw_block_io+0x3a6/0x4c0<br>
&nbsp;Sep 22 12:26:12 jerry kernel:&nbsp; [&lt;c02ddcbe&gt;]
do_block_io_op+0xce/0xf0<br>
&nbsp;Sep 22 12:26:12 jerry kernel:&nbsp; [&lt;c02dd8c3&gt;]
blkif_schedule+0x73/0x290<br>
&nbsp;Sep 22 12:26:12 jerry kernel:&nbsp; [&lt;c012d517&gt;] =
kthread+0xa7/0xf0<br>
&nbsp;Sep 22 12:26:12 jerry kernel:&nbsp; [&lt;c0102d9d&gt;]
kernel_thread_helper+0x5/0x18<br>
&nbsp;Sep 22 12:26:12 jerry kernel: Code:&nbsp; Bad EIP value.<br>
&nbsp;Sep 22 12:26:12 jerry kernel:&nbsp; &lt;0&gt;Fatal exception: =
panic in 5
seconds&nbsp; <br>
&nbsp;<br>
<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D<span class=3DGramE>On</span> the next =
node<br>
&nbsp;Sep 22 12:33:02 jerry kernel: Unable to handle kernel NULL pointer
dereference at virtual<br>
&nbsp;<span class=3DGramE>address</span><br>
&nbsp;00000000<br>
&nbsp;Sep 22 12:33:02 jerry kernel:&nbsp; printing <span =
class=3DSpellE>eip</span>:<br>
&nbsp;Sep 22 12:33:02 jerry kernel: 00000000<br>
&nbsp;Sep 22 12:33:02 jerry kernel: *<span class=3DSpellE>pde</span> =3D =
ma
00000000 pa fffff000<br>
&nbsp;Sep 22 12:33:02 jerry kernel: Oops: 0000 [#1]<br>
&nbsp;Sep 22 12:33:02 jerry kernel: Modules linked in: <span =
class=3DSpellE>drbd</span>
<span class=3DSpellE>ipmi_devintf</span> <span =
class=3DSpellE>ipmi_si</span> <span
class=3DSpellE>ipmi_msghandler</span> video<br>
&nbsp;<span class=3DGramE>thermal</span> processor fan button battery ac =
e1000<br>
&nbsp;Sep 22 12:33:02 jerry kernel: CPU:&nbsp; &nbsp; 0<br>
&nbsp;Sep 22 12:33:02 jerry kernel: EIP:&nbsp; &nbsp; <span =
class=3DGramE>0061:</span>[&lt;00000000&gt;]&nbsp;
&nbsp; Not tainted VLI<br>
&nbsp;Sep 22 12:33:02 jerry kernel: EFLAGS: 00010206<span =
class=3DGramE>&nbsp; (</span>2.6.16.13-xen0
#1)<br>
&nbsp;Sep 22 12:33:02 jerry kernel: EIP is at _stext+0x3fefe000/0x40<br>
&nbsp;Sep 22 12:33:02 jerry kernel: <span class=3DSpellE>eax</span>: =
ed45e200<span
class=3DGramE>&nbsp; <span class=3DSpellE>ebx</span></span>: =
00000000&nbsp; <span
class=3DSpellE>ecx</span>: 00001000&nbsp; <span =
class=3DSpellE>edx</span>: ec8a6ab8<br>
&nbsp;Sep 22 12:33:02 jerry kernel: <span class=3DSpellE>esi</span>: =
00008000<span
class=3DGramE>&nbsp; <span class=3DSpellE>edi</span></span>: =
efe8e800&nbsp; <span
class=3DSpellE>ebp</span>: ee369b28&nbsp; <span =
class=3DSpellE>esp</span>: ee369b08<br>
&nbsp;Sep 22 12:33:02 jerry kernel: <span class=3DSpellE>ds</span>: =
007b<span
class=3DGramE>&nbsp; <span class=3DSpellE>es</span></span>: 007b&nbsp; =
<span
class=3DSpellE>ss</span>: 0069<br>
&nbsp;Sep 22 12:33:02 jerry kernel: Process java (<span =
class=3DSpellE><span
class=3DGramE>pid</span></span>: 6091, <span =
class=3DSpellE>threadinfo</span>=3Dee368000
task=3Dea9045b0)<br>
&nbsp;Sep 22 12:33:02 jerry kernel: Stack: &lt;0&gt;f12c522f ec8a6ab8 =
e98d1b00
c0763fb0 00011000 e98d1b00<br>
&nbsp;00001000 c0763fb0<br>
&nbsp;Sep 22 12:33:03 jerry kernel:&nbsp; &nbsp; &nbsp; &nbsp; ee369b68
c015ed68 ec8a6ab8 e98d1b00 c0763fb0 c015e762<br>
&nbsp;c093a760 000000d0<br>
&nbsp;Sep 22 12:33:03 jerry kernel:&nbsp; &nbsp; &nbsp; &nbsp; 0000000c
00000000 00000001 000000d0 00000001 00001000<br>
&nbsp;00000001 <span class=3DSpellE>00000001</span><br>
&nbsp;Sep 22 12:33:03 jerry kernel: Call Trace:<br>
&nbsp;Sep 22 12:33:03 jerry kernel:&nbsp; [&lt;c010515a&gt;]
show_stack_log_lvl+0xaa/0xe0<br>
&nbsp;Sep 22 12:33:03 jerry kernel:&nbsp; [&lt;c010536e&gt;]
show_registers+0x18e/0x210<br>
&nbsp;Sep 22 12:33:03 jerry kernel:&nbsp; [&lt;c0105569&gt;] =
die+0xd9/0x180<br>
&nbsp;Sep 22 12:33:03 jerry kernel:&nbsp; [&lt;c0112ccc&gt;]
do_page_fault+0x3cc/0x68e<br>
&nbsp;Sep 22 12:33:03 jerry kernel:&nbsp; [&lt;c0104d7f&gt;]
error_code+0x2b/0x30<br>
&nbsp;Sep 22 12:33:03 jerry kernel:&nbsp; [&lt;c015ed68&gt;]
__bio_add_page+0x268/0x2d0<br>
&nbsp;Sep 22 12:33:03 jerry kernel:&nbsp; [&lt;c015ee4e&gt;] =
bio_add_page+0x3e/0x40<br>
&nbsp;Sep 22 12:33:03 jerry kernel:&nbsp; [&lt;c017d622&gt;]
do_mpage_readpage+0x182/0x320<br>
&nbsp;Sep 22 12:33:03 jerry kernel:&nbsp; [&lt;c017d86c&gt;]
mpage_readpages+0xac/0x140<br>
&nbsp;Sep 22 12:33:03 jerry kernel:&nbsp; [&lt;c01c21b8&gt;]
ext3_readpages+0x28/0x30<br>
&nbsp;Sep 22 12:33:03 jerry kernel:&nbsp; [&lt;c013fced&gt;]
read_pages+0xfd/0x110<br>
&nbsp;Sep 22 12:33:03 jerry kernel:&nbsp; [&lt;c013fe48&gt;]
__do_page_cache_readahead+0x148/0x190<br>
&nbsp;Sep 22 12:33:03 jerry kernel:&nbsp; [&lt;c013ffdf&gt;]
blockable_page_cache_readahead+0x4f/0xd0<br>
&nbsp;Sep 22 12:33:03 jerry kernel:&nbsp; [&lt;c014021d&gt;] =
page_cache_readahead+0xfd/0x1a0<br>
&nbsp;Sep 22 12:33:03 jerry kernel:&nbsp; [&lt;c0138de2&gt;]
do_generic_mapping_read+0x442/0x620<br>
&nbsp;Sep 22 12:33:03 jerry kernel:&nbsp; [&lt;c013924c&gt;]
__generic_file_aio_read+0x19c/0x220<br>
&nbsp;Sep 22 12:33:03 jerry kernel:&nbsp; [&lt;c0139323&gt;]
generic_file_aio_read+0x53/0x70<br>
&nbsp;Sep 22 12:33:03 jerry kernel:&nbsp; [&lt;c015951a&gt;]
do_sync_read+0xba/0x110<br>
&nbsp;Sep 22 12:33:03 jerry kernel:&nbsp; [&lt;c0159611&gt;]
vfs_read+0xa1/0x190<br>
&nbsp;Sep 22 12:33:03 jerry kernel:&nbsp; [&lt;c01599eb&gt;] =
sys_read+0x4b/0x80<br>
&nbsp;Sep 22 12:33:03 jerry kernel:&nbsp; [&lt;c0104c09&gt;] =
syscall_call+0x7/0xb<br>
&nbsp;Sep 22 12:33:03 jerry kernel: Code:&nbsp; Bad EIP value.<br>
&nbsp;Sep 22 12:33:03 jerry kernel:&nbsp; &lt;0&gt;<span =
class=3DGramE>Fatal</span>
exception: panic in 5 seconds<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>EM--<o:p></o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C6DE8C.4D01D5C9--
