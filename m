Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C85465.F0273D1D"
Date: Fri, 11 Jan 2008 10:23:37 -0500
Message-ID: <342BAC0A5467384983B586A6B0B3767107C5AF60@EXNA.corp.stratus.com>
From: "Graham, Simon" <Simon.Graham@stratus.com>
To: <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] [DRBD-8.0 PATCH] Revert some changes that cause resync
	to stall
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C85465.F0273D1D
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_002_01C85465.F0273D1D"


------_=_NextPart_002_01C85465.F0273D1D
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

The attached patches revert a couple of changes made in DRBD-8.0 that
can cause resync to stall if it is pasued/resumed quickly (as can happen
if you have a lot of devices all releated with sync-after settings).

=20

Simon


------_=_NextPart_002_01C85465.F0273D1D
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

<p class=3DMsoNormal>The attached patches revert a couple of changes =
made in
DRBD-8.0 that can cause resync to stall if it is pasued/resumed quickly =
(as can
happen if you have a lot of devices all releated with sync-after =
settings).<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Simon<o:p></o:p></p>

</div>

</body>

</html>

------_=_NextPart_002_01C85465.F0273D1D--

------_=_NextPart_001_01C85465.F0273D1D
Content-Type: application/octet-stream;
	name="0004-Revert-Fixing-drbdadm-pause-sync-r0-drbdadm-resu.patch"
Content-Transfer-Encoding: base64
Content-Description: 0004-Revert-Fixing-drbdadm-pause-sync-r0-drbdadm-resu.patch
Content-Disposition: attachment;
	filename="0004-Revert-Fixing-drbdadm-pause-sync-r0-drbdadm-resu.patch"

RnJvbSA5MzE0NGY3NmJiM2UyMmJjODUwY2FmYWZhNDg5ZmM5MDRiNmM5M2RiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTaW1vbiBHcmFoYW0gPHNncmFoYW1AYW5uYS5zbi5zdHJhdHVz
LmNvbT4KRGF0ZTogRnJpLCAyMSBEZWMgMjAwNyAyMjoyNzo1NiAtMDUwMApTdWJqZWN0OiBbUEFU
Q0hdIFJldmVydCAiRml4aW5nICJkcmJkYWRtIHBhdXNlLXN5bmMgcjAgOyBkcmJkYWRtIHJlc3Vt
ZS1zeW5jIHIwIiIKClRoaXMgcmV2ZXJ0cyBjb21taXQgNjg2NjBjZDg4NTU2NGI1OTBjMDU1OWVm
ZGJiMjhmOWVkY2I4N2ZmMi4KClRoZSBjaGFuZ2UgY2F1c2VkIHRoZSBzeW5jIHRvIHN0YWxsIHdo
ZW4gcGF1c2VkIGFuZCByZXN1bWVkIHF1aWNrbHkKLS0tCiBkcmJkL2RyYmRfbWFpbi5jIHwgICAg
MiArLQogMSBmaWxlcyBjaGFuZ2VkLCAxIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb25zKC0pCgpk
aWZmIC0tZ2l0IGEvZHJiZC9kcmJkX21haW4uYyBiL2RyYmQvZHJiZF9tYWluLmMKaW5kZXggOGQx
ODYwMS4uMTQzMDc5NCAxMDA2NDQKLS0tIGEvZHJiZC9kcmJkX21haW4uYworKysgYi9kcmJkL2Ry
YmRfbWFpbi5jCkBAIC03ODUsNyArNzg1LDcgQEAgaW50IF9kcmJkX3NldF9zdGF0ZShkcmJkX2Rl
diogbWRldiwgZHJiZF9zdGF0ZV90IG5zLGVudW0gY2hnX3N0YXRlX2ZsYWdzIGZsYWdzKQogCQlJ
TkZPKCJTeW5jZXIgY29udGludWVzLlxuIik7CiAJCW1kZXYtPnJzX3BhdXNlZCArPSAobG9uZylq
aWZmaWVzLShsb25nKW1kZXYtPnJzX21hcmtfdGltZTsKIAkJaWYgKG5zLmNvbm4gPT0gU3luY1Rh
cmdldCkgewotCQkJaWYgKCF0ZXN0X2FuZF9jbGVhcl9iaXQoU1RPUF9TWU5DX1RJTUVSLCZtZGV2
LT5mbGFncykpIHsKKwkJCWlmICghdGVzdF9iaXQoU1RPUF9TWU5DX1RJTUVSLCZtZGV2LT5mbGFn
cykpIHsKIAkJCQltb2RfdGltZXIoJm1kZXYtPnJlc3luY190aW1lcixqaWZmaWVzKTsKIAkJCX0K
IAkJCS8qIFRoaXMgaWYgKCF0ZXN0X2JpdCkgaXMgb25seSBuZWVkZWQgZm9yIHRoZSBjYXNlCi0t
IAoxLjUuNC5yYzEKCg==

