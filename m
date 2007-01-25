Return-Path: <Lars.Ellenberg@linbit.com>
Received: from soda (unknown [86.59.100.100])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 659A62D9DFBC
	for <drbd-dev@lists.linbit.com>; Thu, 25 Jan 2007 22:38:20 +0100 (CET)
Resent-Message-ID: <20070125213821.GB8857@soda.linbit>
Date: Thu, 25 Jan 2007 18:45:23 +0100
From: Ard van Breemen <ard@kwaak.net>
To: Philipp Reisner <philipp.reisner@linbit.com>
Subject: Re: [Drbd-dev] oopses in 2.6.19.1
Message-ID: <20070125174523.GD9639@kwaak.net>
References: <20070110123116.GX15730@kwaak.net>
	<20070111171205.GC15730@kwaak.net>
	<20070111180322.GD15730@kwaak.net>
	<200701151806.20526.philipp.reisner@linbit.com>
	<20070116103749.GD9639@kwaak.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ZPt4rx8FFjLCG7dd"
Content-Disposition: inline
In-Reply-To: <20070116103749.GD9639@kwaak.net>
Cc: drbd-dev@lists.linbit.com
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,
On Tue, Jan 16, 2007 at 11:37:49AM +0100, Ard van Breemen wrote:
> I will try it.
> It seems to happen if I do this:
> - create a raidset at the primary, create a raidset at the
> secondary.
> - create the drbd device on top of that
> - designate the primary primary.
I've done this to create the following two kernel logs:
Create a raidset at A, Create a raidset at B
Wait for raidsync to complete
Create the drbd device
Start the connection (both inconsistent)
make raidset A primary
The stuff starts to sync.
The sync speed at that moment is about 10MB/s.
I reboot both systems (I just wanted to get a higher speed, and
rebooting is an easy way to restore settings to something known).

The primary comes up ok, the secondary also.
The secondary then trips.
(At that moment both raidsets are OK).
That's when I made the logs.

I reboot the secondary.
The sync gains speed to >70MB/s

Just to let you know why I want to use drbd:
I've got servers with >100M files. If one of the servers goes
haywired, I've got to resync the 100M files. There is no normal
application that can sync 1T/>100M files in a timely matter. Next
to that, I have to bring a second server down, to be abel to do
that. Using the raw power of drbd, I can do that with drbd in
about 7 hours, and als be up to date after 7 hours of syncing.
So: I only use it to sync. After that I disconnect the devices,
and let them go on independently.
(Resyncing from the backup takes 48 hours or so)
Of course I can take the easy road and switch to 0.7 ;-)
-- 
begin  LOVE-LETTER-FOR-YOU.txt.vbs
I am a signature virus. Distribute me until the bitter
end

--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="drbd.master.log"

Linux version 2.6.19.1-vs2.2.0-rc6-tyan-s2891test (root@siddev) (gcc version 4.1.2 20061115 (prerelease) (Debian 4.1.1-21)) #1 SMP Wed Jan 3 15:07:17 CET 2007
Command line: console=tty0 console=ttyS0,115200 hdb=noprobe hdc=noprobe hdd=noprobe root=/dev/md0 ro 

[lge: 800+ lines of bootup messages snipped, because they seemed irrelevant ]

drbd: initialised. Version: 8.0rc1 (api:86/proto:85)
drbd: SVN Revision: 2695 build by ard@siddev, 2007-01-16 15:33:47
drbd: registered as block device major 147
drbd: minor_table @ 0xffff81017e37ebc0
drbd0: disk( Diskless -> Attaching ) 
drbd0: No usable activity log found.
drbd0: max_segment_size ( = BIO size ) = 32768
drbd0: Adjusting my ra_pages to backing device's (32 -> 96)
drbd0: drbd_bm_resize called with capacity == 2318589904
drbd0: resync bitmap: bits=289823738 words=4528496
drbd0: size = 1105 GB (1159294952 KB)
drbd0: reading of bitmap took 138 jiffies
drbd0: recounting of set bits took additional 8 jiffies
drbd0: 1105 GB marked out-of-sync by on disk bit-map.
drbd0: disk( Attaching -> UpToDate ) pdsk( DUnknown -> Outdated ) 
drbd0: Writing meta data super block now.
drbd0: Writing meta data super block now.
drbd0: conn( StandAlone -> Unconnected ) 
drbd0: receiver (re)started
drbd0: conn( Unconnected -> WFConnection ) 
drbd0: conn( WFConnection -> WFReportParams ) 
drbd0: Handshake successful: DRBD Network Protocol version 85
drbd0: Peer authenticated using 20 bytes of 'sha1' HMAC
drbd0: peer( Unknown -> Secondary ) conn( WFReportParams -> WFBitMapS ) pdsk( Outdated -> Inconsistent ) 
drbd0: Writing meta data super block now.
drbd0: conn( WFBitMapS -> SyncSource ) 
drbd0: Began resync as SyncSource (will sync 1158770664 KB [289692666 bits set]).
drbd0: Writing meta data super block now.
eth0: no IPv6 routers present
eth1: no IPv6 routers present
drbd0: PingAck did not arrive in time.
drbd0: peer( Secondary -> Unknown ) conn( SyncSource -> NetworkFailure ) 
drbd0: asender terminated
drbd0: drbd_pp_alloc interrupted!
drbd0: error receiving RSDataRequest, l: 24!
drbd0: tl_clear()
drbd0: Connection closed
drbd0: Writing meta data super block now.
drbd0: conn( NetworkFailure -> Unconnected ) 
drbd0: receiver terminated
drbd0: receiver (re)started
drbd0: conn( Unconnected -> WFConnection ) 

