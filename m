Return-Path: <Ernest.Montrose@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C86DD2.CC0AEE27"
Date: Tue, 12 Feb 2008 18:55:51 -0500
Message-ID: <BD7042533C2F8943A6A4257A9E31C454F47AC0@EXNA.corp.stratus.com>
In-Reply-To: 200801291437.06285.philipp.reisner@linbit.com
References: <342BAC0A5467384983B586A6B0B3767107E8A3F8@EXNA.corp.stratus.com>
	200801291437.06285.philipp.reisner@linbit.com
From: "Montrose, Ernest" <Ernest.Montrose@stratus.com>
To: "Philipp Reisner" <philipp.reisner@linbit.com>, <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] Stuck in WFBitMapS again
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C86DD2.CC0AEE27
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


It looks like we still have a race condition while finishing syncing and
pausing/resuming syncing at the same time.=20

What's happening is that we finish syncing.
The secondary side goes to Connected at the end of
drbd_resync_finished()

The Primary side is still in drbd_resync_finished().  While still there,

the syncer isp flag gets set and unset due to a higher priority device
syncer getting paused/resumed.

Now the Primary side sends "Inconsistent" state to the Secondary since
we are still in drbd_resync_finished()
and have not gone Connected and UptoDate yet. But the other side is
connected and UpToDate though.

The secondary goes WFBitMapS via drbd_sync_handshake()

In the mean time the Primary finally goes Connected and UptoDate.

The Secondary is stuck in WFBitMapS.

I include a patch that may be the fix for this.  Any other ideas?

Thanks.
EM--


------_=_NextPart_001_01C86DD2.CC0AEE27
Content-Type: application/octet-stream;
	name="4595.patch"
Content-Transfer-Encoding: base64
Content-Description: 4595.patch
Content-Disposition: attachment;
	filename="4595.patch"

ZGlmZiAtLWdpdCBhL2RyYmQvZHJiZF9yZWNlaXZlci5jIGIvZHJiZC9kcmJkX3JlY2VpdmVyLmMK
aW5kZXggMDQ4YTc1OS4uMTg0ZjZkZiAxMDA2NDQKLS0tIGEvZHJiZC9kcmJkX3JlY2VpdmVyLmMK
KysrIGIvZHJiZC9kcmJkX3JlY2VpdmVyLmMKQEAgLTI0NjcsNiArMjQ2Nyw4IEBAIFNUQVRJQyBp
bnQgcmVjZWl2ZV9zdGF0ZShkcmJkX2RldiAqbWRldiwgRHJiZF9IZWFkZXIgKmgpCiAJCQltZGV2
LT5zdGF0ZS5kaXNrID09IE5lZ290aWF0aW5nKSk7CiAJCWNyIHw9IHRlc3RfYml0KENPTlNJREVS
X1JFU1lOQywmbWRldi0+ZmxhZ3MpOyAvKiBwZWVyIGZvcmNlZCAqLwogCQljciB8PSAob2Nvbm4g
PT0gQ29ubmVjdGVkICYmIHBlZXJfc3RhdGUuY29ubiA+IENvbm5lY3RlZCk7CisgICAgICAgICAg
ICAgICBjciB8PSAoKG9jb25uID09IFdGQml0TWFwUyB8fCBvY29ubiA9PSBXRkJpdE1hcFQpICYm
IAorICAgICAgICAgICAgICAgICAgICAgcGVlcl9zdGF0ZS5kaXNrID09IFVwVG9EYXRlICYmICBt
ZGV2LT5zdGF0ZS5kaXNrID09IFVwVG9EYXRlKTsKIAogCQlpZiAoY3IpIG5jb25uPWRyYmRfc3lu
Y19oYW5kc2hha2UobWRldiwgcGVlcl9zdGF0ZS5yb2xlLCBwZWVyX3N0YXRlLmRpc2spOwogCg==

------_=_NextPart_001_01C86DD2.CC0AEE27--
