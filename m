Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C740C9.544C9081"
Date: Thu, 25 Jan 2007 16:39:44 -0500
Message-ID: <342BAC0A5467384983B586A6B0B37671048F859F@EXNA.corp.stratus.com>
From: "Graham, Simon" <Simon.Graham@stratus.com>
To: <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] DRBD-8: another crash following disk write failures
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C740C9.544C9081
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Just run into another crash when we get disk write failures - this is =
related to the other recent problems where we could try to use the =
activity log after the disk is detached - in this case it's an actual =
crash rather than a BUG() call:

Unable to handle kernel NULL pointer dereference at virtual address =
000000ac
EIP is at w_io_error+0x18/0xa0 [drbd]
Call Trace:
=A0[<c0105431>] show_stack_log_lvl+0xa1/0xe0
=A0[<c0105621>] show_registers+0x181/0x200
=A0[<c0105840>] die+0x100/0x1a0
=A0[<c0115746>] do_page_fault+0x3c6/0x8b1
=A0[<c0105097>] error_code+0x2b/0x30
=A0[<ee3b4b0e>] drbd_worker+0x2de/0x4b5 [drbd]
=A0[<ee3c6eec>] drbd_thread_setup+0x8c/0x100 [drbd]
=A0[<c0102ec5>] kernel_thread_helper+0x5/0x10

And the code in question is this:

int w_io_error(drbd_dev* mdev, struct drbd_work* w,int cancel)
{
=A0=A0=A0=A0drbd_request_t *req =3D (drbd_request_t*)w;
=A0=A0=A0=A0int ok;

=A0=A0=A0=A0/* FIXME send a "set_out_of_sync" packet to the peer
=A0=A0=A0=A0 * in the PassOn case...
=A0=A0=A0=A0 * in the Detach (or Panic) case, we (try to) send
=A0=A0=A0=A0 * a "we are diskless" param packet anyways, and the peer
=A0=A0=A0=A0 * will then set the FullSync bit in the meta data ...
=A0=A0=A0=A0 */
=A0=A0=A0=A0D_ASSERT(mdev->bc->dc.on_io_error !=3D PassOn);

Oops - mdev->bc can be NULL by the time we get here...

I propose simply commenting out the assert for now (patch attached - I =
left the code there because of the 'FIX ME' line above -- didn't want to =
lose that!)

Simon


------_=_NextPart_001_01C740C9.544C9081
Content-Type: application/octet-stream;
	name="ava-1617.patch"
Content-Transfer-Encoding: base64
Content-Description: ava-1617.patch
Content-Disposition: attachment;
	filename="ava-1617.patch"

SW5kZXg6IHNyYy9kcmJkL2RyYmRfd29ya2VyLmMKPT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQotLS0gc3JjL2RyYmQvZHJi
ZF93b3JrZXIuYwkocmV2aXNpb24gODkyMykKKysrIHNyYy9kcmJkL2RyYmRfd29ya2VyLmMJKHdv
cmtpbmcgY29weSkKQEAgLTE4OCw3ICsxODgsOCBAQAogCSAqIGEgIndlIGFyZSBkaXNrbGVzcyIg
cGFyYW0gcGFja2V0IGFueXdheXMsIGFuZCB0aGUgcGVlcgogCSAqIHdpbGwgdGhlbiBzZXQgdGhl
IEZ1bGxTeW5jIGJpdCBpbiB0aGUgbWV0YSBkYXRhIC4uLgogCSAqLwotCURfQVNTRVJUKG1kZXYt
PmJjLT5kYy5vbl9pb19lcnJvciAhPSBQYXNzT24pOworCS8vIE5PVEU6IG1kZXYtPmJjIGNhbiBi
ZSBOVUxMIGJ5IHRoZSB0aW1lIHdlIGdldCBoZXJlIQorCS8vRF9BU1NFUlQobWRldi0+YmMtPmRj
Lm9uX2lvX2Vycm9yICE9IFBhc3NPbik7CiAKIAkvKiB0aGUgb25seSB3YXkgdGhpcyBjYWxsYmFj
ayBpcyBzY2hlZHVsZWQgaXMgZnJvbSBfcmVxX21heV9iZV9kb25lLAogCSAqIHdoZW4gaXQgaXMg
ZG9uZSBhbmQgaGFkIGEgbG9jYWwgd3JpdGUgZXJyb3IsIHNlZSBjb21tZW50cyB0aGVyZSAqLwo=

------_=_NextPart_001_01C740C9.544C9081--
