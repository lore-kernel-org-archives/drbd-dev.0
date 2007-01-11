Return-Path: <ard@kwaak.net>
Received: from mail.kwaak.net (gw-cistron.kwaak.net [62.216.22.210])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id E55FB2D9DDDE
	for <drbd-dev@lists.linbit.com>; Thu, 11 Jan 2007 19:03:28 +0100 (CET)
Received: from ard by mail.kwaak.net with local (Exim 4.50) id 1H54Go-0007QU-H6
	for drbd-dev@lists.linbit.com; Thu, 11 Jan 2007 19:03:22 +0100
Date: Thu, 11 Jan 2007 19:03:22 +0100
From: Ard van Breemen <ard@kwaak.net>
To: drbd-dev@lists.linbit.com
Message-ID: <20070111180322.GD15730@kwaak.net>
References: <20070110123116.GX15730@kwaak.net>
	<200701101723.47571.philipp.reisner@linbit.com>
	<20070111143845.GB15730@kwaak.net>
	<20070111171205.GC15730@kwaak.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20070111171205.GC15730@kwaak.net>
Subject: [Drbd-dev] oopses in 2.6.19.1
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Thu, Jan 11, 2007 at 06:12:05PM +0100, Ard van Breemen wrote:
> Your patch, but fixed with ^^^^ and working. (I do have unrelated
> oopses).

On the Inconsistent side, it starts to oops. During the first
sink I do a disconnect, and then...
I will pay more attention on the next oops on what was I doing.

drbd: initialised. Version: 8.0rc1 (api:86/proto:85)
drbd: SVN Revision: 2679M build by ard@siddev, 2007-01-11 15:51:43
drbd: registered as block device major 147
drbd: minor_table @ 0xffff81017e2ce0c0
drbd0: disk( Diskless -> Attaching )=20
drbd0: No usable activity log found.
drbd0: max_segment_size ( =3D BIO size ) =3D 32768
drbd0: Adjusting my ra_pages to backing device's (32 -> 96)
drbd0: drbd_bm_resize called with capacity =3D=3D 2318589904
drbd0: resync bitmap: bits=3D289823738 words=3D4528496
drbd0: size =3D 1105 GB (1159294952 KB)

[more]=0D      =0Ddrbd0: reading of bitmap took 86 jiffies
drbd0: recounting of set bits took additional 7 jiffies
drbd0: 892 GB marked out-of-sync by on disk bit-map.
drbd0: disk( Attaching -> Inconsistent )=20
drbd0: Writing meta data super block now.
drbd0: conn( StandAlone -> Unconnected )=20
drbd0: receiver (re)started
drbd0: conn( Unconnected -> WFConnection )=20
drbd0: conn( WFConnection -> WFReportParams )=20
drbd0: Handshake successful: DRBD Network Protocol version 85
drbd0: Peer authenticated usind 20 bytes of 'sha1' HMAC
drbd0: peer( Unknown -> Secondary ) conn( WFReportParams -> WFBitMapT ) pds=
k( DUnknown -> UpToDate )=20
drbd0: Writing meta data super block now.
drbd0: conn( WFBitMapT -> WFSyncUUID )=20
drbd0: conn( WFSyncUUID -> SyncTarget )=20
drbd0: Began resync as SyncTarget (will sync 935358440 KB [233839610 bits s=
et]).
drbd0: Writing meta data super block now.
----------- [cut here ] --------- [please bite here ] ---------
Kernel BUG at ...ed/kernel/tyan-s2891/modules/drbd/drbd/lru_cache.c:312
invalid opcode: 0000 [1] SMP=20
CPU 1=20
Modules linked in: drbd sha1 cn ipv6 tg3

