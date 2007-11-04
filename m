Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C81F2C.34A1F20F"
Date: Sun, 4 Nov 2007 16:46:47 -0500
Message-ID: <342BAC0A5467384983B586A6B0B376710707453A@EXNA.corp.stratus.com>
From: "Graham, Simon" <Simon.Graham@stratus.com>
To: <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] PATCH: Missing state change netlink events
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C81F2C.34A1F20F
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

 <<ava-3834.patch>> We have noticed that not all state changes are being
reported via netlink (as seen with the 'drbdsetup /dev/drbd0 events -a
-u' command) - the reason for this is that the state broadcast is done
in after_state_ch using the _current_ mdev state when it runs - it's
entirely possible for two state changes to occur in quick succession
before the after_state_ch worker runs which results in the same state
being broadcast twice - this is especially a problem if you are looking
to see disk Failed state changes as the state tends to change to Failed
and then to Diskless very quickly, which can result in the Diskless
state being reported twice.

I think the fix is simple - modify the code so that after_state_ch
broadcasts the new state rather than the current state (patch attached)
- I would have removed the passing of mdev completely from
drbd_bcast_state() if it weren't for the fact it is required by the
generated to_tags function. I'm testing this at the moment but it's a
little hard to be sure it's right since this requires fairly tight
timing.

Simon


------_=_NextPart_001_01C81F2C.34A1F20F
Content-Type: application/octet-stream;
	name="ava-3834.patch"
Content-Transfer-Encoding: base64
Content-Description: ava-3834.patch
Content-Disposition: attachment;
	filename="ava-3834.patch"

SW5kZXg6IHNyYy9kcmJkL2RyYmRfbmwuYwo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Ci0tLSBzcmMvZHJiZC9kcmJkX25s
LmMJKHJldmlzaW9uIDIwNjEwKQorKysgc3JjL2RyYmQvZHJiZF9ubC5jCSh3b3JraW5nIGNvcHkp
CkBAIC0xNjg4LDcgKzE2ODgsNyBAQAogCiBhdG9taWNfdCBkcmJkX25sX3NlcSA9IEFUT01JQ19J
TklUKDIpOyAvLyB0d28uCiAKLXZvaWQgZHJiZF9iY2FzdF9zdGF0ZShkcmJkX2RldiAqbWRldikK
K3ZvaWQgZHJiZF9iY2FzdF9zdGF0ZShkcmJkX2RldiAqbWRldiwgZHJiZF9zdGF0ZV90IHN0YXRl
KQogewogCWNoYXIgYnVmZmVyW3NpemVvZihzdHJ1Y3QgY25fbXNnKSsKIAkJICAgIHNpemVvZihz
dHJ1Y3QgZHJiZF9ubF9jZmdfcmVwbHkpKwpAQCAtMTcwMCw3ICsxNzAwLDcgQEAKIAogCS8vIFdB
Uk4oImRyYmRfYmNhc3Rfc3RhdGUoKSBnb3QgY2FsbGVkXG4iKTsKIAotCXRsID0gZ2V0X3N0YXRl
X3RvX3RhZ3MobWRldiwoc3RydWN0IGdldF9zdGF0ZSopJm1kZXYtPnN0YXRlLHRsKTsKKwl0bCA9
IGdldF9zdGF0ZV90b190YWdzKG1kZXYsKHN0cnVjdCBnZXRfc3RhdGUqKSZzdGF0ZSx0bCk7CiAJ
KnRsKysgPSBUVF9FTkQ7IC8qIENsb3NlIHRoZSB0YWcgbGlzdCAqLwogCiAJY25fcmVwbHktPmlk
LmlkeCA9IENOX0lEWF9EUkJEOwpJbmRleDogc3JjL2RyYmQvZHJiZF9tYWluLmMKPT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PQotLS0gc3JjL2RyYmQvZHJiZF9tYWluLmMJKHJldmlzaW9uIDIwNjEwKQorKysgc3JjL2RyYmQv
ZHJiZF9tYWluLmMJKHdvcmtpbmcgY29weSkKQEAgLTg3Miw3ICs4NzIsNyBAQAogCX0KIAogCS8q
IEluZm9ybSB1c2Vyc3BhY2UgYWJvdXQgdGhlIGNoYW5nZS4uLiAqLwotCWRyYmRfYmNhc3Rfc3Rh
dGUobWRldik7CisJZHJiZF9iY2FzdF9zdGF0ZShtZGV2LCBucyk7CiAKIAkvKiBIZXJlIHdlIGhh
dmUgdGhlIGFjdGlvbnMgdGhhdCBhcmUgcGVyZm9ybWVkIGFmdGVyIGEKIAkgICBzdGF0ZSBjaGFu
Z2UuIFRoaXMgZnVuY3Rpb24gbWlnaHQgc2xlZXAgKi8KSW5kZXg6IHNyYy9kcmJkL2RyYmRfaW50
LmgKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PQotLS0gc3JjL2RyYmQvZHJiZF9pbnQuaAkocmV2aXNpb24gMjA2MTApCisr
KyBzcmMvZHJiZC9kcmJkX2ludC5oCSh3b3JraW5nIGNvcHkpCkBAIC0xNDE1LDcgKzE0MTUsNyBA
QAogCiB2b2lkIGRyYmRfbmxfY2xlYW51cCh2b2lkKTsKIGludCBfX2luaXQgZHJiZF9ubF9pbml0
KHZvaWQpOwotdm9pZCBkcmJkX2JjYXN0X3N0YXRlKGRyYmRfZGV2ICptZGV2KTsKK3ZvaWQgZHJi
ZF9iY2FzdF9zdGF0ZShkcmJkX2RldiAqbWRldiwgZHJiZF9zdGF0ZV90IHN0YXRlKTsKIHZvaWQg
ZHJiZF9iY2FzdF9zeW5jX3Byb2dyZXNzKGRyYmRfZGV2ICptZGV2KTsKIHZvaWQgZHJiZF9iY2Fz
dF9zcGxpdF9icmFpbihkcmJkX2RldiAqbWRldixpbnQgZmxhZyk7CiAK

------_=_NextPart_001_01C81F2C.34A1F20F--
