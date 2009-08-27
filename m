Return-Path: <cyril@bouthors.org>
Received: from mail.jexiste.org (control2.isvtec.com [87.98.193.131])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id B97781069358
	for <drbd-dev@lists.linbit.com>; Thu, 27 Aug 2009 23:13:56 +0200 (CEST)
Received: from [10.1.3.100] (helo=wide.bouthors.org)
	by mail.jexiste.org with esmtpa (Exim 4.63)
	(envelope-from <cyril@bouthors.org>) id 1Mgm3F-00007W-JT
	for drbd-dev@lists.linbit.com; Thu, 27 Aug 2009 20:58:33 +0000
Received: from cyb by wide.bouthors.org with local (Exim 4.69)
	(envelope-from <cyril@bouthors.org>) id 1Mgm3E-0006KF-Om
	for drbd-dev@lists.linbit.com; Thu, 27 Aug 2009 22:58:32 +0200
From: Cyril Bouthors <cyril@bouthors.org>
To: drbd-dev@lists.linbit.com
Date: Thu, 27 Aug 2009 22:58:32 +0200
Message-ID: <8763c9ynwn.fsf@wide.bouthors.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Drbd-dev] Out of memory on 8.0.14 and 2.6.26
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

In case anyone is interested, I'm having issues with DRBD on a virgin
Lenny with vserver patch :

 - kernel 2.6.26-2-vserver-amd64
 - drbd 2.6.26+8.0.14-6+lenny1 official

