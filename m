Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C85466.1C768A93"
Date: Fri, 11 Jan 2008 10:24:51 -0500
Message-ID: <342BAC0A5467384983B586A6B0B3767107C5AF64@EXNA.corp.stratus.com>
From: "Graham, Simon" <Simon.Graham@stratus.com>
To: <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] [DRBD-8.0 PATCH] Add split-brain event to netlink
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C85466.1C768A93
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_002_01C85466.1C768A93"


------_=_NextPart_002_01C85466.1C768A93
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I'm not sure if this was previously submitted or not, but this change
adds an explicit split-brain event to the netlink notifications so that
user mode code can know when a split-brain situation is encountered.

=20

Simon


------_=_NextPart_002_01C85466.1C768A93
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:x=3D"urn:schemas-microsoft-com:office:excel" =
xmlns:p=3D"urn:schemas-microsoft-com:office:powerpoint" =
xmlns:a=3D"urn:schemas-microsoft-com:office:access" =
xmlns:dt=3D"uuid:C2F41010-65B3-11d1-A29F-00AA00C14882" =
xmlns:s=3D"uuid:BDC6E3F0-6DA3-11d1-A2A3-00AA00C14882" =
xmlns:rs=3D"urn:schemas-microsoft-com:rowset" xmlns:z=3D"#RowsetSchema" =
xmlns:b=3D"urn:schemas-microsoft-com:office:publisher" =
xmlns:ss=3D"urn:schemas-microsoft-com:office:spreadsheet" =
xmlns:c=3D"urn:schemas-microsoft-com:office:component:spreadsheet" =
xmlns:oa=3D"urn:schemas-microsoft-com:office:activation" =
xmlns:html=3D"http://www.w3.org/TR/REC-html40" =
xmlns:q=3D"http://schemas.xmlsoap.org/soap/envelope/" xmlns:D=3D"DAV:" =
xmlns:x2=3D"http://schemas.microsoft.com/office/excel/2003/xml" =
xmlns:ois=3D"http://schemas.microsoft.com/sharepoint/soap/ois/" =
xmlns:dir=3D"http://schemas.microsoft.com/sharepoint/soap/directory/" =
xmlns:ds=3D"http://www.w3.org/2000/09/xmldsig#" =
xmlns:dsp=3D"http://schemas.microsoft.com/sharepoint/dsp" =
xmlns:udc=3D"http://schemas.microsoft.com/data/udc" =
xmlns:xsd=3D"http://www.w3.org/2001/XMLSchema" =
xmlns:sps=3D"http://schemas.microsoft.com/sharepoint/soap/" =
xmlns:xsi=3D"http://www.w3.org/2001/XMLSchema-instance" =
xmlns:udcxf=3D"http://schemas.microsoft.com/data/udc/xmlfile" =
xmlns:wf=3D"http://schemas.microsoft.com/sharepoint/soap/workflow/" =
xmlns:mver=3D"http://schemas.openxmlformats.org/markup-compatibility/2006=
" xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns:mrels=3D"http://schemas.openxmlformats.org/package/2006/relationshi=
ps" =
xmlns:ex12t=3D"http://schemas.microsoft.com/exchange/services/2006/types"=
 =
xmlns:ex12m=3D"http://schemas.microsoft.com/exchange/services/2006/messag=
es" xmlns=3D"http://www.w3.org/TR/REC-html40">

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

<p class=3DMsoNormal>I&#8217;m not sure if this was previously submitted =
or not,
but this change adds an explicit split-brain event to the netlink =
notifications
so that user mode code can know when a split-brain situation is =
encountered.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Simon<o:p></o:p></p>

</div>

</body>

</html>

------_=_NextPart_002_01C85466.1C768A93--

------_=_NextPart_001_01C85466.1C768A93
Content-Type: application/octet-stream;
	name="0006-Add-split-brain-event-to-netlink.patch"
Content-Transfer-Encoding: base64
Content-Description: 0006-Add-split-brain-event-to-netlink.patch
Content-Disposition: attachment;
	filename="0006-Add-split-brain-event-to-netlink.patch"

