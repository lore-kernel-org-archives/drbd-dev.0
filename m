Return-Path: <Ernest.Montrose@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C7D2F9.59CCCE1A"
Date: Mon, 30 Jul 2007 18:31:19 -0400
Message-ID: <BD7042533C2F8943A6A4257A9E31C454F4799A@EXNA.corp.stratus.com>
From: "Montrose, Ernest" <Ernest.Montrose@stratus.com>
To: <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] DRBD8: Deadlock in PausedSyncS 
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C7D2F9.59CCCE1A
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_002_01C7D2F9.59CCCE1A"


------_=_NextPart_002_01C7D2F9.59CCCE1A
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi all,
We are seeing a problem where we deadlock if a pause sync request
happens while attaching.  Below is an explaination of what I think is
occurring:

Consider two nodes X primary and Y Secondary.
1. X becomes Secondary/Diskless
2. Y becomes Primary
3. X tries to Attach and sends its states/uuids to Y
4. While Y is in receive_state() doing a drbd_sync_handshake(), it
receives a Paused Sync request.
  This is where the trouble starts.
5. aftr_isp is changed from 0->1 on Y and after_state_ch() called.  This
triggers
  a drbd_send_state() from Y.=20
6.  X receives States from Y but no uuids and runs a
drbd_sync_handshake() with the old uuids and
    we deadlocked with PausedSyncS on both sides.

I am not sure how to best fix this.  Perhaps we should not call
drbd_send_state()=20
in after_state_ch() for a sync request from the peer if the peer's disk
is diskless. =20
Or we do send states, sends the uuids as well.  The attached patch will
at least serve as an illustration of the issue if not the correct fix.
=20
Thank you!
=20
EM--

------_=_NextPart_002_01C7D2F9.59CCCE1A
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
<link rel=3DFile-List href=3D"cid:filelist.xml@01C7D2D7.D271E670">
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
font-family:Arial'>We are seeing a problem where we deadlock if a pause =
sync
request happens while attaching. <span =
style=3D'mso-spacerun:yes'>&nbsp;</span>Below
is an <span class=3DSpellE>explaination</span> of what I think is =
occurring:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 color=3Dblack face=3DTahoma><span =
style=3D'font-size:
9.0pt;font-family:Tahoma;color:black'><br>
Consider two nodes X primary and Y Secondary.<br>
1. X becomes Secondary/Diskless<br>
2. Y becomes Primary<br>
3. X tries to Attach and sends its states/<span =
class=3DSpellE>uuids</span> to Y<br>
4. While Y is in <span class=3DSpellE>receive_<span =
class=3DGramE>state</span></span><span
class=3DGramE>(</span>) doing a <span =
class=3DSpellE>drbd_sync_handshake</span>(),
it receives a Paused Sync request.<br>
&nbsp; This is where the trouble starts.<br>
5. <span class=3DSpellE><span class=3DGramE>aftr_isp</span></span> is =
changed from
0-&gt;1 on Y and <span class=3DSpellE>after_state_ch</span>() =
called.&nbsp; <span
class=3DGramE>This triggers</span><br>
&nbsp; <span class=3DGramE>a</span> <span =
class=3DSpellE>drbd_send_state</span>()
from Y. <br>
6.&nbsp; X receives States from Y but no <span =
class=3DSpellE>uuids</span> and
runs a <span class=3DSpellE>drbd_sync_<span =
class=3DGramE>handshake</span></span><span
class=3DGramE>(</span>) with the old <span class=3DSpellE>uuids</span> =
and<br>
&nbsp; &nbsp; <span class=3DGramE>we</span> deadlocked with <span =
class=3DSpellE>PausedSyncS</span>
on both sides.<br>
<br>
I am not sure how to best fix this.&nbsp; Perhaps we should not call =
<span
class=3DSpellE>drbd_send_<span class=3DGramE>state</span></span><span =
class=3DGramE>(</span>)
<br>
in <span class=3DSpellE>after_state_ch</span>() for a sync request from =
the peer
if the peer's disk is diskless.&nbsp; <br>
Or we do send states, sends the <span class=3DSpellE>uuids</span> as =
well.<span
style=3D'mso-spacerun:yes'>&nbsp; </span>The attached patch will at =
least serve
as an illustration of the issue if not the correct =
fix.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 color=3Dblack face=3DTahoma><span =
style=3D'font-size:
9.0pt;font-family:Tahoma;color:black'><o:p>&nbsp;</o:p></span></font></p>=


<p class=3DMsoNormal><font size=3D1 color=3Dblack face=3DTahoma><span =
style=3D'font-size:
9.0pt;font-family:Tahoma;color:black'>Thank =
you!<o:p></o:p></span></font></p>

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

------_=_NextPart_002_01C7D2F9.59CCCE1A--

------_=_NextPart_001_01C7D2F9.59CCCE1A
Content-Type: application/octet-stream;
	name="pausedsync.patch"
Content-Transfer-Encoding: base64
Content-Description: pausedsync.patch
Content-Disposition: attachment;
	filename="pausedsync.patch"

SW5kZXg6IGRyYmQvZHJiZF9tYWluLmMKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQotLS0gZHJiZC9kcmJkX21haW4uYwko
cmV2aXNpb24gMTY4NTMpCisrKyBkcmJkL2RyYmRfbWFpbi5jCSh3b3JraW5nIGNvcHkpCkBAIC05
NTMsNyArOTUzLDggQEAKIAkvKiBXZSB3YW50IHRvIHBhdXNlL2NvbnRpbnVlIHJlc3luYywgdGVs
bCBwZWVyLiAqLwogCWlmICggbnMuY29ubiA+PSBDb25uZWN0ZWQgJiYgCiAJICAgICAoKCBvcy5h
ZnRyX2lzcCAhPSBucy5hZnRyX2lzcCApIHx8Ci0JICAgICAgKCBvcy51c2VyX2lzcCAhPSBucy51
c2VyX2lzcCApKSApIHsKKwkgICAgICAoIG9zLnVzZXJfaXNwICE9IG5zLnVzZXJfaXNwICkpICYm
CisgICAgICAgICAgICBtZGV2LT5zdGF0ZS5wZHNrICE9IERpc2tsZXNzICkgewogCQlkcmJkX3Nl
bmRfc3RhdGUobWRldik7CiAJfQogCg==

------_=_NextPart_001_01C7D2F9.59CCCE1A--
