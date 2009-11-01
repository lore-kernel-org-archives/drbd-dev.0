Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01CA5B42.410C1EFA"
Date: Sun, 1 Nov 2009 17:25:44 -0500
Message-ID: <BC2F8964429F14468EA0E6D6CF00E8C9390D66@EXHQ.corp.stratus.com>
From: "Graham, Simon" <Simon.Graham@stratus.com>
To: <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] Primary/Diskless node cannot reconnect
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01CA5B42.410C1EFA
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

If you are in a situation where one node is Primary/Diskless and the
other Secondary/UpToDate, DRDB works just fine, redirecting the I/O to
the secondary node. However, if you then lose the network connection for
any reasons (say some sort of transient issue), DRBD will not allow the
connection to be re-established even though nothing has actually
changed.

When the connect request comes in, you see this trace message:

       Can only connect to data with current UUID=3DXXXXX

Which is output by receive_uuids in drbd_receiver.c. I understand why
this check should be made _if_ you actually have a local disk on the
Primary, but if you are Diskless I think it is not necessary and results
in unnecessary problems. My proposed fix is to add an explicit test for
Diskless in the if statement so that it only does the check for current
UUID if the disk state is > Diskless.

Proposed patch attached against 8.2.
Simon

------_=_NextPart_001_01CA5B42.410C1EFA
Content-Type: application/octet-stream;
	name="primary-diskless-connect.patch"
Content-Transfer-Encoding: base64
Content-Description: primary-diskless-connect.patch
Content-Disposition: attachment;
	filename="primary-diskless-connect.patch"

ZGlmZiAtLWdpdCBhL2RyYmQvZHJiZF9yZWNlaXZlci5jIGIvZHJiZC9kcmJkX3JlY2VpdmVyLmMK
aW5kZXggZTVlNDc2OS4uNWZkZWI4NyAxMDA2NDQKLS0tIGEvZHJiZC9kcmJkX3JlY2VpdmVyLmMK
KysrIGIvZHJiZC9kcmJkX3JlY2VpdmVyLmMKQEAgLTI0NTksNiArMjQ1OSw3IEBAIFNUQVRJQyBp
bnQgcmVjZWl2ZV91dWlkcyhzdHJ1Y3QgZHJiZF9jb25mICptZGV2LCBzdHJ1Y3QgRHJiZF9IZWFk
ZXIgKmgpCiAJbWRldi0+cF91dWlkID0gcF91dWlkOwogCiAJaWYgKG1kZXYtPnN0YXRlLmNvbm4g
PCBDb25uZWN0ZWQgJiYKKwkgICAgbWRldi0+c3RhdGUuZGlzayA+IERpc2tsZXNzICYmCiAJICAg
IG1kZXYtPnN0YXRlLmRpc2sgPD0gTmVnb3RpYXRpbmcgJiYKIAkgICAgbWRldi0+c3RhdGUucm9s
ZSA9PSBQcmltYXJ5ICYmCiAJICAgIChtZGV2LT5lZF91dWlkICYgfigodTY0KTEpKSAhPSAocF91
dWlkW0N1cnJlbnRdICYgfigodTY0KTEpKSkgewo=

------_=_NextPart_001_01CA5B42.410C1EFA--