[more]=0D      =0DPid: 1593:#0, comm: md6_raid5 Not tainted 2.6.19.1-vs2.2.=
0-rc6-tyan-s2891test #1
RIP: 0010:[<ffffffff8807967f>]  [<ffffffff8807967f>] :drbd:lc_put+0x4f/0xc0
RSP: 0018:ffff81017ce87c38  EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffffc20000b7c2d8 RCX: ffffc20000b7c2d8
RDX: ffffc20000b7c2d8 RSI: ffffc20000b7c2d8 RDI: ffffc20000b7c000
RBP: ffff81007ddab000 R08: 000000000000001f R09: 0000000000000001
R10: ffffffff806bd740 R11: ffffffff8027bb60 R12: ffff81007ddab5a8
R13: 0000000000000293 R14: ffff81007ddab368 R15: 0000000000000000
FS:  00002aaefeae54a0(0000) GS:ffff8101000c64c0(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 00000000005bd000 CR3: 00000001786d0000 CR4: 00000000000006e0
Process md6_raid5 (pid: 1593[#0], threadinfo ffff81017ce86000, task ffff810=
17d3e47b0)
Stack:  ffffffff88077c1f 0000000000000010 ffff81007ddab000 ffff81007ca5f1e8
 0000000000000000 0000000000000001 ffffffff8806b79d 0000000000000246
 0000000000000000 0000000000000000 ffff81017c4113c8 00000000ffffffff
Call Trace:
 [<ffffffff88077c1f>] :drbd:drbd_rs_complete_io+0xcf/0x130
 [<ffffffff8806b79d>] :drbd:drbd_endio_write_sec+0x1bd/0x2d0
 [<ffffffff80453dfb>] handle_stripe+0x248b/0x2780
 [<ffffffff804091ac>] ata_qc_issue_prot+0x12c/0x2b0
 [<ffffffff8040677a>] ata_qc_issue+0x40a/0x4a0
 [<ffffffff8040c7bc>] ata_scsi_rw_xlat+0x29c/0x400

[more]=0D      =0D [<ffffffff8040dc40>] ata_exec_command+0x0/0x50
 [<ffffffff8026958b>] thread_return+0x0/0x105
 [<ffffffff803f6078>] scsi_dispatch_cmd+0x258/0x2e0
 [<ffffffff8045424d>] raid5d+0x15d/0x1a0
 [<ffffffff8029e4e0>] keventd_create_kthread+0x0/0x80
 [<ffffffff8045cd4d>] md_thread+0x11d/0x140
 [<ffffffff8029e720>] autoremove_wake_function+0x0/0x30
 [<ffffffff8045cc30>] md_thread+0x0/0x140
 [<ffffffff80235de9>] kthread+0xd9/0x120
 [<ffffffff80266dc8>] child_rip+0xa/0x12
 [<ffffffff8029e4e0>] keventd_create_kthread+0x0/0x80
 [<ffffffff80235d10>] kthread+0x0/0x120
 [<ffffffff80266dbe>] child_rip+0x0/0x12


Code: 0f 0b 68 40 a9 08 88 c2 38 01 66 66 66 90 66 66 90 48 3b 77=20
RIP  [<ffffffff8807967f>] :drbd:lc_put+0x4f/0xc0
 RSP <ffff81017ce87c38>
 NMI Watchdog detected LOCKUP on CPU 0
CPU 0=20
Modules linked in: drbd sha1 cn ipv6 tg3
Pid: 31157:#0, comm: drbd0_asender Not tainted 2.6.19.1-vs2.2.0-rc6-tyan-s2=
891test #1

[more]=0D      =0DRIP: 0010:[<ffffffff8026b4ba>]  [<ffffffff8026b4ba>] _spi=
n_lock_irqsave+0xa/0x20
RSP: 0018:ffff81007ca07e18  EFLAGS: 00000086
RAX: 0000000000000246 RBX: 000000000370fe40 RCX: ffffffff88087498
RDX: 000000008a32dfcf RSI: 000000001b87f200 RDI: ffff81007ddab5a8
RBP: 0000000000000000 R08: 0000000000000402 R09: 0000000000000000
R10: 00000000000005a8 R11: 00000000ffffffff R12: ffff81007ddab000
R13: 000000000370fe47 R14: 000000001b87f200 R15: ffff81007ddab5a8
FS:  00002b2b5b00e700(0000) GS:ffffffff8064b000(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 00002aed443a2640 CR3: 000000007eb5d000 CR4: 00000000000006e0
Process drbd0_asender (pid: 31157[#0], threadinfo ffff81007ca06000, task ff=
ff81007fb267f0)
Stack:  ffffffff8807747b 0000000000000282 ffff81007ddb6c38 ffff81007ddab000
 000000001b87f200 0000000000000001 ffff81007ca07e80 0000000000000200
 ffffffff88070e98 ffff81007ddb6c38 ffff81007ddb6ef8 ffff81007ddab000
Call Trace:
 [<ffffffff8807747b>] :drbd:__drbd_set_in_sync+0x1bb/0x2e0
 [<ffffffff88070e98>] :drbd:e_end_resync_block+0x68/0x100
 [<ffffffff8806f35b>] :drbd:drbd_process_done_ee+0xdb/0x140
 [<ffffffff880714d8>] :drbd:drbd_asender+0xe8/0x580
 [<ffffffff8807f729>] :drbd:drbd_thread_setup+0x99/0xe0
 [<ffffffff80266dc8>] child_rip+0xa/0x12
 [<ffffffff8027bb60>] flat_send_IPI_mask+0x0/0x50

[more]=0D      =0D [<ffffffff8807f690>] :drbd:drbd_thread_setup+0x0/0xe0
 [<ffffffff80266dbe>] child_rip+0x0/0x12


Code: 83 3f 00 7e f9 eb f2 c3 66 66 66 90 66 66 66 90 66 66 90 66=20
=20
File erased !

telnet> sened=08 =08=08 =08d break


Debian GNU/Linux ttyS0 115200 (janneke)

janneke login: <6>SysRq : Keyboard mode set to XLATE
oot
Password:=20

Login incorrect

janneke login: root
Password:=20
Last login: Thu Jan 11 14:56:22 2007 from 10.41.1.173 on pts/0
Linux janneke 2.6.19.1-vs2.2.0-rc6-tyan-s2891test #1 SMP Wed Jan 3 15:07:17=
 CET 2007 x86_64 GNU/Linux

The programs included with the Debian GNU/Linux system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
permitted by applicable law.
rjanneke:~# reboot
=0DINIT: =0DINIT: Sending processes the TERM signal=0D
janneke:~# =0DIStopping all DRBdrbd0: sock_sendmsg returned -104
D resourcesdrbd0: peer( Secondary -> Unknown ) conn( SyncTarget -> BrokenPi=
pe ) pdsk( UpToDate -> DUnknown )=20
drbd0: short sent StateChgRequest size=3D16 sent=3D0
drbd0: conn( BrokenPipe -> Disconnecting ) disk( Inconsistent -> Outdated )=
=20
Child process does not terminate!
Exiting.
ERROR: Module drbd is in use
=2E
Stopping periodic command scheduler: cron.
Stopping internet superserver: inetd.
Stopping munin-node: done.
Stopping rsync daemon: rsync.
Stopping network management services: snmpd snmptrapd.
Stopping OpenBSD Secure Shell server: sshd.
Stopping NTP server: ntpd.
Saving the System Clock time to the Hardware Clock...
Hardware Clock updated to Thu Jan 11 16:05:42 CET 2007.
Stopping RAID monitor daemon: mdadm -F.
Stopping deferred execution scheduler: atd.
Stopping kernel log daemon: klogd.
Stopping system log daemon: syslogd.
Sending all processes the TERM signal...BUG: soft lockup detected on CPU#1!

Call Trace:
 <IRQ>  [<ffffffff802b5e0a>] softlockup_tick+0xfa/0x120
 [<ffffffff80294487>] update_process_times+0x57/0x90
 [<ffffffff80278d24>] smp_local_timer_interrupt+0x34/0x60
 [<ffffffff80279259>] smp_apic_timer_interrupt+0x59/0x80
 [<ffffffff80266be6>] apic_timer_interrupt+0x66/0x70
 <EOI>  [<ffffffff802257b7>] flush_tlb_others+0x87/0xd0
 [<ffffffff802257af>] flush_tlb_others+0x7f/0xd0
 [<ffffffff80278a80>] flush_tlb_mm+0xb0/0xc0
 [<ffffffff80213407>] unmap_region+0x117/0x160
 [<ffffffff80212398>] do_munmap+0x238/0x330
 [<ffffffff8026ae62>] __down_write_nested+0x12/0xb0
 [<ffffffff80216de8>] sys_munmap+0x48/0x80
 [<ffffffff8026600e>] system_call+0x7e/0x83

