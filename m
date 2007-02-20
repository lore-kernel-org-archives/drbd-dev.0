Return-Path: <Lars.Ellenberg@linbit.com>
Received: from soda (unknown [86.59.100.100])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 18DBC2E05EA2
	for <drbd-dev@lists.linbit.com>; Tue, 20 Feb 2007 12:55:41 +0100 (CET)
Date: Tue, 20 Feb 2007 12:55:42 +0100
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] drbd 8.0.0 over IP over infiniband crashes
Message-ID: <20070220115542.GC7742@soda.linbit>
References: <874ppnhgq3.fsf@informatik.uni-tuebingen.de>
	<87hctj1fy5.fsf@informatik.uni-tuebingen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87hctj1fy5.fsf@informatik.uni-tuebingen.de>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

/ 2007-02-18 19:25:06 +0100
\ Goswin von Brederlow:
> Ok,
> 
> here we go. I got it to crash again after 3 days of running bonnie
> (mostly on ext3). This time the crash was while testing reiserfs on
> the drbd devices and it is only an oops. Before it crashed when
> syncing the drbd itself and I had to reset.
> 
> Does this look drbd related at all or just reiserfs screwing up?

reiser seems to think it runs on "dm-3";
do you use drbd as PV?

anyways, I don't see anything drbd related in that kernel log.
more something about reiserfs not behaving during memory pressure
(within xen; this may or may not be relevant).

I read it like: reiser tries to delete something, which for some reason
is not where it is expected (may be in memory data corruption, may be
some bad timing and race in reiserfs, may be a logic bug somewhere),
then tries to allocate an error buffer, which it does not get for some
reason; but it then dereferences that buffer pointer anyways. boom.

it may still be drbd related in the sense that drbd may add to the
memory pressure... but nothing we can fix in drbd.

