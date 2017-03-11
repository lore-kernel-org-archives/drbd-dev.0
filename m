Return-Path: <drbd-dev@lists.ewheeler.net>
Received: from mail.ewheeler.net (mx.ewheeler.net [66.155.3.69])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 43BE21056446
	for <drbd-dev@lists.linbit.com>; Sat, 11 Mar 2017 01:29:37 +0100 (CET)
Date: Fri, 10 Mar 2017 16:29:30 -0800 (PST)
From: Eric Wheeler <drbd-dev@lists.ewheeler.net>
To: Lars Ellenberg <lars.ellenberg@linbit.com>
In-Reply-To: <20170302213312.GL10667@soda.linbit>
Message-ID: <alpine.LRH.2.11.1703101611570.21446@mail.ewheeler.net>
References: <alpine.LRH.2.11.1702281620050.16946@mail.ewheeler.net>
	<20170301130614.GH10667@soda.linbit>
	<alpine.LRH.2.11.1703011211010.6659@mail.ewheeler.net>
	<20170302213312.GL10667@soda.linbit>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Cc: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] BUG: NULL pointer dereference triggered by drbdsetup
 events2
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

On Thu, 2 Mar 2017, Lars Ellenberg wrote:

> On Wed, Mar 01, 2017 at 01:36:55PM -0800, Eric Wheeler wrote:
> > On Wed, 1 Mar 2017, Lars Ellenberg wrote:
> > 
> > > On Tue, Feb 28, 2017 at 04:28:46PM -0800, Eric Wheeler wrote:
> > > > Hello all,
> > > > 
> > > > We found a relatively easy to reproduce bug that crashes the kernel. Start 
> > > > with all of the resources down and only the DRBD module loaded and run the 
> > > > following:
> > > > 
> > > > drbdadm up foo
> > > > drbdsetup events2 foo | true
> > > > drbdadm down foo; ls -d /sys/devices/virtual/bdi/147:7740
> > > > drbdadm up foo
> > > > 
> > > > The backtrace is below. The ls above simply illustrates the problem. After 
> > > > a down, the sysfs entry should not exist. The bug manifests because 
> > > > add_disk attempts to create the same sysfs entry but it cannot and fails 
> > > > up the stack. I have a feeling that the interface used by events2 is 
> > > > holding open a reference count after down so the sysfs entry is never 
> > > > removed.
> > > > 
> > > > We are piping into true because it fails quickly without reading any 
> > > > stdio, so perhaps the kernel is blocked trying to flush a buffer into 
> > > > userspace and never releases a resource count (speculation).
> > > > 
> > > > This was tested using the 4.10.1 kernel with userspace tools 
> > > > drbd-utils-8.9.4. I suspect this could be worked around in userspace, but 
> > > > it would be ideal if the kernel module could be fixed up to prevent a 
> > > > crash.
> > > > 
> > > > Please let me know if you need additional information or if I can provide 
> > > > any other testing.
> > > > 
> > > > Thank you for your help!
> > > 
> > > The "events2" part of drbd 8.4 was a "backport" from drbd 9.
> > > I found this apparently relevant commit in our DRBD 9 repo.
> > > 
> > > In our out-of-tree 8.4 code, we later dropped the .done parts again,
> > > for compat with RHEL 5, which is likely why this fix fell through.
> > > 
> > > I basically only re-diffed and compile-tested for current upstream kernel.
> > > Does this help already, or do we need to dig deeper?
> > 
> > Hi Lars,
> > 
> > Thank you for responding so quickly!
> > 
> > The events2 feature is neat, it allows us to prevent polling and provide 
> > better responsiveness in our infrastructure. We applied the patch and this 
> > is what we found:
> > 
> > It no longer crashes the kernel with a null pointer dereference, but now 
> > the drbdsetup calls never leave the kernel. The first time we ran the test 
> > case it worked fine, but the second time 'drbdadm down foo' hung. I 
> > checked the stack traces inside the kernel for each process that is hung 
> > and have also included the output of this test:
> > 
> > 
> > # This test succeeded
> > ~]# drbdadm up foo
> > ~]# drbdsetup events2 foo | true
> > ~]# drbdadm down foo; ls -d /sys/devices/virtual/bdi/147:7740
> > ls: cannot access /sys/devices/virtual/bdi/147:7740: No such file or directory
> > ~]# drbdadm up foo
> 
> right.
> 
> > # This test failed
> > ~]# drbdsetup events2 foo | true
> > ~]# drbdadm down foo; ls -d /sys/devices/virtual/bdi/147:7740
> > Command 'drbdsetup-84 down foo' did not terminate within 600 seconds
> > /sys/devices/virtual/bdi/147:7740
> > ~]# drbdadm up foo
> > Command 'drbdsetup-84 new-resource foo --on-no-data-accessible=suspend-io' did not terminate within 5 seconds
> 
> There is something else going on here.
> 
> > The second test that failed left hung drbdsetup processes:
> > 
> > ~]# ps ax |grep drbdsetup-84
> >  1579 pts/0    D      0:00 drbdsetup-84 down foo
> >  1585 ?        D      0:00 drbdsetup-84 role 7740
> 
> Where is that "role" coming from?
> 
> >  1737 pts/0    D      0:00 drbdsetup-84 new-resource foo --on-no-data-accessible=suspend-io
> > 
> > These are the in-kernel stack traces for each pid:
> > 
> > ##### 1579 pts/0    D+     0:00 drbdsetup-84 down foo
> > [root@hvtest2 ~]# cat /proc/1579/stack 
> > [<ffffffff81102a8c>] wait_rcu_gp+0x5c/0x80
> > [<ffffffff81106685>] synchronize_sched+0x45/0x60
> > [<ffffffffa02a8ca2>] adm_del_resource+0xf2/0x110 [drbd]
> 
> Hm.
> That's just doing a synchronize_rcu().
> 
> > [<ffffffffa02ab5f3>] drbd_adm_down+0x233/0x240 [drbd]
> > [<ffffffff8161235d>] genl_family_rcv_msg+0x1cd/0x400
> > [<ffffffff81612621>] genl_rcv_msg+0x91/0xd0
> > [<ffffffff816113f1>] netlink_rcv_skb+0xc1/0xe0
> > [<ffffffff81611adc>] genl_rcv+0x2c/0x40
> > [<ffffffff81610a76>] netlink_unicast+0x106/0x210
> > [<ffffffff81610fb4>] netlink_sendmsg+0x434/0x690
> 
> > ##### 1585 ?        D      0:00 drbdsetup-84 role 7740
> > ~]# cat /proc/1585/stack
> > [<ffffffff81612658>] genl_rcv_msg+0xc8/0xd0
> 
> This is likely waiting for the "genl_lock()".
> 
> > [<ffffffff816113f1>] netlink_rcv_skb+0xc1/0xe0
> > [<ffffffff81611adc>] genl_rcv+0x2c/0x40
> > [<ffffffff81610a76>] netlink_unicast+0x106/0x210
> > [<ffffffff81610fb4>] netlink_sendmsg+0x434/0x690
> 
> > ##### 1737 pts/0    D      0:00 drbdsetup-84 new-resource foo --on-no-data-accessible=suspend-io
> > ~]# cat /proc/1737/stack 
> > [<ffffffff81612658>] genl_rcv_msg+0xc8/0xd0
> 
> The same.
> 
> > [<ffffffff816113f1>] netlink_rcv_skb+0xc1/0xe0
> > [<ffffffff81611adc>] genl_rcv+0x2c/0x40
> > [<ffffffff81610a76>] netlink_unicast+0x106/0x210
> > [<ffffffff81610fb4>] netlink_sendmsg+0x434/0x690
> 
> The two drbdsetup waiting for genl_lock()
> are maybe ugly, but expected in this,
> as the drbdsetup down still holds it.
> 
> Question is: why does that down not make progress,
> Why does the rcu grace period not make progress?
> 
> Anything suspicious in the logs before that?
> 
> > Please let me know if you would like any additional information.
> 
> Just as an additional data point,
> can you try to reproduce with our out-of-tree DRBD 8.4 git?
> (plus that .done() fix... I did not yet push it)

