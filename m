Return-Path: <Ernest.Montrose@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Drbd-dev] DRBD8: Panic in drbd_uuid_compare due to mdev->bc
	beingnull
Date: Mon, 11 Jun 2007 16:23:12 -0400
Message-ID: <BD7042533C2F8943A6A4257A9E31C454F4792C@EXNA.corp.stratus.com>
In-Reply-To: BD7042533C2F8943A6A4257A9E31C454F4792B@EXNA.corp.stratus.com
From: "Montrose, Ernest" <Ernest.Montrose@stratus.com>
To: "Montrose, Ernest" <Ernest.Montrose@stratus.com>,
	"Philipp Reisner" <philipp.reisner@linbit.com>, <drbd-dev@lists.linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

O! BTW,=20
Here is the stack trace for the panic:
May 25 05:42:49 chobs kernel: drbd1: disk( Diskless -> Attaching )=20
May 25 05:42:49 chobs kernel: drbd1: Found 6 transactions (276 active
extents) in activity log.
May 25 05:42:49 chobs kernel: drbd1: ASSERT( mdev->bc =3D=3D NULL ) in
/test_logs/builds/SuperNova/trunk/070525/platform/drbd/src/drbd/drbd_nl.
c:855
May 25 05:42:49 chobs kernel: drbd1: max_segment_size ( =3D BIO size ) =
=3D
32768
May 25 05:42:49 chobs kernel: drbd1: reading of bitmap took 1 jiffies
May 25 05:42:49 chobs kernel: drbd1: recounting of set bits took
additional 0 jiffies
May 25 05:42:49 chobs kernel: drbd1: 12 GB marked out-of-sync by on disk
bit-map.
May 25 05:42:49 chobs kernel: drbd1: Marked additional 0 KB as
out-of-sync based on AL.
May 25 05:42:49 chobs kernel: drbd1: disk( Attaching -> Negotiating )=20
May 25 05:42:49 chobs kernel: Unable to handle kernel NULL pointer
dereference at virtual address 00000024
May 25 05:42:49 chobs kernel:  printing eip:
May 25 05:42:49 chobs kernel: ee254765
May 25 05:42:49 chobs kernel: 24ab0000 -> *pde =3D 00000002:132ac001
May 25 05:42:49 chobs kernel: 2c8ac000 -> *pme =3D 00000000:00000000
May 25 05:42:49 chobs kernel: Oops: 0000 [#1]
May 25 05:42:49 chobs kernel: SMP=20
May 25 05:42:49 chobs kernel: Modules linked in: drbd cn ipmi_devintf
ipmi_si ipmi_msghandler ipv6 i2c_dev i2c_core bridge binfmt_misc
dm_mirror video thermal processor fan container button battery ac
uhci_hcd ehci_hcd usbcore hw_random shpchp pci_hotplug bnx2 piix
ide_generic mptfc scsi_transport_fc mptsas scsi_transport_sas mptspi
scsi_transport_spi raid1 dm_mod ide_disk mptscsih mptbase sd_mod
scsi_mod
May 25 05:42:49 chobs kernel: CPU:    0
May 25 05:42:49 chobs kernel: EIP:    0061:[<ee254765>]    Tainted: GF
VLI
May 25 05:42:49 chobs kernel: EFLAGS: 00010296  (2.6.16.38-xen #1)=20
May 25 05:42:49 chobs kernel: EIP is at drbd_uuid_compare+0x15/0x410
[drbd]
May 25 05:42:49 chobs kernel: eax: 00000000  ebx: eb8e5944  ecx:
00000008  edx: e9a43f34
May 25 05:42:49 chobs kernel: esi: eb8e5944  edi: 00000008  ebp:
e9a43f10  esp: e9a43ed8
May 25 05:42:49 chobs kernel: ds: 007b  es: 007b  ss: 0069
May 25 05:42:49 chobs kernel: Process drbd1_receiver (pid: 6060,
threadinfo=3De9a42000 task=3Ded4b1570)
May 25 05:42:49 chobs kernel: Stack: <0>e9a43ef8 e9a43ef8 e9a43efc
c016a8c5 6b458f28 eb8e59f8 00000004 eb8e5944=20
May 25 05:42:49 chobs kernel:        e9a43f44 e9a43f34 eb8e5944 eb8e59f8
eb8e5944 00000008 e9a43f44 ee254b94=20
May 25 05:42:49 chobs kernel:        00000000 00000000 e9a43f10 00000001
00000000 00000004 00000001 00000000=20
May 25 05:42:49 chobs kernel: Call Trace:
May 25 05:42:49 chobs kernel:  [<c0105a01>] show_stack_log_lvl+0xa1/0xe0
May 25 05:42:49 chobs kernel:  [<c0105bf1>] show_registers+0x181/0x200
May 25 05:42:49 chobs kernel:  [<c0105e10>] die+0x100/0x1b0
May 25 05:42:49 chobs kernel:  [<c01168f6>] do_page_fault+0x3c6/0x8c1
May 25 05:42:49 chobs kernel:  [<c010565f>] error_code+0x2b/0x30
May 25 05:42:49 chobs kernel:  [<ee254b94>]
drbd_sync_handshake+0x34/0x570 [drbd]
May 25 05:42:49 chobs kernel:  [<ee2561f4>] receive_state+0x2c4/0x3c0
[drbd]
May 25 05:42:49 chobs kernel:  [<ee2568a2>] drbdd+0x42/0x170 [drbd]
May 25 05:42:49 chobs kernel:  [<ee257c05>] drbdd_init+0x1c5/0x210
[drbd]
May 25 05:42:49 chobs kernel:  [<ee262eac>] drbd_thread_setup+0x8c/0x100
[drbd]
May 25 05:42:49 chobs kernel:  [<c0103485>]
kernel_thread_helper+0x5/0x10
May 25 05:42:49 chobs kernel: Code: de ec d1 8b 5d f8 8b 75 fc 89 ec 5d
c3 89 f6 8d bc 27 00 00 00 00 55 89 e5 57 56 53 83 ec 2c 89 45 f0 8b 5d
f0 89 55 ec 8b 40 14 <8b> 50 24 8b 40 20 89 55 e8 89 c1 83 e1 fe 89 4d
e4 8b 83 38 03=20
May 25 05:42:49 chobs kernel:  <0>Fatal exception: panic in 5 seconds

-----Original Message-----
From: drbd-dev-bounces@linbit.com [mailto:drbd-dev-bounces@linbit.com]
On Behalf Of Montrose, Ernest
Sent: Monday, June 11, 2007 4:17 PM
To: Philipp Reisner; drbd-dev@linbit.com
Subject: [Drbd-dev] DRBD8: Panic in drbd_uuid_compare due to mdev->bc
beingnull

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
