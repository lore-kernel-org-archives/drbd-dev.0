Return-Path: <Ernest.Montrose@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6F7B8.A19F36E6"
Date: Tue, 24 Oct 2006 18:06:18 -0400
Message-ID: <BD7042533C2F8943A6A4257A9E31C45439C811@EXNA.corp.stratus.com>
From: "Montrose, Ernest" <Ernest.Montrose@stratus.com>
To: <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] DRBD8: pri-lost-after-sb handler not kicking in on
	Split-brain or so it seems
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C6F7B8.A19F36E6
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi all,
I set my configuration to allow two primaries and have those parameters
set:
=20
allow-two-primaries;
after-sb-0pri discard-least-changes;
after-sb-2pri call-pri-lost-after-sb;
=20
I, of course, set a pri-lost-after-sb handler.    I then induced a split
brain (Ifdown hbiface; ifup hbiface).
I issue a drbdadm connect all on my primary.
=20
What happens is that:
*	one of the nodes is forced to be secondary. (T original state
was Primary/Primary before the split brain)
*	My handler I never called.
=20
A quick look at drbd_receiver.c:drbd_asb_recover_2p() reveals that my
handler would not be called because I successfully
Setup the node to secondary.  Is this by design?  I would like for the
handler to be called every time I attempt to recover from SB. Or at
least,
If in fact, the SB is "automatically solved" then my Sstate of
Primary/Primary should return.  Any thoughts?
=20
Thanks,
=20
EM--

------_=_NextPart_001_01C6F7B8.A19F36E6
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
<link rel=3DFile-List href=3D"cid:filelist.xml@01C6F797.1A5C5960">
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
	{mso-list-id:336007613;
	mso-list-type:hybrid;
	mso-list-template-ids:-682956804 46430132 67698691 67698693 67698689 =
67698691 67698693 67698689 67698691 67698693;}
@list l0:level1
	{mso-level-start-at:500;
	mso-level-number-format:bullet;
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
font-family:Arial'>I set my configuration to allow two primaries and =
have those
parameters set:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><span class=3DGramE><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>allow-two-primaries</span></=
font></span><font
size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>;<o:p></o:p></span></font></=
p>

<p class=3DMsoNormal><span class=3DGramE><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>after-sb-0pri</span></font><=
/span><font
size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'> =
discard-least-changes;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><span class=3DGramE><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>after-sb-2pri</span></font><=
/span><font
size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'> call-<span
class=3DSpellE>pri-lost-after-sb</span>;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I, of course, set a <span =
class=3DSpellE>pri-lost-after-sb</span>
handler. <span style=3D'mso-spacerun:yes'>&nbsp;</span><span
style=3D'mso-spacerun:yes'>&nbsp;</span><span
style=3D'mso-spacerun:yes'>&nbsp;</span>I then induced a split brain =
(<span
class=3DSpellE>Ifdown</span> <span class=3DSpellE>hbiface</span>; <span
class=3DSpellE>ifup</span> <span =
class=3DSpellE>hbiface</span>).<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I issue a <span class=3DSpellE>drbdadm</span> connect =
all on my
primary.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>What happens is that:<o:p></o:p></span></font></p>

<ul style=3D'margin-top:0in' type=3Ddisc>
 <li class=3DMsoNormal style=3D'mso-list:l0 level1 lfo1;tab-stops:list =
.5in'><span
     class=3DGramE><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
     font-family:Arial'>one</span></font></span><font size=3D2 =
face=3DArial><span
     style=3D'font-size:10.0pt;font-family:Arial'> of the nodes is =
forced to be secondary.
     (T original state was Primary/Primary before the split =
brain)<o:p></o:p></span></font></li>
 <li class=3DMsoNormal style=3D'mso-list:l0 level1 lfo1;tab-stops:list =
.5in'><font
     size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>My handler
     I never called.<o:p></o:p></span></font></li>
</ul>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>A quick look at =
drbd_receiver.c:drbd_asb_recover_<span
class=3DGramE>2p(</span>) reveals that my handler would not be called =
because I successfully<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Setup the node to secondary. <span
style=3D'mso-spacerun:yes'>&nbsp;</span>Is this by design? <span
style=3D'mso-spacerun:yes'>&nbsp;</span>I would like for the handler to =
be called
every time I attempt to recover from SB. Or at =
least,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>If in fact, the SB is &#8220;automatically =
solved&#8221;
then my <span class=3DSpellE>Sstate</span> of Primary/Primary should =
return. <span
style=3D'mso-spacerun:yes'>&nbsp;</span><span class=3DGramE>Any =
thoughts?</span><o:p></o:p></span></font></p>

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

------_=_NextPart_001_01C6F7B8.A19F36E6--
