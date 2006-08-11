Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C6BD95.D5246A21"
Subject: RE: [Drbd-dev] DRBD-8: recent regression causing corruption andcrashes
Date: Fri, 11 Aug 2006 18:31:01 -0400
Message-ID: <342BAC0A5467384983B586A6B0B3767103624FB2@EXNA.corp.stratus.com>
From: "Graham, Simon" <Simon.Graham@stratus.com>
To: "Graham, Simon" <Simon.Graham@stratus.com>,
	"Lars Ellenberg" <Lars.Ellenberg@linbit.com>, <drbd-dev@lists.linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C6BD95.D5246A21
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

That was it -- things are going MUCH better now - trivial patch
attached.

Simon


> -----Original Message-----
> From: drbd-dev-bounces@linbit.com [mailto:drbd-dev-bounces@linbit.com]
> On Behalf Of Graham, Simon
> Sent: Friday, August 11, 2006 5:56 PM
> To: Lars Ellenberg; drbd-dev@linbit.com
> Subject: RE: [Drbd-dev] DRBD-8: recent regression causing corruption
> andcrashes
>=20
> After a lot of looking at the disassembly of the send-ack routines, I
> think I've found it -- the new routines Philipp added do this:
>=20
> static int _drbd_send_ack(drbd_dev *mdev, Drbd_Packet_Cmd cmd,
> 			  sector_t sector,
> 			  unsigned int blksize,
> 			  u64 block_id)
> {...}
>=20
> int drbd_send_ack(drbd_dev *mdev, Drbd_Packet_Cmd cmd, struct
> Tl_epoch_entry *e)
> {
> 	return _drbd_send_ack(mdev,cmd,
> 			      cpu_to_be64(drbd_ee_get_sector(e)),
> 			      cpu_to_be32(drbd_ee_get_size(e)),
> 			      e->block_id);
> }
>=20
> Now, if you build on a system that does NOT have CONFIG_LBD defined,
> then the definition of sector_t is 'unsigned long' - i.e. 32-bits, to
> the code above byte swaps the sector number as a u64, then truncates
it
> to 32-bits leaving JUST the byte-swapped upper portion, i.e. zero
> _ALWAYS_.
>=20
> I just checked my config and CONFIG_LBD is off -- I'm guessing it's
> probably on for the tests you run?
>=20
> I also think the fix is simply a matter of changing the definition of
> _drbd_send_ack to be 'u64 sector' - I'm going to try this right now!
>=20
> Simon
>=20
> _______________________________________________
> drbd-dev mailing list
> drbd-dev@lists.linbit.com
> http://lists.linbit.com/mailman/listinfo/drbd-dev

------_=_NextPart_001_01C6BD95.D5246A21
Content-Type: application/octet-stream;
	name="drbd-sector.patch"
Content-Transfer-Encoding: base64
Content-Description: drbd-sector.patch
Content-Disposition: attachment;
	filename="drbd-sector.patch"

SW5kZXg6IGRyYmRfbWFpbi5jCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KLS0tIGRyYmRfbWFpbi5jCShyZXZpc2lvbiAz
NTA0KQorKysgZHJiZF9tYWluLmMJKHdvcmtpbmcgY29weSkKQEAgLTE1MDYsNyArMTUwNiw3IEBA
CiAgKiBpbiBiaWcgZW5kaWFuIQogICovIAogc3RhdGljIGludCBfZHJiZF9zZW5kX2FjayhkcmJk
X2RldiAqbWRldiwgRHJiZF9QYWNrZXRfQ21kIGNtZCwgCi0JCQkgIHNlY3Rvcl90IHNlY3RvciwK
KwkJCSAgdTY0IHNlY3RvciwKIAkJCSAgdW5zaWduZWQgaW50IGJsa3NpemUsCiAJCQkgIHU2NCBi
bG9ja19pZCkKIHsK

------_=_NextPart_001_01C6BD95.D5246A21--
