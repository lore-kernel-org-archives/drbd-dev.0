Return-Path: <m@sys4.de>
Received: from mail.sys4.de (mail.sys4.de [194.126.158.139])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 6155D101AC7F
	for <drbd-dev@lists.linbit.com>; Fri, 19 Sep 2014 11:58:40 +0200 (CEST)
Received: from localhost (port-19100.pppoe.wtnet.de [46.59.136.61])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.sys4.de (Postfix) with ESMTPSA id 3hzqxy3KwYzWR
	for <drbd-dev@lists.linbit.com>; Fri, 19 Sep 2014 11:49:10 +0200 (CEST)
Date: Fri, 19 Sep 2014 11:49:09 +0200
From: Marc Schiffbauer <m@sys4.de>
To: drbd-dev@lists.linbit.com
Message-ID: <20140919094909.GA21578@schiffbauer.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: [Drbd-dev] drbd 8.4.3: refcounter overflow on re-sync
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hi,

about a year ago I encountered a problem with drbd: On long running 
re-syncs a refcounter overflow happens in the drbd module resulting 
in loss of network connection (and reconnect).

I am running a linux kernel that is hardened with grsecurity and 
PaX.  It has a feature to detect such recounter overflows 
(CONFIG_PAX_REFCOUNT)

Now I encountered that same Probleem egain with a much newer kernel.

There may be two causes that can trigger those cases:
1) real bug in a part of the kernel (drbd in that case)
2) false positive in PAX

The developer of PAX had a look at this issue and assumes a real bug 
in drbd but asked me to ask the drbd developer for details.

Please see [1].

Now today, with a newer kernel the issue looks like that:

[63999.116870] PAX: refcount overflow detected in: drbd_r_ms03:6378, uid/euid: 0/0
[63999.116875] CPU: 0 PID: 6378 Comm: drbd_r_ms03 Not tainted 3.14.18-hardened-r2 #1
[63999.116876] Hardware name: Supermicro X9DRi-LN4+/X9DR3-LN4+/X9DRi-LN4+/X9DR3-LN4+, BIOS 3.0b 05/27/2014
[63999.116878] task: ffff882f8b599010 ti: ffff882f8b599730 task.ti: ffff882f8b599730
[63999.116879] RIP: 0010:[<ffffffffa00663ca>]  [<ffffffffa00663ca>] ffffffffa00663ca
[63999.116882] RSP: 0000:ffffc90016483dd8  EFLAGS: 00000a02
[63999.116883] RAX: 0000000000000000 RBX: 000000027fd7cb00 RCX: ffff88306c17e6a0
[63999.116884] RDX: 0000000000000100 RSI: ffffffff818d2101 RDI: ffff882fb6c9d650
[63999.116884] RBP: ffff882f9c577010 R08: ffff88306c17e6a0 R09: ffff882fb6e76cc0
[63999.116885] R10: ffff882fb6e76cc0 R11: ffff882fb6e76cc0 R12: ffffc90016483e50
[63999.116886] R13: ffff882fb617f228 R14: ffff882f35028200 R15: ffff882fb617f000
[63999.116888] FS:  0000000000000000(0000) GS:ffff88307f200000(0000) knlGS:0000000000000000
[63999.116889] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[63999.116889] CR2: 00000320a5073008 CR3: 000000000154d000 CR4: 00000000001607f0
[63999.116890] Stack:
[63999.116891]  ffff882f8b85d800 0000000000000018 0000000000000018 0000010000000018
[63999.116893]  0000000000000000 ffff882f8b85d800 0000000000000009 00000000000000d8
[63999.116895]  0000000000000018 0000000000000018 0000000000000000 ffffffffa0068134
[63999.116896] Call Trace:
[63999.116907]  [<ffffffffa0068134>] ? drbdd_init+0x147/0x1d7 [drbd]
[63999.116913]  [<ffffffffa006f617>] ? drbd_thread_setup+0x4e/0x117 [drbd]
[63999.116917]  [<ffffffffa006f5c9>] ? conn_destroy+0x86/0x86 [drbd]
[63999.116922]  [<ffffffff8107fbfc>] ? kthread+0xd5/0xdd
[63999.116924]  [<ffffffff8107fb27>] ? kthread_worker_fn+0xf9/0xf9
[63999.116929]  [<ffffffff81535f74>] ? ret_from_fork+0x74/0xa0
[63999.116930]  [<ffffffff8107fb27>] ? kthread_worker_fn+0xf9/0xf9
[63999.116931] Code: 48 89 de 4c 89 ff e8 c3 80 00 00 85 c0 0f 85 b2 00 00 00 8b 54 24 1c f0 41 01 97 d0 04 00 00 71 0a f0 41 29 97 d0 04 00 00 cd 04 <bb> 03 00 00 00 f0 41 ff 87 24 02 00 00 71 0a f0 41 ff 8f 24 02


and drbd itself says:

[63999.116965] block drbd0: drbd_alloc_pages interrupted!
[63999.116968] d-con ms03: error receiving RSDataRequest, e: -12 l: 0!
[63999.116986] d-con ms03: peer( Secondary -> Unknown ) conn( SyncSource -> ProtocolError )
[63999.117021] d-con ms03: asender terminated
[63999.117025] d-con ms03: Terminating drbd_a_ms03
[63999.130575] d-con ms03: Connection closed
[63999.130599] d-con ms03: conn( ProtocolError -> Unconnected )
[63999.130601] d-con ms03: receiver terminated
[63999.130602] d-con ms03: Restarting receiver thread
[63999.130603] d-con ms03: receiver (re)started
[63999.130614] d-con ms03: conn( Unconnected -> WFConnection )
[64000.116691] d-con ms03: initial packet S crossed
[64009.195530] d-con ms03: Handshake successful: Agreed network protocol version 101
[64009.195807] d-con ms03: Peer authenticated using 64 bytes HMAC
[64009.195834] d-con ms03: conn( WFConnection -> WFReportParams )
[64009.195843] d-con ms03: Starting asender thread (from drbd_r_ms03 [6378])
[ ... and continues to sync ... ]


Is this a real bug in drbd?

Thanks
-Marc



[1] https://forums.grsecurity.net/viewtopic.php?f=3&t=3786&p=13558&hilit=REFCOUNT#p13558
-- 
[*] sys4 AG

http://sys4.de, +49 (89) 30 90 46 64
Franziskanerstraße 15, 81669 München

Sitz der Gesellschaft: München, Amtsgericht München: HRB 199263
Vorstand: Patrick Ben Koetter, Marc Schiffbauer
Aufsichtsratsvorsitzender: Florian Kirstein
