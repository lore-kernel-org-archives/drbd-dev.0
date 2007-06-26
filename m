Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C7B798.29554479"
Date: Mon, 25 Jun 2007 22:17:34 -0400
Message-ID: <342BAC0A5467384983B586A6B0B3767105DEBD0D@EXNA.corp.stratus.com>
From: "Graham, Simon" <Simon.Graham@stratus.com>
To: <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] Patch to drbdsetup to flush output when monitoring events
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C7B798.29554479
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_002_01C7B798.29554479"


------_=_NextPart_002_01C7B798.29554479
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Currently, if you run 'drbdsetup events' with stdout set up to be a
pipe, the output is not seen immediately because stdout runs in buffered
mode; the attached patch flushes stdout after each event is printed.

=20

Simon


------_=_NextPart_002_01C7B798.29554479
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 12 (filtered medium)">
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.Section1
	{page:Section1;}
-->
</style>
<!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext=3D"edit">
  <o:idmap v:ext=3D"edit" data=3D"1" />
 </o:shapelayout></xml><![endif]-->
</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal>Currently, if you run &#8216;drbdsetup =
events&#8217; with
stdout set up to be a pipe, the output is not seen immediately because =
stdout
runs in buffered mode; the attached patch flushes stdout after each =
event is
printed.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Simon<o:p></o:p></p>

</div>

</body>

</html>

------_=_NextPart_002_01C7B798.29554479--

------_=_NextPart_001_01C7B798.29554479
Content-Type: application/octet-stream;
	name="drbdsetup-flush.patch"
Content-Transfer-Encoding: base64
Content-Description: drbdsetup-flush.patch
Content-Disposition: attachment;
	filename="drbdsetup-flush.patch"

SW5kZXg6IHNyYy91c2VyL2RyYmRzZXR1cC5jCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KLS0tIHNyYy91c2VyL2RyYmRz
ZXR1cC5jCShyZXZpc2lvbiAxNTYzNykKKysrIHNyYy91c2VyL2RyYmRzZXR1cC5jCShyZXZpc2lv
biAxNTYzOCkKQEAgLTEyMTQsNiArMTIxNCw4IEBACiAJCWJyZWFrOwogCX0KIAorCWZmbHVzaChz
dGRvdXQpOworCiAJcmV0dXJuIDE7CiB9CiAK

------_=_NextPart_001_01C7B798.29554479--
