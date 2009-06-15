Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id C3698101380B
	for <drbd-dev@lists.linbit.com>; Mon, 15 Jun 2009 15:02:39 +0200 (CEST)
Resent-Message-ID: <20090615130238.GB8739@soda.linbit>
Received: from mail.carnet.hr (mail.CARNet.hr [161.53.123.6])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 837A0101380B
	for <drbd-dev@lists.linbit.com>; Mon, 15 Jun 2009 14:15:47 +0200 (CEST)
Date: Mon, 15 Jun 2009 13:58:57 +0200
From: Valentin Vidic <Valentin.Vidic@CARNet.hr>
To: drbd-dev@lists.linbit.com
Message-ID: <20090615115856.GV15441@gavran.carpriv.carnet.hr>
References: <200906121138.55945.philipp.reisner@linbit.com>
	<20090614035828.GA20436@soda.linbit>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090614035828.GA20436@soda.linbit>
Cc: Tom Brown <wc-linbit.com@vmail.baremetal.com>,
	Ivars =?utf-8?B?U3RyYXpkacWGxaE=?= <ivars.strazdins@gmail.com>
Subject: Re: [Drbd-dev] possible FIX [Xen - DRBD issue / panic
	in	skb_copy_bits]
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Sun, Jun 14, 2009 at 05:58:28AM +0200, Lars Ellenberg wrote:
> But this might fix it.
> Though I'm not able to reproduce the problem, the Linbit Xen test setup
> apparently does not break.  So I cannot confirm it fixed, either.
> 
> Please, someone who can reproduce the problem without this patch,
> verify and give feedback whether this fixes it.

I've reproduced the problem with Debian lenny versions of kernel (2.6.26)
and DRBD (8.0.14). Unfortunately it seems the patches don't help. I've
tried both and the ooops still happens: 

