Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C6DA73.BBEFBAF0"
Subject: RE: [Drbd-dev] DRBD-8: Fix to Negotiating state handling
Date: Sun, 17 Sep 2006 12:10:01 -0400
Message-ID: <342BAC0A5467384983B586A6B0B37671039D3DAA@EXNA.corp.stratus.com>
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

------_=_NextPart_001_01C6DA73.BBEFBAF0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Ignore previous email... I've figured out what I did wrong (test was in
the wrong place) -- I also left out the code to have the receiver of a
negotiating state update it's peer state to UpToDate instead of
Negotiating...

Final, really working but possibly not entirely correct, patch
attached...
Simon


> -----Original Message-----
> From: Graham, Simon
> Sent: Sunday, September 17, 2006 11:04 AM
> To: Graham, Simon; drbd-dev@linbit.com
> Subject: RE: [Drbd-dev] DRBD-8: Fix to Negotiating state handling
>=20
> Hmm - not sure what I was on the other day, but this patch was wrong
--
> I was comparing the local disk state to negotiating instead of the
> peers state! Still doesn't seem to be working right though... any
> better suggestions?
>=20
> Simon
>=20
> > -----Original Message-----
> > From: drbd-dev-bounces@linbit.com [mailto:drbd-dev-
> bounces@linbit.com]
> > On Behalf Of Graham, Simon
> > Sent: Friday, September 15, 2006 4:30 PM
> > To: drbd-dev@linbit.com
> > Subject: [Drbd-dev] DRBD-8: Fix to Negotiating state handling
> >
> > I took the latest update today and found that when I did
> detach/attach,
> > the side attaching would never exit the Negotiating state - the
other
> > side updated it's view of the peer correctly, but it never sent
> > anything
> > back to the originating side to make it go from Negotiating to
> UpToDate
> > - I _think_ the expected thing here is to send back a ReportState
> > message when we are Connected _and_ the peer says its Negotiating --
> > patch attached that seems to work...
> >
> > Simon
> >


------_=_NextPart_001_01C6DA73.BBEFBAF0
Content-Type: application/octet-stream;
	name="connpatch.patch"
Content-Transfer-Encoding: base64
Content-Description: connpatch.patch
Content-Disposition: attachment;
	filename="connpatch.patch"

SW5kZXg6IGRyYmRfcmVjZWl2ZXIuYwo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Ci0tLSBkcmJkX3JlY2VpdmVyLmMJKC4u
Li90cnVuay9kcmJkL2RyYmRfcmVjZWl2ZXIuYykJKHJldmlzaW9uIDQwOTQpCisrKyBkcmJkX3Jl
Y2VpdmVyLmMJKC4uLi9icmFuY2hlcy9kcmJkLXBhbmljL2RyYmQvZHJiZF9yZWNlaXZlci5jKQko
cmV2aXNpb24gNDA5NCkKQEAgLTIxNjYsNiArMjE3MCwxMCBAQAogCQkJZHJiZF9zZW5kX3V1aWRz
KG1kZXYpOwogCQkJZHJiZF9zZW5kX3N0YXRlKG1kZXYpOwogCQl9CisJCWVsc2UgaWYgKG5jb25u
ID09IENvbm5lY3RlZCAmJiBwZWVyX3N0YXRlLmRpc2sgPT0gTmVnb3RpYXRpbmcpIHsKKwkJCS8v
IHBlZXIgaXMgd2FpdGluZyBmb3IgdXMgdG8gcmVzcG9uZC4uLgorCQkJZHJiZF9zZW5kX3N0YXRl
KG1kZXYpOworCQl9CiAJfQogCiAJc3Bpbl9sb2NrX2lycSgmbWRldi0+cmVxX2xvY2spOwpAQCAt
MjE3Niw2ICsyMTg0LDcgQEAKIAlucy5wZHNrID0gcGVlcl9zdGF0ZS5kaXNrOwogCW5zLnBlZXJf
aXNwID0gKCBwZWVyX3N0YXRlLmFmdHJfaXNwIHwgcGVlcl9zdGF0ZS51c2VyX2lzcCApOwogCWlm
KG5jb25uID09IENvbm5lY3RlZCAmJiBucy5kaXNrID09IE5lZ290aWF0aW5nICkgbnMuZGlzayA9
IFVwVG9EYXRlOworCWlmKG5jb25uID09IENvbm5lY3RlZCAmJiBucy5wZHNrID09IE5lZ290aWF0
aW5nICkgbnMucGRzayA9IFVwVG9EYXRlOwogCXJ2ID0gX2RyYmRfc2V0X3N0YXRlKG1kZXYsbnMs
Q2hnU3RhdGVWZXJib3NlIHwgQ2hnU3RhdGVIYXJkKTsKIAlzcGluX3VubG9ja19pcnEoJm1kZXYt
PnJlcV9sb2NrKTsKIAlpZiAocnY9PVNTX1N1Y2Nlc3MpIHsK

------_=_NextPart_001_01C6DA73.BBEFBAF0--