[ 3462.898608] drbd3: disk( Diskless -> Attaching )
[ 3462.898648] drbd3: Starting worker thread (from cqueue [3668])
[ 3462.898608] drbd3: ASSERT( mdev->state.disk == Diskless && mdev->state.conn == StandAlone ) in /build/buildd/linux-modules-extra-2.6-2.6.26/debian/build/build_amd64_vserver_amd64_drbd8/drbd/drbd_worker.c:1091
[ 3462.898608] drbd3: drbd_bm_resize called with capacity == 0
[ 3462.898608] drbd3: worker terminated
[ 3462.898608] drbd3: Terminating worker thread
[ 3462.900246] drbd3: No usable activity log found.
[ 3462.900246] drbd3: max_segment_size ( = BIO size ) = 32768
[ 3462.900246] drbd3: drbd_bm_resize: (!b) in /build/buildd/linux-modules-extra-2.6-2.6.26/debian/build/build_amd64_vserver_amd64_drbd8/drbd/drbd_bitmap.c:355
[ 3462.900246] drbd3: drbd_bm_capacity: (!mdev->bitmap) in /build/buildd/linux-modules-extra-2.6-2.6.26/debian/build/build_amd64_vserver_amd64_drbd8/drbd/drbd_bitmap.c:233
[ 3462.900246] drbd3: OUT OF MEMORY! Could not allocate bitmap! <6>drbd3: size = 0 KB (0 KB)
[ 3462.900246] drbd3: disk( Attaching -> Diskless )
[ 3540.392381] IPv6 addrconf: prefix with wrong length 56
[ 3698.114449] drbd3: drbd_nl_disk_conf: mdev->bc not NULL.
[ 3732.668318] drbd3: drbd_nl_disk_conf: mdev->bc not NULL.
[ 3732.668318] general protection fault: 0000 [1] SMP
[ 3732.668318] CPU 7
[ 3732.668318] Modules linked in: xt_multiport sha1_generic drbd cn tun nfsd auth_rpcgss exportfs nfs lockd nfs_acl sunrpc ipt_MASQUERADE iptable_nat nf_nat nf_conntrack_ipv4 nf_conntrack iptable_filter ip_tables x_tables bridge snd_pcm snd_timer pcspkr snd soundcore snd_page_alloc button i2c_nforce2 i2c_core evdev ext3 jbd mbcache dm_mirror dm_log dm_snapshot dm_mod sd_mod sata_nv ata_generic libata dock floppy mptsas mptscsih mptbase scsi_transport_sas scsi_mod ehci_hcd amd74xx ide_pci_generic forcedeth ide_core ohci_hcd thermal processor fan thermal_sys
[ 3732.668318] Pid: 3668, comm: cqueue Not tainted 2.6.26-2-vserver-amd64 #1
[ 3732.668318] RIP: 0010:[<ffffffff802a7447>]  [<ffffffff802a7447>] fput+0x0/0x11
[ 3732.668318] RSP: 0018:ffff810225129e08  EFLAGS: 00010286
[ 3732.671853] RAX: 000000000000003f RBX: 0000000000000005 RCX: ffffffff80544188
[ 3732.671853] RDX: 0000000100000000 RSI: 0000000000000082 RDI: ea0c5283020a000a
[ 3732.671853] RBP: ffff81042682a800 R08: ffffffff80544170 R09: 0000000000000001
[ 3732.671853] R10: 0000000000000001 R11: ffff81022f23ca00 R12: 000000000000007c
[ 3732.671853] R13: ffff810223d5cc24 R14: ffff810424cb5e00 R15: ffff81042682a800
[ 3732.671853] FS:  00007f9f4277e6e0(0000) GS:ffff81042721c840(0000) knlGS:0000000000000000
[ 3732.671853] CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
[ 3732.671853] CR2: 00007f0fa7cb8000 CR3: 0000000425d9c000 CR4: 00000000000006e0
[ 3732.671853] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 3732.671853] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
[ 3732.671853] Process cqueue (pid: 3668, threadinfo ffff810225128000, task ffff810225d21810)
[ 3732.671853] Stack:  ffffffffa0308e9b ffff810413cae154 ffff810424cb5e00 0000000000000000
[ 3732.671853]  0000000000000030 ffff810413cae140 ffff810223d5cc10 ffff810223d5cc24
[ 3732.671853]  ffffffffa031b970 ffff81042682a800 ffffffffa0307b0f ffff810225d21810
[ 3732.671853] Call Trace:
[ 3732.671853]  [<ffffffffa0308e9b>] ? :drbd:drbd_nl_disk_conf+0xb15/0xbb0
[ 3732.671853]  [<ffffffffa0307b0f>] ? :drbd:drbd_connector_callback+0xfb/0x1a4
[ 3732.671853]  [<ffffffffa02e70c3>] ? :cn:cn_queue_wrapper+0x0/0x33
[ 3732.671853]  [<ffffffffa02e70d8>] ? :cn:cn_queue_wrapper+0x15/0x33
[ 3732.671853]  [<ffffffff80243d14>] ? run_workqueue+0x82/0x111
[ 3732.671853]  [<ffffffff802445e1>] ? worker_thread+0xd5/0xe0
[ 3732.671853]  [<ffffffff80246f99>] ? autoremove_wake_function+0x0/0x2e
[ 3732.671853]  [<ffffffff8024450c>] ? worker_thread+0x0/0xe0
[ 3732.671853]  [<ffffffff80246e71>] ? kthread+0x47/0x76
[ 3732.671853]  [<ffffffff80230258>] ? schedule_tail+0x27/0x86
[ 3732.671853]  [<ffffffff8020cf28>] ? child_rip+0xa/0x12
[ 3732.671853]  [<ffffffff80246e2a>] ? kthread+0x0/0x76
[ 3732.671853]  [<ffffffff8020cf1e>] ? child_rip+0x0/0x12
[ 3732.671853]
[ 3732.671853]
[ 3732.671853] Code: 2b fb ff ff 48 83 ce ff 48 c7 c7 00 f6 5a 80 ba 40 00 00 00 e8 c2 b2 08 00 48 89 df 48 c7 c6 7d 6f 2a 80 5b e9 ed 0f fd ff 5b c3 <f0> ff 4f 28 0f 94 c0 84 c0 74 05 e9 7c fb ff ff c3 55 48 89 f5
[ 3732.671853] RIP  [<ffffffff802a7447>] fput+0x0/0x11
[ 3732.671853]  RSP <ffff810225129e08>
[ 3732.673618] ---[ end trace 27770b5e3b5fca04 ]---

-- 
Cyril Bouthors
