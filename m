Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C82072.5E1A44BE"
Subject: RE: [Drbd-dev] PATCH: Missing state change netlink events
Date: Tue, 6 Nov 2007 07:41:34 -0500
Message-ID: <342BAC0A5467384983B586A6B0B376710707474E@EXNA.corp.stratus.com>
In-Reply-To: 200711051125.23233.philipp.reisner@linbit.com
References: <342BAC0A5467384983B586A6B0B376710707453A@EXNA.corp.stratus.com>
	200711051125.23233.philipp.reisner@linbit.com
From: "Graham, Simon" <Simon.Graham@stratus.com>
To: "Philipp Reisner" <philipp.reisner@linbit.com>, <drbd-dev@lists.linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C82072.5E1A44BE
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> > I think the fix is simple - modify the code so that after_state_ch
> > broadcasts the new state rather than the current state (patch
> attached)
> > - I would have removed the passing of mdev completely from
> > drbd_bcast_state() if it weren't for the fact it is required by the
> > generated to_tags function. I'm testing this at the moment but it's
a
> > little hard to be sure it's right since this requires fairly tight
> > timing.
> >
>=20
> Hi Simon,
>=20
> You are right. Obviously.
> I have put it into GIT.
>

Actually, this patch wasn't quite complete -- there were a couple of
places where the wrong new state was broadcast (where ScheduleAfter was
_not_ set in the call to _drbd_set_state). Patch attached.

Simon

=20

------_=_NextPart_001_01C82072.5E1A44BE
Content-Type: application/octet-stream;
	name="ava-3847.patch"
Content-Transfer-Encoding: base64
Content-Description: ava-3847.patch
Content-Disposition: attachment;
	filename="ava-3847.patch"

SW5kZXg6IHNyYy9kcmJkL2RyYmRfcmVjZWl2ZXIuYwo9PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Ci0tLSBzcmMvZHJiZC9k
cmJkX3JlY2VpdmVyLmMJKHJldmlzaW9uIDIwNjYxKQorKysgc3JjL2RyYmQvZHJiZF9yZWNlaXZl
ci5jCSh3b3JraW5nIGNvcHkpCkBAIC0yNDMxLDYgKzI0MzEsNyBAQAogCWlmKChuY29ubiA9PSBD
b25uZWN0ZWQgfHwgbmNvbm4gPT0gV0ZCaXRNYXBUKSAmJgogCSAgIG5zLnBkc2sgPT0gTmVnb3Rp
YXRpbmcgKSBucy5wZHNrID0gVXBUb0RhdGU7CiAJcnYgPSBfZHJiZF9zZXRfc3RhdGUobWRldixu
cyxDaGdTdGF0ZVZlcmJvc2UgfCBDaGdTdGF0ZUhhcmQpOworCW5zID0gbWRldi0+c3RhdGU7CiAJ
c3Bpbl91bmxvY2tfaXJxKCZtZGV2LT5yZXFfbG9jayk7CiAKIAlpZihydiA8IFNTX1N1Y2Nlc3Mp
IHsKQEAgLTI3NzgsNiArMjc3OSw3IEBACiAJCW5zID0gb3M7CiAJCW5zLmNvbm4gPSBVbmNvbm5l
Y3RlZDsKIAkJcnY9X2RyYmRfc2V0X3N0YXRlKG1kZXYsbnMsQ2hnU3RhdGVWZXJib3NlKTsKKwkJ
bnMgPSBtZGV2LT5zdGF0ZTsKIAl9CiAJc3Bpbl91bmxvY2tfaXJxKCZtZGV2LT5yZXFfbG9jayk7
CiAJaWYgKHJ2ID09IFNTX1N1Y2Nlc3MpIHsK

------_=_NextPart_001_01C82072.5E1A44BE--
