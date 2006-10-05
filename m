Return-Path: <Ernest.Montrose@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C6E8C6.6EBB2A09"
Date: Thu, 5 Oct 2006 17:37:18 -0400
Message-ID: <BD7042533C2F8943A6A4257A9E31C45439C7F6@EXNA.corp.stratus.com>
From: "Montrose, Ernest" <Ernest.Montrose@stratus.com>
To: <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] Cstate stays in "Disconnecting" after Heartbeat link
	down and up
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C6E8C6.6EBB2A09
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi all,
If I do an ifdown and an ifup on the heartbeat link drbd goes into
CS:Disconnecting .  I cannot manually recover until a reboot. Should the
state be "StandAlone" instead? I include a patch that seems to work for
me.

A side question:
Should drbd notice when the link comes up?  He does not seem to.

Thanks.

EM--


------_=_NextPart_001_01C6E8C6.6EBB2A09
Content-Type: application/octet-stream;
	name="drbd_receiver_CS.patch"
Content-Transfer-Encoding: base64
Content-Description: drbd_receiver_CS.patch
Content-Disposition: attachment;
	filename="drbd_receiver_CS.patch"

SW5kZXg6IHRydW5rL2RyYmQvZHJiZF9yZWNlaXZlci5jCj09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KLS0tIHRydW5rL2Ry
YmQvZHJiZF9yZWNlaXZlci5jCShyZXZpc2lvbiA0ODk0KQorKysgdHJ1bmsvZHJiZC9kcmJkX3Jl
Y2VpdmVyLmMJKHdvcmtpbmcgY29weSkKQEAgLTYyNSw3ICs2MjUsNyBAQAogCWlmIChlcnIpIHsK
IAkJRVJSKCJVbmFibGUgdG8gYmluZCBzb2NrMiAoJWQpXG4iLCBlcnIpOwogCQlzb2NrX3JlbGVh
c2Uoc29jazIpOwotCQlkcmJkX2ZvcmNlX3N0YXRlKG1kZXYsTlMoY29ubixEaXNjb25uZWN0aW5n
KSk7CisJCWRyYmRfZm9yY2Vfc3RhdGUobWRldixOUyhjb25uLFN0YW5kQWxvbmUpKTsKIAkJcmV0
dXJuIE5VTEw7CiAJfQogCkBAIC0yODIxLDcgKzI4MjEsNyBAQAogCQl9CiAJCWlmKCBoIDwgMCAp
IHsKIAkJCVdBUk4oIkRpc2NhcmRpbmcgbmV0d29yayBjb25maWd1cmF0aW9uLlxuIik7Ci0JCQlk
cmJkX2ZvcmNlX3N0YXRlKG1kZXYsTlMoY29ubixEaXNjb25uZWN0aW5nKSk7CisJCQlkcmJkX2Zv
cmNlX3N0YXRlKG1kZXYsTlMoY29ubixTdGFuZEFsb25lKSk7CiAJCX0KIAl9IHdoaWxlICggaCA9
PSAwICk7CiAK

------_=_NextPart_001_01C6E8C6.6EBB2A09--
