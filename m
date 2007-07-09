Return-Path: <Ernest.Montrose@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C7C23D.55883FA4"
Date: Mon, 9 Jul 2007 11:25:08 -0400
Message-ID: <BD7042533C2F8943A6A4257A9E31C454F47973@EXNA.corp.stratus.com>
In-Reply-To: BD7042533C2F8943A6A4257A9E31C454F4796C@EXNA.corp.stratus.com
From: "Montrose, Ernest" <Ernest.Montrose@stratus.com>
To: "Philipp Reisner" <philipp.reisner@linbit.com>, <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] DRBD8: An attach after a disk fault on the sync target
	causes a deadlock in WFBitMapT
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C7C23D.55883FA4
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


Hi all,
We are seeing a problem where while syncing if the sync target detaches
then attempts to attach, both nodes end up in cs:WABitMapT state.  This
happens if both nodes where in Secondary/Secondary state and the dettach
happened on the SyncTarget.

I think what's happening is that the syncsource is losing the fact that
the synctarget is out of date.  After_state_ch() clears that fact out. I
am not  sure that the included patch is the proper fix for this but it
will illustrates the issue.=20

Thanks,

EM--

------_=_NextPart_001_01C7C23D.55883FA4
Content-Type: application/octet-stream;
	name="wbitmat.patch"
Content-Transfer-Encoding: base64
Content-Description: wbitmat.patch
Content-Disposition: attachment;
	filename="wbitmat.patch"

SW5kZXg6IGRyYmQvZHJiZF9yZWNlaXZlci5jCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KLS0tIGRyYmQvZHJiZF9yZWNl
aXZlci5jCShyZXZpc2lvbiAxNTk5NSkKKysrIGRyYmQvZHJiZF9yZWNlaXZlci5jCSh3b3JraW5n
IGNvcHkpCkBAIC0xOTU2LDcgKzE5NTYsOCBAQAogCX0KIAogCWlmKCAobXlkaXNrPT1JbmNvbnNp
c3RlbnQgJiYgcGVlcl9kaXNrPkluY29uc2lzdGVudCkgfHwKLQkgICAgKHBlZXJfZGlzaz09SW5j
b25zaXN0ZW50ICYmIG15ZGlzaz5JbmNvbnNpc3RlbnQpICkgIHsKKwkgICAgKHBlZXJfZGlzaz09
SW5jb25zaXN0ZW50ICYmIG15ZGlzaz5JbmNvbnNpc3RlbnQpIHx8CisgICAgICAgICAgIChkcmJk
X21kX3Rlc3RfZmxhZyhtZGV2LT5iYyxNREZfUGVlck91dERhdGVkKSAmJiBteWRpc2s+SW5jb25z
aXN0ZW50KSkgIHsKIAkJaW50IGYgPSAoaGcgPT0gLTEwMCkgfHwgYWJzKGhnKSA9PSAyOwogCQlo
ZyA9IG15ZGlzayA+IEluY29uc2lzdGVudCA/IDEgOiAtMTsKIAkJaWYoZikgaGc9aGcqMjsKSW5k
ZXg6IGRyYmQvZHJiZF9tYWluLmMKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQotLS0gZHJiZC9kcmJkX21haW4uYwkocmV2
aXNpb24gMTU5OTUpCisrKyBkcmJkL2RyYmRfbWFpbi5jCSh3b3JraW5nIGNvcHkpCkBAIC04NjMs
NyArODYzLDggQEAKIAkJaWYgKG1kZXYtPnN0YXRlLmRpc2sgPiBJbmNvbnNpc3RlbnQpICAgbWRm
IHw9IE1ERl9Db25zaXN0ZW50OwogCQlpZiAobWRldi0+c3RhdGUuZGlzayA+IE91dGRhdGVkKSAg
ICAgICBtZGYgfD0gTURGX1dhc1VwVG9EYXRlOwogCQlpZiAobWRldi0+c3RhdGUucGRzayA8PSBP
dXRkYXRlZCAmJgotCQkgICAgbWRldi0+c3RhdGUucGRzayA+PSBJbmNvbnNpc3RlbnQpICBtZGYg
fD0gTURGX1BlZXJPdXREYXRlZDsKKwkJICAgIChtZGV2LT5zdGF0ZS5wZHNrID49IEluY29uc2lz
dGVudCB8fAorICAgICAgICAgICAgICAgICAgIG1kZXYtPnN0YXRlLnBkc2sgPT0gRGlza2xlc3Mp
KSAgbWRmIHw9IE1ERl9QZWVyT3V0RGF0ZWQ7CiAJCWlmKCBtZGYgIT0gbWRldi0+YmMtPm1kLmZs
YWdzKSB7CiAJCQltZGV2LT5iYy0+bWQuZmxhZ3MgPSBtZGY7CiAJCQlkcmJkX21kX21hcmtfZGly
dHkobWRldik7Cg==

------_=_NextPart_001_01C7C23D.55883FA4--
