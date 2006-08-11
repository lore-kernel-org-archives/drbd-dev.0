Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Drbd-dev] DRBD-8: recent regression causing corruption and
	crashes
Date: Fri, 11 Aug 2006 12:01:23 -0400
Message-ID: <342BAC0A5467384983B586A6B0B3767103624F3C@EXNA.corp.stratus.com>
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

Quick update:

> -----Original Message-----
> 1. I get errors during initial synchronization of a volume like this
> that cause the resync to be aborted:
>=20
> drbd15: tl_verify: failed to find req e51a4da0, sector 0 in list
> drbd15: Got a corrupt block_id/sector pair(2).
> drbd15: short read expecting header on sock: r=3D-512
> drbd15: tl_clear()
>=20

FWIW, I have now confirmed that the WriteAck messages are being sent
with sector=3D0 (I used ethereal plus a drbd protocol dissector that I'm
working on -- more on that later when it's closer to being ready;
however, I checked the binary dump as well, and the node is definitely
sending lots of WriteAck's with sector=3D=3D0 and =
block_id=3D=3DSYNCER_ID) - for
example:

Frame 5706 (354 bytes on wire, 354 bytes captured)
Ethernet II, Src: Dell_4b:00:e2 (00:13:72:4b:00:e2), Dst: Dell_4a:ff:8e
(00:13:72:4a:ff:8e)
Internet Protocol, Src: 192.168.1.100 (192.168.1.100), Dst:
192.168.1.101 (192.168.1.101)
Transmission Control Protocol, Src Port: 7803 (7803), Dst Port: 42289
(42289), Seq: 129, Ack: 9, Len: 288
DRBD, Cmd: WriteAck, BlkId: SYNCER Sector: 0, AckLen: 8000
DRBD, Cmd: WriteAck, BlkId: SYNCER Sector: 0, AckLen: 8000
DRBD, Cmd: WriteAck, BlkId: SYNCER Sector: 0, AckLen: 8000
DRBD, Cmd: WriteAck, BlkId: SYNCER Sector: 0, AckLen: 8000
DRBD, Cmd: WriteAck, BlkId: SYNCER Sector: 0, AckLen: 8000
DRBD, Cmd: WriteAck, BlkId: SYNCER Sector: 0, AckLen: 8000
DRBD, Cmd: WriteAck, BlkId: SYNCER Sector: 0, AckLen: 8000
DRBD, Cmd: WriteAck, BlkId: SYNCER Sector: 0, AckLen: 8000
DRBD, Cmd: WriteAck, BlkId: SYNCER Sector: 0, AckLen: 8000

> 2. I get panics with the following signature:- these look like they
are
> happening when a local write
>     on the primary (which this node is) completes.

The panic signature seems to change - for example, I just got one like
this in the receiver thread:

drbd15: ASSERT( drbd_req_get_sector(i) =3D=3D sector ) in
/sandbox/sgraham/sn/trunk/platform/drbd/8.0/drbd/drbd_main.c:313
drbd15: tl_verify: found req e63d0240 but it has wrong sector (8 versus
0)
drbd15: tl_verify: failed to find req e63d02b0, sector 0 in list
drbd15: Got a corrupt block_id/sector pair(2).
drbd15: drbd_pp_alloc interrupted!
drbd15: error receiving RSDataRequest, l: 24!
drbd15: tl_clear()
drbd15: in tl_clear_barrier:374: ap_pending_cnt =3D -1 < 0 !
drbd15: ap_pending_cnt =3D -1
Unable to handle kernel paging request at virtual address 7f10debb
 printing eip:
7f10debb
*pde =3D ma 00000000 pa fffff000
Oops: 0000 [#1]
Modules linked in: drbd ipmi_devintf ipmi_si ipmi_msghandler video
thermal processor fan button battery ac
CPU:    0
EIP:    0061:[<7f10debb>]    Not tainted VLI
EFLAGS: 00010082   (2.6.16.13-xen0 #2)=20
EIP is at 0x7f10debb
eax: eae0833e   ebx: 7720debb   ecx: ffffffff   edx: 00000003
esi: 7eccc0b3   edi: df4deadb   ebp: f3c0c015   esp: eadb7ece
ds: 007b   es: 007b   ss: 0069
Process drbd15_receiver (pid: 4250, threadinfo=3Deadb6000 =
task=3Dc17d4a70)
Stack: <0>b3b1eadb f3c0f128 f3c0debb 0200debb 00000000 00030000 00010000
00000000=20
       00000000 00000000 7ef80000 7ef8eadb 7f10eadb 91c0eadb ff80ec82
91c0ffff=20
       7f54ec82 b62eeadb 91c0f128 6620ec82 fff8c155 0001001f 02000000
00030000=20
Call Trace:
 [<c010513a>] show_stack_log_lvl+0xaa/0xe0
 [<c010534e>] show_registers+0x18e/0x210
 [<c0105549>] die+0xd9/0x180
 [<c0112b7c>] do_page_fault+0x3cc/0x640
 [<c0104d5f>] error_code+0x2b/0x30
Code:  Bad EIP value.
 <0>Fatal exception: panic in 5 seconds

All suggestions gratefully accepted!
Simon
