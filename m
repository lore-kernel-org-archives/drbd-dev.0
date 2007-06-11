Return-Path: <Ernest.Montrose@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C7AC65.86EFBC03"
Date: Mon, 11 Jun 2007 16:17:25 -0400
Message-ID: <BD7042533C2F8943A6A4257A9E31C454F4792B@EXNA.corp.stratus.com>
In-Reply-To: 200706081151.04454.philipp.reisner@linbit.com
From: "Montrose, Ernest" <Ernest.Montrose@stratus.com>
To: "Philipp Reisner" <philipp.reisner@linbit.com>, <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] DRBD8: Panic in drbd_uuid_compare due to mdev->bc being
	null
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C7AC65.86EFBC03
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi all,

We are seeing a panic that occurs while syncing.  Essentially if you are
primary and you are syncing and get an io error then on the next attach
you can panic.  Especially if that attach happens quickly after the
detach.

I think what's happening is this:
* The local disk dies and we transiton to "Diskless"
* After_state_ch() suppose to call drbd_free_bc() to free mdev->bc.
* But before we can free mdev->bc, mdev->local_cnt would have to be 0,
in this case it was not.  Not too sure why. So we wait for
mdev->local_cnt to become 0.
* While waiting an "Attach" request comes in. We ASSERT that mdev->bc is
not NULL but we brush it off, set a new bc and leak the old.
* The wait in after_state_ch is now over. we free the new mdev->bc that
the "attach" had set.
* we call drbd_sync_handshake(), access a NULL mdev->bc and we die.

A quick thing to do is to just fail the attach request if mdev->bc is
not null. Patch included

EM--

------_=_NextPart_001_01C7AC65.86EFBC03
Content-Type: application/octet-stream;
	name="drbd_nl.patch"
Content-Transfer-Encoding: base64
Content-Description: drbd_nl.patch
Content-Disposition: attachment;
	filename="drbd_nl.patch"

SW5kZXg6IGRyYmQvZHJiZF9ubC5jCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KLS0tIGRyYmQvZHJiZF9ubC5jCShyZXZp
c2lvbiAxNDk4MSkKKysrIGRyYmQvZHJiZF9ubC5jCSh3b3JraW5nIGNvcHkpCkBAIC02NzYsNyAr
Njc2LDcgQEAKIAlzdHJ1Y3QgaW5vZGUgKmlub2RlLCAqaW5vZGUyOwogCXN0cnVjdCBscnVfY2Fj
aGUqIHJlc3luY19scnUgPSBOVUxMOwogCWRyYmRfc3RhdGVfdCBucyxvczsKLQlpbnQgcnY7CisJ
aW50IHJ2LG50cmllcz0wOwogCiAJLyogaWYgeW91IHdhbnQgdG8gcmVjb25maWd1cmUsIHBsZWFz
ZSB0ZWFyIGRvd24gZmlyc3QgKi8KIAlpZiAobWRldi0+c3RhdGUuZGlzayA+IERpc2tsZXNzKSB7
CkBAIC02ODQsNiArNjg0LDIzIEBACiAJCWdvdG8gZmFpbDsKIAl9CiAKKyAgICAgICAvKiAKKyAg
ICAgICAgKiBXZSBtYXkgaGF2ZSBnb3R0ZW4gaGVyZSB2ZXJ5IHF1aWNrbHkgZnJvbSBhIGRldGFj
aC4gV2FpdCBmb3IgYSBiaXQKKyAgICAgICAgKiB0aGVuIGZhaWwuCisgICAgICAgICovCisgICAg
ICAgd2hpbGUobWRldi0+YmMgIT0gTlVMTCAmJiBudHJpZXMgPD0gNSkgeworICAgICAgICAgIGlm
KG50cmllcyA9PSA1KSAKKyAgICAgICAgICB7CisgICAgICAgICAgICAgV0FSTigiZHJiZF9ubF9k
aXNrX2NvbmY6IG1kZXYtPmJjIG5vdCBOVUxMLiBHaXZpbmcgdXAhXG4iKTsKKyAgICAgICAgICAg
ICByZXRjb2RlPUhhdmVEaXNrQ29uZmlnOworICAgICAgICAgICAgIGdvdG8gZmFpbDsKKyAgICAg
ICAgICB9CisgICAgICAgICAgV0FSTigiZHJiZF9ubF9kaXNrX2NvbmY6IG1kZXYtPmJjIG5vdCBO
VUxMLiBXYWl0aW5nLi5cbiIpOworICAgICAgICAgIHNldF9jdXJyZW50X3N0YXRlKFRBU0tfSU5U
RVJSVVBUSUJMRSk7CisgICAgICAgICAgc2NoZWR1bGVfdGltZW91dChIWi8xMCk7CisgICAgICAg
ICAgKytudHJpZXM7CisgICAgICAgfS8qRW5kIHdoaWxlKi8KKwogCW5iYyA9IGttYWxsb2Moc2l6
ZW9mKHN0cnVjdCBkcmJkX2JhY2tpbmdfZGV2KSxHRlBfS0VSTkVMKTsKIAlpZighbmJjKSB7CiAJ
CXJldGNvZGU9S01hbGxvY0ZhaWxlZDsK

------_=_NextPart_001_01C7AC65.86EFBC03--
