Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 8 Aug 2006 10:47:04 -0400
Message-ID: <342BAC0A5467384983B586A6B0B37671034713A9@EXNA.corp.stratus.com>
From: "Graham, Simon" <Simon.Graham@stratus.com>
To: <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] DRBD-8: Disk I/O failure during processing of attach
	command causes panic in drbd_chk_io_error
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

The drbd_ioctl_set_disk() routine allocates a new backing_dev structure
but does not attach it to the mdev until after the meta data has been
successfully read - if any disk error (such as a read of the meta data
area failing) occurs during this process, the low level routines such as
drbd_al_read_tr call drbd_chk_io_error which assumes that mdev->bc has
been initialized, leading to a panic.

Not sure what the right answer is here, but perhaps drbd_chk_io_error()
and drbd_io_error() need to be passed the backing_dev* as a parameter
instead of reading it from mdev->bc?

/simgr

--- sample panic ---

Aug  8 10:32:05 ellwood kernel: Simulating read meta-data sync failure
Aug  8 10:32:05 ellwood kernel: drbd15:
drbd_md_sync_page_io(,2097082,READ) failed!
Aug  8 10:32:05 ellwood kernel: Unable to handle kernel NULL pointer
dereference at virtual address 00000014
Aug  8 10:32:05 ellwood kernel:  printing eip:
Aug  8 10:32:05 ellwood kernel: f1115997
Aug  8 10:32:05 ellwood kernel: *pde =3D ma 00000000 pa fffff000
Aug  8 10:32:05 ellwood kernel: Oops: 0000 [#1]
Aug  8 10:32:05 ellwood kernel: Modules linked in: drbd ipmi_devintf
ipmi_si ipmi_msghandler video thermal processor fan button battery ac
Aug  8 10:32:05 ellwood kernel: CPU:    0
Aug  8 10:32:05 ellwood kernel: EIP:    0061:[<f1115997>]    Not tainted
VLI
Aug  8 10:32:05 ellwood kernel: EFLAGS: 00010046   (2.6.16.13-xen0 #1)=20
Aug  8 10:32:05 ellwood kernel: EIP is at drbd_al_read_tr+0x87/0x170
[drbd]
Aug  8 10:32:05 ellwood kernel: eax: 00000000   ebx: 00000000   ecx:
00004ee0   edx: 00000001
Aug  8 10:32:05 ellwood kernel: esi: ebd2d000   edi: ec117660   ebp:
ec19bd9c   esp: ec19bd80
Aug  8 10:32:05 ellwood kernel: ds: 007b   es: 007b   ss: 0069
Aug  8 10:32:05 ellwood kernel: Process drbdsetup (pid: 7639,
threadinfo=3Dec19a000 task=3Decb00530)
Aug  8 10:32:05 ellwood kernel: Stack: <0>ec117660 ee4e7c40 001fffba
00000000 00000000 ebd2d000 ec117660 ec19bde4=20
Aug  8 10:32:05 ellwood kernel:        f1115b29 ec117660 ee4e7c40
ebd2d000 00000002 f1105a02 00000005 00000000=20
Aug  8 10:32:05 ellwood kernel:        00000000 0000000d 0000000c
00000002 00000001 00000000 ee4e7c40 00000000=20
Aug  8 10:32:05 ellwood kernel: Call Trace:
Aug  8 10:32:05 ellwood kernel:  [<c010513a>]
show_stack_log_lvl+0xaa/0xe0
Aug  8 10:32:05 ellwood kernel:  [<c010534e>] show_registers+0x18e/0x210
Aug  8 10:32:05 ellwood kernel:  [<c0105549>] die+0xd9/0x180
Aug  8 10:32:05 ellwood kernel:  [<c0112b7c>] do_page_fault+0x3cc/0x640
Aug  8 10:32:05 ellwood kernel:  [<c0104d5f>] error_code+0x2b/0x30
Aug  8 10:32:05 ellwood kernel:  [<f1115b29>]
drbd_al_read_log+0xa9/0x330 [drbd]
Aug  8 10:32:05 ellwood kernel:  [<f1105fe1>]
drbd_ioctl_set_disk+0x3c1/0x760 [drbd]
Aug  8 10:32:05 ellwood kernel:  [<f110812e>] drbd_ioctl+0x7ee/0x825
[drbd]
Aug  8 10:32:05 ellwood kernel:  [<c020f702>]
blkdev_driver_ioctl+0x42/0x70
Aug  8 10:32:05 ellwood kernel:  [<c020f8af>] blkdev_ioctl+0x17f/0x200
Aug  8 10:32:05 ellwood kernel:  [<c016182b>] block_ioctl+0x2b/0x30
Aug  8 10:32:05 ellwood kernel:  [<c016b76e>] do_ioctl+0x6e/0x80
Aug  8 10:32:05 ellwood kernel:  [<c016b8c2>] vfs_ioctl+0x62/0x1d0
Aug  8 10:32:05 ellwood kernel:  [<c016ba71>] sys_ioctl+0x41/0x70
Aug  8 10:32:05 ellwood kernel:  [<c0104be9>] syscall_call+0x7/0xb
Aug  8 10:32:05 ellwood kernel: Code: 7e f2 31 d2 8b 86 f8 01 00 00 0f
c8 39 d8 0f 44 d1 83 c4 10 89 d0 5b 5e 5f 5d c3 a1 bc 75 4c c0 0f b6 58
01 c6 40 01 01 8b 47 30 <8b> 40 14 83 f8 01 0f 84 82 00 00 00 72 33 83
f8 02 74 2e 8b 15=20
Aug  8 10:32:05 ellwood kernel:  <0>Fatal exception: panic in 5 seconds
