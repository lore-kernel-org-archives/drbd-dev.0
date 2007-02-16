Return-Path: <Ernest.Montrose@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Drbd-dev] DRBD8: Panic in drbd_bm_write_sect() after an io
	errorduring resync.
Date: Fri, 16 Feb 2007 09:55:12 -0500
Message-ID: <BD7042533C2F8943A6A4257A9E31C45439C8FE@EXNA.corp.stratus.com>
From: "Montrose, Ernest" <Ernest.Montrose@stratus.com>
To: "Philipp Reisner" <philipp.reisner@linbit.com>, <drbd-dev@lists.linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Phil,
Thanks!

I think all these panics on I/O errors are all related to the same bug.

Your comments make me look at a different angle... Looking at the logs
around the failure
Shows a problem on repeated I/O errors...the state machine is somewhat
confused..It essentially
Goes from Uptodate->Failed which is fine...then from
Failed->Diskless...fine...then we go and
Wait for mdev->local_cnt to be false like you explained...
Then we get more I/O errors...and our problem starts...
We go from Diskless->failed..again.(This does not seem correct since we
just went from this state)
Then faile->diskless again
We get more I/O errors...(not good)
Mdev->bc is set to null eventually
We went and wait again for mdev->local_cnt to be False..(not good)
Now we die an awful ungodly death..:)

