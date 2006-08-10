Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C6BCB4.EABA20E4"
Subject: RE: [Drbd-dev] Proposed update to packet dumping code
Date: Thu, 10 Aug 2006 15:41:01 -0400
Message-ID: <342BAC0A5467384983B586A6B0B3767103624E6D@EXNA.corp.stratus.com>
From: "Graham, Simon" <Simon.Graham@stratus.com>
To: "Philipp Reisner" <philipp.reisner@linbit.com>, <drbd-dev@lists.linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C6BCB4.EABA20E4
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I found in debugging my problem that I was still getting too much =
output, so I've enhanced the trace a little to enable one to specify =
which devices have their packets traced - I did this by adding a 2nd =
sysfs variable dump_packet_devs which is a bitmap of devices to trace =
(which means you can only trace the first 32 devices -- is that a =
problem for anyone?).

I also fixed up some formatting errors (including fields that are =
meaningless, adding the socket name to the summary trace, tracing =
packets sent with drbd_send_cmd2()).

One other thing in this patch is a bit more tracing in tl_verify() when =
a failure is detected -- you can remove this if you like, but I think =
it's actually useful (more on this in a separate email later!)

Simon


> -----Original Message-----
> From: drbd-dev-bounces@linbit.com [mailto:drbd-dev-bounces@linbit.com]
> On Behalf Of Philipp Reisner
> Sent: Thursday, August 10, 2006 5:40 AM
> To: drbd-dev@linbit.com
> Subject: Re: [Drbd-dev] Proposed update to packet dumping code
>=20
> > Let me know what you think and if anything else should be done.
> > Simon
>=20
> Ok, I have applied the patch to trunk...
>=20
> -Phil
> --
> : Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
> : LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
> : Sch=F6nbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com =
:
> _______________________________________________
> drbd-dev mailing list
> drbd-dev@lists.linbit.com
> http://lists.linbit.com/mailman/listinfo/drbd-dev

------_=_NextPart_001_01C6BCB4.EABA20E4
Content-Type: application/octet-stream;
	name="drbd-trace-update.patch"
Content-Transfer-Encoding: base64
Content-Description: drbd-trace-update.patch
Content-Disposition: attachment;
	filename="drbd-trace-update.patch"

