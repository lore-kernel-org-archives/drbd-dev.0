Return-Path: <drbd-dev@lists.ewheeler.net>
Received: from mail.ewheeler.net (mx.ewheeler.net [66.155.3.69])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id F25251056487
	for <drbd-dev@lists.linbit.com>; Wed,  1 Mar 2017 01:33:52 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mail.ewheeler.net (Postfix) with ESMTP id 3E536A0C5B
	for <drbd-dev@lists.linbit.com>; Tue, 28 Feb 2017 16:28:50 -0800 (PST)
Received: from mail.ewheeler.net ([127.0.0.1])
	by localhost (mail.ewheeler.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id IYbXGuzFjiIw for <drbd-dev@lists.linbit.com>;
	Tue, 28 Feb 2017 16:28:49 -0800 (PST)
Received: from mx.ewheeler.net (mx.ewheeler.net [66.155.3.69])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.ewheeler.net (Postfix) with ESMTPSA id 5A462A0C5A
	for <drbd-dev@lists.linbit.com>; Tue, 28 Feb 2017 16:28:49 -0800 (PST)
Date: Tue, 28 Feb 2017 16:28:46 -0800 (PST)
From: Eric Wheeler <drbd-dev@lists.ewheeler.net>
To: drbd-dev@lists.linbit.com
Message-ID: <alpine.LRH.2.11.1702281620050.16946@mail.ewheeler.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [Drbd-dev] BUG: NULL pointer dereference triggered by drbdsetup
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

Hello all,

We found a relatively easy to reproduce bug that crashes the kernel. Start 
with all of the resources down and only the DRBD module loaded and run the 
following:

drbdadm up foo
drbdsetup events2 foo | true
drbdadm down foo; ls -d /sys/devices/virtual/bdi/147:7740
drbdadm up foo

The backtrace is below. The ls above simply illustrates the problem. After 
a down, the sysfs entry should not exist. The bug manifests because 
add_disk attempts to create the same sysfs entry but it cannot and fails 
up the stack. I have a feeling that the interface used by events2 is 
holding open a reference count after down so the sysfs entry is never 
removed.

We are piping into true because it fails quickly without reading any 
stdio, so perhaps the kernel is blocked trying to flush a buffer into 
userspace and never releases a resource count (speculation).

This was tested using the 4.10.1 kernel with userspace tools 
drbd-utils-8.9.4. I suspect this could be worked around in userspace, but 
it would be ideal if the kernel module could be fixed up to prevent a 
crash.

Please let me know if you need additional information or if I can provide 
any other testing.

Thank you for your help!

--
Eric Wheeler


[  147.386028] ------------[ cut here ]------------
[  147.386495] WARNING: CPU: 0 PID: 1956 at fs/sysfs/dir.c:31 sysfs_warn_dup+0x64/0x80
[  147.387106] sysfs: cannot create duplicate filename '/devices/virtual/bdi/147:7740'
[  147.387735] Modules linked in: md4 xt_CHECKSUM iptable_mangle ipt_MASQUERADE nf_nat_masquerade_ipv4 iptable_nat nf_nat_ipv4 nf_nat nf_conntrack_ipv4 nf_defrag_ipv4 xt_conntrack nf_conntrack ipt_REJECT nf_reject_ipv4 bridge stp llc ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter dm_thin_pool dm_persistent_data dm_bio_prison dm_bufio kvm_intel kvm irqbypass nfsd sg ppdev virtio_balloon parport_pc parport i2c_piix4 acpi_cpufreq pcspkr auth_rpcgss nfs_acl lockd grace sunrpc ip_tables ext4 jbd2 mbcache sr_mod cdrom ata_generic pata_acpi cirrus drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops ttm serio_raw virtio_blk floppy virtio_net drm ata_piix i2c_core libata dm_mirror dm_region_hash dm_log dm_mod drbd libcrc32c crc32c_intel lru_cache
[  147.392997] CPU: 0 PID: 1956 Comm: drbdsetup-84 Not tainted 4.10.1 #9
[  147.393508] Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
[  147.394029] Call Trace:
[  147.394230]  dump_stack+0x63/0x87
[  147.394495]  __warn+0xd1/0xf0
[  147.394730]  warn_slowpath_fmt+0x5f/0x80
[  147.395039]  ? kernfs_path_from_node+0x50/0x60
[  147.395391]  sysfs_warn_dup+0x64/0x80
[  147.396799]  sysfs_create_dir_ns+0x7e/0x90
[  147.398192]  kobject_add_internal+0xc1/0x340
[  147.399548]  ? vsnprintf+0x34e/0x4d0
[  147.400841]  kobject_add+0x75/0xd0
[  147.402104]  ? mutex_lock+0x12/0x40
[  147.403351]  device_add+0x119/0x610
[  147.404588]  device_create_groups_vargs+0xd8/0x100
[  147.405923]  device_create_vargs+0x1c/0x20
[  147.407193]  bdi_register+0x8c/0x1a0
[  147.408417]  bdi_register_owner+0x38/0x60
[  147.409677]  device_add_disk+0x165/0x4a0
[  147.410914]  ? kmem_cache_alloc_trace+0x19b/0x1b0
[  147.412207]  drbd_create_device+0x64f/0x780 [drbd]
[  147.413554]  drbd_adm_new_minor+0xec/0x2c0 [drbd]
[  147.414848]  ? selinux_capable+0x20/0x30
[  147.416052]  genl_family_rcv_msg+0x1f6/0x3e0
[  147.417247]  ? copy_to_iter+0x97/0x430
[  147.418433]  genl_rcv_msg+0x5c/0xb0
[  147.419564]  ? __netlink_lookup+0xc0/0x110
[  147.420733]  ? genl_family_rcv_msg+0x3e0/0x3e0
[  147.421949]  netlink_rcv_skb+0xa7/0xc0
[  147.423092]  genl_rcv+0x28/0x40
[  147.424187]  netlink_unicast+0x181/0x240
[  147.425336]  netlink_sendmsg+0x32e/0x3b0
[  147.426477]  sock_sendmsg+0x38/0x50
[  147.427606]  sock_write_iter+0x85/0xf0
[  147.428750]  __vfs_write+0xe2/0x140
[  147.429843]  vfs_write+0xb2/0x1b0
[  147.430916]  ? syscall_trace_enter+0x1d0/0x2b0
[  147.432109]  SyS_write+0x55/0xc0
[  147.433183]  do_syscall_64+0x67/0x180
[  147.434268]  entry_SYSCALL64_slow_path+0x25/0x25
[  147.435406] RIP: 0033:0x7f2615c4cc60
[  147.436439] RSP: 002b:00007fffa5bcb488 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[  147.437753] RAX: ffffffffffffffda RBX: 0000000000a04070 RCX: 00007f2615c4cc60
[  147.439020] RDX: 0000000000000030 RSI: 0000000000a04080 RDI: 0000000000000004
[  147.440264] RBP: 0000000000000030 R08: 0000000000001fd8 R09: 0000000000000065
[  147.441469] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000a04080
[  147.442694] R13: 0000000000000030 R14: 0000000000000004 R15: 0000000000414438
[  147.443874] ---[ end trace 81090c3270658cb6 ]---
[  147.444975] ------------[ cut here ]------------
[  147.446066] WARNING: CPU: 0 PID: 1956 at lib/kobject.c:240 kobject_add_internal+0x2d4/0x340
[  147.447436] kobject_add_internal failed for 147:7740 with -EEXIST, don't try to register things with the same name in the same directory.
[  147.449675] Modules linked in: md4 xt_CHECKSUM iptable_mangle ipt_MASQUERADE nf_nat_masquerade_ipv4 iptable_nat nf_nat_ipv4 nf_nat nf_conntrack_ipv4 nf_defrag_ipv4 xt_conntrack nf_conntrack ipt_REJECT nf_reject_ipv4 bridge stp llc ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter dm_thin_pool dm_persistent_data dm_bio_prison dm_bufio kvm_intel kvm irqbypass nfsd sg ppdev virtio_balloon parport_pc parport i2c_piix4 acpi_cpufreq pcspkr auth_rpcgss nfs_acl lockd grace sunrpc ip_tables ext4 jbd2 mbcache sr_mod cdrom ata_generic pata_acpi cirrus drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops ttm serio_raw virtio_blk floppy virtio_net drm ata_piix i2c_core libata dm_mirror dm_region_hash dm_log dm_mod drbd libcrc32c crc32c_intel lru_cache
[  147.460329] CPU: 0 PID: 1956 Comm: drbdsetup-84 Tainted: G        W       4.10.1 #9
[  147.461922] Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
[  147.463263] Call Trace:
[  147.464357]  dump_stack+0x63/0x87
[  147.465660]  __warn+0xd1/0xf0
[  147.466801]  warn_slowpath_fmt+0x5f/0x80
[  147.468016]  ? sysfs_warn_dup+0x6c/0x80
[  147.469222]  kobject_add_internal+0x2d4/0x340
[  147.470461]  ? vsnprintf+0x34e/0x4d0
[  147.471650]  kobject_add+0x75/0xd0
[  147.472810]  ? mutex_lock+0x12/0x40
[  147.473970]  device_add+0x119/0x610
[  147.475130]  device_create_groups_vargs+0xd8/0x100
[  147.476415]  device_create_vargs+0x1c/0x20
[  147.477746]  bdi_register+0x8c/0x1a0
[  147.478935]  bdi_register_owner+0x38/0x60
[  147.480160]  device_add_disk+0x165/0x4a0
[  147.481416]  ? kmem_cache_alloc_trace+0x19b/0x1b0
[  147.482698]  drbd_create_device+0x64f/0x780 [drbd]
[  147.483964]  drbd_adm_new_minor+0xec/0x2c0 [drbd]
[  147.485229]  ? selinux_capable+0x20/0x30
[  147.486457]  genl_family_rcv_msg+0x1f6/0x3e0
[  147.487825]  ? copy_to_iter+0x97/0x430
[  147.489023]  genl_rcv_msg+0x5c/0xb0
[  147.490211]  ? __netlink_lookup+0xc0/0x110
[  147.491438]  ? genl_family_rcv_msg+0x3e0/0x3e0
[  147.492689]  netlink_rcv_skb+0xa7/0xc0
[  147.493928]  genl_rcv+0x28/0x40
[  147.495077]  netlink_unicast+0x181/0x240
[  147.496374]  netlink_sendmsg+0x32e/0x3b0
[  147.497608]  sock_sendmsg+0x38/0x50
[  147.498843]  sock_write_iter+0x85/0xf0
[  147.500020]  __vfs_write+0xe2/0x140
[  147.501199]  vfs_write+0xb2/0x1b0
[  147.502329]  ? syscall_trace_enter+0x1d0/0x2b0
[  147.503592]  SyS_write+0x55/0xc0
[  147.504694]  do_syscall_64+0x67/0x180
[  147.505837]  entry_SYSCALL64_slow_path+0x25/0x25
[  147.507038] RIP: 0033:0x7f2615c4cc60
[  147.508155] RSP: 002b:00007fffa5bcb488 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[  147.509537] RAX: ffffffffffffffda RBX: 0000000000a04070 RCX: 00007f2615c4cc60
[  147.510864] RDX: 0000000000000030 RSI: 0000000000a04080 RDI: 0000000000000004
[  147.512276] RBP: 0000000000000030 R08: 0000000000001fd8 R09: 0000000000000065
[  147.513545] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000a04080
[  147.514890] R13: 0000000000000030 R14: 0000000000000004 R15: 0000000000414438
[  147.516183] ---[ end trace 81090c3270658cb7 ]---
[  147.517686] BUG: unable to handle kernel NULL pointer dereference at 0000000000000040
[  147.518959] IP: sysfs_do_create_link_sd.isra.2+0x34/0xb0
[  147.520001] PGD 234009067 
[  147.520002] PUD 234b30067 
[  147.520877] PMD 0 
[  147.521734] 
[  147.523326] Oops: 0000 [#1] SMP
[  147.524164] Modules linked in: md4 xt_CHECKSUM iptable_mangle ipt_MASQUERADE nf_nat_masquerade_ipv4 iptable_nat nf_nat_ipv4 nf_nat nf_conntrack_ipv4 nf_defrag_ipv4 xt_conntrack nf_conntrack ipt_REJECT nf_reject_ipv4 bridge stp llc ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter dm_thin_pool dm_persistent_data dm_bio_prison dm_bufio kvm_intel kvm irqbypass nfsd sg ppdev virtio_balloon parport_pc parport i2c_piix4 acpi_cpufreq pcspkr auth_rpcgss nfs_acl lockd grace sunrpc ip_tables ext4 jbd2 mbcache sr_mod cdrom ata_generic pata_acpi cirrus drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops ttm serio_raw virtio_blk floppy virtio_net drm ata_piix i2c_core libata dm_mirror dm_region_hash dm_log dm_mod drbd libcrc32c crc32c_intel lru_cache
[  147.534222] CPU: 3 PID: 1956 Comm: drbdsetup-84 Tainted: G        W       4.10.1 #9
[  147.535672] Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
[  147.536950] task: ffff8802346fbd80 task.stack: ffffc90001ba4000
[  147.538251] RIP: 0010:sysfs_do_create_link_sd.isra.2+0x34/0xb0
[  147.539547] RSP: 0018:ffffc90001ba79a8 EFLAGS: 00010246
[  147.540797] RAX: 0000000000000000 RBX: 0000000000000040 RCX: 0000000000000001
[  147.542216] RDX: 0000000000000001 RSI: 0000000000000040 RDI: ffffffff8224bdb0
[  147.543622] RBP: ffffc90001ba79d0 R08: 000000000001cb40 R09: ffffffff813886c1
[  147.545113] R10: ffff88023fd9cb40 R11: ffffea0008d44700 R12: ffffffff81a26c0a
[  147.546525] R13: ffff880234d41a50 R14: 0000000000000001 R15: ffff8802326009b0
[  147.547944] FS:  00007f2616134740(0000) GS:ffff88023fd80000(0000) knlGS:0000000000000000
[  147.549432] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  147.550785] CR2: 0000000000000040 CR3: 0000000233b46000 CR4: 00000000000006e0
[  147.552220] Call Trace:
[  147.553401]  sysfs_create_link+0x25/0x40
[  147.554610]  device_add_disk+0x1fb/0x4a0
[  147.555838]  drbd_create_device+0x64f/0x780 [drbd]
[  147.557130]  drbd_adm_new_minor+0xec/0x2c0 [drbd]
[  147.558405]  ? selinux_capable+0x20/0x30
[  147.559622]  genl_family_rcv_msg+0x1f6/0x3e0
[  147.560866]  ? copy_to_iter+0x97/0x430
[  147.562091]  genl_rcv_msg+0x5c/0xb0
[  147.563335]  ? __netlink_lookup+0xc0/0x110
[  147.564612]  ? genl_family_rcv_msg+0x3e0/0x3e0
[  147.565877]  netlink_rcv_skb+0xa7/0xc0
[  147.567187]  genl_rcv+0x28/0x40
[  147.568343]  netlink_unicast+0x181/0x240
[  147.569555]  netlink_sendmsg+0x32e/0x3b0
[  147.570763]  sock_sendmsg+0x38/0x50
[  147.571914]  sock_write_iter+0x85/0xf0
[  147.573090]  __vfs_write+0xe2/0x140
[  147.574275]  vfs_write+0xb2/0x1b0
[  147.575447]  ? syscall_trace_enter+0x1d0/0x2b0
[  147.576687]  SyS_write+0x55/0xc0
[  147.577813]  do_syscall_64+0x67/0x180
[  147.579039]  entry_SYSCALL64_slow_path+0x25/0x25
[  147.580262] RIP: 0033:0x7f2615c4cc60
[  147.581395] RSP: 002b:00007fffa5bcb488 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[  147.582843] RAX: ffffffffffffffda RBX: 0000000000a04070 RCX: 00007f2615c4cc60
[  147.584315] RDX: 0000000000000030 RSI: 0000000000a04080 RDI: 0000000000000004
[  147.585762] RBP: 0000000000000030 R08: 0000000000001fd8 R09: 0000000000000065
[  147.587194] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000a04080
[  147.588590] R13: 0000000000000030 R14: 0000000000000004 R15: 0000000000414438
[  147.589959] Code: 48 89 e5 41 57 41 56 41 55 41 54 49 89 d4 53 74 73 48 85 ff 49 89 fd 74 6b 48 89 f3 48 c7 c7 b0 bd 24 82 41 89 ce e8 0c 00 47 00 <48> 8b 1b 48 85 db 74 08 48 89 df e8 dc c4 ff ff 48 c7 c7 b0 bd 
[  147.592976] RIP: sysfs_do_create_link_sd.isra.2+0x34/0xb0 RSP: ffffc90001ba79a8
[  147.594307] CR2: 0000000000000040
[  147.595350] ---[ end trace 81090c3270658cb8 ]---
[  147.596650] Kernel panic - not syncing: Fatal exception
[  147.597957] Kernel Offset: disabled
[  147.598975] ---[ end Kernel panic - not syncing: Fatal exception
