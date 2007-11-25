Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C82F8F.45A1DF92"
Date: Sun, 25 Nov 2007 13:16:15 -0500
Message-ID: <342BAC0A5467384983B586A6B0B37671072830A7@EXNA.corp.stratus.com>
From: "Graham, Simon" <Simon.Graham@stratus.com>
To: <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] [PATCH] Supporting barriers in DRBD, part 1
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C82F8F.45A1DF92
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_002_01C82F8F.45A1DF92"


------_=_NextPart_002_01C82F8F.45A1DF92
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

As part of the work to properly handle on-disk caches, I have enabled
barrier support in DRBD for requests from above - the attached proposed
patch includes the following changes (patch is against 8.0.6):

=20

1.       Stop rejecting barrier requests in drbd_make_request_common()
unless we know they are not supported (see point 1 in the 'things to do'
below though).

2.       Fixed a few places where the code assumed
BIO_RW_BARRIER/BIO_RW_SYNC were masks rather than bit numbers

3.       Added barriers to AL/MD writes, including detecting if the
underlying device does not implement barriers and backing off in that
case.

4.       Forced a meta data write when a disk is attached so that we
determine early on whether or not barriers are supported.

5.       Extended the tracing of BIO's to include internally generated
BIOs as well as the ones from above

6.       I reformatted about_to_complete_local_write() - not necessary
but I was trying to read the code...

=20

Things to do (potentially):

1.       RIght now, the code assumes that either both systems support
barriers or neither do - should probably detect the mixed case and if
either side does not support for any given device, reject barrier
requests from above - I'm already setting the flag in the mdev when the
disk is attached - we could pass this flag between the two systems and
set the barrier-not-supported flag as the union of the two systems'
values. Off hand, I can't see an easy place to add code to pass this
capability between the systems.

2.       Should complete bitmap writes be issued with a barrier? If so,
then should this be just the first or last or all bitmap I/Os? I think
the last but I'm not sure.

3.       I think we can remove the #ifdef BIO_RW_XXX - certainly they
are not present everywhere these macros are referenced...

=20

I've tested this on a system that does support barriers (2.6.18 based
with DRBD on top of LVM volumes) - it's a little hard for me to test in
a case that does not support barriers - clearly that needs to be tested
before this can be applied... I know that there are several flavours of
md device that do not support barriers (linear, raid0, multipath for
example), so that might be a somewhat easy way to setup a test - create
a suitable md device and run drbd on top of it

=20

/simgr


------_=_NextPart_002_01C82F8F.45A1DF92
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
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin-top:0in;
	margin-right:0in;
	margin-bottom:0in;
	margin-left:.5in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
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
 /* List Definitions */
 @list l0
	{mso-list-id:156968589;
	mso-list-type:hybrid;
	mso-list-template-ids:-1542660656 67698703 67698713 67698715 67698703 =
67698713 67698715 67698703 67698713 67698715;}
@list l0:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1
	{mso-list-id:1687291919;
	mso-list-type:hybrid;
	mso-list-template-ids:656823230 67698703 67698713 67698715 67698703 =
67698713 67698715 67698703 67698713 67698715;}
@list l1:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
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

<p class=3DMsoNormal>As part of the work to properly handle on-disk =
caches, I
have enabled barrier support in DRBD for requests from above &#8211; the
attached proposed patch includes the following changes (patch is against =
8.0.6):<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoListParagraph style=3D'text-indent:-.25in;mso-list:l1 =
level1 lfo1'><![if !supportLists]><span
style=3D'mso-list:Ignore'>1.<span style=3D'font:7.0pt "Times New =
Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><![endif]>Stop rejecting barrier requests in =
drbd_make_request_common()
unless we know they are not supported (see point 1 in the &#8216;things =
to do&#8217;
below though).<o:p></o:p></p>

<p class=3DMsoListParagraph style=3D'text-indent:-.25in;mso-list:l1 =
level1 lfo1'><![if !supportLists]><span
style=3D'mso-list:Ignore'>2.<span style=3D'font:7.0pt "Times New =
Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><![endif]>Fixed a few places where the code assumed
BIO_RW_BARRIER/BIO_RW_SYNC were masks rather than bit =
numbers<o:p></o:p></p>

<p class=3DMsoListParagraph style=3D'text-indent:-.25in;mso-list:l1 =
level1 lfo1'><![if !supportLists]><span
style=3D'mso-list:Ignore'>3.<span style=3D'font:7.0pt "Times New =
Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><![endif]>Added barriers to AL/MD writes, including =
detecting if
the underlying device does not implement barriers and backing off in =
that case.<o:p></o:p></p>

<p class=3DMsoListParagraph style=3D'text-indent:-.25in;mso-list:l1 =
level1 lfo1'><![if !supportLists]><span
style=3D'mso-list:Ignore'>4.<span style=3D'font:7.0pt "Times New =
Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><![endif]>Forced a meta data write when a disk is attached =
so
that we determine early on whether or not barriers are =
supported.<o:p></o:p></p>

<p class=3DMsoListParagraph style=3D'text-indent:-.25in;mso-list:l1 =
level1 lfo1'><![if !supportLists]><span
style=3D'mso-list:Ignore'>5.<span style=3D'font:7.0pt "Times New =
Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><![endif]>Extended the tracing of BIO&#8217;s to include =
internally
generated BIOs as well as the ones from above<o:p></o:p></p>

<p class=3DMsoListParagraph style=3D'text-indent:-.25in;mso-list:l1 =
level1 lfo1'><![if !supportLists]><span
style=3D'mso-list:Ignore'>6.<span style=3D'font:7.0pt "Times New =
Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><![endif]>I reformatted about_to_complete_local_write() =
&#8211;
not necessary but I was trying to read the code&#8230;<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Things to do (potentially):<o:p></o:p></p>

<p class=3DMsoListParagraph style=3D'text-indent:-.25in;mso-list:l0 =
level1 lfo2'><![if !supportLists]><span
style=3D'mso-list:Ignore'>1.<span style=3D'font:7.0pt "Times New =
Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><![endif]>RIght now, the code assumes that either both =
systems
support barriers or neither do &#8211; should probably detect the mixed =
case
and if either side does not support for any given device, reject barrier
requests from above &#8211; I&#8217;m already setting the flag in the =
mdev when
the disk is attached &#8211; we could pass this flag between the two =
systems and
set the barrier-not-supported flag as the union of the two =
systems&#8217;
values. Off hand, I can&#8217;t see an easy place to add code to pass =
this
capability between the systems.<o:p></o:p></p>

<p class=3DMsoListParagraph style=3D'text-indent:-.25in;mso-list:l0 =
level1 lfo2'><![if !supportLists]><span
style=3D'mso-list:Ignore'>2.<span style=3D'font:7.0pt "Times New =
Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><![endif]>Should complete bitmap writes be issued with a =
barrier?
If so, then should this be just the first or last or all bitmap I/Os? I =
think
the last but I&#8217;m not sure.<o:p></o:p></p>

