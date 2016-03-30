Return-Path: <drbd-dev@lists.ewheeler.net>
Received: from mail.ewheeler.net (mx.ewheeler.net [71.19.153.34])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id B86B01056332
	for <drbd-dev@lists.linbit.com>; Wed, 30 Mar 2016 04:24:37 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mail.ewheeler.net (Postfix) with ESMTP id 657B2A0F4B
	for <drbd-dev@lists.linbit.com>; Wed, 30 Mar 2016 02:19:15 +0000 (UTC)
Received: from mail.ewheeler.net ([127.0.0.1])
	by localhost (mail.ewheeler.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id frXx_9FVVdUk for <drbd-dev@lists.linbit.com>;
	Wed, 30 Mar 2016 02:19:14 +0000 (UTC)
Received: from mx.ewheeler.net (mx.ewheeler.net [71.19.153.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.ewheeler.net (Postfix) with ESMTPSA id 4EFFFA0F4A
	for <drbd-dev@lists.linbit.com>; Wed, 30 Mar 2016 02:19:14 +0000 (UTC)
Date: Wed, 30 Mar 2016 02:19:07 +0000 (UTC)
From: Eric Wheeler <drbd-dev@lists.ewheeler.net>
To: drbd-dev@lists.linbit.com
Message-ID: <alpine.LRH.2.11.1603300137590.2225@mail.ewheeler.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [Drbd-dev] NULL pointer derefernce in 8.4.7-1
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

Hello all,

We are getting kernel crashes in linux 4.1.20 with the drbd-8.4.git tree 
at commit 3a6a769340ef93b1ba2792c6461250790795db49 .  

I don't see anything in the newer commits that addresses this issue so 
I'm posting---but I'll try the latest commit in master, too, just in case.

Please see the backtrace below.  I also included our global_common.conf 
further down.  This is protocol A and the link is quite slow.  This NULL 
ptr dereference appears to show up when the drbd kernel thread is blocked 
for a long time.  It might happen at reconnect time because the BUG didn't 
show up until 13 seconds after the P_BARRIER error.

The problem is pretty reproducable, so I can probably test patches.  
Please let me know what I can do to help test.

Thanks!

--
Eric Wheeler


[ 2467.187849] block drbd7994: We did not send a P_BARRIER for 27003ms > ko-count (3) * timeout (90 * 0.1s); drbd kernel thread blocked?

22 or 23s elapse... and then:

[ 2480.674208] BUG: unable to handle kernel 
ter dereference
 at 0000000000000003
[ 2480.676403] IP:
 [<ffffffff81357a96>] memcpy_erms+0x6/0x10
[ 2480.678547] PGD 0 
 
[ 2480.680628] Oops: 0000 [#1] 
[...]
[ 2480.700341] CPU: 7 PID: 23962 Comm: drbd_w_www3.ewh Tainted: G           O    4.1.20
[ 2480.702612] Hardware name: Supermicro X9SCL/X9SCM/X9SCL/X9SCM, BIOS 2.2 02/20/2015
[ 2480.704921] task: ffff8807c01d6e00 ti: ffff8807b7a88000 task.ti: ffff8807b7a88000
[ 2480.707206] RIP: 0010:[<ffffffff81357a96>] 
 [<ffffffff81357a96>] memcpy_erms+0x6/0x10
[ 2480.709537] RSP: 0018:ffff8807b7a8ba50  EFLAGS: 00010286
[ 2480.711774] RAX: ffff8807dc0cc4d8 RBX: 00000000000004a6 RCX: 00000000000004a6
[ 2480.714079] RDX: 00000000000004a6 RSI: 0000000000000003 RDI: ffff8807dc0cc4d8
[ 2480.716324] RBP: ffff8807b7a8ba98 R08: ffff8807b7a8bbd8 R09: ffff8807c01d7b28
[ 2480.718605] R10: 0000000000000000 R11: ffff88075891b800 R12: 0000000000000a50
[ 2480.720853] R13: ffff8807b7a8bbf8 R14: ffff8807b7a8bbf8 R15: 0000000000000000
[ 2480.723052] FS:  0000000000000000(0000) GS:ffff88082fdc0000(0000) knlGS:000000000000000
[ 2480.725221] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2480.727436] CR2: 0000000000000003 CR3: 0000000001a22000 CR4: 00000000001426e0
[ 2480.729500] Stack:
[ 2480.731538]  ffffffff8135c40f
 ffff8807b7a8bbd8
 ffff8807dc0cc97e
 ffff8807b7a8ba98
 
[ 2480.733562]  ffff8807738cb600
 ffff8807f7949000
 000000000000fa9b
 ffff8807b7a8bbe8
 
[ 2480.735620]  0000000000000a50
 ffff8807b7a8bb48
 ffffffff8161b76a
 ffff88070000000c
 
[ 2480.737704] Call Trace:
[ 2480.739750]  [<ffffffff8135c40f>] ? copy_from_iter+0x2bf/0x2e0
[ 2480.741834]  [<ffffffff8161b76a>] tcp_sendmsg+0xa2a/0xb50
[ 2480.743914]  [<ffffffff81646c54>] inet_sendmsg+0x64/0xa0
[ 2480.745905]  [<ffffffff812d1403>] ? selinux_socket_sendmsg+0x23/0x30
[ 2480.747877]  [<ffffffff815ac54d>] sock_sendmsg+0x3d/0x50
[ 2480.749813]  [<ffffffff815ac67b>] kernel_sendmsg+0x2b/0x30
[ 2480.751713]  [<ffffffffa06b0f26>] drbd_send+0xe6/0x200 [drbd]
[ 2480.753608]  [<ffffffffa06b2b81>] _drbd_no_send_page.isra.40+0x71/0xb0 [drbd]
[ 2480.755463]  [<ffffffffa06b3178>] drbd_send_dblock+0x3e8/0x7a0 [drbd]
[ 2480.757263]  [<ffffffffa06a5874>] ? complete_master_bio+0x94/0x170 [drbd]
[ 2480.759073]  [<ffffffffa06935cf>] w_send_dblock+0xaf/0x1e0 [drbd]
[ 2480.760844]  [<ffffffffa06949a9>] drbd_worker+0xf9/0x3a0 [drbd]
[ 2480.762567]  [<ffffffffa06aed00>] ? drbd_destroy_connection+0x190/0x190 [drbd]
[ 2480.764181]  [<ffffffffa06aed1d>] drbd_thread_setup+0x1d/0x110 [drbd]
[ 2480.765777]  [<ffffffffa06aed00>] ? drbd_destroy_connection+0x190/0x190 [drbd]
[ 2480.767337]  [<ffffffff810c0b08>] kthread+0xd8/0xf0
[ 2480.768873]  [<ffffffff810c0a30>] ? kthread_create_on_node+0x1b0/0x1b0
[ 2480.770409]  [<ffffffff816e94e2>] ret_from_fork+0x42/0x70
[ 2480.771868]  [<ffffffff810c0a30>] ? kthread_create_on_node+0x1b0/0x1b0


===> /etc/drbd.d/global_common.conf <===
common {
	startup {
		wfc-timeout 30;
		outdated-wfc-timeout 20;
		degr-wfc-timeout 30;
	}
	options {
		on-no-data-accessible suspend-io;
	}
	syncer {
		rate 500M;
	}
	disk {
		al-extents 3389;
		c-fill-target 10240;
		c-delay-target 100;
		c-plan-ahead 70;
		c-min-rate 1024;
		c-max-rate 400M;
		on-io-error pass_on;
		read-balancing when-congested-remote;
	}
	net {
		after-sb-0pri discard-zero-changes;
		after-sb-1pri call-pri-lost-after-sb;
		after-sb-2pri disconnect;
		allow-two-primaries no;
		protocol A;
		cram-hmac-alg sha1;
		verify-alg crc32c;
		csums-alg crc32c;
		max-buffers 8192;
		max-epoch-size 8192;
		tcp-cork yes;
		sndbuf-size 1M;
		rcvbuf-size 2M;
		unplug-watermark 128; 
		ko-count 3;
		timeout 90;
		
		ping-int 10;
		ping-timeout 30;
	}
}