[  324.221585] drbd0: PingAck did not arrive in time.
[  324.227086] drbd0: peer( Secondary -> Unknown ) conn( Connected -> NetworkFailure ) pdsk( UpToDate -> DUnknown ) susp( 0 -> 1 ) 
[  324.243076] drbd0: asender terminated
[  324.243085] drbd0: Creating new current UUID
[  324.247081] drbd0: short read expecting header on sock: r=-512
[  324.257741] drbd0: Terminating asender thread
[  324.262770] drbd0: Connection closed
[  324.266776] drbd0: helper command: /sbin/drbdadm outdate-peer minor-0
[  325.191228] drbd1: PingAck did not arrive in time.
[  325.196733] drbd1: peer( Secondary -> Unknown ) conn( Connected -> NetworkFailure ) pdsk( UpToDate -> DUnknown ) susp( 0 -> 1 ) 
[  325.212725] drbd1: asender terminated
[  325.214269] drbd1: short read expecting header on sock: r=-512
[  325.222266] drbd1: Creating new current UUID
[  325.232767] drbd1: Terminating asender thread
[  325.238099] drbd1: Connection closed
[  325.242107] drbd1: helper command: /sbin/drbdadm outdate-peer minor-1
[  325.826381] drbd2: susp( 0 -> 1 ) 
[  325.829027] device vif3.0 entered promiscuous mode
[  325.830112] xenbr0: port 4(vif3.0) entering learning state
[  325.833034] xenbr0: topology change detected, propagating
[  325.833037] xenbr0: port 4(vif3.0) entering forwarding state
[  325.858724] drbd2: helper command: /sbin/drbdadm outdate-peer minor-2
[  325.886905] drbd2: helper command: /sbin/drbdadm outdate-peer minor-2 exit code 5 (0x500)
[  325.896221] drbd2: outdate-peer helper returned 5 (peer is unreachable, assumed to be dead)
[  325.906764] drbd2: role( Secondary -> Primary ) pdsk( DUnknown -> Outdated ) 
[  325.918524] drbd2: susp( 1 -> 0 ) 
[  325.922603] drbd2: Creating new current UUID
[  326.270542] blkback: ring-ref 8, event-channel 8, protocol 1 (x86_64-abi)
[  335.140402] drbd0: helper command: /sbin/drbdadm outdate-peer minor-0 exit code 5 (0x500)
[  335.148469] drbd0: outdate-peer helper returned 5 (peer is unreachable, assumed to be dead)
[  335.160480] drbd0: pdsk( DUnknown -> Outdated ) 
[  335.175286] drbd0: susp( 1 -> 0 ) 
[  335.175558] drbd0: conn( NetworkFailure -> Unconnected ) 
[  335.183290] drbd0: receiver terminated
[  335.187735] drbd0: Restarting receiver thread
[  335.195736] drbd0: receiver (re)started
[  335.200170] drbd0: conn( Unconnected -> WFConnection ) 
[  335.441825] drbd1: helper command: /sbin/drbdadm outdate-peer minor-1 exit code 5 (0x500)
[  335.452406] drbd1: outdate-peer helper returned 5 (peer is unreachable, assumed to be dead)
[  335.461933] drbd1: pdsk( DUnknown -> Outdated ) 
[  335.468304] drbd1: susp( 1 -> 0 ) 
[  335.475648] drbd1: conn( NetworkFailure -> Unconnected ) 
[  335.482274] drbd1: receiver terminated
[  335.486587] drbd1: Restarting receiver thread
[  335.491590] drbd1: receiver (re)started
[  335.499686] drbd1: conn( Unconnected -> WFConnection ) 
[  340.785501] BUG: unable to handle kernel paging request at ffff880001534000
[  340.793653] IP: [<ffffffff803bfabb>] skb_copy_bits+0x12d/0x201
[  340.793653] PGD 1c5a067 PUD 1c5b067 PMD 1c66067 PTE 0
[  340.805645] Oops: 0000 [1] SMP 
[  340.805645] CPU 0 
[  340.805645] Modules linked in: xt_physdev sha1_generic drbd cn ipt_REJECT xt_tcpudp xt_multiport nf_conntrack_ipv4 xt_state nf_conntrack iptable_filter ip_tables x_tables ipv6 bridge bonding ipmi_si ipmi_devintf ipmi_msghandler 8021q loop iTCO_wdt psmouse parport_pc serio_raw parport rng_core i2c_i801 i2c_core pcspkr container i5000_edac edac_core shpchp button pci_hotplug evdev usbhid hid ff_memless ext3 jbd mbcache dm_mirror dm_log dm_snapshot dm_mod sg sr_mod cdrom ata_piix ata_generic libata dock ses sd_mod enclosure floppy ide_pci_generic ide_core bnx2 firmware_class ehci_hcd uhci_hcd megaraid_sas scsi_mod thermal processor fan thermal_sys
[  340.881648] Pid: 0, comm: swapper Not tainted 2.6.26-2-xen-amd64 #1
[  340.881648] RIP: e030:[<ffffffff803bfabb>]  [<ffffffff803bfabb>] skb_copy_bits+0x12d/0x201
[  340.881648] RSP: e02b:ffffffff80595c50  EFLAGS: 00010286
[  340.881648] RAX: 0000000000000062 RBX: ffff88001ed0b5a8 RCX: 0000000000000588
[  340.881648] RDX: ffff88001dc26010 RSI: ffff880001534000 RDI: ffff88001dc261a0
[  340.881648] RBP: 0000000000000588 R08: 00000000000005ea R09: 0000000000000588
[  340.881648] R10: ffff880080000000 R11: ffffffff803c8320 R12: 0000000000000062
[  340.881648] R13: 0000000000000001 R14: 0000000000000062 R15: ffff88001dc261a0
[  340.881648] FS:  00007f65af826730(0000) GS:ffffffff80539000(0000) knlGS:0000000000000000
[  340.881648] CS:  e033 DS: 0000 ES: 0000
[  340.881648] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  340.881648] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
[  340.881648] Process swapper (pid: 0, threadinfo ffffffff80552000, task ffffffff804fe460)
[  340.881648] Stack:  ffff88001ed0b5a8 ffff8800017e2000 ffff88001ed0b5a8 ffff88001ed0b5a8
[  340.881648]  0000000000000000 0000000000000000 00000000000005a8 ffffffff803c078b
[  340.881648]  0000000200000000 ffff8800017e2000 ffff88001ed0b5a8 ffff88001ed0b5a8
[  340.881648] Call Trace:
[  340.881648]  <IRQ>  [<ffffffff803c078b>] ? __pskb_pull_tail+0x86/0x294
[  340.881648]  [<ffffffff803c8473>] ? dev_queue_xmit+0x153/0x3ec
[  340.881648]  [<ffffffff803e9701>] ? ip_queue_xmit+0x29a/0x2ed
[  340.881648]  [<ffffffff80409f23>] ? inet_sk_rebuild_header+0xf2/0x32f
[  340.881648]  [<ffffffff8020e7b4>] ? get_nsec_offset+0x9/0x2c
[  340.881648]  [<ffffffff8020e7b4>] ? get_nsec_offset+0x9/0x2c
[  340.881648]  [<ffffffff8020e810>] ? local_clock+0x39/0x83
[  340.881648]  [<ffffffff803f9618>] ? tcp_transmit_skb+0x739/0x776
[  340.881648]  [<ffffffff8020e8e3>] ? sched_clock+0x15/0x36
[  340.881648]  [<ffffffff803fa2df>] ? tcp_retransmit_skb+0x48f/0x599
[  340.881648]  [<ffffffff803fc8ed>] ? tcp_write_timer+0x557/0x77e
[  340.881648]  [<ffffffff8020ee50>] ? timer_interrupt+0x401/0x415
[  340.881648]  [<ffffffff803fc396>] ? tcp_write_timer+0x0/0x77e
[  340.881648]  [<ffffffff802356b7>] ? run_timer_softirq+0x190/0x237
[  340.881648]  [<ffffffff80231ca0>] ? __do_softirq+0x77/0x103
[  340.881648]  [<ffffffff8020c13c>] ? call_softirq+0x1c/0x28
[  340.881648]  [<ffffffff8020e08a>] ? do_softirq+0x55/0xbb
[  340.881648]  [<ffffffff8020e16d>] ? do_IRQ+0x7d/0x9a
[  340.881648]  [<ffffffff8037d42c>] ? evtchn_do_upcall+0x13c/0x1fc
[  340.881648]  [<ffffffff8020bbde>] ? do_hypervisor_callback+0x1e/0x30
[  340.881648]  <EOI>  [<ffffffff8020e795>] ? xen_safe_halt+0x90/0xa6
[  340.881648]  [<ffffffff8020a0c8>] ? xen_idle+0x2e/0x66
[  340.881648]  [<ffffffff80209cd6>] ? cpu_idle+0x97/0xb9
[  340.881648] 
[  340.881648] 
[  340.881648] Code: f0 48 b8 00 00 00 00 00 88 ff ff 48 c1 e6 0c 48 01 c6 8b 83 c8 00 00 00 8b 44 02 20 48 01 c6 49 63 c4 48 01 c6 49 63 c6 48 29 c6 <f3> a4 65 48 8b 04 25 10 00 00 00 ff 88 44 e0 ff ff 44 29 cd 0f 
[  340.881648] RIP  [<ffffffff803bfabb>] skb_copy_bits+0x12d/0x201
[  340.881648]  RSP <ffffffff80595c50>
[  340.881648] CR2: ffff880001534000
[  340.881648] ---[ end trace af90b7643bf78b52 ]---
[  340.881648] Kernel panic - not syncing: Aiee, killing interrupt handler!

-- 
Valentin Vidic
Computer systems engineer
Computer and IT Systems and Services Department
Croatian Academic and Research Network - CARNet
Josipa Marohnica 5, HR-10000 Zagreb, Croatia
tel: +385 1 6661 714, fax. +385 1 6661 766
www.CARNet.hr
