Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C7B284.D6E54021"
Date: Tue, 19 Jun 2007 11:16:40 -0400
Message-ID: <342BAC0A5467384983B586A6B0B3767105BD4EEC@EXNA.corp.stratus.com>
From: "Graham, Simon" <Simon.Graham@stratus.com>
To: <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] Running Protocol C with disk cache enabled
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C7B284.D6E54021
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I've been thinking recently about making sure that DRBD handles failures
properly when the disks are run with their caches enabled - in most
cases, I believe that the existing activity log code in DRBD will
correctly handle this by ensuring that portions of the disk that _might_
have been in cache only when a failure occurred are resynchronized.

=20

However - there is one case that I don't think is covered currently;
it's entirely possible that I'm missing something, but I wanted to
check; the case in question is if the Secondary system suffers an
unexpected power loss, therebye potentially losing some writes that were
acknowledged prior to the failure. Now, I think that the activity log
maintained by the Primary actually includes the necessary information
about blocks which should be resynchronized _but_ I don't see any code
that would actually add these blocks to the bitmap when such a failure
occurs.

=20

Conversely, if the Primary suffers an unexpected power loss, when it
comes back up, it will add all the blocks described by its on-disk
activity log to the bitmap as part of the attach processing on that
node.

=20

Maybe this is overkill, but perhaps the Primary should add the contents
of the current AL to the in-memory and on-disk bitmaps whenever it loses
contact with the secondary unexpectedly?

=20

Simon


------_=_NextPart_001_01C7B284.D6E54021
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
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

<p class=3DMsoNormal>I&#8217;ve been thinking recently about making sure =
that
DRBD handles failures properly when the disks are run with their caches =
enabled
&#8211; in most cases, I believe that the existing activity log code in =
DRBD
will correctly handle this by ensuring that portions of the disk that =
_<i>might</i>_
have been in cache only when a failure occurred are =
resynchronized.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>However &#8211; there is one case that I =
don&#8217;t think
is covered currently; it&#8217;s entirely possible that I&#8217;m =
missing
something, but I wanted to check; the case in question is if the =
Secondary
system suffers an unexpected power loss, therebye potentially losing =
some
writes that were acknowledged prior to the failure. Now, I think that =
the
activity log maintained by the Primary actually includes the necessary
information about blocks which should be resynchronized _<i>but</i>_ I =
don&#8217;t
see any code that would actually add these blocks to the bitmap when =
such a
failure occurs.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Conversely, if the Primary suffers an unexpected =
power loss,
when it comes back up, it will add all the blocks described by its =
on-disk
activity log to the bitmap as part of the attach processing on that =
node.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Maybe this is overkill, but perhaps the Primary =
should add
the contents of the current AL to the in-memory and on-disk bitmaps =
whenever it
loses contact with the secondary unexpectedly?<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Simon<o:p></o:p></p>

</div>

</body>

</html>

------_=_NextPart_001_01C7B284.D6E54021--