RnJvbSA4Nzg1NDQwZjUyNTUyNThiM2M2ZGYzMzhmOGI4NjA1MDgwNjYyODk2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTaW1vbiBHcmFoYW0gPHNncmFoYW1AYW5uYS5zbi5zdHJhdHVz
LmNvbT4KRGF0ZTogU2F0LCAyMiBEZWMgMjAwNyAxMzoxNzoxNCAtMDUwMApTdWJqZWN0OiBbUEFU
Q0hdIEFkZCBzcGxpdC1icmFpbiBldmVudCB0byBuZXRsaW5rCgotLS0KIGRyYmQvZHJiZF9pbnQu
aCAgICAgIHwgICAgMSArCiBkcmJkL2RyYmRfbmwuYyAgICAgICB8ICAgMzUgKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysKIGRyYmQvZHJiZF9yZWNlaXZlci5jIHwgICAgMSArCiBk
cmJkL2xpbnV4L2RyYmRfbmwuaCB8ICAgIDQgKysrKwogdXNlci9kcmJkc2V0dXAuYyAgICAgfCAg
ICA4ICsrKysrKysrCiA1IGZpbGVzIGNoYW5nZWQsIDQ5IGluc2VydGlvbnMoKyksIDAgZGVsZXRp
b25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJiZC9kcmJkX2ludC5oIGIvZHJiZC9kcmJkX2ludC5oCmlu
ZGV4IDAxZWViYTYuLmIzNzRkYzcgMTAwNjQ0Ci0tLSBhL2RyYmQvZHJiZF9pbnQuaAorKysgYi9k
cmJkL2RyYmRfaW50LmgKQEAgLTE0MjYsNiArMTQyNiw3IEBAIHZvaWQgZHJiZF9ubF9jbGVhbnVw
KHZvaWQpOwogaW50IF9faW5pdCBkcmJkX25sX2luaXQodm9pZCk7CiB2b2lkIGRyYmRfYmNhc3Rf
c3RhdGUoZHJiZF9kZXYgKm1kZXYsIGRyYmRfc3RhdGVfdCBzdGF0ZSk7CiB2b2lkIGRyYmRfYmNh
c3Rfc3luY19wcm9ncmVzcyhkcmJkX2RldiAqbWRldik7Cit2b2lkIGRyYmRfYmNhc3Rfc3BsaXRf
YnJhaW4oZHJiZF9kZXYgKm1kZXYsaW50IGZsYWcpOwogCiAvKgogICogaW5saW5lIGhlbHBlciBm
dW5jdGlvbnMKZGlmZiAtLWdpdCBhL2RyYmQvZHJiZF9ubC5jIGIvZHJiZC9kcmJkX25sLmMKaW5k
ZXggNjE1OTNlZC4uNWVmMWQ4OSAxMDA2NDQKLS0tIGEvZHJiZC9kcmJkX25sLmMKKysrIGIvZHJi
ZC9kcmJkX25sLmMKQEAgLTE3NjksNiArMTc2OSw0MSBAQCB2b2lkIGRyYmRfYmNhc3RfZXZfaGVs
cGVyKGRyYmRfZGV2ICptZGV2LCBjaGFyKiBoZWxwZXJfbmFtZSkKIAljbl9uZXRsaW5rX3NlbmQo
Y25fcmVwbHksIENOX0lEWF9EUkJELCBHRlBfS0VSTkVMKTsKIH0KIAordm9pZCBkcmJkX2JjYXN0
X3NwbGl0X2JyYWluKGRyYmRfZGV2ICptZGV2LGludCBmbGFnKQoreworCWNoYXIgYnVmZmVyW3Np
emVvZihzdHJ1Y3QgY25fbXNnKSsKKwkJICAgIHNpemVvZihzdHJ1Y3QgZHJiZF9ubF9jZmdfcmVw
bHkpKworCQkgICAgc2l6ZW9mKHN0cnVjdCBzcGxpdF9icmFpbl90YWdfbGVuX3N0cnVjdCkrCisJ
CSAgICBzaXplb2Yoc2hvcnQgaW50KV07CisJc3RydWN0IGNuX21zZyAqY25fcmVwbHkgPSAoc3Ry
dWN0IGNuX21zZyAqKSBidWZmZXI7CisJc3RydWN0IGRyYmRfbmxfY2ZnX3JlcGx5KiByZXBseSA9
IChzdHJ1Y3QgZHJiZF9ubF9jZmdfcmVwbHkqKWNuX3JlcGx5LT5kYXRhOworCXVuc2lnbmVkIHNo
b3J0ICp0bCA9IHJlcGx5LT50YWdfbGlzdDsKKwlpbnQgdmFsID0gZmxhZzsKKyAgICAgICAKKwkq
dGwrKyA9IFRfc3BsaXRfYnJhaW47CisJKnRsKysgPSBzaXplb2YoaW50KTsKKyAgICAgICBtZW1j
cHkodGwsICZ2YWwsIHNpemVvZihpbnQpKTsKKwl0bD0odW5zaWduZWQgc2hvcnQqKSgoY2hhciop
dGwgKyBzaXplb2YoaW50KSk7CisJKnRsKysgPSBUVF9FTkQ7IC8qIENsb3NlIHRoZSB0YWcgbGlz
dCAqLworCisJY25fcmVwbHktPmlkLmlkeCA9IENOX0lEWF9EUkJEOworCWNuX3JlcGx5LT5pZC52
YWwgPSBDTl9WQUxfRFJCRDsKKworCWNuX3JlcGx5LT5zZXEgPSBhdG9taWNfYWRkX3JldHVybigx
LCZkcmJkX25sX3NlcSk7CisJY25fcmVwbHktPmFjayA9IDA7IC8vIG5vdCB1c2VkIGhlcmUuCisJ
Y25fcmVwbHktPmxlbiA9IHNpemVvZihzdHJ1Y3QgZHJiZF9ubF9jZmdfcmVwbHkpICsKKwkJKGlu
dCkoKGNoYXIqKXRsIC0gKGNoYXIqKXJlcGx5LT50YWdfbGlzdCk7CisJY25fcmVwbHktPmZsYWdz
ID0gMDsKKworCXJlcGx5LT5wYWNrZXRfdHlwZSA9IFBfc3BsaXRfYnJhaW47CisJcmVwbHktPm1p
bm9yID0gbWRldl90b19taW5vcihtZGV2KTsKKwlyZXBseS0+cmV0X2NvZGUgPSBOb0Vycm9yOwor
CisJVFJBQ0UoVHJhY2VUeXBlTmwsIFRyYWNlTHZsU3VtbWFyeSwgbmxfdHJhY2VfcmVwbHkoY25f
cmVwbHkpOyk7CisKKwljbl9uZXRsaW5rX3NlbmQoY25fcmVwbHksIENOX0lEWF9EUkJELCBHRlBf
S0VSTkVMKTsKK30KKwogdm9pZCBkcmJkX2JjYXN0X3N5bmNfcHJvZ3Jlc3MoZHJiZF9kZXYgKm1k
ZXYpCiB7CiAJY2hhciBidWZmZXJbc2l6ZW9mKHN0cnVjdCBjbl9tc2cpKwpkaWZmIC0tZ2l0IGEv
ZHJiZC9kcmJkX3JlY2VpdmVyLmMgYi9kcmJkL2RyYmRfcmVjZWl2ZXIuYwppbmRleCAwOGFkZTQ5
Li5hODk5MjFjIDEwMDY0NAotLS0gYS9kcmJkL2RyYmRfcmVjZWl2ZXIuYworKysgYi9kcmJkL2Ry
YmRfcmVjZWl2ZXIuYwpAQCAtMjAyMyw2ICsyMDIzLDcgQEAgU1RBVElDIGRyYmRfY29ubnNfdCBk
cmJkX3N5bmNfaGFuZHNoYWtlKGRyYmRfZGV2ICptZGV2LCBkcmJkX3JvbGVfdCBwZWVyX3JvbGUs
CiAJCWRyYmRfdXVpZF9kdW1wKG1kZXYsInNlbGYiLG1kZXYtPmJjLT5tZC51dWlkKTsKIAkJZHJi
ZF91dWlkX2R1bXAobWRldiwicGVlciIsbWRldi0+cF91dWlkKTsKIAkJZHJiZF9mb3JjZV9zdGF0
ZShtZGV2LE5TKGNvbm4sRGlzY29ubmVjdGluZykpOworCQlkcmJkX2JjYXN0X3NwbGl0X2JyYWlu
KG1kZXYsMSk7Ly9UZWxsIHVzZXIgd2Ugc3BsaXQgYnJhaW5lZCAKIAkJZHJiZF9raGVscGVyKG1k
ZXYsInNwbGl0LWJyYWluIik7CiAJCXJldHVybiBjb25uX21hc2s7CiAJfQpkaWZmIC0tZ2l0IGEv
ZHJiZC9saW51eC9kcmJkX25sLmggYi9kcmJkL2xpbnV4L2RyYmRfbmwuaAppbmRleCBiMGU3NzBj
Li44YzYxNjhmIDEwMDY0NAotLS0gYS9kcmJkL2xpbnV4L2RyYmRfbmwuaAorKysgYi9kcmJkL2xp
bnV4L2RyYmRfbmwuaApAQCAtOTcsNiArOTcsMTAgQEAgTkxfUEFDS0VUKHN5bmNfcHJvZ3Jlc3Ms
IDIzLAogCU5MX0lOVEVHRVIoCTQzLAlUX01BWV9JR05PUkUsCXN5bmNfcHJvZ3Jlc3MpCiApCiAK
K05MX1BBQ0tFVChzcGxpdF9icmFpbiwgMjQsCisJTkxfSU5URUdFUigJNDQsCVRfTUFZX0lHTk9S
RSwJc3BsaXRfYnJhaW4pCispCisKICN1bmRlZiBOTF9QQUNLRVQKICN1bmRlZiBOTF9JTlRFR0VS
CiAjdW5kZWYgTkxfSU5UNjQKZGlmZiAtLWdpdCBhL3VzZXIvZHJiZHNldHVwLmMgYi91c2VyL2Ry
YmRzZXR1cC5jCmluZGV4IDBmNWRkYzIuLmQwODhjZDggMTAwNjQ0Ci0tLSBhL3VzZXIvZHJiZHNl
dHVwLmMKKysrIGIvdXNlci9kcmJkc2V0dXAuYwpAQCAtMTIzOCw2ICsxMjM4LDE0IEBAIGludCBw
cmludF9zdGF0ZSh1bnNpZ25lZCBpbnQgc2VxLCBpbnQgdSBfX2F0dHJpYnV0ZSgodW51c2VkKSks
CiAJCQkJc3luY2VkICUgMTApOwogCQl9IGVsc2UgZnByaW50ZihzdGRlcnIsIk1pc3NpbmcgdGFn
ICE/XG4iKTsKIAkJYnJlYWs7CisJY2FzZSBQX3NwbGl0X2JyYWluOgorCQlpZiAoY29uc3VtZV90
YWdfaW50KFRfc3BsaXRfYnJhaW4sIHJlcGx5LT50YWdfbGlzdCwgJnN5bmNlZCkpIHsKKwkJCXBy
aW50ZigiJXUgU0IgJWQgJWRcbiIsIAorCQkJCXNlcSwKKwkJCQlyZXBseS0+bWlub3IsCisJCQkJ
c3luY2VkKTsKKwkJfSBlbHNlIGZwcmludGYoc3RkZXJyLCJNaXNzaW5nIHRhZyAhP1xuIik7CisJ
CWJyZWFrOwogCWRlZmF1bHQ6CiAJCXByaW50ZigiJXUgPz8gJWQgPG90aGVyIG1lc3NhZ2U+XG4i
LHNlcSwgcmVwbHktPm1pbm9yKTsKIAkJYnJlYWs7Ci0tIAoxLjUuNC5yYzEKCg==

------_=_NextPart_001_01C85466.1C768A93--
