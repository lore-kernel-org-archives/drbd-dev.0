Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C91741.0370CD6C"
Subject: RE: [Drbd-dev] Problems with code to disallow connection when peer
	has mismatched UUID
Date: Mon, 15 Sep 2008 10:40:34 -0400
Message-ID: <DA0E7D869C862D4095C265233CD1D41E01192D4A@EXNA.corp.stratus.com>
In-Reply-To: <DA0E7D869C862D4095C265233CD1D41E011929C8@EXNA.corp.stratus.com>
References: <DA0E7D869C862D4095C265233CD1D41E011929A3@EXNA.corp.stratus.com>20080911092451.GB9756@soda.linbit
	<DA0E7D869C862D4095C265233CD1D41E011929C8@EXNA.corp.stratus.com>
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

------_=_NextPart_001_01C91741.0370CD6C
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Attached is a proposed patch to address this problem that does the
following:

1. When connection is lost, a new UUID is not created on the primary if
the local disk is inconsistent
2. Allow connection to be established if local disk is inconsistent even
if the remote is using
   a different UUID - our data is useless and cannot have been changed
anyway. The following handshake
   will cause the appropriate resync.

Although only one of these is actually required to fix my problem, I
thought it was better to be consistent
and change both.

Simon

> -----Original Message-----
> From: drbd-dev-bounces@linbit.com [mailto:drbd-dev-bounces@linbit.com]
> On Behalf Of Graham, Simon
> Sent: Thursday, September 11, 2008 6:33 AM
> To: drbd-dev@linbit.com
> Subject: RE: [Drbd-dev] Problems with code to disallow connection when
> peerhasmismatched UUID
>=20
> Thanks Lars,
>=20
> > > I'm not sure what the right answer is here, but I have a couple of
> > > observations:
> > > 1. When we lose connection and are Primary/Inconsistent, should we
> > > really create a new current UUID? The local data is bad.
> >
> > I don't think we should.
>=20
> OK - I'll look at implementing this.
>=20
> > that piece of code is to avoid "time warps" of content.
> > the specific scenario this should protect against is:
> >
> > Primary, Connected
> >  connection breaks.
> > Primary  ---?
> >  primary generates new "current uuid",
> >  and continues to write
> >  local disk breaks
> > Primary, Diskless, ---?
> >  connection heals
> >
> > now, if we allow this connection and accept the data of the
> secondary,
> > we just jumped back in time.
>=20
> Ah OK -- would it perhaps then be OK to check for local disk state =
<=3D
> Negotiating instead of < Outdated:
>=20
> 	if (mdev->state.conn < Connected &&
> 	    mdev->state.disk <=3D Negotiating &&
> 	    mdev->state.role =3D=3D Primary &&
> 	    (mdev->ed_uuid & ~((u64)1)) !=3D (p_uuid[Current] &
> ~((u64)1))) {
> 		ERR("Can only connect to data with current
> UUID=3D%016llX\n",
> 		    (unsigned long long)mdev->ed_uuid);
> 		drbd_force_state(mdev,NS(conn,Disconnecting));
> 		return FALSE;
> 	}
>=20
> This would handle the case we see where we KNOW the local disk does
not
> have good data... (and we knew before the connection was lost, so we
> would NOT have actually been able to change the local copy of the data
> on disk).
>=20
> Simon
> _______________________________________________
> drbd-dev mailing list
> drbd-dev@lists.linbit.com
> http://lists.linbit.com/mailman/listinfo/drbd-dev

------_=_NextPart_001_01C91741.0370CD6C
Content-Type: application/octet-stream;
	name="0001-Better-handling-of-losing-connection-in-primary-inco.patch"
Content-Transfer-Encoding: base64
Content-Description: 0001-Better-handling-of-losing-connection-in-primary-inco.patch
Content-Disposition: attachment;
	filename="0001-Better-handling-of-losing-connection-in-primary-inco.patch"

