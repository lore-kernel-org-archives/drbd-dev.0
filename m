Return-Path: <Simon.Graham@stratus.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01CA5B40.EA3001A1"
Content-class: urn:content-classes:message
Date: Sun, 1 Nov 2009 17:16:07 -0500
Message-ID: <BC2F8964429F14468EA0E6D6CF00E8C9390D65@EXHQ.corp.stratus.com>
From: "Graham, Simon" <Simon.Graham@stratus.com>
To: <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] DRBD does not always send UnplugRemote when it should
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01CA5B40.EA3001A1
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

In looking at DRBD performance, I noticed that DRBD does not always send
an UnplugRemote command when (I think) it should - I believe this is
because it uses the mdev UNPLUG_REMOTE flag to control whether or not
the command would be helpful and this flag is set in the worker thread
as part of actually sending the data packet.

This means that an unplug call can be made from above between the time
the bio is submitted and the time the worker thread starts processing it
- this call will be ignored because the flag it not set yet.
Subsequently, the flag gets set but it's too late by then and you can
see a very long delay on the secondary until the unplug timeout expires
there.

I think the fix is to set the flag in the queue_for_net_write action in
_req_mod - this is called inline with the bio so the flag will be set
before the unplug routine is called.

Proposed patch against 8.2 attached.
Simon


------_=_NextPart_001_01CA5B40.EA3001A1
Content-Type: application/octet-stream;
	name="unplug-remote.patch"
Content-Transfer-Encoding: base64
Content-Description: unplug-remote.patch
Content-Disposition: attachment;
	filename="unplug-remote.patch"

ZGlmZiAtLWdpdCBhL2RyYmQvZHJiZF9tYWluLmMgYi9kcmJkL2RyYmRfbWFpbi5jCmluZGV4IDk0
M2VmMGIuLmNjZjJlMTcgMTAwNjQ0Ci0tLSBhL2RyYmQvZHJiZF9tYWluLmMKKysrIGIvZHJiZC9k
cmJkX21haW4uYwpAQCAtMjAyMyw3ICsyMDIzLDYgQEAgaW50IGRyYmRfc2VuZF9kYmxvY2soc3Ry
dWN0IGRyYmRfY29uZiAqbWRldiwgc3RydWN0IGRyYmRfcmVxdWVzdCAqcmVxKQogCXAuZHBfZmxh
Z3MgPSBjcHVfdG9fYmUzMihkcF9mbGFncyk7CiAJZHVtcF9wYWNrZXQobWRldiwgbWRldi0+ZGF0
YS5zb2NrZXQsIDAsICh2b2lkICopJnAsIF9fRklMRV9fLCBfX0xJTkVfXyk7CiAJYmxrX2FkZF90
cmFjZV9iaW8obWRldi0+cnFfcXVldWUsIHJlcS0+bWFzdGVyX2JpbywgQkxLX1RBX0dFVFJRKTsK
LQlzZXRfYml0KFVOUExVR19SRU1PVEUsICZtZGV2LT5mbGFncyk7CiAJb2sgPSAoc2l6ZW9mKHAp
ID09CiAJCWRyYmRfc2VuZChtZGV2LCBtZGV2LT5kYXRhLnNvY2tldCwgJnAsIHNpemVvZihwKSwg
TVNHX01PUkUpKTsKIAlpZiAob2sgJiYgZGdzKSB7CmRpZmYgLS1naXQgYS9kcmJkL2RyYmRfcmVx
LmMgYi9kcmJkL2RyYmRfcmVxLmMKaW5kZXggNzQ1NzEzZS4uNzRmZTkwNSAxMDA2NDQKLS0tIGEv
ZHJiZC9kcmJkX3JlcS5jCisrKyBiL2RyYmQvZHJiZF9yZXEuYwpAQCAtNjYxLDYgKzY2MSw4IEBA
IHZvaWQgX3JlcV9tb2Qoc3RydWN0IGRyYmRfcmVxdWVzdCAqcmVxLCBlbnVtIGRyYmRfcmVxX2V2
ZW50IHdoYXQsIGludCBlcnJvcikKIAkJICoKIAkJICogQWRkIHJlcSB0byB0aGUgKG5vdykgY3Vy
cmVudCBlcG9jaCAoYmFycmllcikuICovCiAKKwkJc2V0X2JpdChVTlBMVUdfUkVNT1RFLCAmbWRl
di0+ZmxhZ3MpOyAvKiBXb3J0aCBzZW5kaW5nIHVucGx1ZyB3aGVuIGhpZ2hlciBsYXllciB1bnBs
dWdzICovCisKIAkJLyogc2VlIGRyYmRfbWFrZV9yZXF1ZXN0X2NvbW1vbiwKIAkJICoganVzdCBh
ZnRlciBpdCBncmFicyB0aGUgcmVxX2xvY2sgKi8KIAkJRF9BU1NFUlQodGVzdF9iaXQoQ1JFQVRF
X0JBUlJJRVIsICZtZGV2LT5mbGFncykgPT0gMCk7Cg==

------_=_NextPart_001_01CA5B40.EA3001A1--
