Return-Path: <Ernest.Montrose@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C74721.A687C736"
Subject: RE: [Drbd-dev] DRBD8:Panics in lc_find due to null
	lcafterScsiMEDIUM_ERROR I.O error.
Date: Fri, 2 Feb 2007 18:27:05 -0500
Message-ID: <BD7042533C2F8943A6A4257A9E31C45439C8E1@EXNA.corp.stratus.com>
From: "Montrose, Ernest" <Ernest.Montrose@stratus.com>
To: <drbd-dev@lists.linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C74721.A687C736
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

 Phil,
The one spot that was missed is in this patch.  I looked around for
other places but I am
Still not that everything is covered.

EM--

-----Original Message-----
From: drbd-dev-bounces@linbit.com [mailto:drbd-dev-bounces@linbit.com]
On Behalf Of Montrose, Ernest
Sent: Friday, February 02, 2007 9:20 AM
To: Montrose, Ernest; Philipp Reisner; drbd-dev@linbit.com
Subject: RE: [Drbd-dev] DRBD8:Panics in lc_find due to null
lcafterScsiMEDIUM_ERROR I.O error.

Phil,
I finally got to testing the fix this morning.  Unfortunately, the panic
just moved To another code path but still a lru_cache.c..Null lc. So
some more code paths Need fixing. Here is the trace:
------------[ cut here ]------------
kernel BUG at
/sandbox/emontros/devel/trunk/platform/drbd/src/drbd/lru_cache.c:214!
invalid opcode: 0000 [#1]
SMP
Modules linked in: drbd cn bridge ipv6 ipmi_devintf ipmi_si
ipmi_msghandler binfmt_misc dm_mirror video thermal processor fan
container button battery ac hw_random i2c_i801 i2c_core shpchp
pci_hotplug e1000 piix ide_cd cdrom raid1 dm_mod ide_disk ata_piix
libata sd_mod scsi_mod
CPU:    0
EIP:    0061:[<ee233fe7>]    Tainted: GF    VLI
EFLAGS: 00010046  (2.6.16.29-xen #1)
EIP is at lc_get+0x127/0x160 [drbd]
eax: 00000000  ebx: 00000058  ecx: 00000000  edx: 00000058
esi: 00000000  edi: eb547fb0  ebp: eab91e84  esp: eab91e78
ds: 007b  es: 007b  ss: 0069
Process drbd1_asender (pid: 6356, threadinfo=3Deab90000 task=3Ded55f570)
Stack: <0>00000058 00058007 eb547fb0 eab91ed0 ee231d78 ee2209be c072dd80
ed785c00
      eaf43280 eab91ea4 c014c33e eab91ebc 00000000 eab91ed0 ee21ea49
00000058
      002c0000 00000000 eb547c00 00000008 00058007 eb547fb0 eab91f28
ee2321a5
Call Trace:
 [<c0105431>] show_stack_log_lvl+0xa1/0xe0  [<c0105621>]
show_registers+0x181/0x200  [<c0105840>] die+0x100/0x1a0  [<c0105961>]
do_trap+0x81/0xc0  [<c0105c45>] do_invalid_op+0xa5/0xb0  [<c0105097>]
error_code+0x2b/0x30  [<ee231d78>] drbd_try_clear_on_disk_bm+0x28/0x280
[drbd]  [<ee2321a5>] __drbd_set_in_sync+0x1d5/0x330 [drbd]  [<ee22bb7b>]
got_BlockAck+0x9b/0x430 [drbd]  [<ee22ca04>] drbd_asender+0x3a4/0x5b1
[drbd]  [<ee236cac>] drbd_thread_setup+0x8c/0x100 [drbd]  [<c0102ec5>]
kernel_thread_helper+0x5/0x10
Code: 83 ff 46 38 f0 0f ba 76 28 00 31 c0 eb 92 0f ba 6e 28 02 f0 0f ba
76 28 00 e9 68 ff ff ff 0f 0b d7 00 44 5e 24 ee e9 01 ff ff ff <0f> 0b
d6 00 44 5e 24 ee e9 e9 fe ff ff 0f 0b d9 00 44 5e 24 ee  <0>Fatal
exception: panic in 5 seconds
=20

-----Original Message-----
From: drbd-dev-bounces@linbit.com [mailto:drbd-dev-bounces@linbit.com]
On Behalf Of Montrose, Ernest
Sent: Wednesday, January 31, 2007 12:33 PM
To: Philipp Reisner; drbd-dev@linbit.com
Subject: RE: [Drbd-dev] DRBD8:Panics in lc_find due to null lc
afterScsiMEDIUM_ERROR I.O error.

Phil,
Thank you very much.That was fast!!..This should be quick to verify!!
Just have to run it
On my machine with the broken disk.  Sweet!! I'll let you know.

EM--=20

-----Original Message-----
From: drbd-dev-bounces@linbit.com [mailto:drbd-dev-bounces@linbit.com]
On Behalf Of Philipp Reisner
Sent: Wednesday, January 31, 2007 12:26 PM
To: drbd-dev@linbit.com
Cc: Montrose, Ernest
Subject: Re: [Drbd-dev] DRBD8:Panics in lc_find due to null lc after
ScsiMEDIUM_ERROR I.O error.

Am Mittwoch, 31. Januar 2007 14:58 schrieb Montrose, Ernest:

Just for the records, this triggered this commit:
http://lists.linbit.com/pipermail/drbd-cvs/2007-January/001458.html

-Phil
--=20
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Vivenotgasse 48, 1120 Vienna, Austria        http://www.linbit.com :
_______________________________________________
drbd-dev mailing list
drbd-dev@lists.linbit.com
http://lists.linbit.com/mailman/listinfo/drbd-dev
_______________________________________________
drbd-dev mailing list
drbd-dev@lists.linbit.com
http://lists.linbit.com/mailman/listinfo/drbd-dev
_______________________________________________
drbd-dev mailing list
drbd-dev@lists.linbit.com
http://lists.linbit.com/mailman/listinfo/drbd-dev

------_=_NextPart_001_01C74721.A687C736
Content-Type: application/octet-stream;
	name="drbd_receiver.c.panic.patch"
Content-Transfer-Encoding: base64
Content-Description: drbd_receiver.c.panic.patch
Content-Disposition: attachment;
	filename="drbd_receiver.c.panic.patch"

SW5kZXg6IHRydW5rL2RyYmQvZHJiZF9yZWNlaXZlci5jCj09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KLS0tIHRydW5rL2Ry
YmQvZHJiZF9yZWNlaXZlci5jCShyZXZpc2lvbiA5OTIzKQorKysgdHJ1bmsvZHJiZC9kcmJkX3Jl
Y2VpdmVyLmMJKHdvcmtpbmcgY29weSkKQEAgLTMxMzksNyArMzEzOSwxMSBAQAogCXVwZGF0ZV9w
ZWVyX3NlcShtZGV2LGJlMzJfdG9fY3B1KHAtPnNlcV9udW0pKTsKIAogCWlmKCBpc19zeW5jZXJf
YmxvY2tfaWQocC0+YmxvY2tfaWQpKSB7Ci0JCWRyYmRfc2V0X2luX3N5bmMobWRldixzZWN0b3Is
Ymxrc2l6ZSk7CisgICAgICBpZihpbmNfbG9jYWxfaWZfc3RhdGUobWRldixGYWlsZWQpKQorICAg
ICAgeworICAgICAgICAgZHJiZF9zZXRfaW5fc3luYyhtZGV2LHNlY3RvcixibGtzaXplKTsKKyAg
ICAgICAgIGRlY19sb2NhbChtZGV2KTsKKyAgICAgIH0KIAkJZGVjX3JzX3BlbmRpbmcobWRldik7
CiAJfSBlbHNlIHsKIAkJc3Bpbl9sb2NrX2lycSgmbWRldi0+cmVxX2xvY2spOwo=

------_=_NextPart_001_01C74721.A687C736--
