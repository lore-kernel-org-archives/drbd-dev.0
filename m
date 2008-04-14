Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C89E61.870E2404"
Date: Mon, 14 Apr 2008 14:58:26 -0400
Message-ID: <342BAC0A5467384983B586A6B0B3767108F031F6@EXNA.corp.stratus.com>
From: "Graham, Simon" <Simon.Graham@stratus.com>
To: <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] [PATCH] - DRBD 8.0: Add standard disk counters to DRBD
	devices
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C89E61.870E2404
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_002_01C89E61.870E2404"


------_=_NextPart_002_01C89E61.870E2404
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

The attached patch adds support for the standard disk stats (as reported
in /proc/diskstats et al) at the DRBD device level - this is nice
because it can be used to show the actual response times etc at that
level, after both local and remote (and meta data) I/O is done. These
numbers also show up in the standard sar data for disk I/O.

=20

It was a little trickier than I thought because getting the right values
for the various time fields is not obvious but in the end I copied what
md and ll_rw_blk.c do and the numbers certainly look correct now. There
are also a few error paths at the top of make_request that do not count
bio's that are failed early - since I need to hold the mdev request lock
when manipulating the counters, I put the code in after the lock was
already acquired which leaves a few error paths that are not counted.
However, the normal paths are there, so I think it's OK.

=20

Simon


------_=_NextPart_002_01C89E61.870E2404
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

<p class=3DMsoNormal>The attached patch adds support for the standard =
disk stats
(as reported in /proc/diskstats et al) at the DRBD device level &#8211; =
this is
nice because it can be used to show the actual response times etc at =
that
level, after both local and remote (and meta data) I/O is done. These =
numbers
also show up in the standard sar data for disk I/O.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>It was a little trickier than I thought because =
getting the
right values for the various time fields is not obvious but in the end I =
copied
what md and ll_rw_blk.c do and the numbers certainly look correct now. =
There
are also a few error paths at the top of make_request that do not count =
bio&#8217;s
that are failed early &#8211; since I need to hold the mdev request lock =
when
manipulating the counters, I put the code in after the lock was already
acquired which leaves a few error paths that are not counted. However, =
the
normal paths are there, so I think it&#8217;s OK.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Simon<o:p></o:p></p>

</div>

</body>

</html>

------_=_NextPart_002_01C89E61.870E2404--

------_=_NextPart_001_01C89E61.870E2404
Content-Type: application/octet-stream;
	name="0003-Add-support-for-standard-disk-stats-to-DRBD-devices.patch"
Content-Transfer-Encoding: base64
Content-Description: 0003-Add-support-for-standard-disk-stats-to-DRBD-devices.patch
Content-Disposition: attachment;
	filename="0003-Add-support-for-standard-disk-stats-to-DRBD-devices.patch"