> MfG
>         Goswin
> 
> ----------------------------------------------------------------------
> 
> [256015.223049] ReiserFS: dm-3: checking transaction log (dm-3)
> [256015.414938] ReiserFS: dm-3: Using r5 hash to sort names
> [256015.415029] ReiserFS: dm-3: warning: Created .reiserfs_priv on dm-3 - reserved for xattr storage.
> [289477.179091] ReiserFS: dm-3: warning: vs-5355: reiserfs_delete_solid_item: [2 29 0x0 SD] not found
> [289491.807841] ReiserFS: dm-3: warning: vs-13060: reiserfs_update_sd: stat data of object [2 32 0x0 SD] (nlink == 1) not found (pos 10)
> [289491.810040] Unable to handle kernel NULL pointer dereference at 0000000000000014 RIP: 
> [289491.810058]  [<ffffffff802c1006>] prepare_error_buf+0x109/0x56d
> [289491.810140] PGD ab049067 PUD c5080067 PMD 0 
> [289491.810187] Oops: 0000 [1] SMP 
> [289491.810225] CPU 1 
> [289491.810254] Modules linked in: drbd bridge llc ib_umad ib_ipoib ib_sa ib_mthca ehci_hcd uhci_hcd ib_mad i2c_i801 usbcore ib_core i2c_core e1000
> [289491.810411] Pid: 21160, comm: bonnie Not tainted 2.6.19.2-xen-3.0.4 #1
> [289491.810440] RIP: e030:[<ffffffff802c1006>]  [<ffffffff802c1006>] prepare_error_buf+0x109/0x56d
> [289491.810495] RSP: e02b:ffff88003a4cbb88  EFLAGS: 00010202
> [289491.810522] RAX: 0000000000000028 RBX: 0000000000000004 RCX: 0000000000000001
> [289491.810565] RDX: ffff88003a4cbc98 RSI: ffffffffffffffff RDI: ffffffff8074c1ef
> [289491.810609] RBP: ffff88003a4cbc58 R08: 00000000fffffffe R09: 0000000000000020
> [289491.816593] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff8074c5c0
> [289491.816640] R13: ffffffff8074c1fe R14: 0000000000000001 R15: 0000000000000000
> [289491.816690] FS:  00002ade3e1f5b00(0000) GS:ffffffff806ca080(0000) knlGS:0000000000000000
> [289491.816737] CS:  e033 DS: 0000 ES: 0000 CR0: 000000008005003b
> [289491.816769] CR2: 0000000000000000 CR3: 00000000311ac000 CR4: 0000000000002660
> [289491.816816] Process bonnie (pid: 21160, threadinfo ffff88003a4ca000, task ffff880000e130c0)
> [289491.816863] Stack:  0000000000000000 0000000000000000 0000000000000000 000000000000000a
> [289491.816944]  ffff8800507f0000 0000000000001980 ffffffff802126fa ffff88003a4cbbe0
> [289491.817017]  0000000000000008 ffffffff8074c5fe ffff88003a4cbc50 ffff8800f1043750
> [289491.817067] Call Trace:
> [289491.817114]  [<ffffffff802126fa>] xen_send_IPI_mask+0xa1/0xa8
> [289491.817145]  [<ffffffff8022340a>] try_to_wake_up+0x33c/0x34d
> [289491.817177]  [<ffffffff802c0b86>] reiserfs_warning+0x50/0x91
> [289491.817208]  [<ffffffff802c6a22>] search_for_position_by_key+0x34/0x2b1
> [289491.817241]  [<ffffffff80222eda>] task_rq_lock+0x3f/0x71
> [289491.817272]  [<ffffffff8022340a>] try_to_wake_up+0x33c/0x34d
> [289491.817305]  [<ffffffff8027d77c>] __d_lookup+0xb0/0x100
> [289491.817337]  [<ffffffff802c7db9>] reiserfs_do_truncate+0x19e/0x4aa
> [289491.817369]  [<ffffffff802c80f7>] reiserfs_delete_object+0x32/0x6e
> [289491.817401]  [<ffffffff802b7621>] reiserfs_delete_inode+0x8c/0xf6
> [289491.817433]  [<ffffffff802b7595>] reiserfs_delete_inode+0x0/0xf6
> [289491.817463]  [<ffffffff8027faa4>] generic_delete_inode+0xad/0x129
> [289491.817494]  [<ffffffff802776b2>] do_unlinkat+0xd5/0x148
> [289491.817525]  [<ffffffff8026a95e>] kmem_cache_free+0x77/0xca
> [289491.817557]  [<ffffffff8026cdb9>] do_sys_open+0xb9/0xc5
> [289491.817587]  [<ffffffff80209ba6>] system_call+0x86/0x8b
> [289491.817631]  [<ffffffff80209b20>] system_call+0x0/0x8b
> [289491.817659] 
> [289491.817682] 
> [289491.817683] Code: 8a 43 10 49 c7 c4 1c 45 5e 80 84 c0 74 2a 3c 03 49 c7 c4 d9 
> [289491.817879] RIP  [<ffffffff802c1006>] prepare_error_buf+0x109/0x56d
> [289491.817917]  RSP <ffff88003a4cbb88>
> [289491.817943] CR2: 0000000000000014
> [289491.818854]  BUG: warning at kernel/exit.c:859/do_exit()
> [289491.819148] 
> [289491.819149] Call Trace:
> [289491.819414]  [<ffffffff8022c23a>] do_exit+0x52/0x837
> [289491.819555]  [<ffffffff8020622a>] hypercall_page+0x22a/0x1000
> [289491.819693]  [<ffffffff80217863>] do_page_fault+0x12d2/0x1383
> [289491.819833]  [<ffffffff8028bb19>] __find_get_block+0x16e/0x1b0
> [289491.819977]  [<ffffffff805772c7>] error_exit+0x0/0x6e
> [289491.820118]  [<ffffffff802c1006>] prepare_error_buf+0x109/0x56d
> [289491.820257]  [<ffffffff802c1422>] prepare_error_buf+0x525/0x56d
> [289491.820397]  [<ffffffff802126fa>] xen_send_IPI_mask+0xa1/0xa8
> [289491.820535]  [<ffffffff8022340a>] try_to_wake_up+0x33c/0x34d
> [289491.820675]  [<ffffffff802c0b86>] reiserfs_warning+0x50/0x91
> [289491.820816]  [<ffffffff802c6a22>] search_for_position_by_key+0x34/0x2b1
> [289491.820958]  [<ffffffff80222eda>] task_rq_lock+0x3f/0x71
> [289491.821095]  [<ffffffff8022340a>] try_to_wake_up+0x33c/0x34d
> [289491.821232]  [<ffffffff8027d77c>] __d_lookup+0xb0/0x100
> [289491.821369]  [<ffffffff802c7db9>] reiserfs_do_truncate+0x19e/0x4aa
> [289491.821509]  [<ffffffff802c80f7>] reiserfs_delete_object+0x32/0x6e
> [289491.821647]  [<ffffffff802b7621>] reiserfs_delete_inode+0x8c/0xf6
> [289491.821787]  [<ffffffff802b7595>] reiserfs_delete_inode+0x0/0xf6
> [289491.821925]  [<ffffffff8027faa4>] generic_delete_inode+0xad/0x129
> [289491.822062]  [<ffffffff802776b2>] do_unlinkat+0xd5/0x148
> [289491.822199]  [<ffffffff8026a95e>] kmem_cache_free+0x77/0xca
> [289491.822336]  [<ffffffff8026cdb9>] do_sys_open+0xb9/0xc5
> [289491.822472]  [<ffffffff80209ba6>] system_call+0x86/0x8b
> [289491.822608]  [<ffffffff80209b20>] system_call+0x0/0x8b
> [289491.822743] 
> Message from syslogd@jay_beo-19 at Sun Feb 18 17:40:20 2007 ...
> jay_beo-19 kernel: [289491.817943] CR2: 0000000000000014
> 
> Message from syslogd@jay_beo-19 at Sun Feb 18 17:40:20 2007 ...
> jay_beo-19 kernel: [289491.810187] Oops: 0000 [1] SMP 
> _______________________________________________
> drbd-dev mailing list
> drbd-dev@lists.linbit.com
> http://lists.linbit.com/mailman/listinfo/drbd-dev

-- 
: Lars Ellenberg                            Tel +43-1-8178292-55 :
: LINBIT Information Technologies GmbH      Fax +43-1-8178292-82 :
: Vivenotgasse 48, A-1120 Vienna/Europe    http://www.linbit.com :
