Return-Path: <Ernest.Montrose@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C701FD.F01ACF51"
Date: Mon, 6 Nov 2006 18:47:36 -0500
Message-ID: <BD7042533C2F8943A6A4257A9E31C45439C826@EXNA.corp.stratus.com>
From: "Montrose, Ernest" <Ernest.Montrose@stratus.com>
To: "Graham, Simon" <Simon.Graham@stratus.com>,
	<drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] DRBD8: Split-brain false positive on Primary/primary
	potential patch
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C701FD.F01ACF51
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

When running Primary/Primary if the Heartbeat connection goes down when
we recover we always split brain.  Simon had an idea which I have
implemented. He is on vacation  so this may not reflect his exact idea.

Essentially with this change, we do not create a new current UUID on the
node unless I/O is seen. This prevent Split-Brain mitigation when both
nodes are primary but only one node is originating I/O and never the
other.  He is only stand-by in that case.

Take a look and let me know.

EM--

------_=_NextPart_001_01C701FD.F01ACF51
Content-Type: application/octet-stream;
	name="anti_spli_brain.patch"
Content-Transfer-Encoding: base64
Content-Description: anti_spli_brain.patch
Content-Disposition: attachment;
	filename="anti_spli_brain.patch"

SW5kZXg6IHRydW5rL2RyYmQvZHJiZF9hY3Rsb2cuYwo9PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Ci0tLSB0cnVuay9kcmJk
L2RyYmRfYWN0bG9nLmMJKHJldmlzaW9uIDYxNTIpCisrKyB0cnVuay9kcmJkL2RyYmRfYWN0bG9n
LmMJKHdvcmtpbmcgY29weSkKQEAgLTI1OSw2ICsyNTksMTQgQEAKIAkJc3Bpbl91bmxvY2tfaXJx
KCZtZGV2LT5hbF9sb2NrKTsKIAkJd2FrZV91cCgmbWRldi0+YWxfd2FpdCk7CiAJfQorCisgICBp
ZiAobWRldi0+c3RhdGUucm9sZSA9PSBQcmltYXJ5ICYmIAorICAgICAgIG1kZXYtPmJjLT5tZC51
dWlkW0JpdG1hcF0gPT0gMCAmJiAgIAorICAgICAgIG1kZXYtPnN0YXRlLmNvbm4gPT0gU3RhbmRB
bG9uZSkgeworICAgICAgLyogT25seSBkbyBpdCBpZiB3ZSBoYXZlIG5vdCB5ZXQgZG9uZSBpdC4u
LiAqLworICAgICAgZHJiZF91dWlkX25ld19jdXJyZW50KG1kZXYpOworICAgfQorICAKIH0KIAog
dm9pZCBkcmJkX2FsX2NvbXBsZXRlX2lvKHN0cnVjdCBEcmJkX0NvbmYgKm1kZXYsIHNlY3Rvcl90
IHNlY3RvcikKSW5kZXg6IHRydW5rL2RyYmQvZHJiZF9tYWluLmMKPT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQotLS0gdHJ1
bmsvZHJiZC9kcmJkX21haW4uYwkocmV2aXNpb24gNjE1MikKKysrIHRydW5rL2RyYmQvZHJiZF9t
YWluLmMJKHdvcmtpbmcgY29weSkKQEAgLTkwMCwxMSArOTAwLDYgQEAKIAkJCW1kZXYtPnBfdXVp
ZCA9IE5VTEw7CiAJCX0KIAkJaWYgKGluY19sb2NhbChtZGV2KSkgewotCQkJaWYgKG5zLnJvbGUg
PT0gUHJpbWFyeSAmJiBtZGV2LT5iYy0+bWQudXVpZFtCaXRtYXBdID09IDAgKSB7Ci0JCQkJLyog
T25seSBkbyBpdCBpZiB3ZSBoYXZlIG5vdCB5ZXQgZG9uZSBpdC4uLiAqLwotCQkJCUlORk8oIkNy
ZWF0aW5nIG5ldyBjdXJyZW50IFVVSURcbiIpOwotCQkJCWRyYmRfdXVpZF9uZXdfY3VycmVudCht
ZGV2KTsKLQkJCX0KIAkJCWlmIChucy5wZWVyID09IFByaW1hcnkgKSB7IAogCQkJCS8qIE5vdGU6
IFRoZSBjb25kaXRpb24gbnMucGVlciA9PSBQcmltYXJ5IGltcGxpZXMKIAkJCQkgICB0aGF0IHdl
IGFyZSBjb25uZWN0ZWQuIE90aGVyd2lzZSBpdCB3b3VsZAo=

------_=_NextPart_001_01C701FD.F01ACF51--