<p class=3DMsoListParagraph style=3D'text-indent:-.25in;mso-list:l0 =
level1 lfo2'><![if !supportLists]><span
style=3D'mso-list:Ignore'>3.<span style=3D'font:7.0pt "Times New =
Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><![endif]>I think we can remove the #ifdef BIO_RW_XXX =
&#8211;
certainly they are not present everywhere these macros are =
referenced&#8230;<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>I&#8217;ve tested this on a system that does =
support
barriers (2.6.18 based with DRBD on top of LVM volumes) &#8211; =
it&#8217;s a
little hard for me to test in a case that does not support barriers =
&#8211;
clearly that needs to be tested before this can be applied&#8230; I know =
that
there are several flavours of md device that do not support barriers =
(linear,
raid0, multipath for example), so that might be a somewhat easy way to =
setup a
test &#8211; create a suitable md device and run drbd on top of =
it<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>/simgr<o:p></o:p></p>

</div>

</body>

</html>

------_=_NextPart_002_01C82F8F.45A1DF92--

------_=_NextPart_001_01C82F8F.45A1DF92
Content-Type: application/octet-stream;
	name="drbd-barrier.patch"
Content-Transfer-Encoding: base64
Content-Description: drbd-barrier.patch
Content-Disposition: attachment;
	filename="drbd-barrier.patch"

