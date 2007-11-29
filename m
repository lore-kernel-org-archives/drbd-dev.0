Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C83235.F08F16AE"
Date: Wed, 28 Nov 2007 22:14:21 -0500
Message-ID: <342BAC0A5467384983B586A6B0B3767107283694@EXNA.corp.stratus.com>
From: "Graham, Simon" <Simon.Graham@stratus.com>
To: <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] [PATCH] Supporting on-disk cache in DRBD, part 2
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C83235.F08F16AE
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_002_01C83235.F08F16AE"


------_=_NextPart_002_01C83235.F08F16AE
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Attached is a proposed patch (against 8.0.6) for the second part of the
work to support on-disk caches in DRBD - I took Phil's excellent advice
and used the existing transaction log - the change was simply to
maintain this for Protocol C as well as A and B, everything else was
already in place so that whenever we lose contact with the secondary,
the existing TL log is added to the bitmap (covering everything sent
since the last time a barrier was executed on the secondary).

=20

I was a tad concerned about the perf impact of this, so I ran some
simple non-scientific benchmarks to see - what I actually did was run 9
copies of bonnie (doing synchronous writes) against 9 different DRBD
devices that were spread between two physical disks per system and
averaged out the results for all the bonnie runs to get an idea of what
one copy can expect to achieve (possibly not the best calculation, but
it was the easiest to do). The results were actually encouraging -
98-100% of the throughput with no change in CPU usage (although I'm not
entirely convinced bonnie is really a good test).

=20

Simon


------_=_NextPart_002_01C83235.F08F16AE
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

<p class=3DMsoNormal>Attached is a proposed patch (against 8.0.6) for =
the second
part of the work to support on-disk caches in DRBD &#8211; I took =
Phil&#8217;s
excellent advice and used the existing transaction log &#8211; the =
change was
simply to maintain this for Protocol C as well as A and B, everything =
else was
already in place so that whenever we lose contact with the secondary, =
the
existing TL log is added to the bitmap (covering everything sent since =
the last
time a barrier was executed on the secondary).<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>I was a tad concerned about the perf impact of =
this, so I
ran some simple non-scientific benchmarks to see &#8211; what I actually =
did
was run 9 copies of bonnie (doing synchronous writes) against 9 =
different DRBD
devices that were spread between two physical disks per system and =
averaged out
the results for all the bonnie runs to get an idea of what one copy can =
expect
to achieve (possibly not the best calculation, but it was the easiest to =
do).
The results were actually encouraging &#8211; 98-100% of the throughput =
with no
change in CPU usage (although I&#8217;m not entirely convinced bonnie is =
really
a good test).<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Simon<o:p></o:p></p>

</div>

</body>

</html>

------_=_NextPart_002_01C83235.F08F16AE--

------_=_NextPart_001_01C83235.F08F16AE
Content-Type: application/octet-stream;
	name="drbd-tl.patch"
Content-Transfer-Encoding: base64
Content-Description: drbd-tl.patch
Content-Disposition: attachment;
	filename="drbd-tl.patch"