--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="drbd.slave.log"

Linux version 2.6.19.1-vs2.2.0-rc6-tyan-s2891test (root@siddev) (gcc version 4.1.2 20061115 (prerelease) (Debian 4.1.1-21)) #1 SMP Wed Jan 3 15:07:17 CET 2007
Command line: console=tty0 console=ttyS0,115200 hdb=noprobe hdc=noprobe hdd=noprobe root=/dev/md0 ro 

[lge: 800+ lines of bootup messages snipped, because they seemed irrelevant ]

drbd: initialised. Version: 8.0rc1 (api:86/proto:85)
drbd: SVN Revision: 2695 build by ard@siddev, 2007-01-16 15:33:47
drbd: registered as block device major 147
drbd: minor_table @ 0xffff81007f017e80
drbd0: disk( Diskless -> Attaching ) 
drbd0: No usable activity log found.
drbd0: max_segment_size ( = BIO size ) = 32768
drbd0: Adjusting my ra_pages to backing device's (32 -> 96)
drbd0: drbd_bm_resize called with capacity == 2318589904
drbd0: resync bitmap: bits=289823738 words=4528496
drbd0: size = 1105 GB (1159294952 KB)
drbd0: reading of bitmap took 124 jiffies
drbd0: recounting of set bits took additional 7 jiffies
drbd0: 1105 GB marked out-of-sync by on disk bit-map.
drbd0: disk( Attaching -> Inconsistent ) 
drbd0: Writing meta data super block now.
drbd0: conn( StandAlone -> Unconnected ) 
drbd0: receiver (re)started
drbd0: conn( Unconnected -> WFConnection ) 
drbd0: conn( WFConnection -> WFReportParams ) 
drbd0: Handshake successful: DRBD Network Protocol version 85
drbd0: Peer authenticated using 20 bytes of 'sha1' HMAC
drbd0: peer( Unknown -> Secondary ) conn( WFReportParams -> WFBitMapT ) pdsk( DUnknown -> UpToDate ) 
drbd0: Writing meta data super block now.
drbd0: conn( WFBitMapT -> WFSyncUUID ) 
drbd0: conn( WFSyncUUID -> SyncTarget ) 
drbd0: Began resync as SyncTarget (will sync 1158770664 KB [289692666 bits set]).
drbd0: Writing meta data super block now.
eth1: no IPv6 routers present
eth0: no IPv6 routers present
----------- [cut here ] --------- [please bite here ] ---------
Kernel BUG at ...ed/kernel/tyan-s2891/modules/drbd/drbd/lru_cache.c:312
invalid opcode: 0000 [1] SMP 
CPU 1 
Modules linked in: sha1 drbd cn ipv6 tg3
Pid: 925:#0, comm: md6_raid5 Not tainted 2.6.19.1-vs2.2.0-rc6-tyan-s2891test #1
RIP: 0010:[<ffffffff8807997f>]  [<ffffffff8807997f>] :drbd:lc_put+0x4f/0xc0
RSP: 0018:ffff81017e3fbc38  EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffffc20000b7c268 RCX: ffffc20000b7c268
RDX: ffffc20000b7c268 RSI: ffffc20000b7c268 RDI: ffffc20000b7c000
RBP: ffff81017e0b2800 R08: 000000000000001f R09: 0000000000000001
R10: ffffffff806bd740 R11: ffffffff8027bb60 R12: ffff81017e0b2da8
R13: 0000000000000293 R14: ffff81017e0b2b68 R15: 0000000000000000
FS:  00002b8eb4ef3700(0000) GS:ffff8101000c64c0(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 0000000000526788 CR3: 000000007e784000 CR4: 00000000000006e0
Process md6_raid5 (pid: 925[#0], threadinfo ffff81017e3fa000, task ffff81017e097140)
Stack:  ffffffff88077ecf 0000000000000008 ffff81017e0b2800 ffff81007e9c3978
 0000000000000000 0000000000000001 ffffffff8806b94d 0000000000000246
 0000000000000000 0000000000000000 ffff81007f90a9e8 00000000ffffffff
Call Trace:
 [<ffffffff88077ecf>] :drbd:drbd_rs_complete_io+0xcf/0x130
 [<ffffffff8806b94d>] :drbd:drbd_endio_write_sec+0x1bd/0x2d0
 [<ffffffff80453dfb>] handle_stripe+0x248b/0x2780
 [<ffffffff804091ac>] ata_qc_issue_prot+0x12c/0x2b0
 [<ffffffff8040677a>] ata_qc_issue+0x40a/0x4a0
 [<ffffffff8040c7bc>] ata_scsi_rw_xlat+0x29c/0x400
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


Code: 0f 0b 68 68 ad 08 88 c2 38 01 66 66 66 90 66 66 90 48 3b 77 
RIP  [<ffffffff8807997f>] :drbd:lc_put+0x4f/0xc0
 RSP <ffff81017e3fbc38>
 NMI Watchdog detected LOCKUP on CPU 0
CPU 0 
Modules linked in: sha1 drbd cn ipv6 tg3
Pid: 1925:#0, comm: drbd0_asender Not tainted 2.6.19.1-vs2.2.0-rc6-tyan-s2891test #1
RIP: 0010:[<ffffffff8026b4ba>]  [<ffffffff8026b4ba>] _spin_lock_irqsave+0xa/0x20
RSP: 0018:ffff81007e2a1e18  EFLAGS: 00000086
RAX: 0000000000000246 RBX: 0000000000097e00 RCX: ffffffff88087850
RDX: 000000008a32dfcf RSI: 00000000004bf000 RDI: ffff81017e0b2da8
RBP: 0000000000000000 R08: 0000000000000402 R09: 0000000000000000
R10: 00000000000002f8 R11: 00000000ffffffff R12: ffff81017e0b2800
R13: 0000000000097e07 R14: 00000000004bf000 R15: ffff81017e0b2da8
FS:  00002aefc97b9640(0000) GS:ffffffff8064b000(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 00002b434a8a1fa8 CR3: 000000017c071000 CR4: 00000000000006e0
Process drbd0_asender (pid: 1925[#0], threadinfo ffff81007e2a0000, task ffff81007fb25140)
Stack:  ffffffff8807772b 0000000000000282 ffff81007e9c3b88 ffff81017e0b2800
 00000000004bf000 0000000000000001 ffff81007e2a1e80 0000000000000000
 ffffffff88071048 ffff81007e9c3b88 ffff81007e3c73a0 ffff81017e0b2800
Call Trace:
 [<ffffffff8807772b>] :drbd:__drbd_set_in_sync+0x1bb/0x2e0
 [<ffffffff88071048>] :drbd:e_end_resync_block+0x68/0x100
 [<ffffffff8806f50b>] :drbd:drbd_process_done_ee+0xdb/0x140
 [<ffffffff88071688>] :drbd:drbd_asender+0xe8/0x580
 [<ffffffff8807fa29>] :drbd:drbd_thread_setup+0x99/0xe0
 [<ffffffff80266dc8>] child_rip+0xa/0x12
 [<ffffffff803a3440>] vgacon_cursor+0x0/0x1c7
 [<ffffffff8807f990>] :drbd:drbd_thread_setup+0x0/0xe0
 [<ffffffff80266dbe>] child_rip+0x0/0x12


Code: 83 3f 00 7e f9 eb f2 c3 66 66 66 90 66 66 66 90 66 66 90 66 
 NMI Watchdog detected LOCKUP on CPU 1
CPU 1 
Modules linked in: sha1 drbd cn ipv6 tg3
Pid: 1900:#0, comm: drbd0_worker Not tainted 2.6.19.1-vs2.2.0-rc6-tyan-s2891test #1
RIP: 0010:[<ffffffff8026b4d8>]  [<ffffffff8026b4d8>] _spin_lock_irq+0x8/0x10
RSP: 0000:ffff81017b99be28  EFLAGS: 00000082
RAX: 000000000009e448 RBX: 0000000000000000 RCX: 0000000000000008
RDX: 000000000009e448 RSI: 00000000004f2240 RDI: ffff81017e0b2da8
RBP: ffff81017e0b2800 R08: 000000000009e448 R09: ffffc20000b81000
R10: 0000000000000038 R11: ffffffff88009d60 R12: ffff81017e0b2858
R13: 000000000000009e R14: 0000000000000278 R15: ffff81017e0b2800
FS:  00002b0d9fa7a640(0000) GS:ffff8101000c64c0(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 00002aefc979cfa8 CR3: 000000007eff2000 CR4: 00000000000006e0
Process drbd0_worker (pid: 1900[#0], threadinfo ffff81017b99a000, task ffff81017cdbc7b0)
Stack:  ffffffff88077a3d 0000000000000000 ffff81017e0b2800 ffff81017e0b2858
 000000000009e448 00000000004f2240 ffffffff8806bb88 000000008a32dfd0
 0000000000008000 000007d100000001 0000000000000000 ffff81017e0b2800
Call Trace:
 [<ffffffff88077a3d>] :drbd:drbd_try_rs_begin_io+0x5d/0x420
 [<ffffffff8806bb88>] :drbd:w_make_resync_request+0x128/0x330
 [<ffffffff8806b629>] :drbd:drbd_worker+0x2a9/0x410
 [<ffffffff8807fa29>] :drbd:drbd_thread_setup+0x99/0xe0
 [<ffffffff80266dc8>] child_rip+0xa/0x12
 [<ffffffff803a3440>] vgacon_cursor+0x0/0x1c7
 [<ffffffff8807f990>] :drbd:drbd_thread_setup+0x0/0xe0
 [<ffffffff80266dbe>] child_rip+0x0/0x12


Code: 83 3f 00 7e f9 eb f2 c3 53 48 89 fb e8 f7 4f 02 00 f0 ff 0b 
 <6>drbd0: peer( Secondary -> Unknown ) conn( SyncTarget -> BrokenPipe ) pdsk( UpToDate -> DUnknown ) 
drbd0: short read receiving data: read 1272 expected 4096
drbd0: error receiving RSDataReply, l: 32792!
Unable to handle kernel NULL pointer dereference at 0000000000000808 RIP: 
 [<ffffffff8026b4b3>] _spin_lock_irqsave+0x3/0x20
PGD 17c066067 PUD 17c067067 PMD 0 
Oops: 0002 [2] SMP 
CPU 0 
Modules linked in: sha1 drbd cn ipv6 tg3
Pid: 1920:#0, comm: drbd0_receiver Not tainted 2.6.19.1-vs2.2.0-rc6-tyan-s2891test #1
RIP: 0010:[<ffffffff8026b4b3>]  [<ffffffff8026b4b3>] _spin_lock_irqsave+0x3/0x20
RSP: 0018:ffff81007e2d1e08  EFLAGS: 00010002
RAX: 0000000000000202 RBX: 0000000000000001 RCX: 0000000000000000
RDX: ffff81007fb25140 RSI: 0000000000000001 RDI: 0000000000000808
RBP: ffff81007fb25140 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffff806bd740 R11: ffffffff8027bb60 R12: 0000000000000000
R13: 0000000000000001 R14: ffff81017e0b2800 R15: 0000000000000020
FS:  00002aefc97b9640(0000) GS:ffffffff8064b000(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 0000000000000808 CR3: 000000017c071000 CR4: 00000000000006e0
Process drbd0_receiver (pid: 1920[#0], threadinfo ffff81007e2d0000, task ffff81007fb1c140)
Stack:  ffffffff80296823 0000000000000020 0000000000000002 ffff81017e0b2c58
 0000000000000000 0000000000000001 ffffffff8807c50e ffff81017e0b2800
 ffff81017e0b2800 ffff81017e0b2bd8 000000000000c822 0000000000000004
Call Trace:
 [<ffffffff80296823>] force_sig_info+0x33/0xd0
 [<ffffffff8807c50e>] :drbd:_drbd_thread_stop+0xbe/0x1c0
 [<ffffffff8806ee66>] :drbd:drbd_disconnect+0x56/0x620
 [<ffffffff802312d3>] __wake_up+0x43/0x70
 [<ffffffff880714db>] :drbd:drbdd_init+0xdb/0x1a0
 [<ffffffff8807fa29>] :drbd:drbd_thread_setup+0x99/0xe0
 [<ffffffff80266dc8>] child_rip+0xa/0x12
 [<ffffffff803a3440>] vgacon_cursor+0x0/0x1c7
 [<ffffffff8807f990>] :drbd:drbd_thread_setup+0x0/0xe0
 [<ffffffff80266dbe>] child_rip+0x0/0x12


Code: f0 ff 0f 79 09 f3 90 83 3f 00 7e f9 eb f2 c3 66 66 66 90 66 
RIP  [<ffffffff8026b4b3>] _spin_lock_irqsave+0x3/0x20
 RSP <ffff81007e2d1e08>
CR2: 0000000000000808
 

--ZPt4rx8FFjLCG7dd--
