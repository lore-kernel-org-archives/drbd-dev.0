Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C72384.ABA59598"
Date: Tue, 19 Dec 2006 10:45:04 -0500
Message-ID: <342BAC0A5467384983B586A6B0B3767104464575@EXNA.corp.stratus.com>
From: "Graham, Simon" <Simon.Graham@stratus.com>
To: <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] DRBD-8: Patch to fix incorrect split-brain occurrence.
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C72384.ABA59598
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

In testing, we have run into a case where we unexpectedly get a
split-brain situation - after some investigation I think I have found
the reason - at the end of syncing, the SyncTarget side finishes up by
setting it's UUID info to the same as the Source (in
drbd_resync_finished) - the code that does this checks for connection
state SyncTarget before doing this.=20

Now, I have seen that sometimes the resync completes when in PausedSyncT
state - for example, if the last set of blocks is already under way when
we decide to go into the PausedSyncT state - thus it's entirely possible
to enter drbd_resync_finished with connection state PausedSyncT in which
case we do finish up the resync but do not copy the UUID info - this
means that the next time we need to resync, the code determines that we
have a split-brain situation.

In other places in the code, checks are made for either SyncTarget or
PausedSyncT so I propose fixing this (patch attached) the same way -
have drbd_resync_finished check for either SyncTarget OR PausedSyncT.

Simon


------_=_NextPart_001_01C72384.ABA59598
Content-Type: application/octet-stream;
	name="drbd-resync.patch"
Content-Transfer-Encoding: base64
Content-Description: drbd-resync.patch
Content-Disposition: attachment;
	filename="drbd-resync.patch"

SW5kZXg6IHNyYy9kcmJkL2RyYmRfd29ya2VyLmMKPT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQotLS0gc3JjL2RyYmQvZHJi
ZF93b3JrZXIuYwkocmV2aXNpb24gNzkzMikKKysrIHNyYy9kcmJkL2RyYmRfd29ya2VyLmMJKHdv
cmtpbmcgY29weSkKQEAgLTQwMiw3ICs0MDIsOCBAQAogCWlmIChtZGV2LT5yc19mYWlsZWQpIHsK
IAkJSU5GTygiICAgICAgICAgICAgJWx1IGZhaWxlZCBibG9ja3NcbiIsbWRldi0+cnNfZmFpbGVk
KTsKIAotCQlpZiAobWRldi0+c3RhdGUuY29ubiA9PSBTeW5jVGFyZ2V0KSB7CisJCWlmIChtZGV2
LT5zdGF0ZS5jb25uID09IFN5bmNUYXJnZXQgfHwgCisJCSAgICBtZGV2LT5zdGF0ZS5jb25uID09
IFBhdXNlZFN5bmNUKSB7CiAJCQlkc3RhdGUgPSBJbmNvbnNpc3RlbnQ7CiAJCQlwZHN0YXRlID0g
VXBUb0RhdGU7CiAJCX0gZWxzZSB7CkBAIC00MTIsNyArNDEzLDggQEAKIAl9IGVsc2UgewogCQlk
c3RhdGUgPSBwZHN0YXRlID0gVXBUb0RhdGU7CiAKLQkJaWYgKCBtZGV2LT5zdGF0ZS5jb25uID09
IFN5bmNUYXJnZXQpIHsKKwkJaWYgKCBtZGV2LT5zdGF0ZS5jb25uID09IFN5bmNUYXJnZXQgfHwg
CisJCSAgICAgbWRldi0+c3RhdGUuY29ubiA9PSBQYXVzZWRTeW5jVCkgewogCQkJaWYoIG1kZXYt
PnBfdXVpZCApIHsKIAkJCQlpbnQgaTsKIAkJCQlmb3IgKCBpPUJpdG1hcCA7IGk8PUhpc3Rvcnlf
ZW5kIDsgaSsrICkgewo=

------_=_NextPart_001_01C72384.ABA59598--