SW5kZXg6IGRyYmQtOC4wLjYvZHJiZC9kcmJkX21haW4uYwo9PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Ci0tLSBkcmJkLTgu
MC42L2RyYmQvZHJiZF9tYWluLmMJKHJldmlzaW9uIDIxMzM1KQorKysgZHJiZC04LjAuNi9kcmJk
L2RyYmRfbWFpbi5jCSh3b3JraW5nIGNvcHkpCkBAIC0yMjgsMTAgKzIyOCw3IEBACiAJYiA9IG1k
ZXYtPm9sZGVzdF9iYXJyaWVyOwogCW1kZXYtPm9sZGVzdF9iYXJyaWVyID0gYi0+bmV4dDsKIAot
CS8qIGluIHByb3RvY29sIEMgdGhpcyBsaXN0IHNob3VsZCBiZSBlbXB0eSwKLQkgKiB1bmxlc3Mg
dGhlcmUgaXMgbG9jYWwgaW8gcGVuZGluZy4KLQkgKiBpbiBwcm90b2NvbCBBIGFuZCBCLCB0aGlz
IHNob3VsZCBub3QgYmUgZW1wdHksIGV2ZW4gdGhvdWdoIHRoZQotCSAqIG1hc3Rlcl9iaW8ncyBj
b3VsZCBhbHJlYWR5IGJlZW4gY29tcGxldGVkLiAgKi8KKwkvKiBDbGVhbiB1cCBsaXN0IG9mIHJl
cXVlc3RzIHByb2Nlc3NlZCBkdXJpbmcgY3VycmVudCBlcG9jaCAqLwogCWxpc3RfZm9yX2VhY2hf
c2FmZShsZSwgdGxlLCAmYi0+cmVxdWVzdHMpIHsKIAkJciA9IGxpc3RfZW50cnkobGUsIHN0cnVj
dCBkcmJkX3JlcXVlc3QsdGxfcmVxdWVzdHMpOwogCQlfcmVxX21vZChyLCBiYXJyaWVyX2Fja2Vk
LCAwKTsKSW5kZXg6IGRyYmQtOC4wLjYvZHJiZC9kcmJkX3JlcS5jCj09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KLS0tIGRy
YmQtOC4wLjYvZHJiZC9kcmJkX3JlcS5jCShyZXZpc2lvbiAyMTMzNSkKKysrIGRyYmQtOC4wLjYv
ZHJiZC9kcmJkX3JlcS5jCSh3b3JraW5nIGNvcHkpCkBAIC02NjEsMTAgKzY2MSwxNCBAQAogCQly
ZXEtPnJxX3N0YXRlIHw9IFJRX05FVF9TSVM7CiAJY2FzZSBjb25mbGljdF9kaXNjYXJkZWRfYnlf
cGVlcjoKIAkJLyogaW50ZXJlc3N0aW5nbHksIHRoaXMgaXMgdGhlIHNhbWUgdGhpbmchICovCisJ
CXJlcS0+cnFfc3RhdGUgfD0gUlFfTkVUX0RPTkU7CisJCS8qIGZhbGwgdGhyb3VnaCAqLwogCWNh
c2Ugd3JpdGVfYWNrZWRfYnlfcGVlcjoKIAkJLyogYXNzZXJ0IHNvbWV0aGluZz8gKi8KIAkJLyog
cHJvdG9jb2wgQzsgc3VjY2Vzc2Z1bGx5IHdyaXR0ZW4gb24gcGVlciAqLwotCQlyZXEtPnJxX3N0
YXRlIHw9IFJRX05FVF9ET05FOworCQkvKiBOb3RoaW5nIHRvIGRvIGhlcmUgLSB1c2VkIHRvIHNl
dCBORVRfRE9ORSBidXQgbm8gbW9yZSAqLyAKKwkJLyogYXMgd2Ugd2FudCB0byBrZWVwIHRoZSB0
bCBpbiBwbGFjZSBmb3IgYWxsIHByb3RvY29scyAqLworCiAJCS8qIHJlc3QgaXMgdGhlIHNhbWUg
YXMgZm9yOiAqLwogCWNhc2UgcmVjdl9hY2tlZF9ieV9wZWVyOgogCQkvKiBwcm90b2NvbCBCOyBw
cmV0ZW5kcyB0byBiZSBzdWNlc3NmdWxseSB3cml0dGVuIG9uIHBlZXIuCkBAIC02ODgsOSArNjky
LDYgQEAKIAkJYnJlYWs7CiAKIAljYXNlIGJhcnJpZXJfYWNrZWQ6Ci0JCS8qIGNhbiBldmVuIGhh
cHBlbiBmb3IgcHJvdG9jb2wgQywKLQkJICogd2hlbiBsb2NhbCBpbyBpcyBzdGlsbCBwZW5kaW5n
LgotCQkgKiBpbiB3aGljaCBjYXNlIGl0IGRvZXMgbm90aGluZy4gKi8KIAkJaWYgKHJlcS0+cnFf
c3RhdGUgJiBSUV9ORVRfUEVORElORykgewogCQkJLyogYmFycmllciBjYW1lIGluIGJlZm9yZSBh
bGwgcmVxdWVzdHMgaGF2ZSBiZWVuIGFja2VkLgogCQkJICogdGhpcyBpcyBiYWQsIGJlY2F1c2Ug
aWYgdGhlIGNvbm5lY3Rpb24gaXMgbG9zdCBub3csCg==

------_=_NextPart_001_01C83235.F08F16AE--