RnJvbSAwYjM1YTgxY2NkYTA2YzY3MTFjZGYzY2JhZTFhMGNmZjAzM2NhMjVlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTaW1vbiBQLiBHcmFoYW0gPFNpbW9uLkdyYWhhbUBzdHJhdHVz
LmNvbT4KRGF0ZTogTW9uLCAxNCBBcHIgMjAwOCAxMDozNTozMyAtMDQwMApTdWJqZWN0OiBbUEFU
Q0hdIEFkZCBzdXBwb3J0IGZvciBzdGFuZGFyZCBkaXNrIHN0YXRzIHRvIERSQkQgZGV2aWNlcwoK
LS0tCiBkcmJkL2RyYmRfaW50LmggfCAgICAxICsKIGRyYmQvZHJiZF9yZXEuYyB8ICAgMzggKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKIGRyYmQvZHJiZF9yZXEuaCB8ICAg
IDEgKwogMyBmaWxlcyBjaGFuZ2VkLCA0MCBpbnNlcnRpb25zKCspLCAwIGRlbGV0aW9ucygtKQoK
ZGlmZiAtLWdpdCBhL2RyYmQvZHJiZF9pbnQuaCBiL2RyYmQvZHJiZF9pbnQuaAppbmRleCA4ZjY5
M2YzLi4wNWVkYzU1IDEwMDY0NAotLS0gYS9kcmJkL2RyYmRfaW50LmgKKysrIGIvZHJiZC9kcmJk
X2ludC5oCkBAIC02MjksNiArNjI5LDcgQEAgc3RydWN0IGRyYmRfcmVxdWVzdCB7CiAJc3RydWN0
IGJpbyAqbWFzdGVyX2JpbzsgICAgICAgLyogbWFzdGVyIGJpbyBwb2ludGVyICovCiAJdW5zaWdu
ZWQgbG9uZyBycV9zdGF0ZTsgLyogc2VlIGNvbW1lbnRzIGFib3ZlIF9yZXFfbW9kKCkgKi8KIAlp
bnQgc2VxX251bTsKKwl1bnNpZ25lZCBsb25nIHN0YXJ0X3RpbWU7CiB9OwogCiBzdHJ1Y3QgZHJi
ZF9iYXJyaWVyIHsKZGlmZiAtLWdpdCBhL2RyYmQvZHJiZF9yZXEuYyBiL2RyYmQvZHJiZF9yZXEu
YwppbmRleCBmMDZhMGU0Li5kNzViNjc0IDEwMDY0NAotLS0gYS9kcmJkL2RyYmRfcmVxLmMKKysr
IGIvZHJiZC9kcmJkX3JlcS5jCkBAIC0xMDUsNiArMTA1LDM3IEBAIHZvaWQgX3ByaW50X3JlcV9t
b2QoZHJiZF9yZXF1ZXN0X3QgKnJlcSxkcmJkX3JlcV9ldmVudF90IHdoYXQpCiAjZGVmaW5lIHBy
aW50X3JlcV9tb2QoVCxXKQogI2VuZGlmCiAKKy8qIFVwZGF0ZSBkaXNrIHN0YXRzIGF0IHN0YXJ0
IG9mIEkvTyByZXF1ZXN0ICovCitzdGF0aWMgaW5saW5lIHZvaWQgX2RyYmRfc3RhcnRfaW9fYWNj
dChkcmJkX2RldiAqbWRldiwgZHJiZF9yZXF1ZXN0X3QgKnJlcSwgc3RydWN0IGJpbyAqYmlvKQor
eworCWludCBydyA9IGJpb19kYXRhX2RpcihiaW8pOworCisJTVVTVF9IT0xEKCZtZGV2LT5yZXFf
bG9jaykKKworCWRpc2tfc3RhdF9pbmMobWRldi0+dmRpc2ssIGlvc1tyd10pOworCWRpc2tfc3Rh
dF9hZGQobWRldi0+dmRpc2ssIHNlY3RvcnNbcnddLCBiaW9fc2VjdG9ycyhiaW8pKTsKKwlwcmVl
bXB0X2Rpc2FibGUoKTsKKwlkaXNrX3JvdW5kX3N0YXRzKG1kZXYtPnZkaXNrKTsKKwlwcmVlbXB0
X2VuYWJsZSgpOworCW1kZXYtPnZkaXNrLT5pbl9mbGlnaHQrKzsKK30KKworLyogVXBkYXRlIGRp
c2sgc3RhdHMgd2hlbiBjb21wbGV0aW5nIHJlcXVlc3QgdXB3YXJkcyAqLworc3RhdGljIGlubGlu
ZSB2b2lkIF9kcmJkX2VuZF9pb19hY2N0KGRyYmRfZGV2ICptZGV2LCBkcmJkX3JlcXVlc3RfdCAq
cmVxKQoreworCWludCBydyA9IGJpb19kYXRhX2RpcihyZXEtPm1hc3Rlcl9iaW8pOworCXVuc2ln
bmVkIGxvbmcgZHVyYXRpb24gPSBqaWZmaWVzIC0gcmVxLT5zdGFydF90aW1lOworCisJTVVTVF9I
T0xEKCZtZGV2LT5yZXFfbG9jaykKKworCXByZWVtcHRfZGlzYWJsZSgpOworCWRpc2tfcm91bmRf
c3RhdHMobWRldi0+dmRpc2spOworCXByZWVtcHRfZW5hYmxlKCk7CisJbWRldi0+dmRpc2stPmlu
X2ZsaWdodC0tOworCisJZGlza19zdGF0X2FkZChtZGV2LT52ZGlzaywgdGlja3NbcnddLCBkdXJh
dGlvbik7Cit9CisKIHN0YXRpYyB2b2lkIF9yZXFfaXNfZG9uZShkcmJkX2RldiAqbWRldiwgZHJi
ZF9yZXF1ZXN0X3QgKnJlcSwgY29uc3QgaW50IHJ3KQogewogCWNvbnN0IHVuc2lnbmVkIGxvbmcg
cyA9IHJlcS0+cnFfc3RhdGU7CkBAIC0zMzUsNiArMzY2LDkgQEAgdm9pZCBfcmVxX21heV9iZV9k
b25lKGRyYmRfcmVxdWVzdF90ICpyZXEsIGludCBlcnJvcikKIAkJICogdGhlbiBhZ2FpbiwgaWYg
aXQgaXMgYSBSRUFELCBpdCBpcyBub3QgaW4gdGhlIFRMIGF0IGFsbC4KIAkJICogaXMgaXQgc3Rp
bGwgbGVhZ2FsIHRvIGNvbXBsZXRlIGEgUkVBRCBkdXJpbmcgZnJlZXplPyAqLwogCisJCS8qIFVw
ZGF0ZSBkaXNrIHN0YXRzICovCisJCV9kcmJkX2VuZF9pb19hY2N0KG1kZXYsIHJlcSk7CisKIAkJ
X2NvbXBsZXRlX21hc3Rlcl9iaW8obWRldixyZXEsCiAJCQkgIG9rID8gMCA6ICggZXJyb3IgPyBl
cnJvciA6IC1FSU8gKSApOwogCX0gZWxzZSB7CkBAIC05NTYsNiArOTkwLDkgQEAgZHJiZF9tYWtl
X3JlcXVlc3RfY29tbW9uKGRyYmRfZGV2ICptZGV2LCBzdHJ1Y3QgYmlvICpiaW8pCiAJfQogCiAK
KwkvKiBVcGRhdGUgZGlzayBzdGF0cyAqLworCV9kcmJkX3N0YXJ0X2lvX2FjY3QobWRldiwgcmVx
LCBiaW8pOworCiAJLyogX21heWJlX3N0YXJ0X25ld19lcG9jaChtZGV2KTsKIAkgKiBJZiB3ZSBu
ZWVkIHRvIGdlbmVyYXRlIGEgd3JpdGUgYmFycmllciBwYWNrZXQsIHdlIGhhdmUgdG8gYWRkIHRo
ZQogCSAqIG5ldyBlcG9jaCAoYmFycmllcikgb2JqZWN0LCBhbmQgcXVldWUgdGhlIGJhcnJpZXIg
cGFja2V0IGZvciBzZW5kaW5nLApAQCAtMTAxMiw2ICsxMDQ5LDcgQEAgZHJiZF9tYWtlX3JlcXVl
c3RfY29tbW9uKGRyYmRfZGV2ICptZGV2LCBzdHJ1Y3QgYmlvICpiaW8pCiAJCQlsb2NhbCA9IDA7
CiAJCX0KIAkJaWYgKHJlbW90ZSkgZGVjX2FwX3BlbmRpbmcobWRldik7CisJCV9kcmJkX2VuZF9p
b19hY2N0KG1kZXYsIHJlcSk7CiAJCS8qIFRISU5LOiBkbyB3ZSB3YW50IHRvIGZhaWwgaXQgKC1F
SU8pLCBvciBwcmV0ZW5kIHN1Y2Nlc3M/ICovCiAJCWJpb19lbmRpbyhyZXEtPm1hc3Rlcl9iaW8s
IDApOwogCQlyZXEtPm1hc3Rlcl9iaW8gPSBOVUxMOwpkaWZmIC0tZ2l0IGEvZHJiZC9kcmJkX3Jl
cS5oIGIvZHJiZC9kcmJkX3JlcS5oCmluZGV4IDFkOTgxYjIuLjc0ZDhkYzEgMTAwNjQ0Ci0tLSBh
L2RyYmQvZHJiZF9yZXEuaAorKysgYi9kcmJkL2RyYmRfcmVxLmgKQEAgLTI4NCw2ICsyODQsNyBA
QCBzdGF0aWMgaW5saW5lIGRyYmRfcmVxdWVzdF90KiBkcmJkX3JlcV9uZXcoZHJiZF9kZXYgKm1k
ZXYsIHN0cnVjdCBiaW8gKmJpb19zcmMpCiAJCXJlcS0+ZXBvY2ggICAgICAgPSAwOwogCQlyZXEt
PnNlY3RvciAgICAgID0gYmlvLT5iaV9zZWN0b3I7CiAJCXJlcS0+c2l6ZSAgICAgICAgPSBiaW8t
PmJpX3NpemU7CisJCXJlcS0+c3RhcnRfdGltZSAgPSBqaWZmaWVzOwogCQlJTklUX0hMSVNUX05P
REUoJnJlcS0+Y29saXNpb24pOwogCQlJTklUX0xJU1RfSEVBRCgmcmVxLT50bF9yZXF1ZXN0cyk7
CiAKLS0gCjEuNS40LXJjMS5HSVQKCg==

------_=_NextPart_001_01C89E61.870E2404--