------_=_NextPart_001_01C85465.F0273D1D
Content-Type: application/octet-stream;
	name="0005-Revert-make-resync-more-robust-don-t-reset-find-bi.patch"
Content-Transfer-Encoding: base64
Content-Description: 0005-Revert-make-resync-more-robust-don-t-reset-find-bi.patch
Content-Disposition: attachment;
	filename="0005-Revert-make-resync-more-robust-don-t-reset-find-bi.patch"

RnJvbSBjYWIyMTc5YzZjZWVhOTQzYjQ1ZGNmYzk5YTU0ZTE0ZmQ3MjVhMDgyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTaW1vbiBHcmFoYW0gPHNncmFoYW1AYW5uYS5zbi5zdHJhdHVz
LmNvbT4KRGF0ZTogRnJpLCAyMSBEZWMgMjAwNyAyMjoyODoyNCAtMDUwMApTdWJqZWN0OiBbUEFU
Q0hdIFJldmVydCAibWFrZSByZXN5bmMgbW9yZSByb2J1c3QsIGRvbid0IHJlc2V0IGZpbmQgYml0
IG9mZnNldCB0b28gZWFybHkuIgoKVGhpcyByZXZlcnRzIGNvbW1pdCAzYTU3MTE5NDE3YzQ2YzUx
ZGQ0YmM3MjBhYjdkYmYxNDIyOGYwNWJiLgoKVGhlIGNoYW5nZSBjYXVzZWQgc3luY2luZyB0byBz
dGFsbCBpZiBwYXNlZC9yZXN1bWVkIHF1aWNrbHkKLS0tCiBkcmJkL2RyYmRfYml0bWFwLmMgfCAg
ICA0ICsrLS0KIGRyYmQvZHJiZF9tYWluLmMgICB8ICAgMTIgKysrKy0tLS0tLS0tCiAyIGZpbGVz
IGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEv
ZHJiZC9kcmJkX2JpdG1hcC5jIGIvZHJiZC9kcmJkX2JpdG1hcC5jCmluZGV4IGI5MzA5YTMuLjZh
N2U0YWUgMTAwNjQ0Ci0tLSBhL2RyYmQvZHJiZF9iaXRtYXAuYworKysgYi9kcmJkL2RyYmRfYml0
bWFwLmMKQEAgLTg3NCw3ICs4NzQsNyBAQCB1bnNpZ25lZCBsb25nIGRyYmRfYm1fZmluZF9uZXh0
KGRyYmRfZGV2ICptZGV2KQogCX0KIAlpZiAoaSA+PSBiLT5ibV9iaXRzKSB7CiAJCWkgPSAtMVVM
OwotCQkvKiBsZWF2ZSBiLT5ibV9mbyB1bmNoYW5nZWQuICovCisJCWItPmJtX2ZvID0gMDsKIAl9
IGVsc2UgewogCQliLT5ibV9mbyA9IGkrMTsKIAl9CkBAIC04OTgsNyArODk4LDcgQEAgdm9pZCBk
cmJkX2JtX3NldF9maW5kKGRyYmRfZGV2ICptZGV2LCB1bnNpZ25lZCBsb25nIGkpCiAKIGludCBk
cmJkX2JtX3JzX2RvbmUoZHJiZF9kZXYgKm1kZXYpCiB7Ci0JcmV0dXJuIChtZGV2LT5iaXRtYXAt
PmJtX2ZvID49IG1kZXYtPmJpdG1hcC0+Ym1fYml0cyk7CisJcmV0dXJuIG1kZXYtPmJpdG1hcC0+
Ym1fZm8gPT0gMDsKIH0KIAogLyogcmV0dXJucyBudW1iZXIgb2YgYml0cyBhY3R1YWxseSBjaGFu
Z2VkLgpkaWZmIC0tZ2l0IGEvZHJiZC9kcmJkX21haW4uYyBiL2RyYmQvZHJiZF9tYWluLmMKaW5k
ZXggMTQzMDc5NC4uOThhMWM2MyAxMDA2NDQKLS0tIGEvZHJiZC9kcmJkX21haW4uYworKysgYi9k
cmJkL2RyYmRfbWFpbi5jCkBAIC03ODQsMTQgKzc4NCwxMCBAQCBpbnQgX2RyYmRfc2V0X3N0YXRl
KGRyYmRfZGV2KiBtZGV2LCBkcmJkX3N0YXRlX3QgbnMsZW51bSBjaGdfc3RhdGVfZmxhZ3MgZmxh
Z3MpCiAJICAgIChucy5jb25uID09IFN5bmNUYXJnZXQgIHx8IG5zLmNvbm4gPT0gU3luY1NvdXJj
ZSkgKSB7CiAJCUlORk8oIlN5bmNlciBjb250aW51ZXMuXG4iKTsKIAkJbWRldi0+cnNfcGF1c2Vk
ICs9IChsb25nKWppZmZpZXMtKGxvbmcpbWRldi0+cnNfbWFya190aW1lOwotCQlpZiAobnMuY29u
biA9PSBTeW5jVGFyZ2V0KSB7Ci0JCQlpZiAoIXRlc3RfYml0KFNUT1BfU1lOQ19USU1FUiwmbWRl
di0+ZmxhZ3MpKSB7Ci0JCQkJbW9kX3RpbWVyKCZtZGV2LT5yZXN5bmNfdGltZXIsamlmZmllcyk7
Ci0JCQl9Ci0JCQkvKiBUaGlzIGlmICghdGVzdF9iaXQpIGlzIG9ubHkgbmVlZGVkIGZvciB0aGUg
Y2FzZQotCQkJICAgdGhhdCBhIGRldmljZSB0aGF0IGhhcyBjZWFzZWQgdG8gdXNlZCBpdHMgdGlt
ZXIsCi0JCQkgICBpLmUuIGl0IGlzIGFscmVhZHkgaW4gZHJiZF9yZXN5bmNfZmluaXNoZWQoKSBn
ZXRzCi0JCQkgICBwYXVzZWQgYW5kIHJlc3VtZWQuICovCisJCWlmKCBucy5jb25uID09IFN5bmNU
YXJnZXQgKSB7CisJCQlEX0FTU0VSVCghdGVzdF9iaXQoU1RPUF9TWU5DX1RJTUVSLCZtZGV2LT5m
bGFncykpOworCQkJY2xlYXJfYml0KFNUT1BfU1lOQ19USU1FUiwmbWRldi0+ZmxhZ3MpOworCQkJ
bW9kX3RpbWVyKCZtZGV2LT5yZXN5bmNfdGltZXIsamlmZmllcyk7CiAJCX0KIAl9CiAKLS0gCjEu
NS40LnJjMQoK

------_=_NextPart_001_01C85465.F0273D1D--
