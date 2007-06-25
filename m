Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C7B757.27554ABC"
Date: Mon, 25 Jun 2007 14:32:14 -0400
Message-ID: <342BAC0A5467384983B586A6B0B3767105DEBC84@EXNA.corp.stratus.com>
From: "Graham, Simon" <Simon.Graham@stratus.com>
To: <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] [DRBD-8] Update to drbdsetup events -a command
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C7B757.27554ABC
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_002_01C7B757.27554ABC"


------_=_NextPart_002_01C7B757.27554ABC
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

The drbdsetup events command starts off by outputting the current state
of the selected device - however, when you use '-a' to have it monitor
all devices, it would be useful if it would output the current state of
all devices - this removes the need to poll for state before running the
command. Attached is a suggested patch - probably a little too gross
since I just looped for all possible minor numbers 0-255;  presumably we
should actually read the configured max from somewhere?

=20

Simon

=20

=20


------_=_NextPart_002_01C7B757.27554ABC
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

<p class=3DMsoNormal>The drbdsetup events command starts off by =
outputting the
current state of the selected device &#8211; however, when you use =
&#8216;-a&#8217;
to have it monitor all devices, it would be useful if it would output =
the
current state of all devices &#8211; this removes the need to poll for =
state
before running the command. Attached is a suggested patch &#8211; =
probably a little
too gross since I just looped for all possible minor numbers 0-255; =
&nbsp;presumably
we should actually read the configured max from =
somewhere?<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Simon<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

</div>

</body>

</html>

------_=_NextPart_002_01C7B757.27554ABC--

------_=_NextPart_001_01C7B757.27554ABC
Content-Type: application/octet-stream;
	name="drbd-setup-events.patch"
Content-Transfer-Encoding: base64
Content-Description: drbd-setup-events.patch
Content-Disposition: attachment;
	filename="drbd-setup-events.patch"

SW5kZXg6IHNyYy91c2VyL2RyYmRzZXR1cC5jCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KLS0tIHNyYy91c2VyL2RyYmRz
ZXR1cC5jCShyZXZpc2lvbiAxNTM2NCkKKysrIHNyYy91c2VyL2RyYmRzZXR1cC5jCSh3b3JraW5n
IGNvcHkpCkBAIC0xMTgzLDYgKzExODMsMTAgQEAKIAlkcmJkX3N0YXRlX3Qgc3RhdGU7CiAJY2hh
ciogc3RyOwogCisJLyogSWdub3JlIGVycm9yIHJlcGxpZXMgKi8KKwlpZiAocmVwbHktPnJldF9j
b2RlICE9IE5vRXJyb3IpCisJCXJldHVybiAxOworCiAJc3dpdGNoIChyZXBseS0+cGFja2V0X3R5
cGUpIHsKIAljYXNlIFBfZ2V0X3N0YXRlOgogCQlpZihjb25zdW1lX3RhZ19pbnQoVF9zdGF0ZV9p
LHJlcGx5LT50YWdfbGlzdCwoaW50Kikmc3RhdGUuaSkpIHsKQEAgLTEyNDksNyArMTI1Myw3IEBA
CiAJc3RydWN0IGRyYmRfdGFnX2xpc3QgKnRsOwogCXN0cnVjdCBvcHRpb24gKmxvOwogCXVuc2ln
bmVkIGludCBzZXE9MDsKLQlpbnQgc2tfbmwsYyxjb250PTEscnI7CisJaW50IHNrX25sLGMsY29u
dD0xLHJyLGksbGFzdDsKIAlpbnQgdW5maWx0ZXJlZD0wLCBhbGxfZGV2aWNlcz0wOwogCWludCB3
ZmNfdGltZW91dD0wLCBkZWdyX3dmY190aW1lb3V0PTAsdGltZW91dF9tczsKIAlzdHJ1Y3QgdGlt
ZXZhbCBiZWZvcmUsYWZ0ZXI7CkBAIC0xMzA4LDExICsxMzEyLDIyIEBACiAJdGltZW91dF9tcz0g
MTAwMCAqICggIHJyID8gZGVncl93ZmNfdGltZW91dCA6IHdmY190aW1lb3V0KSAtIDE7CiAKIAkv
LyBhc2sgZm9yIHRoZSBjdXJyZW50IHN0YXRlIGJlZm9yZSB3YWl0aW5nIGZvciBzdGF0ZSB1cGRh
dGVzLi4uCi0JdGwtPmRyYmRfcF9oZWFkZXItPnBhY2tldF90eXBlID0gUF9nZXRfc3RhdGU7Ci0J
dGwtPmRyYmRfcF9oZWFkZXItPmRyYmRfbWlub3IgPSBtaW5vcjsKLQl0bC0+ZHJiZF9wX2hlYWRl
ci0+ZmxhZ3MgPSAwOwotCXNlbmRfY24oc2tfbmwsdGwtPm5sX2hlYWRlciwoY2hhciopdGwtPnRh
Z19saXN0X2Nwb3MtKGNoYXIqKXRsLT5ubF9oZWFkZXIpOworCWlmIChhbGxfZGV2aWNlcykgewor
CQlpID0gMDsKKwkJbGFzdCA9IDI1NTsKKwl9CisJZWxzZSB7CisJCWkgPSBsYXN0ID0gbWlub3I7
CisJfQogCisJd2hpbGUgKGkgPD0gbGFzdCkgeworCQl0bC0+ZHJiZF9wX2hlYWRlci0+cGFja2V0
X3R5cGUgPSBQX2dldF9zdGF0ZTsKKwkJdGwtPmRyYmRfcF9oZWFkZXItPmRyYmRfbWlub3IgPSBp
OworCQl0bC0+ZHJiZF9wX2hlYWRlci0+ZmxhZ3MgPSAwOworCQlzZW5kX2NuKHNrX25sLHRsLT5u
bF9oZWFkZXIsKGNoYXIqKXRsLT50YWdfbGlzdF9jcG9zLShjaGFyKil0bC0+bmxfaGVhZGVyKTsK
KwkJaSsrOworCX0KKwogCWR0X3VubG9ja19kcmJkKGxvY2tfZmQpOwogCWxvY2tfZmQ9LTE7CiAK

------_=_NextPart_001_01C7B757.27554ABC--
