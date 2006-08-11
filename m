Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Aug 2006 22:31:43 -0400
Message-ID: <342BAC0A5467384983B586A6B0B3767103624EB8@EXNA.corp.stratus.com>
From: "Graham, Simon" <Simon.Graham@stratus.com>
To: <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] DRBD-8: recent regression causing corruption and crashes
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

It seems that there has been a recent regression (somewhere in the past
couple of weeks) that is causing me a couple of nasty and very
reproducible problems as follows:

1. I get errors during initial synchronization of a volume like this
that cause the resync to be aborted:

drbd15: tl_verify: failed to find req e51a4da0, sector 0 in list
drbd15: Got a corrupt block_id/sector pair(2).
drbd15: short read expecting header on sock: r=3D-512
drbd15: tl_clear()

	and

drbd15: ASSERT( drbd_req_get_sector(i) =3D=3D sector ) in
/sandbox/sgraham/sn/trunk/platform/drbd/8.0/drbd/drbd_main.c:308
drbd15: tl_verify: found req eaffff28 but it has wrong sector (ac030
versus 0)

	(Note that this trace is the enhanced trace I posted a few hours
ago). When I turn on the packet tracing I get some very
	odd messages, including lots of WriteAck's with 0 for the sector
(but everything else correct - SYNCER_ID for the block id and an=20
      incrementing sequence number 0 like this:

Aug 10 10:58:24 ellwood kernel: drbd15: <<< WriteAck (sector 0, size
8000, id ffffffffffffffff, seq 1671)
Aug 10 10:58:24 ellwood kernel: drbd15: <<< WriteAck (sector 0, size
8000, id ffffffffffffffff, seq 1672)
Aug 10 10:58:24 ellwood kernel: drbd15: <<< WriteAck (sector 0, size
8000, id ffffffffffffffff, seq 1673)

	but I don't see the Ack's with non-SYNCER_ID block id that cause
the previous trace (I'm guessing this is just
	printk not writing all trace messages due to the rate). At first
I thought this was just a bug in the printing
	code but I'm damned if I can spot it!

2. I get panics with the following signature:- these look like they are
happening when a local write
    on the primary (which this node is) completes.

drbd15: tl_verify: failed to find req eab1ce48, sector 0 in list
drbd15: Got a corrupt block_id/sector pair(2).
drbd15: drbd_pp_alloc interrupted!
drbd15: error receiving RSDataRequest, l: 24!
drbd15: tl_clear()
general protection fault: 6fa0 [#1]
Modules linked in: drbd ipmi_devintf ipmi_si ipmi_msghandler video
thermal processor fan button battery ac
CPU:    0
EIP:    0061:[<eafabf4f>]    Not tainted VLI
EFLAGS: 00010096   (2.6.16.13-xen0 #2)=20
EIP is at 0xeafabf4f
eax: eafabf3f   ebx: 00000001   ecx: 00000001   edx: 00000003
esi: eafabf48   edi: bf48eafa   ebp: c0557cbc   esp: c0557c9c
ds: 007b   es: 007b   ss: 0069
Process swapper (pid: 0, threadinfo=3Dc0556000 task=3Dc04c6860)
Stack: <0>c0115a98 eafabf40 00000003 00000000 00000000 00000000 00000001
00000020=20
       c0557ce0 c0115b03 eaf97634 00000003 00000001 00000000 00000000
00000001=20
       eaf975e8 c0557cec c021c27f 00000000 c0557d20 c044ca27 eaf97624
eaf97624=20
Call Trace:
 [<c010513a>] show_stack_log_lvl+0xaa/0xe0
 [<c010534e>] show_registers+0x18e/0x210
 [<c0105549>] die+0xd9/0x180
 [<c0105eb4>] do_general_protection+0xc4/0x100
 [<c0104d5f>] error_code+0x2b/0x30
 [<c0115b03>] __wake_up+0x33/0x60
 [<c021c27f>] __up+0x1f/0x30
 [<c044ca27>] __up_wakeup+0x7/0x10
 [<f127f107>] drbd_endio_write_pri+0xa7/0x230 [drbd]
 [<c015efaf>] bio_endio+0x4f/0x80
 [<c03cf569>] dec_pending+0x49/0x80
 [<c03cf64b>] clone_endio+0xab/0xd0
 [<c015efaf>] bio_endio+0x4f/0x80
 [<c020e260>] __end_that_request_first+0xc0/0x340
 [<c020e52f>] end_that_request_chunk+0x1f/0x30
 [<c0310b57>] scsi_end_request+0x37/0x110
 [<c0310ea4>] scsi_io_completion+0x104/0x530
 [<c037c4fa>] sd_rw_intr+0xca/0x290
 [<c030bdd5>] scsi_finish_command+0x85/0xa0
 [<c03118cb>] scsi_softirq_done+0xcb/0xf0
 [<c020e5cb>] blk_done_softirq+0x8b/0xb0
 [<c011e4c2>] __do_softirq+0x62/0xd0
 [<c011e578>] do_softirq+0x48/0x60
 [<c011e645>] irq_exit+0x35/0x40
 [<c01067a2>] do_IRQ+0x22/0x30
 [<c02dfb74>] evtchn_do_upcall+0x54/0xa0
 [<c0104d90>] hypervisor_callback+0x2c/0x34
 [<c0102b36>] cpu_idle+0x66/0x70
 [<c010202b>] _stext+0x2b/0x40
 [<c055886a>] start_kernel+0x1aa/0x1f0
 [<c010006f>] 0xc010006f
Code: 00 a0 fa ea 6c bf fa ea 25 e4 44 c0 34 76 f9 ea 00 a0 fa ea 30 20
1d eb 00 00 00 00 01 00 00 00 30 20 1d eb 48 bf fa ea 48 bf fa <ea> 34
76 f9 ea a0 6f ad ea e8 75 f9 ea 24 76 f9 ea a0 6f ad ea=20
 <0>Kernel panic - not syncing: Fatal exception in interrupt

At the moment I'm somewhat stumped by this and would welcome any
thoughts on where to look...

Thanks
Simon

PS: Should have explained what we did before hand - the sequence is:

1. Both nodes issue drbdmeta commands to initialize the disk area - this
is done independently - that is, the systems
   are not connected at this point.

2. One node mounts the drbd disk and untars a blob of data, still not
connected to the other node

3, The systems are connected and rebooted and start resyncing
automatically, leading to the above problems.
   Note that we are also writing the volume on the SyncSource during the
resync.