SW5kZXg6IGRyYmRfbWFpbi5jCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KLS0tIGRyYmRfbWFpbi5jCShyZXZpc2lvbiAz
NTA0KQorKysgZHJiZF9tYWluLmMJKHdvcmtpbmcgY29weSkKQEAgLTEzMSw3ICsxMzEsMTIgQEAK
IAkJCS8vIDAgPSBub25lCiAJCQkvLyAxID0gc3VtbWFyeSAodHJhY2UgJ2ludGVyZXN0aW5nJyBw
YWNrZXRzIGluIHN1bW1hcnkgZm10KQogCQkJLy8gMiA9IHZlcmJvc2UgKHRyYWNlIGFsbCBwYWNr
ZXRzIGluIGZ1bGwgZm9ybWF0KQoraW50IGR1bXBfcGFja2V0X2RldnMgPSAwOy8vIGJpdG1hcCBv
ZiBkcmJkIGRldmljZXMgdG8gaGF2ZSB0cmFjaW5nCisJCQkvLyBlbmFibGVkCisKIG1vZHVsZV9w
YXJhbShkdW1wX3BhY2tldHMsaW50LDA2NDQpOworbW9kdWxlX3BhcmFtKGR1bXBfcGFja2V0X2Rl
dnMsaW50LDA2NDQpOworCiAjZW5kaWYKIAogLy8gZGV2ZnMgbmFtZQpAQCAtMzA2LDExICszMTEs
MjEgQEAKIAlobGlzdF9mb3JfZWFjaF9lbnRyeShpLCBuLCBzbG90LCBjb2xpc2lvbikgewogCQlp
ZiAoaT09cmVxKSB7CiAJCQlEX0FTU0VSVChkcmJkX3JlcV9nZXRfc2VjdG9yKGkpID09IHNlY3Rv
cik7CisJCQlpZiAoZHJiZF9yZXFfZ2V0X3NlY3RvcihpKSAhPSBzZWN0b3IpIHsKKwkJCQlFUlIo
InRsX3ZlcmlmeTogZm91bmQgcmVxICVwIGJ1dCBpdCBoYXMgd3Jvbmcgc2VjdG9yICglbGx4IHZl
cnN1cyAlbGx4KVxuIiwKKwkJCQkgICAgcmVxLCAobG9uZyBsb25nKWRyYmRfcmVxX2dldF9zZWN0
b3IoaSksIChsb25nIGxvbmcpc2VjdG9yKTsKKwkJCX0KIAkJCXJ2PTE7CiAJCQlicmVhazsKIAkJ
fQogCX0KIAorCS8vIFJlYWxseSBiZXR0ZXIgZmluZCBpdCEKKwlpZiAoIXJ2KSB7CisJCUVSUigi
dGxfdmVyaWZ5OiBmYWlsZWQgdG8gZmluZCByZXEgJXAsIHNlY3RvciAlbGx4IGluIGxpc3RcbiIs
IAorCQkgICAgcmVxLCAobG9uZyBsb25nKXNlY3Rvcik7CisJfQorCiAJc3Bpbl91bmxvY2tfaXJx
KCZtZGV2LT50bF9sb2NrKTsKIAogCXJldHVybiBydjsKQEAgLTEyOTUsNiArMTMxMCw4IEBACiAK
IAlkb3duKCZtZGV2LT5kYXRhLm11dGV4KTsKIAorCWR1bXBfcGFja2V0KG1kZXYsbWRldi0+ZGF0
YS5zb2NrZXQsMCwodm9pZCopJmgsIF9fRklMRV9fLCBfX0xJTkVfXyk7CisKIAlvayA9ICggc2l6
ZW9mKGgpID09IGRyYmRfc2VuZChtZGV2LG1kZXYtPmRhdGEuc29ja2V0LCZoLHNpemVvZihoKSww
KSApOwogCW9rID0gb2sgJiYgKCBzaXplID09IGRyYmRfc2VuZChtZGV2LG1kZXYtPmRhdGEuc29j
a2V0LGRhdGEsc2l6ZSwwKSApOwogCkBAIC0xNzEzLDcgKzE3MzAsNiBAQAogCXVuc2lnbmVkIGlu
dCBkcF9mbGFncz0wOwogCiAJZG93bigmbWRldi0+ZGF0YS5tdXRleCk7Ci0KIAlwLmhlYWQubWFn
aWMgICA9IEJFX0RSQkRfTUFHSUM7CiAJcC5oZWFkLmNvbW1hbmQgPSBjcHVfdG9fYmUxNihEYXRh
KTsKIAlwLmhlYWQubGVuZ3RoICA9IGNwdV90b19iZTE2KCBzaXplb2YocCktc2l6ZW9mKERyYmRf
SGVhZGVyKQpAQCAtMjkwMywxMSArMjkxOSwxMyBAQAogCWlmIChkdW1wX3BhY2tldHMgPiBEVU1Q
X1NVTU1BUlkpIHsgXAogCQlJTkZPKCIlczolZDogJXMgWyVkXSAlcyAlcyAiIGZtdCAsIFwKIAkJ
ICAgICBmaWxlLCBsaW5lLCBjdXJyZW50LT5jb21tLCBjdXJyZW50LT5waWQsIFwKLQkJICAgICBz
b2NrbmFtZSwgcmVjdj8iPDw8IjoiPj4+IiBcCi0JCSAgICAgLCAjIyBhcmdzICk7IFwKKwkJICAg
ICBzb2NrbmFtZSwgcmVjdj8iPDw8IjoiPj4+IiwgXAorCQkgICAgICMjIGFyZ3MgKTsgXAogCX0g
XAogCWVsc2UgeyBcCi0JCUlORk8oIiVzICIgZm10LCByZWN2PyI8PDwiOiI+Pj4iLCAjIyBhcmdz
ICk7IFwKKwkJSU5GTygiJXMgJXMgIiBmbXQsIHNvY2tuYW1lLCBcCisJCSAgICAgcmVjdj8iPDw8
IjoiPj4+IiwgXAorCQkgICAgICMjIGFyZ3MgKTsgXAogCX0gXAogfSB3aGlsZSAoMCkKIApAQCAt
MjkyOSw4ICsyOTQ3LDYgQEAKIAkJYnJlYWs7CiAKIAljYXNlIERhdGE6Ci0JY2FzZSBEYXRhUmVw
bHk6Ci0JY2FzZSBSU0RhdGFSZXBseToKIAkJSU5GT1AoIiVzIChzZWN0b3IgJWxseCwgaWQgJWxs
eCwgc2VxICV4LCBmICV4KVxuIiwgY21kbmFtZShjbWQpLAogCQkgICAgIChsb25nIGxvbmcpYmU2
NF90b19jcHUocC0+RGF0YS5zZWN0b3IpLCAKIAkJICAgICAobG9uZyBsb25nKWJlNjRfdG9fY3B1
KHAtPkRhdGEuYmxvY2tfaWQpLApAQCAtMjkzOSw2ICsyOTU1LDE0IEBACiAJCSk7CiAJCWJyZWFr
OwogCisJY2FzZSBEYXRhUmVwbHk6CisJY2FzZSBSU0RhdGFSZXBseToKKwkJSU5GT1AoIiVzIChz
ZWN0b3IgJWxseCwgaWQgJWxseClcbiIsIGNtZG5hbWUoY21kKSwKKwkJICAgICAobG9uZyBsb25n
KWJlNjRfdG9fY3B1KHAtPkRhdGEuc2VjdG9yKSwgCisJCSAgICAgKGxvbmcgbG9uZyliZTY0X3Rv
X2NwdShwLT5EYXRhLmJsb2NrX2lkKQorCQkpOworCQlicmVhazsKKwogCWNhc2UgUmVjdkFjazoK
IAljYXNlIFdyaXRlQWNrOgogCWNhc2UgTmVnQWNrOgpJbmRleDogZHJiZF9pbnQuaAo9PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09Ci0tLSBkcmJkX2ludC5oCShyZXZpc2lvbiAzNTA0KQorKysgZHJiZF9pbnQuaAkod29ya2lu
ZyBjb3B5KQpAQCAtMTYxOSw5ICsxNjE5LDEwIEBACiAjaWZkZWYgRFVNUF9FQUNIX1BBQ0tFVAog
CiAvKgotICogdmFyaWFibGUgdGhhdCBjb250cm9scyBkdW1waW5nCisgKiB2YXJpYWJsZXMgdGhh
dCBjb250cm9scyBkdW1waW5nCiAgKi8KIGV4dGVybiBpbnQgZHVtcF9wYWNrZXRzOworZXh0ZXJu
IGludCBkdW1wX3BhY2tldF9kZXZzOyAKIAogI2RlZmluZSBEVU1QX05PTkUgMAogI2RlZmluZSBE
VU1QX1NVTU1BUlkgMQpAQCAtMTYzOCw3ICsxNjM5LDggQEAKIGR1bXBfcGFja2V0KGRyYmRfZGV2
ICptZGV2LCBzdHJ1Y3Qgc29ja2V0ICpzb2NrLAogCSAgICBpbnQgcmVjdiwgRHJiZF9Qb2x5bW9y
cGhfUGFja2V0ICpwLCBjaGFyKiBmaWxlLCBpbnQgbGluZSkKIHsKLQlpZiAoZHVtcF9wYWNrZXRz
ID4gRFVNUF9OT05FKQorCWlmIChkdW1wX3BhY2tldHMgPiBEVU1QX05PTkUgJiYKKwkgICAgKCAo
IDEgPDwgKGludCkobWRldi1kcmJkX2NvbmYpKSAmIGR1bXBfcGFja2V0X2RldnMpICkKIAkJX2R1
bXBfcGFja2V0KG1kZXYsc29jayxyZWN2LHAsZmlsZSxsaW5lKTsKIH0KICNlbHNlCg==

------_=_NextPart_001_01C6BCB4.EABA20E4--
