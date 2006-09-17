Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C6DA6A.760C6CC1"
Subject: RE: [Drbd-dev] DRBD-8: Fix to Negotiating state handling
Date: Sun, 17 Sep 2006 11:03:38 -0400
Message-ID: <342BAC0A5467384983B586A6B0B37671039D3DA9@EXNA.corp.stratus.com>
From: "Graham, Simon" <Simon.Graham@stratus.com>
To: "Graham, Simon" <Simon.Graham@stratus.com>,
	<drbd-dev@lists.linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C6DA6A.760C6CC1
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hmm - not sure what I was on the other day, but this patch was wrong --
I was comparing the local disk state to negotiating instead of the peers
state! Still doesn't seem to be working right though... any better
suggestions?

Simon

> -----Original Message-----
> From: drbd-dev-bounces@linbit.com [mailto:drbd-dev-bounces@linbit.com]
> On Behalf Of Graham, Simon
> Sent: Friday, September 15, 2006 4:30 PM
> To: drbd-dev@linbit.com
> Subject: [Drbd-dev] DRBD-8: Fix to Negotiating state handling
>=20
> I took the latest update today and found that when I did
detach/attach,
> the side attaching would never exit the Negotiating state - the other
> side updated it's view of the peer correctly, but it never sent
> anything
> back to the originating side to make it go from Negotiating to
UpToDate
> - I _think_ the expected thing here is to send back a ReportState
> message when we are Connected _and_ the peer says its Negotiating --
> patch attached that seems to work...
>=20
> Simon
>=20


------_=_NextPart_001_01C6DA6A.760C6CC1
Content-Type: application/octet-stream;
	name="connpatch.patch"
Content-Transfer-Encoding: base64
Content-Description: connpatch.patch
Content-Disposition: attachment;
	filename="connpatch.patch"

SW5kZXg6IGRyYmQvZHJiZF9yZWNlaXZlci5jCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KLS0tIGRyYmQvZHJiZF9yZWNl
aXZlci5jCShyZXZpc2lvbiA0MDYzKQorKysgZHJiZC9kcmJkX3JlY2VpdmVyLmMJKHdvcmtpbmcg
Y29weSkKQEAgLTIxNjcsNiArMjE3MSwxMCBAQAogCQkJZHJiZF9zZW5kX3N0YXRlKG1kZXYpOwog
CQl9CiAJfQorCWVsc2UgaWYgKG5jb25uID09IENvbm5lY3RlZCAmJiBwZWVyX3N0YXRlLmRpc2sg
PT0gTmVnb3RpYXRpbmcpIHsKKwkJLy8gcGVlciBpcyB3YWl0aW5nIGZvciB1cyB0byByZXNwb25k
Li4uCisJCWRyYmRfc2VuZF9zdGF0ZShtZGV2KTsKKwl9CiAKIAlzcGluX2xvY2tfaXJxKCZtZGV2
LT5yZXFfbG9jayk7CiAJb3MgPSBtZGV2LT5zdGF0ZTsK

------_=_NextPart_001_01C6DA6A.760C6CC1--
