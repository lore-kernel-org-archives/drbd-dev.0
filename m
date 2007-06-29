Return-Path: <Ernest.Montrose@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C7BA96.26756682"
Date: Fri, 29 Jun 2007 17:40:45 -0400
Message-ID: <BD7042533C2F8943A6A4257A9E31C454F47968@EXNA.corp.stratus.com>
In-Reply-To: 200706261201.44842.philipp.reisner@linbit.com
From: "Montrose, Ernest" <Ernest.Montrose@stratus.com>
To: "Philipp Reisner" <philipp.reisner@linbit.com>, <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] DRBD8: Receive_state() won't dec_local after a disk
	failure on peer.
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C7BA96.26756682
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


Hi all,
We have been seeing a problem where a cluster of two systems, X and Y.
X is Primary and gets a disk fault.  X goes Diskless.
Y now is forced to be Primary.=20
X recovers from the fault.=20
But now Y gets a disk fault and goes Diskless but Stay Primary.
At this point I/O from r0 hangs on Y! =20

A check on /proc/<ip>/wchan for the worker thread reveals that we are
waiting forever for local_cnt to become 0 in after_state_ch(). So the
worker thread will process the Net_read.  What happened is that after
the first failure on X, receive_state() on Y failed to call dec_local().
The pdisk received state is Diskless therefore we won't dec_local(). The
included patch illustrates the problem and attempts to fix it.=20

Thanks.
EM--

------_=_NextPart_001_01C7BA96.26756682
Content-Type: application/octet-stream;
	name="drbd_recv.patch"
Content-Transfer-Encoding: base64
Content-Description: drbd_recv.patch
Content-Disposition: attachment;
	filename="drbd_recv.patch"

SW5kZXg6IGRyYmQvZHJiZF9yZWNlaXZlci5jCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KLS0tIGRyYmQvZHJiZF9yZWNl
aXZlci5jCShyZXZpc2lvbiAxNTkwMSkKKysrIGRyYmQvZHJiZF9yZWNlaXZlci5jCSh3b3JraW5n
IGNvcHkpCkBAIC0yNDA4LDExICsyNDA4LDEyIEBACiAJaWYgKG5jb25uID09IFdGUmVwb3J0UGFy
YW1zICkgbmNvbm4gPSBDb25uZWN0ZWQ7CiAKIAlpZiAobWRldi0+cF91dWlkICYmIG9jb25uIDw9
IENvbm5lY3RlZCAmJgotCSAgICBpbmNfbG9jYWxfaWZfc3RhdGUobWRldixOZWdvdGlhdGluZykg
JiYKIAkgICAgcGVlcl9zdGF0ZS5kaXNrID49IE5lZ290aWF0aW5nKSB7Ci0JCW5jb25uPWRyYmRf
c3luY19oYW5kc2hha2UobWRldixwZWVyX3N0YXRlLnJvbGUscGVlcl9zdGF0ZS5kaXNrKTsKLQkJ
ZGVjX2xvY2FsKG1kZXYpOwotCisgICAgICAgICAgaWYoaW5jX2xvY2FsX2lmX3N0YXRlKG1kZXYs
TmVnb3RpYXRpbmcpKSB7CisgICAgICAgICAgICAgbmNvbm49ZHJiZF9zeW5jX2hhbmRzaGFrZSht
ZGV2LHBlZXJfc3RhdGUucm9sZSxwZWVyX3N0YXRlLmRpc2spOworICAgICAgICAgICAgIGRlY19s
b2NhbChtZGV2KTsKKyAgICAgICAgICB9CisgICAgICAgICAgCiAJCWlmKG5jb25uID09IGNvbm5f
bWFzaykgcmV0dXJuIEZBTFNFOwogCX0KIAo=

------_=_NextPart_001_01C7BA96.26756682--