Here is the full log around the failure:
Feb 15 16:01:57 captain kernel: end_request: I/O error, dev sda, sector
17554615
Feb 15 16:01:57 captain kernel: drbd0: disk( UpToDate -> Failed )
Feb 15 16:01:57 captain kernel: drbd0: Local IO failed. Detaching...
Feb 15 16:01:57 captain kernel: drbd_io_error: EM--****** Handling an IO
error***mdev->bc is valid***********************
Feb 15 16:01:57 captain kernel: drbd0: disk( Failed -> Diskless )
Feb 15 16:01:57 captain kernel: drbd0: Notified peer that my disk is
broken.
Feb 15 16:01:57 captain kernel: after_state_ch: EM-- *******Waiting for
mdev->local_cnt to be FALSE ******
Feb 15 16:01:57 captain kernel: end_request: I/O error, dev sda, sector
17554623
Feb 15 16:01:57 captain kernel: drbd0: disk( Diskless -> Failed )
Feb 15 16:01:57 captain kernel: drbd0: Local IO failed. Detaching...
Feb 15 16:01:57 captain kernel: drbd_io_error: EM--****** Handling an IO
error***mdev->bc is valid***********************
Feb 15 16:01:57 captain kernel: drbd0: disk( Failed -> Diskless )
Feb 15 16:01:57 captain kernel: drbd0: Notified peer that my disk is
broken.
Feb 15 16:01:57 captain kernel: end_request: I/O error, dev sda, sector
17554719
Feb 15 16:01:57 captain kernel: drbd0: disk( Diskless -> Failed )
Feb 15 16:01:57 captain kernel: drbd0: Local IO failed. Detaching...
Feb 15 16:01:57 captain kernel: after_state_ch: EM-- *******Setting
mdev->bc to NULL after freeing it ******
Feb 15 16:01:57 captain kernel: after_state_ch: EM-- *******Waiting for
mdev->local_cnt to be FALSE ******
Feb 15 16:01:57 captain kernel: after_state_ch: EM-- *******Setting
mdev->bc to NULL after freeing it ******
Feb 15 16:01:57 captain kernel: drbd_io_error: EM--****** Handling an IO
error***mdev->bc is NOT valid***********************
Feb 15 16:01:57 captain kernel: Unable to handle kernel NULL pointer
dereference at virtual address 000000ac
Feb 15 16:01:57 captain kernel:  printing eip:
Feb 15 16:01:57 captain kernel: ee3caaee
Feb 15 16:01:57 captain kernel: 0592d000 -> *pde =3D 00000001:9449d001
Feb 15 16:01:57 captain kernel: 2b89d000 -> *pme =3D 00000000:00000000
Feb 15 16:01:57 captain kernel: Oops: 0000 [#1]
Feb 15 16:01:57 captain kernel: SMP
Feb 15 16:01:57 captain kernel: Modules linked in: iptable_filter
ip_tables x_tables drbd cn bridge ipv6 ipmi_devintf ipmi_si
ipmi_msghandler i2c_dev i2c_core binfmt_misc dm_mirror video thermal
processor fan container button battery ac hw_random shpchp pci_hotplug
e1000 piix ide_cd cdrom sg raid1 dm_mod ide_disk mptscsih mptsas mptspi
mptfc mptscsi mptbase sd_mod scsi_mod
Feb 15 16:01:57 captain kernel: CPU:    0
Feb 15 16:01:57 captain kernel: EIP:    0061:[<ee3caaee>]    Tainted: GF
VLI
Feb 15 16:01:57 captain kernel: EFLAGS: 00010202  (2.6.16.29-xen #1)
Feb 15 16:01:57 captain kernel: EIP is at drbd_io_error+0x5e/0x1f0
[drbd]
Feb 15 16:01:57 captain kernel: eax: 00000000  ebx: ec877400  ecx:
f55f7000  edx: 00000000
Feb 15 16:01:57 captain kernel: esi: 00000000  edi: eafd7f58  ebp:
eafd7efc  esp: eafd7ed8
Feb 15 16:01:57 captain kernel: ds: 007b  es: 007b  ss: 0069
Feb 15 16:01:57 captain kernel: Process drbd0_asender (pid: 5743,
threadinfo=3Deafd6000 task=3Dc597fab0)
Feb 15 16:01:57 captain kernel: Stack: <0>ee3dc660 00000000 00000019
ec877400 00000000 00000000 ec877400 eab90b2c
Feb 15 16:01:57 captain kernel:        eafd7f58 eafd7f30 ee3bcce4
00000000 00000000 00000000 c597fab0 eb43c980
Feb 15 16:01:57 captain kernel:        00000001 005ee800 00000000
eab90b2c ec877400 eafd7f58 eafd7f6c ee3bab09
Feb 15 16:01:57 captain kernel: Call Trace:
Feb 15 16:01:57 captain kernel:  [<c0105401>]
show_stack_log_lvl+0xa1/0xe0
Feb 15 16:01:57 captain kernel:  [<c01055f1>] show_registers+0x181/0x200
Feb 15 16:01:57 captain kernel:  [<c0105810>] die+0x100/0x1a0
Feb 15 16:01:57 captain kernel:  [<c01156f6>] do_page_fault+0x3c6/0x8b1
Feb 15 16:01:57 captain kernel:  [<c0105067>] error_code+0x2b/0x30
Feb 15 16:01:57 captain kernel:  [<ee3bcce4>] e_end_block+0x244/0x250
[drbd]
Feb 15 16:01:57 captain kernel:  [<ee3bab09>]
drbd_process_done_ee+0xc9/0x160 [drbd]
Feb 15 16:01:57 captain kernel:  [<ee3c27bf>] drbd_asender+0x16f/0x5ad
[drbd]
Feb 15 16:01:57 captain kernel:  [<ee3ccf7c>]
drbd_thread_setup+0x8c/0x100 [drbd]
Feb 15 16:01:57 captain kernel:  [<c0102e95>]
kernel_thread_helper+0x5/0x10
Feb 15 16:01:57 captain kernel: Code: 85 c0 74 6d c7 04 24 04 c6 3d ee
e8 ad 69 d5 d1 f0 ff 83 80 02 00 00 0f b6 83 3d 02 00 00 d0 e8 83 e0 0f
83 f8 01 76 0c 8b 43 14 <8b> 80 ac 00 00 00 89 45 f0 f0 ff 8b 80 02 00
00 0f 94 c0 84 c0
Feb 15 16:01:57 captain kernel:  <0>Fatal exception: panic in 5 seconds

-----Original Message-----
From: Philipp Reisner [mailto:philipp.reisner@linbit.com]=20
Sent: Friday, February 16, 2007 6:44 AM
To: drbd-dev@linbit.com
Cc: Montrose, Ernest
Subject: Re: [Drbd-dev] DRBD8: Panic in drbd_bm_write_sect() after an io
errorduring resync.

Am Donnerstag, 15. Februar 2007 16:44 schrieb Montrose, Ernest:
> Phil,
> I will try all these but I think I have some clues for you that may=20
> lead you to a fix.
> I instrumented the driver and caused the crash. Essentially what I=20
> understand to be happening Is that after_state_ch() is setting=20
> mdev->bc to NULL and then
> drbd_io_error() is using it
> after in: drbd_io_error(){.......
>   If(inc_local_if_state(mdev,Failed )){
> 	eh =3D mdev->bc->dc.on_io_error; <-----we die here I
think.mdev->bc is=20
> NULL ...
> }
> Mdev->bc was set to Null earlier in after_state_ch(){.....
> If(os.disk >Diskless && ns.disk =3D=3D Diskless){ ....mdev->bc =3D =
NULL; ..
> }
>
> This is some sort of a race condition as this does not happen all the=20
> times.

Ernest,

At first look I would say this is not possible. Because in
after_state_ch() it only gets freed when we already reached the Diskless
state.

In drbd_io_error() the access to mdev->bc is protected by the
inc_local() - dec_local() clasp.=20

In case we are Diskless that inc_local_if...() fails.
And on the other side, before freeing it in after_state_ch() we wait
until the local_count really reached 0.=20

PS: Was my explanation how to create that .s files too brief ?

-phil
--=20
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Vivenotgasse 48, 1120 Vienna, Austria        http://www.linbit.com :
