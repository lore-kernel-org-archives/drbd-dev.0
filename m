Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [86.59.100.100])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id A372E10667DC
	for <drbd-dev@lists.linbit.com>; Tue, 19 May 2009 12:30:03 +0200 (CEST)
Date: Tue, 19 May 2009 12:30:03 +0200
From: Mickael Marchand <mikmak@freenux.org>
To: drbd-dev@lists.linbit.com
Message-ID: <20090519093313.GV17360@nya.freenux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Drbd-dev] [DRBD-user] drbd 8.3.1 OOPS
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hi,

I have a dual node Xen/drbd cluster that got a problem last week-end,
running 2.6.24-23-xen from ubuntu with self-compiled drbd 8.3.1.

for some reason a SAS disk got kicked by its controller,
drbd properly detected it :
May 17 07:44:20 ifvm1 kernel: [9678143.435599] scsi 0:0:3:0: [sdd] Result: hostbyte=DID_NO_CONNECT driverbyte=DRIVER_OK,SUGGEST_OK
May 17 07:44:20 ifvm1 kernel: [9678143.435604] end_request: I/O error, dev sdd, sector 255302231
May 17 07:44:20 ifvm1 kernel: [9678143.435609] drbd1: Method to ensure write ordering: flush
May 17 07:44:20 ifvm1 kernel: [9678143.435622] drbd1: disk( UpToDate -> Failed )
May 17 07:44:20 ifvm1 kernel: [9678143.435625] drbd1: Local IO failed.  Detaching...
May 17 07:44:20 ifvm1 kernel: [9692200.309651] drbd1: disk( Failed -> Diskless )
May 17 07:44:20 ifvm1 kernel: [9692200.309675] drbd1: Notified peer that my disk is broken.

that drbd was secondary on that host, the primary was still running fine on
the other node so I left it untouched till monday when I removed the
failing drive from the server.
Adding a working drive in the server, I wanted to attach this drive to
drbd but this failed.

I am not sure which exact command I used at this time, probably "drbdadm
attach r1" which gave :
May 18 10:59:00 ifvm1 kernel: [9791064.037185] drbd1: drbd_nl_disk_conf: mdev->bc not NULL.

so I tried to down this drbd and it OOPs-ed :