Sure, this is the latest out of tree DRBD from git with the .done patch:

This is our test:
~]# drbdadm up foo
~]# drbdsetup events2 foo | true
~]# drbdadm down foo; ls -d /sys/devices/virtual/bdi/147:7740
/sys/devices/virtual/bdi/147:7740

The first few times we were running the commands slowly, one at a time and 
did not hit the bug. However, when they are run in short succession in a 
script or by pasting to a terminal, down shows that the directory still 
exists as shown above. Thus, something is holding the sysfs entry in 
place.

There is still a `drbdsetup-84 role 7740` stuck after down completes and 
its stack trace are as follows (Note that we never ran `drbdsetup role 
7740`):

~]# ps ax |grep drbdsetup
14787 ?        D      0:00 drbdsetup-84 role 7740
~]# cat /proc/14787/stack 
[<ffffffff81612658>] genl_rcv_msg+0xc8/0xd0
[<ffffffff816113f1>] netlink_rcv_skb+0xc1/0xe0
[<ffffffff81611adc>] genl_rcv+0x2c/0x40
[<ffffffff81610a76>] netlink_unicast+0x106/0x210
[<ffffffff81610fb4>] netlink_sendmsg+0x434/0x690
[<ffffffff815c036d>] sock_sendmsg+0x3d/0x50
[<ffffffff815c0405>] sock_write_iter+0x85/0xf0
[<ffffffff812257b1>] __vfs_write+0xd1/0x110
[<ffffffff81225e49>] vfs_write+0xa9/0x1b0
[<ffffffff81226cf5>] SyS_write+0x55/0xd0
[<ffffffff816fdb6e>] system_call_fastpath+0x12/0x71
[<ffffffffffffffff>] 0xffffffffffffffff


