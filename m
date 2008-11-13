Return-Path: <roger.tsang@gmail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.239])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 5BEBC2E078FD
	for <drbd-dev@lists.linbit.com>; Thu, 13 Nov 2008 12:49:55 +0100 (CET)
Received: by rv-out-0506.google.com with SMTP id f6so912631rvb.3
	for <drbd-dev@lists.linbit.com>; Thu, 13 Nov 2008 03:49:54 -0800 (PST)
Message-ID: <498263350811130341i2053e36agf20b2e24b694d929@mail.gmail.com>
Date: Thu, 13 Nov 2008 11:41:44 +0000
From: "Roger Tsang" <roger.tsang@gmail.com>
To: drbd-dev@lists.linbit.com
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_3227_14172498.1226576504540"
Subject: [Drbd-dev] [PATCH] 8.2.7 drbdsetup disk size error for flexible
	internal meta data
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

------=_Part_3227_14172498.1226576504540
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

The attached patch fixes a bug in drbd-8.2.7 which fails to set disk
size for drbd devices using flexible internal meta data.

`drbdsetup disk --size` for flexible internal meta data fails
unexpectedly with error LDDeviceTooSmall because in
drbd_nl_disk_conf() the drbd_get_max_capacity() call to check "disk
size" returns bogus values due to uninitialized values in drbd_md
structure.

Roger

------=_Part_3227_14172498.1226576504540
Content-Type: application/octet-stream; name=drbd-827-disk_size_issue
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fnhbrl7h0
Content-Disposition: attachment; filename=drbd-827-disk_size_issue

SW5kZXg6IGRyYmQtOC4yLjcvZHJiZC9kcmJkX25sLmMKPT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQotLS0gZHJiZC04LjIu
Ny5vcmlnL2RyYmQvZHJiZF9ubC5jCisrKyBkcmJkLTguMi43L2RyYmQvZHJiZF9ubC5jCkBAIC04
MjAsNiArODIwLDggQEAgU1RBVElDIGludCBkcmJkX25sX2Rpc2tfY29uZihzdHJ1Y3QgZHJiZAog
CQlnb3RvIGZhaWw7CiAJfQogCisJbWVtc2V0KCZuYmMtPm1kLCAwLCBzaXplb2Yoc3RydWN0IGRy
YmRfbWQpKTsKKwogCWlmICghKG5scC0+ZmxhZ3MgJiBEUkJEX05MX1NFVF9ERUZBVUxUUykgJiYg
aW5jX2xvY2FsKG1kZXYpKSB7CiAJCW1lbWNweSgmbmJjLT5kYywgJm1kZXYtPmJjLT5kYywgc2l6
ZW9mKHN0cnVjdCBkaXNrX2NvbmYpKTsKIAkJZGVjX2xvY2FsKG1kZXYpOwpAQCAtOTE2LDcgKzkx
OCwxMyBAQCBTVEFUSUMgaW50IGRyYmRfbmxfZGlza19jb25mKHN0cnVjdCBkcmJkCiAJCWdvdG8g
cmVsZWFzZV9iZGV2Ml9mYWlsOwogCX0KIAorCS8qIFJUIC0gZm9yIGRyYmRfZ2V0X21heF9jYXBh
Y2l0eSgpIERSQkRfTURfSU5ERVhfRkxFWF9JTlQgKi8KKwlkcmJkX21kX3NldF9zZWN0b3Jfb2Zm
c2V0cyhtZGV2LCBuYmMpOworCiAJaWYgKGRyYmRfZ2V0X21heF9jYXBhY2l0eShuYmMpIDwgbmJj
LT5kYy5kaXNrX3NpemUpIHsKKwkJRVJSKCJtYXggY2FwYWNpdHkgJWxsdSBzbWFsbGVyIHRoYW4g
ZGlzayBzaXplICVsbHVcbiIsCisJCQkodW5zaWduZWQgbG9uZyBsb25nKSBkcmJkX2dldF9tYXhf
Y2FwYWNpdHkobmJjKSwKKwkJCSh1bnNpZ25lZCBsb25nIGxvbmcpIG5iYy0+ZGMuZGlza19zaXpl
KTsKIAkJcmV0Y29kZSA9IExERGV2aWNlVG9vU21hbGw7CiAJCWdvdG8gcmVsZWFzZV9iZGV2Ml9m
YWlsOwogCX0K
------=_Part_3227_14172498.1226576504540--