May 18 10:59:37 ifvm1 kernel: [9791101.108093] drbd1: drbd_nl_disk_conf: mdev->bc not NULL.
May 18 10:59:37 ifvm1 kernel: [9791101.108127] Unable to handle kernel paging request at 000000010000002c RIP:
May 18 10:59:37 ifvm1 kernel: [9791101.108138]  [<ffffffff8029f130>] fput+0x0/0x20
May 18 10:59:37 ifvm1 kernel: [9791101.108150] PGD 9b30067 PUD 0
May 18 10:59:37 ifvm1 kernel: [9791101.108154] Oops: 0002 [1] SMP
May 18 10:59:37 ifvm1 kernel: [9791101.108157] CPU 1
May 18 10:59:37 ifvm1 kernel: [9791101.108159] Modules linked in: drbd af_packet xt_physdev ipt_LOG xt_state xt_tcpudp iptable_nat nf_nat nf_conntrack_ipv4 nf_conntrack bridge 8021q sbs dock sbshc ac battery container video output iptable_filter ip_tables x_tables cn coretemp ipmi_devintf ipmi_si ipmi_watchdog ipmi_poweroff ipmi_msghandler parport_pc lp parport loop ipv6 megaraid_sas psmouse serio_raw iTCO_wdt evdev dcdbas iTCO_vendor_support 8250_pnp button pcspkr i5000_edac edac_core shpchp pci_hotplug 8250 serial_core ext3 jbd mbcache sr_mod cdrom pata_acpi ata_piix sg sd_mod ata_generic libata bnx2 ehci_hcd uhci_hcdusbcore mptsas mptscsih mptbase scsi_transport_sas scsi_mod raid10 raid456 async_xor async_memcpy async_tx xor raid1 raid0 multipath linear md_mod dm_mirrordm_snapshot dm_mod thermal processor fan fuse
May 18 10:59:37 ifvm1 kernel: [9791101.108249] Pid: 6693, comm: cqueue/1 Not tainted 2.6.24-23-xen #1
May 18 10:59:37 ifvm1 kernel: [9791101.108253] RIP: e030:[<ffffffff8029f130>]  [<ffffffff8029f130>] fput+0x0/0x20
May 18 10:59:37 ifvm1 kernel: [9791101.108258] RSP: e02b:ffff88001d7c9dc8  EFLAGS: 00010202
May 18 10:59:37 ifvm1 kernel: [9791101.108261] RAX: 0000000000000041 RBX: 0000000000000005 RCX: 0000000000000001
May 18 10:59:37 ifvm1 kernel: [9791101.108264] RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000100000004
May 18 10:59:37 ifvm1 kernel: [9791101.108268] RBP: ffff88001f672800 R08: 000015d2cd1350db R09: 0000000000000000
May 18 10:59:37 ifvm1 kernel: [9791101.108271] R10: ffff880001ce6fe0 R11: ffffffff80217eb0 R12: ffff880011a93000
May 18 10:59:37 ifvm1 kernel: [9791101.108274] R13: 000000000000007c R14: ffff880011a93000 R15: ffff88000aefb354
May 18 10:59:37 ifvm1 kernel: [9791101.108280] FS: 00007fc3f762c6e0(0000) GS:ffffffff805c7080(0000) knlGS:0000000000000000
May 18 10:59:37 ifvm1 kernel: [9791101.108283] CS:  e033 DS: 0000 ES: 0000
May 18 10:59:37 ifvm1 kernel: [9791101.108287] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
May 18 10:59:37 ifvm1 kernel: [9791101.108290] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
May 18 10:59:38 ifvm1 kernel: [9791101.108293] Process cqueue/1 (pid: 6693, threadinfo ffff88001d7c8000, task ffff8800016cc800)
May 18 10:59:38 ifvm1 kernel: [9791101.108297] Stack:  ffffffff88419168 ffff88001d7c9e60 0000000000000000 ffffffff8061cf80
May 18 10:59:38 ifvm1 kernel: [9791101.108303]  ffffffff8061cf80 ffffffff8061c0c0 ffffffff8061cf80 0000000000000000
May 18 10:59:38 ifvm1 kernel: [9791101.108309]  000000011f672800 00000000000000d0 0000000000000030 ffff88001c213410
May 18 10:59:38 ifvm1 kernel: [9791101.108313] Call Trace:
May 18 10:59:38 ifvm1 kernel: [9791101.108327]  [<ffffffff88419168>] :drbd:drbd_nl_disk_conf+0xb8/0xf30
May 18 10:59:38 ifvm1 kernel: [9791101.108346]  [<ffffffff88418bcc>] :drbd:drbd_connector_callback+0x11c/0x210
May 18 10:59:38 ifvm1 kernel: [9791101.108354] [cn:cn_queue_wrapper+0x0/0x30] :cn:cn_queue_wrapper+0x0/0x30
May 18 10:59:38 ifvm1 kernel: [9791101.108360] [cn:cn_queue_wrapper+0xf/0x30] :cn:cn_queue_wrapper+0xf/0x30
May 18 10:59:38 ifvm1 kernel: [9791101.108367] [run_workqueue+0xb2/0x190] run_workqueue+0xb2/0x190
May 18 10:59:38 ifvm1 kernel: [9791101.108373] [worker_thread+0x0/0x110] worker_thread+0x0/0x110
May 18 10:59:38 ifvm1 kernel: [9791101.108378] [worker_thread+0xa3/0x110] worker_thread+0xa3/0x110
May 18 10:59:38 ifvm1 kernel: [9791101.108384]  [<ffffffff8024cc80>] autoremove_wake_function+0x0/0x30
May 18 10:59:38 ifvm1 kernel: [9791101.108390] [worker_thread+0x0/0x110] worker_thread+0x0/0x110
May 18 10:59:38 ifvm1 kernel: [9791101.108395] [worker_thread+0x0/0x110] worker_thread+0x0/0x110
May 18 10:59:38 ifvm1 kernel: [9791101.108399]  [kthread+0x4b/0x80] kthread+0x4b/0x80
May 18 10:59:38 ifvm1 kernel: [9791101.108405]  [child_rip+0xa/0x12] child_rip+0xa/0x12
May 18 10:59:38 ifvm1 kernel: [9791101.108413] [xen_send_IPI_mask+0x0/0x110] xen_send_IPI_mask+0x0/0x110
May 18 10:59:38 ifvm1 kernel: [9791101.108420]  [kthread+0x0/0x80] kthread+0x0/0x80
May 18 10:59:38 ifvm1 kernel: [9791101.108424]  [child_rip+0x0/0x12] child_rip+0x0/0x12
May 18 10:59:38 ifvm1 kernel: [9791101.108429]
May 18 10:59:38 ifvm1 kernel: [9791101.108430]
May 18 10:59:38 ifvm1 kernel: [9791101.108431] Code: f0 ff 4f 28 0f 94 c0 84 c0 75 05 f3 c3 0f 1f 00 e9 cb fb ff
May 18 10:59:38 ifvm1 kernel: [9791101.108445] RIP  [<ffffffff8029f130>] fput+0x0/0x20
May 18 10:59:38 ifvm1 kernel: [9791101.108449]  RSP <ffff88001d7c9dc8>
May 18 10:59:38 ifvm1 kernel: [9791101.108451] CR2: 000000010000002c
May 18 10:59:38 ifvm1 kernel: [9791101.109019] ---[ end trace e8e64f3da06e3ef3 ]---

then drbd was dead, the other running drbds were still running (the
kernels threads were running ok) but I could not change any
configuration with drbdadm, I had to forcibly reboot this node to get it
back in right order.

Cheers,
Mik
_______________________________________________
drbd-user mailing list
drbd-user@lists.linbit.com
http://lists.linbit.com/mailman/listinfo/drbd-user

