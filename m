Return-Path: <Ernest.Montrose@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C71FA3.A95027FE"
Date: Thu, 14 Dec 2006 12:16:58 -0500
Message-ID: <BD7042533C2F8943A6A4257A9E31C45439C889@EXNA.corp.stratus.com>
From: "Montrose, Ernest" <Ernest.Montrose@stratus.com>
To: <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] DRBD8: Kernel Oops in _drbd_send_page+0x1f/0x120 
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C71FA3.A95027FE
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi all,
We are seeing an oops in _drbd_send_page() it seems like we are having
SIZE issues with the bio list. I am not
Able to state the cause nor am I able to reproduce it consistently.  I
hope someone might have a better idea.
Below is the full message:
=20
Dec 11 05:46:26 chong kernel: xenbr0: port 4(vif31.0) entering disabled
state
Dec 11 05:48:15 chong kernel: drbd1: role( Primary -> Secondary )
Dec 11 05:48:18 chong kernel: drbd1: Writing meta data super block now.
Dec 11 05:48:18 chong kernel: drbd1: peer( Secondary -> Primary )
Dec 11 05:55:40 chong kernel: drbd0: peer( Primary -> Secondary )
Dec 11 05:55:40 chong kernel: drbd0: role( Secondary -> Primary )
Dec 11 05:55:40 chong kernel: drbd0: Writing meta data super block now.
netbk: WARNING: device 'vif32.0' has non-zero queue length (32)!
Dec 11 05:55:40 chong kernel: netbk: WARNING: device 'vif32.0' has
non-zero queue length (32)!
Dec 11 05:55:42 chong kernel: device vif32.0 entered promiscuous mode
Dec 11 05:56:04 chong kernel: xenbr0: port 3(vif32.0) entering learning
state
Dec 11 05:56:04 chong kernel: xenbr0: topology change detected,
propagating
Dec 11 05:56:04 chong kernel: xenbr0: port 3(vif32.0) entering
forwarding state
Dec 11 05:56:20 chong kernel: drbd1: peer( Primary -> Secondary )
Dec 11 05:56:21 chong kernel: drbd1: role( Secondary -> Primary )
Dec 11 05:56:21 chong kernel: drbd1: Writing meta data super block now.
netbk: WARNING: device 'vif33.0' has non-zero queue length (32)!
Dec 11 05:56:21 chong kernel: netbk: WARNING: device 'vif33.0' has
non-zero queue length (32)!
Unable to handle kernel paging request at virtual address 5c65415f
 printing eip:
