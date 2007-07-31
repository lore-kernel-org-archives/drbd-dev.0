Return-Path: <Ernest.Montrose@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C7D3B8.490767F6"
Date: Tue, 31 Jul 2007 17:18:05 -0400
Message-ID: <BD7042533C2F8943A6A4257A9E31C454F4799D@EXNA.corp.stratus.com>
From: "Montrose, Ernest" <Ernest.Montrose@stratus.com>
To: <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] DRBD8: ASSERT( mdev->bc->md.uuid[Bitmap] == 0 ) in
	drbd_main.c:drbd_uuid_new_current()
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C7D3B8.490767F6
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_002_01C7D3B8.490767F6"


------_=_NextPart_002_01C7D3B8.490767F6
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi all,
We are seeing another problem that occurs with the following sequence of
events:
drbdadm secondary vm2.root.fs
drbdadm detach vm2.root.fs
drbdadm primary vm2.root.fs
drbdadm secondary vm2.root.fs
drbdadm primary vm2.root.fs <----- This causes the assert
drbdadm attach vm2.root.fs  <------ This causes an instant Split brain
but only because of the assert above.
=20
I think what's happening is that we are generating a new bitmap UUID
every time the diskless peer goes Primary.
I see no reason why we have to do this more then once.  I include a tiny
patch to do it just one time.=20
=20
Thanks,
=20
EM--

------_=_NextPart_002_01C7D3B8.490767F6
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:st1=3D"urn:schemas-microsoft-com:office:smarttags" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DProgId content=3DWord.Document>
<meta name=3DGenerator content=3D"Microsoft Word 11">
<meta name=3DOriginator content=3D"Microsoft Word 11">
<link rel=3DFile-List href=3D"cid:filelist.xml@01C7D396.C16008C0">
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"City"/>
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
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;
	mso-font-charset:2;
	mso-generic-font-family:auto;
	mso-font-pitch:variable;
	mso-font-signature:0 268435456 0 0 -2147483648 0;}
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
font-family:Arial'>We are seeing another problem that occurs with the =
following
sequence of events:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><span class=3DSpellE><span class=3DGramE><font =
size=3D1
color=3Dblack face=3DTahoma><span =
style=3D'font-size:9.0pt;font-family:Tahoma;
color:black'>drbdadm</span></font></span></span><font size=3D1 =
color=3Dblack
face=3DTahoma><span =
style=3D'font-size:9.0pt;font-family:Tahoma;color:black'>
secondary vm2.root.fs<br>
<span class=3DSpellE><span class=3DGramE>drbdadm</span></span> detach =
vm2.root.fs<br>
<span class=3DSpellE><span class=3DGramE>drbdadm</span></span> primary =
vm2.root.fs<br>
<span class=3DSpellE><span class=3DGramE>drbdadm</span></span> secondary
vm2.root.fs<br>
<span class=3DSpellE><span class=3DGramE>drbdadm</span></span> primary =
vm2.root.fs </span></font><font
size=3D1 color=3Dblack face=3DWingdings><span =
style=3D'font-size:9.0pt;font-family:
Wingdings;mso-ascii-font-family:Tahoma;mso-hansi-font-family:Tahoma;mso-b=
idi-font-family:
Tahoma;color:black;mso-char-type:symbol;mso-symbol-font-family:Wingdings'=
><span
style=3D'mso-char-type:symbol;mso-symbol-font-family:Wingdings'>&szlig;</=
span></span></font><font
size=3D1 color=3Dblack face=3DTahoma><span =
style=3D'font-size:9.0pt;font-family:Tahoma;
color:black'>--- This causes the assert<br>
<span class=3DSpellE><span class=3DGramE>drbdadm</span></span> attach =
vm2.root.fs<span
style=3D'mso-spacerun:yes'>&nbsp; </span></span></font><font size=3D1 =
color=3Dblack
face=3DWingdings><span =
style=3D'font-size:9.0pt;font-family:Wingdings;mso-ascii-font-family:
Tahoma;mso-hansi-font-family:Tahoma;mso-bidi-font-family:Tahoma;color:bla=
ck;
mso-char-type:symbol;mso-symbol-font-family:Wingdings'><span =
style=3D'mso-char-type:
symbol;mso-symbol-font-family:Wingdings'>&szlig;</span></span></font><fon=
t
size=3D1 color=3Dblack face=3DTahoma><span =
style=3D'font-size:9.0pt;font-family:Tahoma;
color:black'>---- This causes an instant <st1:City =
w:st=3D"on"><st1:place w:st=3D"on">Split</st1:place></st1:City>
brain but only because of the assert above.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I think what&#8217;s happening is that we are =
generating a
new bitmap UUID every time the diskless peer goes =
Primary.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I see no reason why we have to do this more then =
once.<span
style=3D'mso-spacerun:yes'>&nbsp; </span>I include a tiny patch to do it =
just one
time. <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Thanks,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>EM--<o:p></o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_002_01C7D3B8.490767F6--

------_=_NextPart_001_01C7D3B8.490767F6
Content-Type: application/octet-stream;
	name="bitmapassert.patch"
Content-Transfer-Encoding: base64
Content-Description: bitmapassert.patch
Content-Disposition: attachment;
	filename="bitmapassert.patch"

SW5kZXg6IGRyYmQvZHJiZF9tYWluLmMKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQotLS0gZHJiZC9kcmJkX21haW4uYwko
cmV2aXNpb24gMTY4NTMpCisrKyBkcmJkL2RyYmRfbWFpbi5jCSh3b3JraW5nIGNvcHkpCkBAIC05
MzMsNyArOTMzLDggQEAKIAogCWlmKCBucy5wZHNrIDwgSW5jb25zaXN0ZW50ICkgewogCQkvKiBE
aXNrbGVzcyBQZWVyIGJlY29tZXMgcHJpbWFyeSAqLwotCQlpZiAob3MucGVlciA9PSBTZWNvbmRh
cnkgJiYgbnMucGVlciA9PSBQcmltYXJ5ICkgeworCQlpZiAob3MucGVlciA9PSBTZWNvbmRhcnkg
JiYgbnMucGVlciA9PSBQcmltYXJ5ICYmCisgICAgICAgICAgICAgICAgICBtZGV2LT5iYy0+bWQu
dXVpZFtCaXRtYXBdID09IDAgKSB7CiAJCQlkcmJkX3V1aWRfbmV3X2N1cnJlbnQobWRldik7CiAJ
CX0KIAkJLyogRGlza2xlc3MgUGVlciBiZWNvbWVzIHNlY29uZGFyeSAqLwo=

------_=_NextPart_001_01C7D3B8.490767F6--
