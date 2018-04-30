Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wr0-f196.google.com (mail-wr0-f196.google.com
	[209.85.128.196])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id B94D41057321
	for <drbd-dev@lists.linbit.com>; Wed,  2 May 2018 17:34:15 +0200 (CEST)
Received: by mail-wr0-f196.google.com with SMTP id y15-v6so2775125wrg.11
	for <drbd-dev@lists.linbit.com>; Wed, 02 May 2018 08:34:15 -0700 (PDT)
Received: from soda.linbit ([86.59.100.100]) by smtp.gmail.com with ESMTPSA id
	o12-v6sm12031405wri.78.2018.05.02.08.34.14
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 02 May 2018 08:34:14 -0700 (PDT)
Resent-Message-ID: <20180502153414.GO10032@soda.linbit>
Received: from mail.xen.prgmr.com (mail.prgmr.com [71.19.149.6])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id EA98B1057321
	for <drbd-dev@lists.linbit.com>; Mon, 30 Apr 2018 03:15:17 +0200 (CEST)
To: philipp.reisner@linbit.com, lars.ellenberg@linbit.com
From: Sarah Newman <srn@prgmr.com>
Message-ID: <e7b77f18-0457-3bf9-0198-90c8239e342c@prgmr.com>
Date: Sun, 29 Apr 2018 18:07:43 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] WARNING: do not call blocking ops when !TASK_RUNNING
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

This warning is from an LTS branch - 4.9.95 with a couple of unrelated patches on top, but I can't find why it would have been fixed in mainline.

I think it's from the mutex_lock in drbd_main.c:conn_prepare_command(). I am not certain of the correct resolution.

It looks like I can reproduce it reliably, so if anyone has a proposed fix I can test it.

The below is with CONFIG_DEBUG_LOCK_ALLOC and CONFIG_DEBUG_ATOMIC_SLEEP on.

[  627.522124] ------------[ cut here ]------------
[  627.522211] WARNING: CPU: 0 PID: 6880 at kernel/sched/core.c:7736 __might_sleep+0x80/0x90
[  627.522308] do not call blocking ops when !TASK_RUNNING; state=1 set at [<ffffffff810fa8b0>] prepare_to_wait+0x30/0x90
[  627.522427] Modules linked in: 8021q garp mrp nf_conntrack_ipv4 nf_defrag_ipv4 xt_state nf_conntrack xt_physdev ip6table_filter ip6_tables
xen_pciback xen_netback xen_gntdev xen_gntalloc xenfs xen_privcmd xen_evtchn xen_blkback xen_acpi_processor tun sch_htb raid456 async_raid6_recov
async_memcpy async_pq async_xor xor async_tx raid6_pq raid10 fuse ext2 ebt_mark ebt_ip ebt_arp ebtable_nat ebtable_filter ebtables drbd lru_cache
libcrc32c cls_fw br_netfilter bridge stp llc iTCO_wdt iTCO_vendor_support pcspkr intel_pch_thermal i2c_i801 i2c_smbus lpc_ich igb shpchp joydev fjes
ipmi_si ipmi_msghandler mei_me mei ioatdma ixgbe mdio dca mlx4_ib ib_core mlx4_en ptp pps_core raid1 mlx4_core mxm_wmi wmi ast ttm
[  627.523246] CPU: 0 PID: 6880 Comm: drbd_w_resource Not tainted 4.9.95+ #1
[  627.523286] Hardware name: Supermicro Super Server/X10SDV-4C-TLN4F, BIOS 1.1c 10/03/2016
[  627.523334]  ffffc90043ddfba8 ffffffff81432f87 ffffc90043ddfbf8 0000000000000000
[  627.523417]  ffffc90043ddfbe8 ffffffff810ae2e1 00001e38818ef630 ffffffff81cdade8
[  627.523476]  000000000000026c 0000000000000000 0000000000000000 0000000000000000
[  627.523533] Call Trace:
[  627.523560]  [<ffffffff81432f87>] dump_stack+0x63/0x8c
[  627.523593]  [<ffffffff810ae2e1>] __warn+0xd1/0xf0
[  627.523623]  [<ffffffff810ae34f>] warn_slowpath_fmt+0x4f/0x60
[  627.523658]  [<ffffffff810fa8b0>] ? prepare_to_wait+0x30/0x90
[  627.523731]  [<ffffffff810fa8b0>] ? prepare_to_wait+0x30/0x90
[  627.523766]  [<ffffffff810da040>] __might_sleep+0x80/0x90
[  627.523798]  [<ffffffff818eac2c>] mutex_lock_nested+0x3c/0x350
[  627.523833]  [<ffffffff811065fa>] ? lock_release+0x26a/0x3f0
[  627.523866]  [<ffffffff81106307>] ? lock_acquire+0xe7/0x170
[  627.523907]  [<ffffffffc026a406>] ? wait_for_work+0x166/0x350 [drbd]
[  627.523954]  [<ffffffffc0288afc>] conn_prepare_command+0x1c/0x60 [drbd]
[  627.523996]  [<ffffffffc0269b1e>] drbd_send_barrier+0x1e/0x80 [drbd]
[  627.524036]  [<ffffffffc026a4bb>] wait_for_work+0x21b/0x350 [drbd]
[  627.524076]  [<ffffffffc026a30f>] ? wait_for_work+0x6f/0x350 [drbd]
[  627.524112]  [<ffffffff810fad40>] ? prepare_to_wait_event+0xf0/0xf0
[  627.524153]  [<ffffffffc026fba6>] drbd_worker+0x336/0x410 [drbd]
[  627.524199]  [<ffffffffc0286fc0>] ? drbd_destroy_connection+0x160/0x160 [drbd]
[  627.524245]  [<ffffffffc028701a>] drbd_thread_setup+0x5a/0x150 [drbd]
[  627.524286]  [<ffffffffc0286fc0>] ? drbd_destroy_connection+0x160/0x160 [drbd]
[  627.524327]  [<ffffffff810d10bf>] kthread+0x10f/0x130
[  627.524366]  [<ffffffff810d0fb0>] ? kthread_park+0x60/0x60
[  627.524411]  [<ffffffff81003a29>] ? do_syscall_64+0x79/0x190
[  627.524453]  [<ffffffff818ef6b7>] ret_from_fork+0x57/0x70
[  627.524582] ---[ end trace 72c3eb79f0bc22b8 ]---

(gdb) list *(conn_prepare_command+0x1c)
0x23b2c is in conn_prepare_command (drivers/block/drbd/drbd_main.c:622).
619	static void *__conn_prepare_command(struct drbd_connection *connection,
620					    struct drbd_socket *sock)
621	{
622		if (!sock->socket)

$ addr2line -i -e drbd.ko 0x23b2c
.../drivers/block/drbd/drbd_main.c:634

void *conn_prepare_command(struct drbd_connection *connection, struct drbd_socket *sock)
{
	void *p;

	mutex_lock(&sock->mutex);
	p = __conn_prepare_command(connection, sock);
	if (!p)
		mutex_unlock(&sock->mutex);

Please let me know if there is any other information I can provide.

Thanks, Sarah
