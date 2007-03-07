Return-Path: <Lars.Ellenberg@linbit.com>
Received: from barkeeper1 (unknown [86.59.100.100])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 594762DEAC7A
	for <drbd-dev@lists.linbit.com>; Wed,  7 Mar 2007 01:08:58 +0100 (CET)
Date: Wed, 7 Mar 2007 01:08:58 +0100
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Oops with drbd-8.0.0 (no disk failure involved)
Message-ID: <20070307000858.GG1055@barkeeper1.linbit>
References: <0ML2xA-1HOYvB2Pdy-0000vh@mrelayeu.kundenserver.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ML2xA-1HOYvB2Pdy-0000vh@mrelayeu.kundenserver.de>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

/ 2007-03-06 13:37:37 +0100
\ Wolfram Gloger:
> [I just read the 8.0.1 announcement.  Maybe the Oops is already
>  fixed, however I had _no_ disk failures as mentioned in the
>  announcement, so I'm reporting this anyway..]
> 
> Hi,
> 
> I'm running drbd-8.0.0 with a vanilla Linux-2.6.20.1 kernel.
> 
> Last night, while resyncing a big drive, I had massive networking
> problems (maybe due to a bad cable, does not matter here) leading to
> repeated loss of carrier.  After several stops and restarts of the
> syncing process, I got an Oops.  The machine could be rebooted
> fine, however, and today with a new cable the syncing process
> finished completely.
> 
> Regards,
> Wolfram.

> Mar  5 22:57:01 my kernel: Unable to handle kernel NULL pointer dereference at 0000000000000000 RIP: 
> Mar  5 22:57:01 my kernel:  [<0000000000000000>] stext+0x7fdff0e0/0xe0
> Mar  5 22:57:01 my kernel: PGD 6d5e7067 PUD 6d59c067 PMD 0 
> Mar  5 22:57:01 my kernel: Oops: 0010 [1] SMP 
> Mar  5 22:57:01 my kernel: CPU 0 
> Mar  5 22:57:01 my kernel: Modules linked in: drbd cn ipv6 ppdev lp button ac battery xt_multiport xt_state xt_tcpudp ipt_REJECT xt_limit ipt_LOG iptable_nat nf_nat nf_conntrack_ipv4 nf_conntrack nfnetlink iptable_filter ip_tables x_tables dm_snapshot dm_mirror dm_mod loop snd_hda_intel snd_hda_codec snd_pcm_oss snd_mixer_oss snd_pcm evdev snd_timer pcspkr snd serio_raw psmouse parport_pc parport soundcore snd_page_alloc k8temp ext3 jbd mbcache ide_cd cdrom pata_amd sd_mod sata_nv amd74xx ata_generic libata scsi_mod forcedeth generic ide_core ehci_hcd ohci_hcd thermal processor fan
> Mar  5 22:57:01 my kernel: Pid: 2921, comm: cqueue/0 Not tainted 2.6.20.1 #2
> Mar  5 22:57:01 my kernel: RIP: 0010:[<0000000000000000>]  [<0000000000000000>] stext+0x7fdff0e0/0xe0
> Mar  5 22:57:01 my kernel: RSP: 0018:ffff81006e589e58  EFLAGS: 00010286
> Mar  5 22:57:01 my kernel: RAX: 000000003796f241 RBX: ffff810002abf428 RCX: ffff81006e589ec8
> Mar  5 22:57:01 my kernel: RDX: ffff81003796f258 RSI: 0000000000000297 RDI: ffff810037c92010
> Mar  5 22:57:01 my kernel: RBP: ffff81003796f240 R08: ffffffff8028e585 R09: 000000006d7b7ea8
> Mar  5 22:57:01 my kernel: R10: 0000000000000000 R11: 0000000000000034 R12: ffff810002abf3d8
> Mar  5 22:57:01 my kernel: R13: ffff810002abf3d8 R14: ffffffff882b60c3 R15: 0000000000000000
> Mar  5 22:57:01 my kernel: FS:  00002b6a39e3b6d0(0000) GS:ffffffff804d1000(0000) knlGS:0000000000000000
> Mar  5 22:57:01 my kernel: CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
> Mar  5 22:57:01 my kernel: CR2: 0000000000000000 CR3: 000000006e8de000 CR4: 00000000000006e0
> Mar  5 22:57:01 my kernel: Process cqueue/0 (pid: 2921, threadinfo ffff81006e588000, task ffff810037f9c0c0)
> Mar  5 22:57:01 my kernel: Stack:  ffffffff882b60d8 ffffffff882b60c3 ffff810002abf3e0 0000000000000297
> Mar  5 22:57:01 my kernel:  ffffffff8024720c ffff81003796f240 ffffffff80243e72 ffff81006e9e3c68
> Mar  5 22:57:01 my kernel:  ffff81006e9e3cb0 ffffffff8028e585 ffffffff80243f86 0000000000000000
> Mar  5 22:57:01 my kernel: Call Trace:
> Mar  5 22:57:01 my kernel:  [<ffffffff882b60d8>] :cn:cn_queue_wrapper+0x15/0x33
> Mar  5 22:57:01 my kernel:  [<ffffffff882b60c3>] :cn:cn_queue_wrapper+0x0/0x33
> Mar  5 22:57:01 my kernel:  [<ffffffff8024720c>] run_workqueue+0x8f/0x137

we hit this bug today ourselves.

there appears to be a (SMP?) race condition in the connector code.
whether this got intriduced in 2.6.20*, or is present before,
and whether this is a generic connector problem, or in how far
this might be related to the way drbd uses the connector
we don't know yet.

-- 
: Lars Ellenberg                            Tel +43-1-8178292-55 :
: LINBIT Information Technologies GmbH      Fax +43-1-8178292-82 :
: Vivenotgasse 48, A-1120 Vienna/Europe    http://www.linbit.com :