SW5kZXg6IGRyYmQtOC4wLjYvZHJiZC9kcmJkX3JlY2VpdmVyLmMKPT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQotLS0gZHJi
ZC04LjAuNi9kcmJkL2RyYmRfcmVjZWl2ZXIuYwkocmV2aXNpb24gMjEyMjkpCisrKyBkcmJkLTgu
MC42L2RyYmQvZHJiZF9yZWNlaXZlci5jCSh3b3JraW5nIGNvcHkpCkBAIC0xMDk0LDYgKzEwOTQs
OCBAQAogCSAgICAgICBJTkZPKCJzdWJtaXQgRUUgKFJTKVdSSVRFIHNlYz0lbGx1cyBzaXplPSV1
IGVlPSVwXG4iLAogCQkgICAgKHVuc2lnbmVkIGxvbmcgbG9uZyllLT5zZWN0b3IsZS0+c2l6ZSxl
KTsKIAkgICAgICAgKTsKKworCWR1bXBfaW50ZXJuYWxfYmlvKCJTZWMiLCBtZGV2LCBXUklURSwg
ZS0+cHJpdmF0ZV9iaW8sIDApOwogCWRyYmRfZ2VuZXJpY19tYWtlX3JlcXVlc3QobWRldixXUklU
RSxEUkJEX0ZBVUxUX1JTX1dSLGUtPnByaXZhdGVfYmlvKTsKIAkvKiBhY2NvdW50aW5nIGRvbmUg
aW4gZW5kaW8gKi8KIApAQCAtMTMxNiw2ICsxMzE4LDcgQEAKIAlzdHJ1Y3QgVGxfZXBvY2hfZW50
cnkgKmU7CiAJRHJiZF9EYXRhX1BhY2tldCAqcCA9IChEcmJkX0RhdGFfUGFja2V0KiloOwogCWlu
dCBoZWFkZXJfc2l6ZSwgZGF0YV9zaXplOworCWludCBydyA9IFdSSVRFOwogCXVuc2lnbmVkIGlu
dCBiYXJyaWVyX25yID0gMDsKIAl1bnNpZ25lZCBpbnQgZXBvY2hfc2l6ZSA9IDA7CiAJdTMyIGRw
X2ZsYWdzOwpAQCAtMTM1OSwxMCArMTM2MiwxMCBAQAogCiAJZHBfZmxhZ3MgPSBiZTMyX3RvX2Nw
dShwLT5kcF9mbGFncyk7CiAJaWYgKCBkcF9mbGFncyAmIERQX0hBUkRCQVJSSUVSICkgewotCQll
LT5wcml2YXRlX2Jpby0+YmlfcncgfD0gQklPX1JXX0JBUlJJRVI7CisJICAgIHJ3IHw9ICgxPDxC
SU9fUldfQkFSUklFUik7CiAJfQogCWlmICggZHBfZmxhZ3MgJiBEUF9SV19TWU5DICkgewotCQll
LT5wcml2YXRlX2Jpby0+YmlfcncgfD0gQklPX1JXX1NZTkM7CisJICAgIHJ3IHw9ICgxPDxCSU9f
UldfU1lOQyk7CiAJfQogCWlmICggZHBfZmxhZ3MgJiBEUF9NQVlfU0VUX0lOX1NZTkMgKSB7CiAJ
CWUtPmZsYWdzIHw9IEVFX01BWV9TRVRfSU5fU1lOQzsKQEAgLTE1NTAsNyArMTU1Myw3IEBACiAJ
CX0gZWxzZSB7CiAJCQllLT5iYXJyaWVyX25yID0gbWRldi0+bmV4dF9iYXJyaWVyX25yOwogCQl9
Ci0JCWUtPnByaXZhdGVfYmlvLT5iaV9ydyB8PSBCSU9fUldfQkFSUklFUjsKKwkJcncgfD0gKDE8
PEJJT19SV19CQVJSSUVSKTsKIAkJbWRldi0+bmV4dF9iYXJyaWVyX25yID0gMDsKIAl9CiAJbGlz
dF9hZGQoJmUtPncubGlzdCwmbWRldi0+YWN0aXZlX2VlKTsKQEAgLTE1OTIsNyArMTU5NSw4IEBA
CiAJCSAgICAodW5zaWduZWQgbG9uZyBsb25nKWUtPnNlY3RvcixlLT5zaXplLGUpOwogCSAgICAg
ICApOwogCS8qIEZJWE1FIGRyYmRfYWxfYmVnaW5faW8gaW4gY2FzZSB3ZSBoYXZlIHR3byBwcmlt
YXJpZXMuLi4gKi8KLQlkcmJkX2dlbmVyaWNfbWFrZV9yZXF1ZXN0KG1kZXYsV1JJVEUsRFJCRF9G
QVVMVF9EVF9XUixlLT5wcml2YXRlX2Jpbyk7CisJZHVtcF9pbnRlcm5hbF9iaW8oIlNlYyIsIG1k
ZXYsIHJ3LCBlLT5wcml2YXRlX2JpbywgMCk7CisJZHJiZF9nZW5lcmljX21ha2VfcmVxdWVzdCht
ZGV2LHJ3LERSQkRfRkFVTFRfRFRfV1IsZS0+cHJpdmF0ZV9iaW8pOwogCS8qIGFjY291bnRpbmcg
ZG9uZSBpbiBlbmRpbyAqLwogCiAJbWF5YmVfa2lja19sbyhtZGV2KTsKQEAgLTE2ODgsNiArMTY5
Miw3IEBACiAJCSAgICAodW5zaWduZWQgbG9uZyBsb25nKWUtPnNlY3RvcixlLT5zaXplLGUpOwog
CSAgICAgICApOwogCS8qIEZJWE1FIGFjdHVhbGx5LCBpdCBjb3VsZCBiZSBhIFJFQURBIG9yaWdp
bmF0aW5nIGZyb20gdGhlIHBlZXIgLi4uICovCisJZHVtcF9pbnRlcm5hbF9iaW8oIlNlYyIsbWRl
dixSRUFELGUtPnByaXZhdGVfYmlvLDApOwogCWRyYmRfZ2VuZXJpY19tYWtlX3JlcXVlc3QobWRl
dixSRUFELGZhdWx0X3R5cGUsZS0+cHJpdmF0ZV9iaW8pOwogCW1heWJlX2tpY2tfbG8obWRldik7
CiAKSW5kZXg6IGRyYmQtOC4wLjYvZHJiZC9kcmJkX25sLmMKPT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQotLS0gZHJiZC04
LjAuNi9kcmJkL2RyYmRfbmwuYwkocmV2aXNpb24gMjEyMjkpCisrKyBkcmJkLTguMC42L2RyYmQv
ZHJiZF9ubC5jCSh3b3JraW5nIGNvcHkpCkBAIC0xMDAzLDYgKzEwMDMsOSBAQAogCQlkZWNfbG9j
YWwobWRldik7CiAJfQogCisJLyogRm9yY2UgbWV0YSBkYXRhIHRvIGJlIHdyaXR0ZW4gdG8gZW5z
dXJlIHdlIGRldGVybWluZSBpZiBiYXJyaWVycyBhcmUgc3VwcG9ydGVkICovCisJZHJiZF9tZF9t
YXJrX2RpcnR5KG1kZXYpOworCiAJZHJiZF9tZF9zeW5jKG1kZXYpOwogCiAJcmVwbHktPnJldF9j
b2RlID0gcmV0Y29kZTsKSW5kZXg6IGRyYmQtOC4wLjYvZHJiZC9kcmJkX2FjdGxvZy5jCj09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT0KLS0tIGRyYmQtOC4wLjYvZHJiZC9kcmJkX2FjdGxvZy5jCShyZXZpc2lvbiAyMTIyOSkK
KysrIGRyYmQtOC4wLjYvZHJiZC9kcmJkX2FjdGxvZy5jCSh3b3JraW5nIGNvcHkpCkBAIC0zOSwz
MiArMzksNTcgQEAKIAkJCQkgc3RydWN0IHBhZ2UgKnBhZ2UsIHNlY3Rvcl90IHNlY3RvciwKIAkJ
CQkgaW50IHJ3LCBpbnQgc2l6ZSkKIHsKLQlzdHJ1Y3QgYmlvICpiaW8gPSBiaW9fYWxsb2MoR0ZQ
X05PSU8sIDEpOwotCXN0cnVjdCBjb21wbGV0aW9uIGV2ZW50OworCXN0cnVjdCBiaW8gKmJpbzsK
KwlzdHJ1Y3QgZHJiZF9tZF9pbyBtZF9pbzsKIAlpbnQgb2s7CiAKKwltZF9pby5tZGV2ID0gbWRl
djsKKwlpbml0X2NvbXBsZXRpb24oJm1kX2lvLmV2ZW50KTsKKwltZF9pby5lcnJvciA9IDA7CisK
KyNpZmRlZiBCSU9fUldfQkFSUklFUgorCWlmIChydyA9PSBXUklURSAmJiAhKG1kZXYtPmZsYWdz
ICYgTk9fQkFSUklFUl9TVVBQKSkKKwkgICAgcncgfD0gKDE8PEJJT19SV19CQVJSSUVSKTsKKyNl
bmRpZgorI2lmZGVmIEJJT19SV19TWU5DCisJcncgfD0gKDEgPDwgQklPX1JXX1NZTkMpOworI2Vu
ZGlmCisKKyByZXRyeToKKwliaW8gPSBiaW9fYWxsb2MoR0ZQX05PSU8sIDEpOwogCWJpby0+Ymlf
YmRldiA9IGJkZXYtPm1kX2JkZXY7CiAJYmlvLT5iaV9zZWN0b3IgPSBzZWN0b3I7CiAJb2sgPSAo
YmlvX2FkZF9wYWdlKGJpbywgcGFnZSwgc2l6ZSwgMCkgPT0gc2l6ZSk7CiAJaWYoIW9rKSBnb3Rv
IG91dDsKLQlpbml0X2NvbXBsZXRpb24oJmV2ZW50KTsKLQliaW8tPmJpX3ByaXZhdGUgPSAmZXZl
bnQ7CisJYmlvLT5iaV9wcml2YXRlID0gJm1kX2lvOwogCWJpby0+YmlfZW5kX2lvID0gZHJiZF9t
ZF9pb19jb21wbGV0ZTsKIAorCWR1bXBfaW50ZXJuYWxfYmlvKCJNZCIsbWRldixydyxiaW8sMCk7
CisKIAlpZiAoRkFVTFRfQUNUSVZFKG1kZXYsIChydyAmIFdSSVRFKT8gRFJCRF9GQVVMVF9NRF9X
UjpEUkJEX0ZBVUxUX01EX1JEKSkgewogCQliaW8tPmJpX3J3IHw9IHJ3OwogCQliaW9fZW5kaW8o
YmlvLGJpby0+Ymlfc2l6ZSwtRUlPKTsKIAl9CiAJZWxzZSB7Ci0jaWZkZWYgQklPX1JXX1NZTkMK
LQkJc3VibWl0X2JpbyhydyB8ICgxIDw8IEJJT19SV19TWU5DKSwgYmlvKTsKLSNlbHNlCiAJCXN1
Ym1pdF9iaW8ocncsIGJpbyk7CisjaWZuZGVmIEJJT19SV19TWU5DCiAJCWRyYmRfYmxrX3J1bl9x
dWV1ZShiZGV2X2dldF9xdWV1ZShiZGV2LT5tZF9iZGV2KSk7CiAjZW5kaWYKIAl9Ci0Jd2FpdF9m
b3JfY29tcGxldGlvbigmZXZlbnQpOworCXdhaXRfZm9yX2NvbXBsZXRpb24oJm1kX2lvLmV2ZW50
KTsKIAlvayA9IHRlc3RfYml0KEJJT19VUFRPREFURSwgJmJpby0+YmlfZmxhZ3MpOworCisjaWZk
ZWYgQklPX1JXX0JBUlJJRVIKKwkvKiBjaGVjayBmb3IgdW5zdXBwb3J0ZWQgYmFycmllciBvcCAq
LworCWlmICh1bmxpa2VseShtZF9pby5lcnJvciA9PSAtRU9QTk9UU1VQUCAmJiAocncgJiBCSU9f
UldfQkFSUklFUikpKSB7CisJCS8qIFRyeSBhZ2FpbiB3aXRoIG5vIGJhcnJpZXIgKi8KKwkJV0FS
TigiQmFycmllcnMgbm90IHN1cHBvcnRlZCAtIGRpc2FibGluZyIpOworCQltZGV2LT5mbGFncyB8
PSBOT19CQVJSSUVSX1NVUFA7CisJCXJ3ICY9IH5CSU9fUldfQkFSUklFUjsKKwkJYmlvX3B1dChi
aW8pOworCQlnb3RvIHJldHJ5OworCX0KKyNlbmRpZgogIG91dDoKIAliaW9fcHV0KGJpbyk7CiAJ
cmV0dXJuIG9rOwpJbmRleDogZHJiZC04LjAuNi9kcmJkL2RyYmRfd29ya2VyLmMKPT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PQotLS0gZHJiZC04LjAuNi9kcmJkL2RyYmRfd29ya2VyLmMJKHJldmlzaW9uIDIxMjI5KQorKysg
ZHJiZC04LjAuNi9kcmJkL2RyYmRfd29ya2VyLmMJKHdvcmtpbmcgY29weSkKQEAgLTY0LDExICs2
NCwxNyBAQAogICovCiBpbnQgZHJiZF9tZF9pb19jb21wbGV0ZShzdHJ1Y3QgYmlvICpiaW8sIHVu
c2lnbmVkIGludCBieXRlc19kb25lLCBpbnQgZXJyb3IpCiB7CisJc3RydWN0IGRyYmRfbWRfaW8g
Km1kX2lvOworCiAJaWYgKGJpby0+Ymlfc2l6ZSkgcmV0dXJuIDE7Ci0JLyogZXJyb3IgcGFyYW1l
dGVyIGlnbm9yZWQ6Ci0JICogZHJiZF9tZF9zeW5jX3BhZ2VfaW8gZXhwbGljaXRseSB0ZXN0cyBi
aW9fdXB0b2RhdGUoYmlvKTsgKi8KIAotCWNvbXBsZXRlKChzdHJ1Y3QgY29tcGxldGlvbiopYmlv
LT5iaV9wcml2YXRlKTsKKwltZF9pbyA9IChzdHJ1Y3QgZHJiZF9tZF9pbyAqKWJpby0+YmlfcHJp
dmF0ZTsKKworCW1kX2lvLT5lcnJvciA9IGVycm9yOworCisJZHVtcF9pbnRlcm5hbF9iaW8oIk1k
IiwgbWRfaW8tPm1kZXYsIDAsIGJpbywgMSk7CisKKwljb21wbGV0ZSgmbWRfaW8tPmV2ZW50KTsK
IAlyZXR1cm4gMDsKIH0KIApAQCAtOTksNiArMTA1LDggQEAKIAogCURfQVNTRVJUKGUtPmJsb2Nr
X2lkICE9IElEX1ZBQ0FOVCk7CiAKKwlkdW1wX2ludGVybmFsX2JpbygiU2VjIiwgbWRldiwgMCwg
YmlvLCAxKTsKKwogCXNwaW5fbG9ja19pcnFzYXZlKCZtZGV2LT5yZXFfbG9jayxmbGFncyk7CiAJ
bWRldi0+cmVhZF9jbnQgKz0gZS0+c2l6ZSA+PiA5OwogCWxpc3RfZGVsKCZlLT53Lmxpc3QpOwpA
QCAtMTQ1LDYgKzE1Myw4IEBACiAKIAlEX0FTU0VSVChlLT5ibG9ja19pZCAhPSBJRF9WQUNBTlQp
OwogCisJZHVtcF9pbnRlcm5hbF9iaW8oIlNlYyIsIG1kZXYsIDAsIGJpbywgMSk7CisKIAlzcGlu
X2xvY2tfaXJxc2F2ZSgmbWRldi0+cmVxX2xvY2ssZmxhZ3MpOwogCW1kZXYtPndyaXRfY250ICs9
IGUtPnNpemUgPj4gOTsKIAlpc19zeW5jZXJfcmVxID0gaXNfc3luY2VyX2Jsb2NrX2lkKGUtPmJs
b2NrX2lkKTsKQEAgLTIxMCw2ICsyMjAsOCBAQAogCQllcnJvciA9IC1FSU87CiAJfQogCisJZHVt
cF9pbnRlcm5hbF9iaW8oIlByaSIsIG1kZXYsIDAsIGJpbywgMSk7CisKIAkvKiB0byBhdm9pZCBy
ZWN1cnNpb24gaW4gX3JlcV9tb2QgKi8KIAl3aGF0ID0gZXJyb3IKIAkgICAgICAgPyAoYmlvX2Rh
dGFfZGlyKGJpbykgPT0gV1JJVEUpCkluZGV4OiBkcmJkLTguMC42L2RyYmQvZHJiZF9tYWluLmMK
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PQotLS0gZHJiZC04LjAuNi9kcmJkL2RyYmRfbWFpbi5jCShyZXZpc2lvbiAyMTIy
OSkKKysrIGRyYmQtOC4wLjYvZHJiZC9kcmJkX21haW4uYwkod29ya2luZyBjb3B5KQpAQCAtMTcx
MCwxNCArMTcxMCwxOCBAQAogCXAuc2VxX251bSAgPSBjcHVfdG9fYmUzMiggcmVxLT5zZXFfbnVt
ID0KIAkJCQkgIGF0b21pY19hZGRfcmV0dXJuKDEsJm1kZXYtPnBhY2tldF9zZXEpICk7CiAJZHBf
ZmxhZ3MgPSAwOwotCWlmKHJlcS0+bWFzdGVyX2Jpby0+YmlfcncgJiBCSU9fUldfQkFSUklFUikg
eworCisJLyogTk9URTogbm8gbmVlZCB0byBjaGVjayBpZiBiYXJyaWVycyBzdXBwb3J0ZWQgaGVy
ZSBhcyB3ZSB3b3VsZAorCSAqICAgICAgIG5vdCBwYXNzIHRoZSB0ZXN0IGluIG1ha2VfcmVxdWVz
dF9jb21tb24gaW4gdGhhdCBjYXNlCisJICovCisJaWYgKGJpb19iYXJyaWVyKHJlcS0+bWFzdGVy
X2JpbykpIHsKIAkJZHBfZmxhZ3MgfD0gRFBfSEFSREJBUlJJRVI7CiAJfQotCWlmKHJlcS0+bWFz
dGVyX2Jpby0+YmlfcncgJiBCSU9fUldfU1lOQykgeworCWlmIChiaW9fc3luYyhyZXEtPm1hc3Rl
cl9iaW8pKSB7CiAJCWRwX2ZsYWdzIHw9IERQX1JXX1NZTkM7CiAJfQotCWlmKG1kZXYtPnN0YXRl
LmNvbm4gPj0gU3luY1NvdXJjZSAmJgotCSAgIG1kZXYtPnN0YXRlLmNvbm4gPD0gUGF1c2VkU3lu
Y1QpIHsKKwlpZiAobWRldi0+c3RhdGUuY29ubiA+PSBTeW5jU291cmNlICYmCisJICAgIG1kZXYt
PnN0YXRlLmNvbm4gPD0gUGF1c2VkU3luY1QpIHsKIAkJZHBfZmxhZ3MgfD0gRFBfTUFZX1NFVF9J
Tl9TWU5DOwogCX0KIApAQCAtMzIyOSw3ICszMjMzLDcgQEAKIAogLy8gRGVidWcgcm91dGluZSB0
byBkdW1wIGluZm8gYWJvdXQgYmlvCiAKLXZvaWQgX2R1bXBfYmlvKGRyYmRfZGV2ICptZGV2LCBz
dHJ1Y3QgYmlvICpiaW8sIGludCBjb21wbGV0ZSkKK3ZvaWQgX2R1bXBfYmlvKGNvbnN0IGNoYXIg
KnBmeCwgZHJiZF9kZXYgKm1kZXYsIGludCBydywgc3RydWN0IGJpbyAqYmlvLCBpbnQgY29tcGxl
dGUpCiB7CiAjaWZkZWYgQ09ORklHX0xCRAogI2RlZmluZSBTRUNUT1JfRk9STUFUICIlTHgiCkBA
IC0zMjQyLDE2ICszMjQ2LDI3IEBACiAJY2hhciAqZmFkZHIgPSAoY2hhciAqKShsb3dhZGRyKTsK
IAlzdHJ1Y3QgYmlvX3ZlYyAqYnZlYzsKIAlpbnQgc2Vnbm87CisJaW50IGJpb3J3LCBiaW9iYXJy
aWVyLCBiaW9zeW5jOwogCi0JSU5GTygiJXMgJXMgQmlvOiVwIC0gJXNvZmZzZXQgIiBTRUNUT1Jf
Rk9STUFUICIsIHNpemUgJXhcbiIsCisJcncgfD0gYmlvLT5iaV9ydzsKKworCWJpb3J3ICAgICAg
PSAocncgJiAoUldfTUFTS3xSV0FfTUFTSykpOworCWJpb2JhcnJpZXIgPSAocncgJiAoMTw8QklP
X1JXX0JBUlJJRVIpKTsKKwliaW9zeW5jICAgID0gKHJ3ICYgKDE8PEJJT19SV19TWU5DKSk7CisK
KwlJTkZPKCIlcyAlczolcyVzJXMgQmlvOiVwIC0gJXNvZmZzZXQgIiBTRUNUT1JfRk9STUFUICIs
IHNpemUgJXhcbiIsCiAJICAgICBjb21wbGV0ZT8gIjw8PCI6Ij4+PiIsCi0JICAgICBiaW9fcnco
YmlvKT09V1JJVEU/IldyaXRlIjoiUmVhZCIsYmlvLAorCSAgICAgcGZ4LAorCSAgICAgYmlvcnc9
PVdSSVRFPyJXcml0ZSI6IlJlYWQiLAorCSAgICAgYmlvYmFycmllcj8iOkIiOiIiLAorCSAgICAg
Ymlvc3luYz8iOlMiOiIiLAorCSAgICAgYmlvLAogCSAgICAgY29tcGxldGU/IChkcmJkX2Jpb191
cHRvZGF0ZShiaW8pPyAiU3VjY2VzcywgIjoiRmFpbGVkLCAiKSA6ICIiLAogCSAgICAgYmlvLT5i
aV9zZWN0b3IgPDwgU0VDVE9SX1NISUZULAogCSAgICAgYmlvLT5iaV9zaXplKTsKIAogCWlmICh0
cmFjZV9sZXZlbCA+PSBUcmFjZUx2bE1ldHJpY3MgJiYKLQkgICAgKChiaW9fcncoYmlvKSA9PSBX
UklURSkgXiBjb21wbGV0ZSkgKSB7CisJICAgICgoYmlvcncgPT0gV1JJVEUpIF4gY29tcGxldGUp
ICkgewogCQlwcmludGsoS0VSTl9ERUJVRyAiICBpbmQgICAgIHBhZ2UgICBvZmZzZXQgICBsZW5n
dGhcbiIpOwogCQlfX2Jpb19mb3JfZWFjaF9zZWdtZW50KGJ2ZWMsIGJpbywgc2Vnbm8sIDApIHsK
IAkJCXByaW50ayhLRVJOX0RFQlVHICIgIFslZF0gJXAgJTguOHggJTguOHhcbiIsc2Vnbm8sCklu
ZGV4OiBkcmJkLTguMC42L2RyYmQvZHJiZF9yZXEuYwo9PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Ci0tLSBkcmJkLTguMC42
L2RyYmQvZHJiZF9yZXEuYwkocmV2aXNpb24gMjEyMjkpCisrKyBkcmJkLTguMC42L2RyYmQvZHJi
ZF9yZXEuYwkod29ya2luZyBjb3B5KQpAQCAtMTg1LDU4ICsxODUsNTggQEAKIHN0YXRpYyB2b2lk
IF9hYm91dF90b19jb21wbGV0ZV9sb2NhbF93cml0ZShkcmJkX2RldiAqbWRldiwgZHJiZF9yZXF1
ZXN0X3QgKnJlcSkKIHsKIAljb25zdCB1bnNpZ25lZCBsb25nIHMgPSByZXEtPnJxX3N0YXRlOwot
CQkJZHJiZF9yZXF1ZXN0X3QgKmk7Ci0JCQlzdHJ1Y3QgVGxfZXBvY2hfZW50cnkgKmU7Ci0JCQlz
dHJ1Y3QgaGxpc3Rfbm9kZSAqbjsKLQkJCXN0cnVjdCBobGlzdF9oZWFkICpzbG90OworCWRyYmRf
cmVxdWVzdF90ICppOworCXN0cnVjdCBUbF9lcG9jaF9lbnRyeSAqZTsKKwlzdHJ1Y3QgaGxpc3Rf
bm9kZSAqbjsKKwlzdHJ1Y3QgaGxpc3RfaGVhZCAqc2xvdDsKIAotCQkJLyogYmVmb3JlIHdlIGNh
biBzaWduYWwgY29tcGxldGlvbiB0byB0aGUgdXBwZXIgbGF5ZXJzLAotCQkJICogd2UgbWF5IG5l
ZWQgdG8gY2xvc2UgdGhlIGN1cnJlbnQgZXBvY2ggKi8KLQkJCWlmIChyZXEtPmVwb2NoID09IG1k
ZXYtPm5ld2VzdF9iYXJyaWVyLT5icl9udW1iZXIpCi0JCQkJc2V0X2JpdChJU1NVRV9CQVJSSUVS
LCZtZGV2LT5mbGFncyk7CisJLyogYmVmb3JlIHdlIGNhbiBzaWduYWwgY29tcGxldGlvbiB0byB0
aGUgdXBwZXIgbGF5ZXJzLAorCSAqIHdlIG1heSBuZWVkIHRvIGNsb3NlIHRoZSBjdXJyZW50IGVw
b2NoICovCisJaWYgKHJlcS0+ZXBvY2ggPT0gbWRldi0+bmV3ZXN0X2JhcnJpZXItPmJyX251bWJl
cikKKwkJc2V0X2JpdChJU1NVRV9CQVJSSUVSLCZtZGV2LT5mbGFncyk7CiAKLQkJCS8qIHdlIG5l
ZWQgdG8gZG8gdGhlIGNvbmZsaWN0IGRldGVjdGlvbiBzdHVmZiwKLQkJCSAqIGlmIHdlIGhhdmUg
dGhlIGVlX2hhc2ggKHR3b19wcmltYXJpZXMpIGFuZAotCQkJICogdGhpcyBoYXMgYmVlbiBvbiB0
aGUgbmV0d29yayAqLwotCQkJaWYgKChzICYgUlFfTkVUX0RPTkUpICYmIG1kZXYtPmVlX2hhc2gg
IT0gTlVMTCkgewotCQkJCWNvbnN0IHNlY3Rvcl90IHNlY3RvciA9IHJlcS0+c2VjdG9yOwotCQkJ
CWNvbnN0IGludCBzaXplID0gcmVxLT5zaXplOworCS8qIHdlIG5lZWQgdG8gZG8gdGhlIGNvbmZs
aWN0IGRldGVjdGlvbiBzdHVmZiwKKwkgKiBpZiB3ZSBoYXZlIHRoZSBlZV9oYXNoICh0d29fcHJp
bWFyaWVzKSBhbmQKKwkgKiB0aGlzIGhhcyBiZWVuIG9uIHRoZSBuZXR3b3JrICovCisJaWYgKChz
ICYgUlFfTkVUX0RPTkUpICYmIG1kZXYtPmVlX2hhc2ggIT0gTlVMTCkgeworCQljb25zdCBzZWN0
b3JfdCBzZWN0b3IgPSByZXEtPnNlY3RvcjsKKwkJY29uc3QgaW50IHNpemUgPSByZXEtPnNpemU7
CiAKLQkJCQkvKiBBU1NFUlQ6Ci0JCQkJICogdGhlcmUgbXVzdCBiZSBubyBjb25mbGljdGluZyBy
ZXF1ZXN0cywgc2luY2UKLQkJCQkgKiB0aGV5IG11c3QgaGF2ZSBiZWVuIGZhaWxlZCBvbiB0aGUg
c3BvdCAqLworCQkvKiBBU1NFUlQ6CisJCSAqIHRoZXJlIG11c3QgYmUgbm8gY29uZmxpY3Rpbmcg
cmVxdWVzdHMsIHNpbmNlCisJCSAqIHRoZXkgbXVzdCBoYXZlIGJlZW4gZmFpbGVkIG9uIHRoZSBz
cG90ICovCiAjZGVmaW5lIE9WRVJMQVBTIG92ZXJsYXBzKHNlY3Rvciwgc2l6ZSwgaS0+c2VjdG9y
LCBpLT5zaXplKQotCQkJCXNsb3QgPSB0bF9oYXNoX3Nsb3QobWRldixzZWN0b3IpOwotCQkJCWhs
aXN0X2Zvcl9lYWNoX2VudHJ5KGksIG4sIHNsb3QsIGNvbGlzaW9uKSB7Ci0JCQkJCWlmIChPVkVS
TEFQUykgewotCQkJCQkJQUxFUlQoIkxPR0lDIEJVRzogY29tcGxldGVkOiAlcCAlbGx1cyArJXU7
IG90aGVyOiAlcCAlbGx1cyArJXVcbiIsCi0JCQkJCQkgICAgICByZXEsICh1bnNpZ25lZCBsb25n
IGxvbmcpc2VjdG9yLCBzaXplLAotCQkJCQkJICAgICAgaSwgICAodW5zaWduZWQgbG9uZyBsb25n
KWktPnNlY3RvciwgaS0+c2l6ZSk7Ci0JCQkJCX0KLQkJCQl9CisJCXNsb3QgPSB0bF9oYXNoX3Ns
b3QobWRldixzZWN0b3IpOworCQlobGlzdF9mb3JfZWFjaF9lbnRyeShpLCBuLCBzbG90LCBjb2xp
c2lvbikgeworCQkJaWYgKE9WRVJMQVBTKSB7CisJCQkJQUxFUlQoIkxPR0lDIEJVRzogY29tcGxl
dGVkOiAlcCAlbGx1cyArJXU7IG90aGVyOiAlcCAlbGx1cyArJXVcbiIsCisJCQkJICAgICAgcmVx
LCAodW5zaWduZWQgbG9uZyBsb25nKXNlY3Rvciwgc2l6ZSwKKwkJCQkgICAgICBpLCAgICh1bnNp
Z25lZCBsb25nIGxvbmcpaS0+c2VjdG9yLCBpLT5zaXplKTsKKwkJCX0KKwkJfQogCi0JCQkJLyog
bWF5YmUgIndha2UiIHRob3NlIGNvbmZsaWN0aW5nIGVwb2NoIGVudHJpZXMKLQkJCQkgKiB0aGF0
IHdhaXQgZm9yIHRoaXMgcmVxdWVzdCB0byBmaW5pc2guCi0JCQkJICoKLQkJCQkgKiBjdXJyZW50
bHksIHRoZXJlIGNhbiBiZSBvbmx5IF9vbmVfIHN1Y2ggZWUKLQkJCQkgKiAod2VsbCwgb3Igc29t
ZSBtb3JlLCB3aGljaCB3b3VsZCBiZSBwZW5kaW5nCi0JCQkJICogRGlzY2FyZEFjayBub3QgeWV0
IHNlbnQgYnkgdGhlIGFzZW5kZXIuLi4pLAotCQkJCSAqIHNpbmNlIHdlIGJsb2NrIHRoZSByZWNl
aXZlciB0aHJlYWQgdXBvbiB0aGUKLQkJCQkgKiBmaXJzdCBjb25mbGljdCBkZXRlY3Rpb24sIHdo
aWNoIHdpbGwgd2FpdCBvbgotCQkJCSAqIG1pc2Nfd2FpdC4gIG1heWJlIHdlIHdhbnQgdG8gYXNz
ZXJ0IHRoYXQ/Ci0JCQkJICoKLQkJCQkgKiBhbnl3YXlzLCBpZiB3ZSBmb3VuZCBvbmUsCi0JCQkJ
ICogd2UganVzdCBoYXZlIHRvIGRvIGEgd2FrZV91cC4gICovCisJCS8qIG1heWJlICJ3YWtlIiB0
aG9zZSBjb25mbGljdGluZyBlcG9jaCBlbnRyaWVzCisJCSAqIHRoYXQgd2FpdCBmb3IgdGhpcyBy
ZXF1ZXN0IHRvIGZpbmlzaC4KKwkJICoKKwkJICogY3VycmVudGx5LCB0aGVyZSBjYW4gYmUgb25s
eSBfb25lXyBzdWNoIGVlCisJCSAqICh3ZWxsLCBvciBzb21lIG1vcmUsIHdoaWNoIHdvdWxkIGJl
IHBlbmRpbmcKKwkJICogRGlzY2FyZEFjayBub3QgeWV0IHNlbnQgYnkgdGhlIGFzZW5kZXIuLi4p
LAorCQkgKiBzaW5jZSB3ZSBibG9jayB0aGUgcmVjZWl2ZXIgdGhyZWFkIHVwb24gdGhlCisJCSAq
IGZpcnN0IGNvbmZsaWN0IGRldGVjdGlvbiwgd2hpY2ggd2lsbCB3YWl0IG9uCisJCSAqIG1pc2Nf
d2FpdC4gIG1heWJlIHdlIHdhbnQgdG8gYXNzZXJ0IHRoYXQ/CisJCSAqCisJCSAqIGFueXdheXMs
IGlmIHdlIGZvdW5kIG9uZSwKKwkJICogd2UganVzdCBoYXZlIHRvIGRvIGEgd2FrZV91cC4gICov
CiAjdW5kZWYgT1ZFUkxBUFMKICNkZWZpbmUgT1ZFUkxBUFMgb3ZlcmxhcHMoc2VjdG9yLCBzaXpl
LCBlLT5zZWN0b3IsIGUtPnNpemUpCi0JCQkJc2xvdCA9IGVlX2hhc2hfc2xvdChtZGV2LHJlcS0+
c2VjdG9yKTsKLQkJCQlobGlzdF9mb3JfZWFjaF9lbnRyeShlLCBuLCBzbG90LCBjb2xpc2lvbikg
ewotCQkJCQlpZiAoT1ZFUkxBUFMpIHsKLQkJCQkJCXdha2VfdXAoJm1kZXYtPm1pc2Nfd2FpdCk7
Ci0JCQkJCQlicmVhazsKLQkJCQkJfQotCQkJCX0KKwkJc2xvdCA9IGVlX2hhc2hfc2xvdChtZGV2
LHJlcS0+c2VjdG9yKTsKKwkJaGxpc3RfZm9yX2VhY2hfZW50cnkoZSwgbiwgc2xvdCwgY29saXNp
b24pIHsKKwkJCWlmIChPVkVSTEFQUykgeworCQkJCXdha2VfdXAoJm1kZXYtPm1pc2Nfd2FpdCk7
CisJCQkJYnJlYWs7CiAJCQl9CisJCX0KKwl9CiAjdW5kZWYgT1ZFUkxBUFMKIH0KIApAQCAtOTcz
LDcgKzk3Myw2IEBACiAJCQlsb2NhbCA9IDA7CiAJCX0KIAkJaWYgKHJlbW90ZSkgZGVjX2FwX3Bl
bmRpbmcobWRldik7Ci0JCWR1bXBfYmlvKG1kZXYscmVxLT5tYXN0ZXJfYmlvLDEpOwogCQkvKiBU
SElOSzogZG8gd2Ugd2FudCB0byBmYWlsIGl0ICgtRUlPKSwgb3IgcHJldGVuZCBzdWNjZXNzPyAq
LwogCQliaW9fZW5kaW8ocmVxLT5tYXN0ZXJfYmlvLCByZXEtPm1hc3Rlcl9iaW8tPmJpX3NpemUs
IDApOwogCQlyZXEtPm1hc3Rlcl9iaW8gPSBOVUxMOwpAQCAtMTAwMCw2ICs5OTksOCBAQAogCQkg
KiB3YXMgbm90IGRldGFjaGVkIGJlbG93IHVzPyAqLwogCQlyZXEtPnByaXZhdGVfYmlvLT5iaV9i
ZGV2ID0gbWRldi0+YmMtPmJhY2tpbmdfYmRldjsKIAorCQlkdW1wX2ludGVybmFsX2JpbygiUHJp
IixtZGV2LHJ3LHJlcS0+cHJpdmF0ZV9iaW8sMCk7CisKIAkJaWYgKEZBVUxUX0FDVElWRShtZGV2
LCBydz09V1JJVEUgPyBEUkJEX0ZBVUxUX0RUX1dSIDoKIAkJCQkgICAgICAgKCBydz09UkVBRCA/
IERSQkRfRkFVTFRfRFRfUkQgOgogICAJCQkJICAgICAgICAgICAgICAgICAgIERSQkRfRkFVTFRf
RFRfUkEgKSApKQpAQCAtMTA3NSw4ICsxMDc2LDEzIEBACiAJCXJldHVybiAwOwogCX0KIAotCS8q
IEN1cnJlbnRseSBvdXIgQkFSUklFUiBjb2RlIGlzIGRpc2FibGVkLiAqLwotCWlmKHVubGlrZWx5
KGJpb19iYXJyaWVyKGJpbykpKSB7CisJLyogUmVqZWN0IGJhcnJpZXIgcmVxdWVzdHMgaWYgd2Ug
a25vdyB0aGUgdW5kZXJseWluZyBkZXZpY2UgZG9lcworCSAqIG5vdCBzdXBwb3J0IHRoZW0uCisJ
ICogWFhYOiBOZWVkIHRvIGdldCB0aGlzIGluZm8gZnJvbSBwZWVyIGFzIHdlbGwgc29tZSBob3cg
c28gd2UKKwkgKiBYWFg6IHJlamVjdCBpZiBFSVRIRVIgc2lkZSBkb2VzIG5vdCBzdXBwb3J0IHRo
ZW0sLCwKKwkqLworCWlmKHVubGlrZWx5KGJpb19iYXJyaWVyKGJpbykgJiYgKG1kZXYtPmZsYWdz
ICYgTk9fQkFSUklFUl9TVVBQKSkpIHsKKwkJV0FSTigiUmVqZWN0aW5nIGJhcnJpZXIgcmVxdWVz
dCBhcyB1bmRlcmx5aW5nIGRldmljZSBkb2VzIG5vdCBzdXBwb3J0XG4iKTsKIAkJYmlvX2VuZGlv
KGJpbywgYmlvLT5iaV9zaXplLCAtRU9QTk9UU1VQUCk7CiAJCXJldHVybiAwOwogCX0KSW5kZXg6
IGRyYmQtOC4wLjYvZHJiZC9kcmJkX2ludC5oCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KLS0tIGRyYmQtOC4wLjYvZHJi
ZC9kcmJkX2ludC5oCShyZXZpc2lvbiAyMTIyOSkKKysrIGRyYmQtOC4wLjYvZHJiZC9kcmJkX2lu
dC5oCSh3b3JraW5nIGNvcHkpCkBAIC02OTgsNyArNjk4LDggQEAKIAlDUkFTSEVEX1BSSU1BUlks
CS8vIFRoaXMgbm9kZSB3YXMgYSBjcmFzaGVkIHByaW1hcnkuIEdldHMKIAkgICAgICAgICAgICAg
ICAgICAgICAgICAvLyBjbGVhcmVkIHdoZW4gdGhlIHN0YXRlLmNvbm4gIGdvZXMgaW50bwogCSAg
ICAgICAgICAgICAgICAgICAgICAgIC8vIENvbm5lY3RlZCBzdGF0ZS4KLQlXUklURV9CTV9BRlRF
Ul9SRVNZTkMJLy8gQSBrbWFsbG9jKCkgZHVyaW5nIHJlc3luYyBmYWlsZWQKKwlXUklURV9CTV9B
RlRFUl9SRVNZTkMsCS8vIEEga21hbGxvYygpIGR1cmluZyByZXN5bmMgZmFpbGVkCisJTk9fQkFS
UklFUl9TVVBQLCAgICAgICAgLy8gdW5kZXJseWluZyBibG9jayBkZXZpY2UgZG9lc24ndCBpbXBs
ZW1lbnQgYmFycmllcnMKIH07CiAKIHN0cnVjdCBkcmJkX2JpdG1hcDsgLy8gb3BhcXVlIGZvciBE
cmJkX0NvbmYKQEAgLTc2Nyw2ICs3NjgsMTIgQEAKIAlzdHJ1Y3QgZGlza19jb25mIGRjOyAvKiBU
aGUgdXNlciBwcm92aWRlZCBjb25maWcuLi4gKi8KIH07CiAKK3N0cnVjdCBkcmJkX21kX2lvIHsK
KwlzdHJ1Y3QgRHJiZF9Db25mICptZGV2OworCXN0cnVjdCBjb21wbGV0aW9uIGV2ZW50OworCWlu
dCBlcnJvcjsKK307CisKIHN0cnVjdCBEcmJkX0NvbmYgewogI2lmZGVmIFBBUkFOT0lBCiAJbG9u
ZyBtYWdpYzsKQEAgLTEyMDQsNiArMTIxMSw3IEBACiAJVHJhY2VUeXBlVW5wbHVnID0gMHgwMDAw
MDAyMCwKIAlUcmFjZVR5cGVObCAgICAgPSAweDAwMDAwMDQwLAogCVRyYWNlVHlwZUFMRXh0cyA9
IDB4MDAwMDAwODAsCisJVHJhY2VUeXBlSW50UnEgID0gMHgwMDAwMDEwMCwKIH07CiAKIHN0YXRp
YyBpbmxpbmUgaW50CkBAIC0xMjQ3LDE0ICsxMjU1LDIwIEBACiAJCQkgICAgICB1bnNpZ25lZCBp
bnQgbGVuZ3RoKTsKIAogLy8gQmlvIHByaW50aW5nIHN1cHBvcnQKLWV4dGVybiB2b2lkIF9kdW1w
X2JpbyhkcmJkX2RldiAqbWRldiwgc3RydWN0IGJpbyAqYmlvLCBpbnQgY29tcGxldGUpOworZXh0
ZXJuIHZvaWQgX2R1bXBfYmlvKGNvbnN0IGNoYXIgKnBmeCwgZHJiZF9kZXYgKm1kZXYsIGludCBy
dywgc3RydWN0IGJpbyAqYmlvLCBpbnQgY29tcGxldGUpOwogCiBzdGF0aWMgaW5saW5lIHZvaWQg
ZHVtcF9iaW8oZHJiZF9kZXYgKm1kZXYsIHN0cnVjdCBiaW8gKmJpbywgaW50IGNvbXBsZXRlKSB7
CiAJTVRSQUNFKFRyYWNlVHlwZVJxLFRyYWNlTHZsU3VtbWFyeSwKLQkgICAgICAgX2R1bXBfYmlv
KG1kZXYsIGJpbywgY29tcGxldGUpOworCSAgICAgICBfZHVtcF9iaW8oIlJxIiwgbWRldiwgMCwg
YmlvLCBjb21wbGV0ZSk7CiAJCSk7CiB9CiAKK3N0YXRpYyBpbmxpbmUgdm9pZCBkdW1wX2ludGVy
bmFsX2Jpbyhjb25zdCBjaGFyICpwZngsIGRyYmRfZGV2ICptZGV2LCBpbnQgcncsIHN0cnVjdCBi
aW8gKmJpbywgaW50IGNvbXBsZXRlKSB7CisJTVRSQUNFKFRyYWNlVHlwZUludFJxLFRyYWNlTHZs
U3VtbWFyeSwKKwkgICAgICAgX2R1bXBfYmlvKHBmeCwgbWRldiwgcncsIGJpbywgY29tcGxldGUp
OworCQkpOworfQorCiAvLyBQYWNrZXQgZHVtcGluZyBzdXBwb3J0CiBleHRlcm4gdm9pZCBfZHVt
cF9wYWNrZXQoZHJiZF9kZXYgKm1kZXYsIHN0cnVjdCBzb2NrZXQgKnNvY2ssCiAJCQkgaW50IHJl
Y3YsIERyYmRfUG9seW1vcnBoX1BhY2tldCAqcCwgY2hhciogZmlsZSwgaW50IGxpbmUpOwpAQCAt
MTI3NCw2ICsxMjg4LDcgQEAKICNkZWZpbmUgVFJBQ0UoaWdub3JlZC4uLikgKCh2b2lkKTApCiAK
ICNkZWZpbmUgZHVtcF9iaW8oaWdub3JlZC4uLikgKCh2b2lkKTApCisjZGVmaW5lIGR1bXBfaW50
ZXJuYWxfYmlvKGlnbm9yZWQuLi4pICgodm9pZCkwKQogI2RlZmluZSBkdW1wX3BhY2tldChpZ25v
cmVkLi4uKSAoKHZvaWQpMCkKICNlbmRpZgogCg==

------_=_NextPart_001_01C82F8F.45A1DF92--