When we were able to trigger the bug, this is the full kernel output. We 
are using the latest 4.1.38 and your latest 8.4 kernel module from 
git://git.linbit.com/drbd-8.4.git .

I notice that there is a bug about rcu scheduling while atomic, but I am 
not sure if that's related or a side effect of the actual issue:

kernel: drbd foo: Starting worker thread (from drbdsetup-84 [14768])
kernel: block drbd7740: disk( Diskless -> Attaching ) 
kernel: drbd foo: Method to ensure write ordering: flush
kernel: block drbd7740: max BIO size = 1048576
kernel: block drbd7740: Adjusting my ra_pages to backing device's (32 -> 1024)
kernel: block drbd7740: drbd_bm_resize called with capacity == 4194040
kernel: block drbd7740: resync bitmap: bits=524255 words=8192 pages=16
kernel: block drbd7740: size = 2048 MB (2097020 KB)
kernel: block drbd7740: recounting of set bits took additional 0 jiffies
kernel: block drbd7740: 0 KB (0 bits) marked out-of-sync by on disk bit-map.
kernel: block drbd7740: disk( Attaching -> UpToDate ) 
kernel: block drbd7740: attached to UUIDs B8CB842A92C72018:0000000000000000:054C0372E3E65F70:054B0372E3E65F70
kernel: drbd foo: conn( StandAlone -> Unconnected ) 
kernel: drbd foo: Starting receiver thread (from drbd_w_foo [14771])
kernel: drbd foo: receiver (re)started
kernel: drbd foo: conn( Unconnected -> WFConnection ) 
kernel: drbd foo: conn( WFConnection -> Disconnecting ) 
kernel: drbd foo: Discarding network configuration.
kernel: drbd foo: Connection closed
kernel: drbd foo: conn( Disconnecting -> StandAlone ) 
kernel: drbd foo: receiver terminated
kernel: drbd foo: Terminating drbd_r_foo
kernel: block drbd7740: disk( UpToDate -> Failed ) 
kernel: BUG: scheduling while atomic: rcuos/2/25/0x00000200
kernel: Modules linked in: md4 xt_CHECKSUM iptable_mangle ipt_MASQUERADE nf_nat_masquerade_ipv4 iptable_nat nf_nat_ipv4 nf_nat nf_conntrack_ipv4 nf_defrag_ipv4 xt_conntrack nf_conntrack ipt_REJECT nf_reject_ipv4 bridge stp llc ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter dm_thin_pool dm_persistent_data dm_bio_prison dm_bufio kvm_intel kvm ppdev i2c_piix4 pcspkr virtio_balloon sg parport_pc parport acpi_cpufreq nfsd auth_rpcgss nfs_acl lockd grace sunrpc drbd(OE) libcrc32c ip_tables ext4 mbcache jbd2 sr_mod cdrom ata_generic pata_acpi cirrus syscopyarea sysfillrect sysimgblt drm_kms_helper ttm drm crc32c_intel ata_piix i2c_core serio_raw virtio_blk libata floppy virtio_net dm_mirror dm_region_hash dm_log dm_mod
kernel: CPU: 2 PID: 25 Comm: rcuos/2 Tainted: G           OE   4.1.38-4.el7.x86_64 #1
kernel: Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
kernel: 0000000000000286 00000000f24899fd ffff88023626fc48 ffffffff816f611c
kernel: ffff88023fd177c0 ffffffff81b4fb64 ffff88023626fc58 ffffffff816f0b25
kernel: ffff88023626fca8 ffffffff816f97ad ffff880236276040 ffff880236270000
kernel: Call Trace:
kernel: [<ffffffff816f611c>] dump_stack+0x63/0x81
kernel: [<ffffffff816f0b25>] __schedule_bug+0x4b/0x59
kernel: [<ffffffff816f97ad>] __schedule+0x7cd/0x950
kernel: [<ffffffff816f9967>] schedule+0x37/0x90
kernel: [<ffffffff816f9c9e>] schedule_preempt_disabled+0xe/0x10
kernel: [<ffffffff816fba95>] __mutex_lock_slowpath+0xb5/0x130
kernel: [<ffffffff816fbb33>] mutex_lock+0x23/0x37
kernel: [<ffffffff8161170f>] genl_lock_done+0x2f/0x60
kernel: [<ffffffff8160cfae>] netlink_sock_destruct+0x3e/0x150
kernel: [<ffffffff815c4663>] __sk_free+0x23/0x140
kernel: [<ffffffff815c4799>] sk_free+0x19/0x20
kernel: [<ffffffff8160da70>] deferred_put_nlk_sk+0x20/0x30
kernel: [<ffffffff81104dff>] rcu_nocb_kthread+0x18f/0x550
kernel: [<ffffffff810e6a80>] ? prepare_to_wait_event+0xf0/0xf0
kernel: [<ffffffff81104c70>] ? rcu_cpu_notify+0x3c0/0x3c0
kernel: [<ffffffff810c0c98>] kthread+0xd8/0xf0
kernel: [<ffffffff810c0bc0>] ? kthread_create_on_node+0x1b0/0x1b0
kernel: [<ffffffff816fdf62>] ret_from_fork+0x42/0x70
kernel: [<ffffffff810c0bc0>] ? kthread_create_on_node+0x1b0/0x1b0
kernel: NOHZ: local_softirq_pending 282
kernel: block drbd7740: 0 KB (0 bits) marked out-of-sync by on disk bit-map.
kernel: block drbd7740: disk( Failed -> Diskless ) 
kernel: drbd foo: Terminating drbd_w_foo
kernel: BUG: scheduling while atomic: rcuos/2/25/0x00000200
kernel: Modules linked in: md4 xt_CHECKSUM iptable_mangle ipt_MASQUERADE nf_nat_masquerade_ipv4 iptable_nat nf_nat_ipv4 nf_nat nf_conntrack_ipv4 nf_defrag_ipv4 xt_conntrack nf_conntrack ipt_REJECT nf_reject_ipv4 bridge stp llc ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter dm_thin_pool dm_persistent_data dm_bio_prison dm_bufio kvm_intel kvm ppdev i2c_piix4 pcspkr virtio_balloon sg parport_pc parport acpi_cpufreq nfsd auth_rpcgss nfs_acl lockd grace sunrpc drbd(OE) libcrc32c ip_tables ext4 mbcache jbd2 sr_mod cdrom ata_generic pata_acpi cirrus syscopyarea sysfillrect sysimgblt drm_kms_helper ttm drm crc32c_intel ata_piix i2c_core serio_raw virtio_blk libata floppy virtio_net dm_mirror dm_region_hash dm_log dm_mod
kernel: CPU: 2 PID: 25 Comm: rcuos/2 Tainted: G        W  OE   4.1.38-4.el7.x86_64 #1
kernel: Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
kernel: 0000000000000286 00000000f24899fd ffff88023626f9c8 ffffffff816f611c
kernel: ffff88023fd177c0 ffff88023626fb80 ffff88023626f9d8 ffffffff816f0b25
kernel: ffff88023626fa28 ffffffff816f97ad ffff88023626f9f8 ffff880236270000
kernel: Call Trace:
kernel: [<ffffffff816f611c>] dump_stack+0x63/0x81
kernel: [<ffffffff816f0b25>] __schedule_bug+0x4b/0x59
kernel: [<ffffffff816f97ad>] __schedule+0x7cd/0x950
kernel: [<ffffffff816f9967>] schedule+0x37/0x90
kernel: [<ffffffff816fc9e4>] schedule_timeout+0x244/0x2c0
kernel: [<ffffffff810cf7c4>] ? try_to_wake_up+0x1d4/0x350
kernel: [<ffffffff81103610>] ? get_state_synchronize_rcu+0x20/0x20
kernel: [<ffffffff816fa4d4>] wait_for_completion+0x134/0x190
kernel: [<ffffffff810cf9b0>] ? wake_up_state+0x20/0x20
kernel: [<ffffffff81103610>] ? get_state_synchronize_rcu+0x20/0x20
kernel: [<ffffffff81141ebf>] __stop_cpus+0x5f/0x90
kernel: [<ffffffff81103610>] ? get_state_synchronize_rcu+0x20/0x20
kernel: [<ffffffff811421fe>] try_stop_cpus+0x3e/0x60
kernel: [<ffffffff81106454>] synchronize_sched_expedited+0x134/0x320
kernel: [<ffffffff8110672e>] synchronize_rcu_expedited+0xe/0x10
kernel: [<ffffffff811cb64a>] bdi_destroy+0x11a/0x170
kernel: [<ffffffff8131dee7>] blk_cleanup_queue+0x117/0x1e0
kernel: [<ffffffffa02934de>] drbd_destroy_device+0x15e/0x370 [drbd]
kernel: [<ffffffffa02ad81d>] forget_state_change+0xbd/0xf0 [drbd]
kernel: [<ffffffffa029e210>] drbd_adm_get_initial_state_done+0x80/0x90 [drbd]
kernel: [<ffffffff81611717>] genl_lock_done+0x37/0x60
kernel: [<ffffffff8160cfae>] netlink_sock_destruct+0x3e/0x150
kernel: [<ffffffff815c4663>] __sk_free+0x23/0x140
kernel: [<ffffffff815c4799>] sk_free+0x19/0x20
kernel: [<ffffffff8160da70>] deferred_put_nlk_sk+0x20/0x30
kernel: [<ffffffff81104dff>] rcu_nocb_kthread+0x18f/0x550
kernel: [<ffffffff810e6a80>] ? prepare_to_wait_event+0xf0/0xf0
kernel: [<ffffffff81104c70>] ? rcu_cpu_notify+0x3c0/0x3c0
kernel: [<ffffffff810c0c98>] kthread+0xd8/0xf0
kernel: [<ffffffff810c0bc0>] ? kthread_create_on_node+0x1b0/0x1b0
kernel: [<ffffffff816fdf62>] ret_from_fork+0x42/0x70
kernel: [<ffffffff810c0bc0>] ? kthread_create_on_node+0x1b0/0x1b0
kernel: BUG: scheduling while atomic: rcuos/2/25/0x00000200
kernel: Modules linked in: md4 xt_CHECKSUM iptable_mangle ipt_MASQUERADE nf_nat_masquerade_ipv4 iptable_nat nf_nat_ipv4 nf_nat nf_conntrack_ipv4 nf_defrag_ipv4 xt_conntrack nf_conntrack ipt_REJECT nf_reject_ipv4 bridge stp llc ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter dm_thin_pool dm_persistent_data dm_bio_prison dm_bufio kvm_intel kvm ppdev i2c_piix4 pcspkr virtio_balloon sg parport_pc parport acpi_cpufreq nfsd auth_rpcgss nfs_acl lockd grace sunrpc drbd(OE) libcrc32c ip_tables ext4 mbcache jbd2 sr_mod cdrom ata_generic pata_acpi cirrus syscopyarea sysfillrect sysimgblt drm_kms_helper ttm drm crc32c_intel ata_piix i2c_core serio_raw virtio_blk libata floppy virtio_net dm_mirror dm_region_hash dm_log dm_mod
kernel: CPU: 2 PID: 25 Comm: rcuos/2 Tainted: G        W  OE   4.1.38-4.el7.x86_64 #1
kernel: Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
kernel: 0000000000000286 00000000f24899fd ffff88023626fa28 ffffffff816f611c
kernel: ffff88023fd177c0 ffff88023626fbe8 ffff88023626fa38 ffffffff816f0b25
kernel: ffff88023626fa88 ffffffff816f97ad ffff88023626fa68 ffff880236270000
kernel: Call Trace:
kernel: [<ffffffff816f611c>] dump_stack+0x63/0x81
kernel: [<ffffffff816f0b25>] __schedule_bug+0x4b/0x59
kernel: [<ffffffff816f97ad>] __schedule+0x7cd/0x950
kernel: [<ffffffff816f9967>] schedule+0x37/0x90
kernel: [<ffffffff816fc9e4>] schedule_timeout+0x244/0x2c0
kernel: [<ffffffff810cf7c4>] ? try_to_wake_up+0x1d4/0x350
kernel: [<ffffffff810cf9b0>] ? wake_up_state+0x20/0x20
kernel: [<ffffffff816fa4d4>] wait_for_completion+0x134/0x190
kernel: [<ffffffff810cf9b0>] ? wake_up_state+0x20/0x20
kernel: [<ffffffff810b9c09>] flush_work+0x109/0x1f0
kernel: [<ffffffff810b7610>] ? destroy_worker+0x90/0x90
kernel: [<ffffffff810b9fc3>] flush_delayed_work+0x43/0x50
kernel: [<ffffffff811cb668>] bdi_destroy+0x138/0x170
kernel: [<ffffffff8131dee7>] blk_cleanup_queue+0x117/0x1e0
kernel: [<ffffffffa02934de>] drbd_destroy_device+0x15e/0x370 [drbd]
kernel: [<ffffffffa02ad81d>] forget_state_change+0xbd/0xf0 [drbd]
kernel: [<ffffffffa029e210>] drbd_adm_get_initial_state_done+0x80/0x90 [drbd]
kernel: [<ffffffff81611717>] genl_lock_done+0x37/0x60
kernel: [<ffffffff8160cfae>] netlink_sock_destruct+0x3e/0x150
kernel: [<ffffffff815c4663>] __sk_free+0x23/0x140
kernel: [<ffffffff815c4799>] sk_free+0x19/0x20
kernel: [<ffffffff8160da70>] deferred_put_nlk_sk+0x20/0x30
kernel: [<ffffffff81104dff>] rcu_nocb_kthread+0x18f/0x550
kernel: [<ffffffff810e6a80>] ? prepare_to_wait_event+0xf0/0xf0
kernel: [<ffffffff81104c70>] ? rcu_cpu_notify+0x3c0/0x3c0
kernel: [<ffffffff810c0c98>] kthread+0xd8/0xf0
kernel: [<ffffffff810c0bc0>] ? kthread_create_on_node+0x1b0/0x1b0
kernel: [<ffffffff816fdf62>] ret_from_fork+0x42/0x70
kernel: [<ffffffff810c0bc0>] ? kthread_create_on_node+0x1b0/0x1b0
kernel: BUG: scheduling while atomic: rcuos/2/25/0x00000200
kernel: Modules linked in: md4 xt_CHECKSUM iptable_mangle ipt_MASQUERADE nf_nat_masquerade_ipv4 iptable_nat nf_nat_ipv4 nf_nat nf_conntrack_ipv4 nf_defrag_ipv4 xt_conntrack nf_conntrack ipt_REJECT nf_reject_ipv4 bridge stp llc ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter dm_thin_pool dm_persistent_data dm_bio_prison dm_bufio kvm_intel kvm ppdev i2c_piix4 pcspkr virtio_balloon sg parport_pc parport acpi_cpufreq nfsd auth_rpcgss nfs_acl lockd grace sunrpc drbd(OE) libcrc32c ip_tables ext4 mbcache jbd2 sr_mod cdrom ata_generic pata_acpi cirrus syscopyarea sysfillrect sysimgblt drm_kms_helper ttm drm crc32c_intel ata_piix i2c_core serio_raw virtio_blk libata floppy virtio_net dm_mirror dm_region_hash dm_log dm_mod
kernel: CPU: 2 PID: 25 Comm: rcuos/2 Tainted: G        W  OE   4.1.38-4.el7.x86_64 #1
kernel: Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
kernel: 0000000000000286 00000000f24899fd ffff88023626f978 ffffffff816f611c
kernel: ffff88023fd177c0 ffff88023626fb28 ffff88023626f988 ffffffff816f0b25
kernel: ffff88023626f9d8 ffffffff816f97ad ffff88023626f9d8 ffff880236270000
kernel: Call Trace:
kernel: [<ffffffff816f611c>] dump_stack+0x63/0x81
kernel: [<ffffffff816f0b25>] __schedule_bug+0x4b/0x59
kernel: [<ffffffff816f97ad>] __schedule+0x7cd/0x950
kernel: [<ffffffff816f9967>] schedule+0x37/0x90
kernel: [<ffffffff816fc9e4>] schedule_timeout+0x244/0x2c0
kernel: [<ffffffff810e6784>] ? __wake_up_sync_key+0x54/0x70
kernel: [<ffffffff816fa4d4>] wait_for_completion+0x134/0x190
kernel: [<ffffffff810cf9b0>] ? wake_up_state+0x20/0x20
kernel: [<ffffffff81105690>] ? __call_rcu+0x340/0x340
kernel: [<ffffffff81102a8c>] wait_rcu_gp+0x5c/0x80
kernel: [<ffffffff81102a10>] ? ftrace_raw_output_rcu_utilization+0x70/0x70
kernel: [<ffffffff81106685>] synchronize_sched+0x45/0x60
kernel: [<ffffffff8131dcc2>] blk_queue_bypass_start+0xb2/0xe0
kernel: [<ffffffff81339968>] blkcg_deactivate_policy+0x38/0x140
kernel: [<ffffffff8133dd28>] blk_throtl_exit+0x38/0x50
kernel: [<ffffffff8133a894>] blkcg_exit_queue+0x44/0x70
kernel: [<ffffffff81321c5e>] blk_release_queue+0x1e/0x100
kernel: [<ffffffff8135effb>] kobject_cleanup+0x7b/0x1a0
kernel: [<ffffffff8135eea0>] kobject_put+0x30/0x70
kernel: [<ffffffff8131def3>] blk_cleanup_queue+0x123/0x1e0
kernel: [<ffffffffa02934de>] drbd_destroy_device+0x15e/0x370 [drbd]
kernel: [<ffffffffa02ad81d>] forget_state_change+0xbd/0xf0 [drbd]
kernel: [<ffffffffa029e210>] drbd_adm_get_initial_state_done+0x80/0x90 [drbd]
kernel: [<ffffffff81611717>] genl_lock_done+0x37/0x60
kernel: [<ffffffff8160cfae>] netlink_sock_destruct+0x3e/0x150
kernel: [<ffffffff815c4663>] __sk_free+0x23/0x140
kernel: [<ffffffff815c4799>] sk_free+0x19/0x20
kernel: [<ffffffff8160da70>] deferred_put_nlk_sk+0x20/0x30
kernel: [<ffffffff81104dff>] rcu_nocb_kthread+0x18f/0x550
kernel: [<ffffffff810e6a80>] ? prepare_to_wait_event+0xf0/0xf0
kernel: [<ffffffff81104c70>] ? rcu_cpu_notify+0x3c0/0x3c0
kernel: [<ffffffff810c0c98>] kthread+0xd8/0xf0
kernel: [<ffffffff810c0bc0>] ? kthread_create_on_node+0x1b0/0x1b0
kernel: [<ffffffff816fdf62>] ret_from_fork+0x42/0x70
kernel: [<ffffffff810c0bc0>] ? kthread_create_on_node+0x1b0/0x1b0
kernel: NOHZ: local_softirq_pending 282
