Return-Path: <Ernest.Montrose@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C8103F.5055C091"
Date: Tue, 16 Oct 2007 17:55:49 -0400
Message-ID: <BD7042533C2F8943A6A4257A9E31C454F47A11@EXNA.corp.stratus.com>
From: "Montrose, Ernest" <Ernest.Montrose@stratus.com>
To: <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] DRBD8: unconfigured devices and scheduling
	after_state_ch problem
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C8103F.5055C091
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_002_01C8103F.5055C091"


------_=_NextPart_002_01C8103F.5055C091
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi all,
We have been seeing a problem where "unconfigured" devices e.g devices
that are Standalone and Diskless with sequential sync order schedule
after_state_ch().  The problem is that there isn't a worker thread in
this case.  So we observed two side effects. One all these queued work
make shutting down the node take a long time as unloading the driver
takes time to clean up. Two we can potentially have a memory exhaustion
issue.=20
=20
Included here is a patch to help fix the problem.
=20
Thanks.
EM--

------_=_NextPart_002_01C8103F.5055C091
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
<link rel=3DFile-List href=3D"cid:filelist.xml@01C8101D.C93A5B40">
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
font-family:Arial'>We have been seeing a problem where &#8220;<span
class=3DSpellE>unconfigured</span>&#8221; devices <span =
class=3DSpellE>e.g</span>
devices that are Standalone and Diskless with sequential sync order =
schedule <span
class=3DSpellE>after_state_<span class=3DGramE>ch</span></span><span =
class=3DGramE>(</span>).<span
style=3D'mso-spacerun:yes'>&nbsp; </span>The problem is that there =
isn&#8217;t a
worker thread in this case.<span style=3D'mso-spacerun:yes'>&nbsp; =
</span>So we
observed two side effects. One all these queued <span =
class=3DGramE>work</span>
make shutting down the node take a long time as unloading the driver =
takes time
to clean up. Two we can potentially have a memory exhaustion issue. =
<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Included here is a patch to help fix the =
problem.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Thanks.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>EM--<o:p></o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_002_01C8103F.5055C091--

------_=_NextPart_001_01C8103F.5055C091
Content-Type: application/octet-stream;
	name="after_isp.patch"
Content-Transfer-Encoding: base64
Content-Description: after_isp.patch
Content-Disposition: attachment;
	filename="after_isp.patch"

SW5kZXg6IGRyYmQvZHJiZF93b3JrZXIuYwo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Ci0tLSBkcmJkL2RyYmRfd29ya2Vy
LmMJKHJldmlzaW9uIDE5MzgxKQorKysgZHJiZC9kcmJkX3dvcmtlci5jCSh3b3JraW5nIGNvcHkp
CkBAIC03OTcsNyArNzk3LDggQEAKIAlpbnQgaSwgcnYgPSAwOwogCiAJZm9yIChpPTA7IGkgPCBt
aW5vcl9jb3VudDsgaSsrKSB7Ci0JCWlmKCAhKG9kZXYgPSBtaW5vcl90b19tZGV2KGkpKSApIGNv
bnRpbnVlOworCQlpZiggIShvZGV2ID0gbWlub3JfdG9fbWRldihpKSkgfHwKKyAgICAgICAgICAg
ICAgICAgIChvZGV2LT5zdGF0ZS5jb25uID09IFN0YW5kQWxvbmUgJiYgb2Rldi0+c3RhdGUuZGlz
ayA9PSBEaXNrbGVzcykgKSBjb250aW51ZTsKIAkJaWYgKCEgX2RyYmRfbWF5X3N5bmNfbm93KG9k
ZXYpKSB7CiAJCQlydiB8PSAoIF9kcmJkX3NldF9zdGF0ZShfTlMob2RldixhZnRyX2lzcCwxKSwK
IAkJCQkJCUNoZ1N0YXRlSGFyZHxTY2hlZHVsZUFmdGVyKQo=

------_=_NextPart_001_01C8103F.5055C091--