RnJvbSA0MThjZDQ2ZTAzM2RhODM2OTViODczYTg0MmY0NGFiZTdkYjA1NzFmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTaW1vbiBQLiBHcmFoYW0gPFNpbW9uLkdyYWhhbUBzdHJhdHVz
LmNvbT4KRGF0ZTogRnJpLCAxMiBTZXAgMjAwOCAxMDo0MTo0OSAtMDQwMApTdWJqZWN0OiBbUEFU
Q0hdIEJldHRlciBoYW5kbGluZyBvZiBsb3NpbmcgY29ubmVjdGlvbiBpbiBwcmltYXJ5L2luY29u
c2lzdGVudCBzdGF0ZQoKMS4gRG9udCBjcmVhdGUgYSBuZXcgVVVJRCBpZiBwcmltYXJ5L2luc29u
c2lzdGVudCB3aGVuIGNvbm5lY3Rpb24gZHJvcHBlZAoyLiBBbGxvdyBjb25uZWN0aW9uIHRvIGJl
IGVzdGFibGlzaGVkIGV2ZW4gaWYgcmVtb3RlIHNpZGUgaGFzIGEgZGlmZmVyZW50CiAgIFVVSUQg
LSBvdXIgZGF0YSBpcyB1c2VsZXNzIGFueXdheS4KLS0tCiBkcmJkL2RyYmRfbWFpbi5jICAgICB8
ICAgIDEgKwogZHJiZC9kcmJkX25sLmMgICAgICAgfCAgICAxICsKIGRyYmQvZHJiZF9yZWNlaXZl
ci5jIHwgICAgMiArLQogMyBmaWxlcyBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVsZXRp
b25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJiZC9kcmJkX21haW4uYyBiL2RyYmQvZHJiZF9tYWluLmMK
aW5kZXggM2Q0NTkwNy4uNGMzOTZmMiAxMDA2NDQKLS0tIGEvZHJiZC9kcmJkX21haW4uYworKysg
Yi9kcmJkL2RyYmRfbWFpbi5jCkBAIC0xMDc4LDYgKzEwNzgsNyBAQCBzdGF0aWMgdm9pZCBhZnRl
cl9zdGF0ZV9jaChzdHJ1Y3QgZHJiZF9jb25mICptZGV2LCB1bmlvbiBkcmJkX3N0YXRlX3Qgb3Ms
CiAJCWlmIChpbmNfbG9jYWwobWRldikpIHsKIAkJCS8qIGdlbmVyYXRlIG5ldyB1dWlkLCB1bmxl
c3Mgd2UgZGlkIGFscmVhZHkgKi8KIAkJCWlmIChucy5yb2xlID09IFByaW1hcnkgJiYKKwkJCSAg
ICBucy5kaXNrID49IENvbnNpc3RlbnQgJiYKIAkJCSAgICBtZGV2LT5iYy0+bWQudXVpZFtCaXRt
YXBdID09IDApCiAJCQkJZHJiZF91dWlkX25ld19jdXJyZW50KG1kZXYpOwogCQkJaWYgKG5zLnBl
ZXIgPT0gUHJpbWFyeSkgewpkaWZmIC0tZ2l0IGEvZHJiZC9kcmJkX25sLmMgYi9kcmJkL2RyYmRf
bmwuYwppbmRleCAzYzc2ZWRjLi5kZGIzM2YyIDEwMDY0NAotLS0gYS9kcmJkL2RyYmRfbmwuYwor
KysgYi9kcmJkL2RyYmRfbmwuYwpAQCAtMzYwLDYgKzM2MCw3IEBAIGludCBkcmJkX3NldF9yb2xl
KHN0cnVjdCBkcmJkX2NvbmYgKm1kZXYsIGVudW0gZHJiZF9yb2xlIG5ld19yb2xlLCBpbnQgZm9y
Y2UpCiAJCWlmIChpbmNfbG9jYWwobWRldikpIHsKIAkJCWlmICggKChtZGV2LT5zdGF0ZS5jb25u
IDwgQ29ubmVjdGVkIHx8CiAJCQkgICAgICAgbWRldi0+c3RhdGUucGRzayA8PSBGYWlsZWQpCisJ
CQkgICAgICAmJiBtZGV2LT5zdGF0ZS5kaXNrID49IENvbnNpc3RlbnQKIAkJCSAgICAgICYmIG1k
ZXYtPmJjLT5tZC51dWlkW0JpdG1hcF0gPT0gMCkgfHwgZm9yY2VkKQogCQkJCWRyYmRfdXVpZF9u
ZXdfY3VycmVudChtZGV2KTsKIApkaWZmIC0tZ2l0IGEvZHJiZC9kcmJkX3JlY2VpdmVyLmMgYi9k
cmJkL2RyYmRfcmVjZWl2ZXIuYwppbmRleCBjNjE5YzdhLi41ZDM4NTUyIDEwMDY0NAotLS0gYS9k
cmJkL2RyYmRfcmVjZWl2ZXIuYworKysgYi9kcmJkL2RyYmRfcmVjZWl2ZXIuYwpAQCAtMjQ1NCw3
ICsyNDU0LDcgQEAgU1RBVElDIGludCByZWNlaXZlX3V1aWRzKHN0cnVjdCBkcmJkX2NvbmYgKm1k
ZXYsIHN0cnVjdCBEcmJkX0hlYWRlciAqaCkKIAltZGV2LT5wX3V1aWQgPSBwX3V1aWQ7CiAKIAlp
ZiAobWRldi0+c3RhdGUuY29ubiA8IENvbm5lY3RlZCAmJgotCSAgICBtZGV2LT5zdGF0ZS5kaXNr
IDwgT3V0ZGF0ZWQgJiYKKwkgICAgbWRldi0+c3RhdGUuZGlzayA8PSBOZWdvdGlhdGluZyAmJgog
CSAgICBtZGV2LT5zdGF0ZS5yb2xlID09IFByaW1hcnkgJiYKIAkgICAgKG1kZXYtPmVkX3V1aWQg
JiB+KCh1NjQpMSkpICE9IChwX3V1aWRbQ3VycmVudF0gJiB+KCh1NjQpMSkpKSB7CiAJCUVSUigi
Q2FuIG9ubHkgY29ubmVjdCB0byBkYXRhIHdpdGggY3VycmVudCBVVUlEPSUwMTZsbFhcbiIsCi0t
IAoxLjUuNC1yYzEuR0lUCgo=

------_=_NextPart_001_01C91741.0370CD6C--
