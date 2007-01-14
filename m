Return-Path: <Lars.Ellenberg@linbit.com>
Received: from soda (unknown [86.59.100.100])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 6BADF2D9DA9F
	for <drbd-dev@lists.linbit.com>; Mon, 15 Jan 2007 08:40:40 +0100 (CET)
Resent-Message-ID: <20070115074041.GC8577@soda.linbit>
Received: from squawk.glines.org (squawk.glines.org [72.36.206.66])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id BED5E2D9DECE
	for <drbd-dev@lists.linbit.com>; Sun, 14 Jan 2007 18:18:50 +0100 (CET)
Received: from [10.1.0.9] (adsl-75-28-77-94.dsl.scrm01.sbcglobal.net
	[75.28.77.94])
	by squawk.glines.org (Postfix) with ESMTP id 1B609CC398
	for <drbd-dev@lists.linbit.com>; Sun, 14 Jan 2007 09:18:48 -0800 (PST)
Message-ID: <45AA65F4.90709@glines.org>
Date: Sun, 14 Jan 2007 09:18:44 -0800
From: Mark Glines <mark@glines.org>
MIME-Version: 1.0
To: drbd-dev@lists.linbit.com
Content-Type: multipart/mixed; boundary="------------030808040602000605080801"
Subject: [Drbd-dev] drbd-svn can't handle modular hmac,
	and crashes if hash can't be found
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

This is a multi-part message in MIME format.
--------------030808040602000605080801
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

A few minor issues.

1.  CONFIG_CRYPTO_HMAC can be defined as a module; the drbd code 
currently requires it to be built into the kernel, apparently for no 
good reason.

2.  If the hash algorithm itself isn't available (like sha1.ko wasn't 
loaded yet), crypto_alloc_hash() returns -ENOENT.  It does not return 
NULL, which is what the drbd code currently checks for.  This leads to 
crashes later.

3.  Once #2 is fixed, the user tools try to report the error, and the 
error message contains a typo, an extra ")".  "Failure: (120) The 
'cram-hmac-alg' you specified is not known in )the kernel."  It also 
doesn't tell the user what to do to fix it.

The attached patch fixes the above issues, and applies cleanly to your 
current svn.  Please review and apply.

Mark

P.S.  Since drbd no longer requires any exported symbols from the 
hmac/hash module, is there any reason to check CONFIG_CRYPTO_HMAC at 
all?  A simpler check on CONFIG_CRYPTO to make sure the basic API exists 
should be all you need...

--------------030808040602000605080801
Content-Type: text/plain;
 name="drbd-hmac-fixes.diff"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="drbd-hmac-fixes.diff"

SW5kZXg6IGRyYmQvZHJiZF9yZWNlaXZlci5jCj09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KLS0tIGRyYmQvZHJi
ZF9yZWNlaXZlci5jCShyZXZpc2lvbiAyNjg3KQorKysgZHJiZC9kcmJkX3JlY2VpdmVyLmMJ
KHdvcmtpbmcgY29weSkKQEAgLTI4OTQsNyArMjg5NCw3IEBACiAJcmV0dXJuIDA7CiB9CiAK
LSNpZm5kZWYgQ09ORklHX0NSWVBUT19ITUFDCisjaWYgIWRlZmluZWQoQ09ORklHX0NSWVBU
T19ITUFDKSAmJiAhZGVmaW5lZChDT05GSUdfQ1JZUFRPX0hNQUNfTU9EVUxFKQogU1RBVElD
IGludCBkcmJkX2RvX2F1dGgoZHJiZF9kZXYgKm1kZXYpCiB7CiAJRVJSKCAiVGhpcyBrZXJu
ZWwgd2FzIGJ1aWxkIHdpdGhvdXQgQ09ORklHX0NSWVBUT19ITUFDLlxuIik7CkluZGV4OiBk
cmJkL2RyYmRfbmwuYwo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09Ci0tLSBkcmJkL2RyYmRfbmwuYwkocmV2aXNp
b24gMjY4NykKKysrIGRyYmQvZHJiZF9ubC5jCSh3b3JraW5nIGNvcHkpCkBAIC0xMDUyLDcg
KzEwNTIsOCBAQAogCWlmKCBuZXdfY29uZi0+Y3JhbV9obWFjX2FsZ1swXSAhPSAwKSB7CiAJ
CXNucHJpbnRmKGhtYWNfbmFtZSxITUFDX05BTUVfTCwiaG1hYyglcykiLG5ld19jb25mLT5j
cmFtX2htYWNfYWxnKTsKIAkJdGZtID0gY3J5cHRvX2FsbG9jX2hhc2goaG1hY19uYW1lLCAw
LCBDUllQVE9fQUxHX0FTWU5DKTsKLQkJaWYgKHRmbSA9PSBOVUxMKSB7CisJCWlmIChJU19F
UlIodGZtKSkgeworCQkJdGZtID0gTlVMTDsKIAkJCXJldGNvZGU9Q1JBTUFsZ05vdEF2YWls
OwogCQkJZ290byBmYWlsOwogCQl9CkluZGV4OiB1c2VyL2RyYmRzZXR1cC5jCj09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT0KLS0tIHVzZXIvZHJiZHNldHVwLmMJKHJldmlzaW9uIDI2ODcpCisrKyB1c2VyL2Ry
YmRzZXR1cC5jCSh3b3JraW5nIGNvcHkpCkBAIC0zNTksOCArMzU5LDggQEAKIAlFTShNRElP
RXJyb3IpID0gIklPIGVycm9yKHMpIG9ycnVjZWQgZHVyaW5nIGluaXRpYWwgYWNjZXNzIHRv
IG1ldGEtZGF0YS5cbiIsCiAJRU0oTURJbnZhbGlkKSA9ICJObyB2YWxpZCBtZXRhLWRhdGEg
c2lnbmF0dXJlIGZvdW5kLlxuKSIKIAkiVXNlICdkcmJkYWRtIGNyZWF0ZS1tZCByZXMnIHRv
IGluaXRpYWxpemUgbWV0YS1kYXRhIGFyZWEuXG4iLAotCUVNKENSQU1BbGdOb3RBdmFpbCkg
PSAiVGhlICdjcmFtLWhtYWMtYWxnJyB5b3Ugc3BlY2lmaWVkIGlzIG5vdCBrbm93biBpbiAp
IgotCSJ0aGUga2VybmVsLlxuIiwKKwlFTShDUkFNQWxnTm90QXZhaWwpID0gIlRoZSAnY3Jh
bS1obWFjLWFsZycgeW91IHNwZWNpZmllZCBpcyBub3Qga25vd24gaW4gIgorCSJ0aGUga2Vy
bmVsLiAobWF5YmUgeW91IG5lZWQgdG8gbW9kcHJvYmUgaXQsIG9yIG1vZHByb2JlIGhtYWM/
KVxuIiwKIAlFTShDUkFNQWxnTm90RGlnZXN0KSA9ICJUaGUgJ2NyYW0taG1hYy1hbGcnIHlv
dSBzcGVjaWZpZWQgaXMgbm90IGEgZGlnZXN0LiIsCiAJRU0oS01hbGxvY0ZhaWxlZCkgPSAi
a21hbGxvYygpIGZhaWxlZC4gT3V0IG9mIG1lbW9yeT8iLAogCUVNKERpc2NhcmROb3RBbGxv
d2VkKSA9ICItLWRpc2NhcmQtbXktZGF0YSBub3QgYWxsb3dlZCB3aGVuIHByaW1hcnkuIiwK

--------------030808040602000605080801--