f12bc71f
*pde =3D ma 00000000 pa fffff000
Oops: 0000 [#1]
Modules linked in: iptable_filter ip_tables x_tables drbd ipmi_devintf
ipmi_si ipmi_msghandler video thermal processor fan button battery ac
e1000
CPU:    0
EIP:    0061:[<f12bc71f>]    Not tainted VLI
EFLAGS: 00010286  (2.6.16.29-xen0 #1)
EIP is at _drbd_send_page+0x1f/0x120 [drbd]
eax: ffffffff  ebx: ca82ccbc  ecx: ec048000  edx: 5c65415f
esi: 00001000  edi: c14a7fc0  ebp: ec049eec  esp: ec049ec0
ds: 007b  es: 007b  ss: 0069
Process drbd0_worker (pid: 4779, threadinfo=3Dec048000 task=3Dec6e9a30)
Stack: <0>ec626380 c1011c40 00000000 00001000 00004000 ec048000 00000020
ffffffff
      ca82ccbc 00000001 cddfab00 ec049f10 f12bc85f ee71f800 5c65415f
00001000
      c14a7fc0 ec049f38 00008000 00000001 ec049f64 f12bc99f ee71f800
cddfab00
Call Trace:
 [<c010522a>] show_stack_log_lvl+0xaa/0xe0
 [<c010543e>] show_registers+0x18e/0x210
 [<c0105639>] die+0xd9/0x180
 [<c011329c>] do_page_fault+0x3cc/0x6ce
 [<c0104e3b>] error_code+0x2b/0x30
 [<f12bc85f>] _drbd_send_zc_bio+0x3f/0x60 [drbd]
 [<f12bc99f>] drbd_send_dblock+0x11f/0x200 [drbd]
 [<f12a8ef1>] w_send_dblock+0x21/0xb0 [drbd]
 [<f12a98a8>] drbd_worker+0x268/0x355 [drbd]
 [<f12bb323>] drbd_thread_setup+0x73/0xd0 [drbd]
 [<c0102d7d>] kernel_thread_helper+0x5/0x18
Code: c3 8d 74 26 00 8d bc 27 00 00 00 00 55 b9 00 e0 ff ff 89 e5 57 56
53 83 ec 20 8b 55 0c 21 e1 8b 41 18 8b 7d 14 8b 75 10 89 45 f0 <8b> 02
89 fb f6 c4 40 74 03 8b 52 0c 8b 42 04 40
85 c0 7e 09 8b
 <0>Fatal exception: panic in 5 seconds

------_=_NextPart_001_01C71FA3.A95027FE
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DProgId content=3DWord.Document>
<meta name=3DGenerator content=3D"Microsoft Word 11">
<meta name=3DOriginator content=3D"Microsoft Word 11">
<link rel=3DFile-List href=3D"cid:filelist.xml@01C71F79.BFD80E20">
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

<p class=3DMsoNormal><font size=3D1 color=3Dblack face=3DTahoma><span =
style=3D'font-size:
9.0pt;font-family:Tahoma;color:black'>Hi =
all,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 color=3Dblack face=3DTahoma><span =
style=3D'font-size:
9.0pt;font-family:Tahoma;color:black'>We are seeing an oops in _<span
class=3DSpellE><i><span style=3D'font-style:italic'>drbd_send_<span =
class=3DGramE>page</span></span></i></span><span
class=3DGramE><i><span =
style=3D'font-style:italic'>(</span></i></span><i><span
style=3D'font-style:italic'>) it seems like we are having SIZE issues =
with the
bio list. I am not<o:p></o:p></span></i></span></font></p>

<p class=3DMsoNormal><i><font size=3D1 color=3Dblack face=3DTahoma><span
style=3D'font-size:9.0pt;font-family:Tahoma;color:black;font-style:italic=
'>Able to
<span class=3DGramE>state the cause nor</span> am I able to reproduce it
consistently. <span style=3D'mso-spacerun:yes'>&nbsp;</span>I hope =
someone might have
a better idea.<o:p></o:p></span></font></i></p>

<p class=3DMsoNormal><i><font size=3D1 color=3Dblack face=3DTahoma><span
style=3D'font-size:9.0pt;font-family:Tahoma;color:black;font-style:italic=
'>Below
is the full message:<o:p></o:p></span></font></i></p>

<p class=3DMsoNormal><font size=3D1 color=3Dblack face=3DTahoma><span =
style=3D'font-size:
9.0pt;font-family:Tahoma;color:black'><o:p>&nbsp;</o:p></span></font></p>=


<p class=3DMsoNormal><font size=3D1 color=3Dblack face=3DTahoma><span =
style=3D'font-size:
9.0pt;font-family:Tahoma;color:black'>Dec 11 05:46:26 <span =
class=3DSpellE>chong</span>
kernel: xenbr0: port 4(vif31.0) entering disabled state<br>
Dec 11 05:48:15 <span class=3DSpellE>chong</span> kernel: drbd1: <span
class=3DGramE>role(</span> Primary -&gt; Secondary )<br>
Dec 11 05:48:18 <span class=3DSpellE>chong</span> kernel: drbd1: Writing =
<span
class=3DGramE>meta</span> data super block now.<br>
Dec 11 05:48:18 <span class=3DSpellE>chong</span> kernel: drbd1: <span
class=3DGramE>peer(</span> Secondary -&gt; Primary )<br>
Dec 11 05:55:40 <span class=3DSpellE>chong</span> kernel: drbd0: <span
class=3DGramE>peer(</span> Primary -&gt; Secondary )<br>
Dec 11 05:55:40 <span class=3DSpellE>chong</span> kernel: drbd0: <span
class=3DGramE>role(</span> Secondary -&gt; Primary )<br>
Dec 11 05:55:40 <span class=3DSpellE>chong</span> kernel: drbd0: Writing =
<span
class=3DGramE>meta</span> data super block now.<br>
<span class=3DSpellE><span class=3DGramE>netbk</span></span>: WARNING: =
device
'vif32.0' has non-zero queue length (32)!<br>
Dec 11 05:55:40 <span class=3DSpellE>chong</span> kernel: <span =
class=3DSpellE>netbk</span>:
WARNING: device 'vif32.0' has non-zero queue length (32)!<br>
Dec 11 05:55:42 <span class=3DSpellE>chong</span> kernel: device vif32.0 =
entered
promiscuous mode<br>
Dec 11 05:56:04 <span class=3DSpellE>chong</span> kernel: xenbr0: port =
3(vif32.0)
entering learning state<br>
Dec 11 05:56:04 <span class=3DSpellE>chong</span> kernel: xenbr0: =
topology change
detected, propagating<br>
Dec 11 05:56:04 <span class=3DSpellE>chong</span> kernel: xenbr0: port =
3(vif32.0)
entering forwarding state<br>
Dec 11 05:56:20 <span class=3DSpellE>chong</span> kernel: drbd1: <span
class=3DGramE>peer(</span> Primary -&gt; Secondary )<br>
Dec 11 05:56:21 <span class=3DSpellE>chong</span> kernel: drbd1: <span
class=3DGramE>role(</span> Secondary -&gt; Primary )<br>
Dec 11 05:56:21 <span class=3DSpellE>chong</span> kernel: drbd1: Writing =
<span
class=3DGramE>meta</span> data super block now.<br>
<span class=3DSpellE><span class=3DGramE>netbk</span></span>: WARNING: =
device
'vif33.0' has non-zero queue length (32)!<br>
Dec 11 05:56:21 <span class=3DSpellE>chong</span> kernel: <span =
class=3DSpellE>netbk</span>:
WARNING: device 'vif33.0' has non-zero queue length (32)!<br>
Unable to handle kernel paging request at virtual address 5c65415f<br>
&nbsp;<span class=3DGramE>printing</span> <span =
class=3DSpellE>eip</span>:<br>
f12bc71f<br>
*<span class=3DSpellE>pde</span> =3D ma 00000000 pa fffff000<br>
Oops: 0000 [#1]<br>
Modules linked in: <span class=3DSpellE>iptable_filter</span> <span =
class=3DSpellE>ip_tables</span>
<span class=3DSpellE>x_tables</span> <span class=3DSpellE>drbd</span> =
<span
class=3DSpellE>ipmi_devintf</span> <span class=3DSpellE>ipmi_si</span> =
<span
class=3DSpellE>ipmi_msghandler</span> video thermal processor fan button =
battery
ac e1000<br>
CPU:&nbsp; &nbsp; 0<br>
EIP:&nbsp; &nbsp; <span =
class=3DGramE>0061:</span>[&lt;f12bc71f&gt;]&nbsp; &nbsp;
Not tainted VLI<br>
EFLAGS: 00010286<span class=3DGramE>&nbsp; (</span>2.6.16.29-xen0 =
#1)<br>
EIP is at _drbd_send_page+0x1f/0x120 [<span =
class=3DSpellE>drbd</span>]<br>
<span class=3DSpellE><span class=3DGramE>eax</span></span>: <span =
class=3DSpellE>ffffffff</span>&nbsp;
<span class=3DSpellE>ebx</span>: ca82ccbc&nbsp; <span =
class=3DSpellE>ecx</span>:
ec048000&nbsp; <span class=3DSpellE>edx</span>: 5c65415f<br>
<span class=3DSpellE><span class=3DGramE>esi</span></span>: =
00001000&nbsp; <span
class=3DSpellE>edi</span>: c14a7fc0&nbsp; <span =
class=3DSpellE>ebp</span>:
ec049eec&nbsp; <span class=3DSpellE>esp</span>: ec049ec0<br>
<span class=3DSpellE><span class=3DGramE>ds</span></span>: 007b&nbsp; =
<span
class=3DSpellE>es</span>: 007b&nbsp; <span class=3DSpellE>ss</span>: =
0069<br>
Process drbd0_worker (<span class=3DSpellE><span =
class=3DGramE>pid</span></span>:
4779, <span class=3DSpellE>threadinfo</span>=3Dec048000 =
task=3Dec6e9a30)<br>
Stack: &lt;0&gt;ec626380 c1011c40 00000000 00001000 00004000 ec048000 =
00000020 <span
class=3DSpellE>ffffffff</span><br>
&nbsp; &nbsp; &nbsp; ca82ccbc 00000001 cddfab00 ec049f10 f12bc85f =
ee71f800
5c65415f 00001000<br>
&nbsp; &nbsp; &nbsp; c14a7fc0 ec049f38 00008000 00000001 ec049f64 =
f12bc99f
ee71f800 cddfab00<br>
Call Trace:<br>
&nbsp;[&lt;c010522a&gt;] show_stack_log_lvl+0xaa/0xe0<br>
&nbsp;[&lt;c010543e&gt;] show_registers+0x18e/0x210<br>
&nbsp;[&lt;c0105639&gt;] die+0xd9/0x180<br>
&nbsp;[&lt;c011329c&gt;] do_page_fault+0x3cc/0x6ce<br>
&nbsp;[&lt;c0104e3b&gt;] error_code+0x2b/0x30<br>
&nbsp;[&lt;f12bc85f&gt;] _drbd_send_zc_bio+0x3f/0x60 [<span =
class=3DSpellE>drbd</span>]<br>
&nbsp;[&lt;f12bc99f&gt;] drbd_send_dblock+0x11f/0x200 [<span =
class=3DSpellE>drbd</span>]<br>
&nbsp;[&lt;f12a8ef1&gt;] w_send_dblock+0x21/0xb0 [<span =
class=3DSpellE>drbd</span>]<br>
&nbsp;[&lt;f12a98a8&gt;] drbd_worker+0x268/0x355 [<span =
class=3DSpellE>drbd</span>]<br>
&nbsp;[&lt;f12bb323&gt;] drbd_thread_setup+0x73/0xd0 [<span =
class=3DSpellE>drbd</span>]<br>
&nbsp;[&lt;c0102d7d&gt;] kernel_thread_helper+0x5/0x18<br>
Code: c3 8d 74 26 00 8d <span class=3DSpellE><span =
class=3DGramE>bc</span></span>
27 00 <span class=3DSpellE>00</span> <span class=3DSpellE>00</span> =
<span
class=3DSpellE>00</span> 55 b9 00 e0 ff <span class=3DSpellE>ff</span> =
89 e5 57 56
53 83 <span class=3DSpellE>ec</span> 20 8b 55 0c 21 e1 8b 41 18 8b 7d 14 =
8b 75 10
89 45 f0 &lt;8b&gt; 02 89 <span class=3DSpellE>fb</span> f6 c4 40 74 03 =
8b 52 0c
8b 42 04 40<br>
85 c0 7e 09 8b<br>
&nbsp;&lt;0&gt;<span class=3DGramE>Fatal</span> exception: panic in 5 =
seconds</span></font><font
size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'><o:p></o:p></span></font></p=
>

</div>

</body>

</html>

------_=_NextPart_001_01C71FA3.A95027FE--
