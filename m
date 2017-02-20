Return-Path: <andreas.osterburg@digide.net>
Received: from mx.datse.de (mx.datse.de [213.211.194.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 2F8EC1056483
	for <drbd-dev@lists.linbit.com>; Mon, 20 Feb 2017 12:04:44 +0100 (CET)
Received: from [192.168.101.42] (andreas.dde [192.168.101.42])
	by mx.datse.de (8.14.9/8.14.9) with ESMTP id v1KAsjXC020688
	for <drbd-dev@lists.linbit.com>; Mon, 20 Feb 2017 11:54:45 +0100
To: drbd-dev@lists.linbit.com
From: Andreas Osterburg <andreas.osterburg@digide.net>
Message-ID: <34e63ed3-e991-8a84-45c7-2d9682d5af86@digide.net>
Date: Mon, 20 Feb 2017 11:54:45 +0100
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------2C3359E4680875E79FAF96C0"
Subject: [Drbd-dev] Avoid nested sleeping on TCP connect
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

This is a multi-part message in MIME format.
--------------2C3359E4680875E79FAF96C0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Recent Linux-kernels (since 3.19) emit a warning when using nested sleeping
statements within kernel code. CONFIG_DEBUG_ATOMIC_SLEEP must be enabled to
see it.
Module drbd_transport_tcp is affected and always triggers a warning
on first connect:

[ 6187.804767] drbd: module cleanup done.
[ 6187.903039] drbd: initialized. Version: 9.0.1-1 (api:2/proto:86-111)
[ 6187.903043] drbd: GIT-hash: 86e443973082570aeb651848db89e0c7b995c306 build by abuild
[ 6187.903048] drbd: registered as block device major 147
[ 6187.913714] drbd test: Starting worker thread (from drbdsetup [17413])
[ 6187.929138] drbd test hidden0: Starting sender thread (from drbdsetup [17423])
[ 6187.933323] drbd test hidden0: conn( StandAlone -> Unconnected )
[ 6187.933488] drbd test hidden0: Starting receiver thread (from drbd_w_test [17414])
[ 6187.933739] drbd test hidden0: conn( Unconnected -> Connecting )
[ 6187.934552] ------------[ cut here ]------------
[ 6187.934573] WARNING: CPU: 33 PID: 17430 at ../kernel/sched/core.c:7963 __might_sleep+0x76/0x80()
[ 6187.934580] do not call blocking ops when !TASK_RUNNING; state=1 set at [<ffffffff810c2dce>] prepare_to_wait_event+0x5e/0xf0
[ 6187.934582] Modules linked in: drbd_transport_tcp(O) drbd(O) dm_mod libcrc32c nf_log_ipv6 xt_pkttype xt_physdev nf_log_ipv4 nf_log_common xt_LOG xt_limit af_packet 8021q garp mrp br_netfilter bridge stp llc bonding iscsi_ibft iscsi_boot_sysfs mptctl mptbase ip6t_REJECT nf_reject_ipv6 xt_tcpudp 
nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_raw ipt_REJECT nf_reject_ipv4 iptable_raw xt_CT iptable_filter ip6table_mangle nf_conntrack_netbios_ns nf_conntrack_broadcast nf_conntrack_ipv4 nf_defrag_ipv4 ip_tables xt_conntrack nf_conntrack ip6table_filter ip6_tables x_tables kvm_amd kvm ixgbe irqbypass 
crct10dif_pclmul crc32_pclmul crc32c_intel mgag200 vxlan drbg ip6_udp_tunnel ttm udp_tunnel igb ptp drm_kms_helper ansi_cprng mdio pps_core joydev cdc_acm amd64_edac_mod edac_mce_amd drm fam15h_power edac_core fb_sys_fops syscopyarea k10temp sysfillrect aesni_intel sp5100_tco aes_x86_64 dca lrw 
sysimgblt gf128mul glue_helper ablk_helper cryptd pcspkr i2c_piix4 i2c_algo_bit shpchp fjes button acpi_cpufreq processor ext4 crc16 jbd2 mbcache sd_mod hid_generic sr_mod usbhid cdrom ohci_pci ahci ehci_pci ohci_hcd libahci ehci_hcd serio_raw mpt3sas usbcore raid_class libata usb_common 
megaraid_sas scsi_transport_sas sg scsi_mod autofs4 [last unloaded: drbd]
[ 6187.934784] CPU: 33 PID: 17430 Comm: drbd_r_test Tainted: G           O     4.4.46-11-default #1
[ 6187.934821] Hardware name: Supermicro H8QG6/H8QG6, BIOS 3.5b       03/25/2016
[ 6187.934833]  0000000000000000 ffffffff81328657 ffff8847feb4bbc8 ffffffff81a60b92
[ 6187.934835]  ffffffff8107e951 ffffffff81a61cac ffff8847feb4bc18 0000000000000061
[ 6187.934845]  0000000000000000 ffff883fe1795868 ffffffff8107e9cc ffffffff81a51610
[ 6187.934855] Call Trace:
[ 6187.934877]  [<ffffffff81019ea9>] dump_trace+0x59/0x320
[ 6187.934885]  [<ffffffff8101a26a>] show_stack_log_lvl+0xfa/0x180
[ 6187.934893]  [<ffffffff8101b011>] show_stack+0x21/0x40
[ 6187.934901]  [<ffffffff81328657>] dump_stack+0x5c/0x85
[ 6187.934910]  [<ffffffff8107e951>] warn_slowpath_common+0x81/0xb0
[ 6187.934918]  [<ffffffff8107e9cc>] warn_slowpath_fmt+0x4c/0x50
[ 6187.934926]  [<ffffffff810a30b6>] __might_sleep+0x76/0x80
[ 6187.934936]  [<ffffffff8160984c>] mutex_lock+0x1c/0x38
[ 6187.934981]  [<ffffffffa05ba8f0>] dtt_wait_connect_cond+0x20/0xa0 [drbd_transport_tcp]
[ 6187.935017]  [<ffffffffa05bb3ce>] dtt_wait_for_connect.constprop.10+0x29e/0x440 [drbd_transport_tcp]
[ 6187.935033]  [<ffffffffa05bbde7>] dtt_connect+0x247/0x7b7 [drbd_transport_tcp]
[ 6187.935072]  [<ffffffffa05300e1>] drbd_receiver+0x171/0x680 [drbd]
[ 6187.935102]  [<ffffffffa053a897>] drbd_thread_setup+0x67/0x120 [drbd]
[ 6187.935115]  [<ffffffff8109d438>] kthread+0xc8/0xe0
[ 6187.935123]  [<ffffffff8160be4f>] ret_from_fork+0x3f/0x70
[ 6187.938887] DWARF2 unwinder stuck at ret_from_fork+0x3f/0x70
[ 6187.938904]
[ 6187.938907] Leftover inexact backtrace:
[ 6187.938907]
[ 6187.938915]  [<ffffffff8109d370>] ? kthread_park+0x50/0x50
[ 6187.938934] ---[ end trace 724c9d4565599062 ]---

I fixed this, the patch is attached on this mail. When it is ok, someone should apply it.

Thanks,
Andreas Osterburg


--------------2C3359E4680875E79FAF96C0
Content-Type: text/plain; charset=UTF-8;
 name="patch.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="patch.txt"

LS0tIGRyYmQvZHJiZF90cmFuc3BvcnRfdGNwLmMJMjAxNi0xMi0wNiAxNjoyMDozOS4wMDAw
MDAwMDAgKzAxMDAKKysrIGRyYmQvZHJiZF90cmFuc3BvcnRfdGNwLmMJMjAxNy0wMi0yMCAx
MToyMzo0Ni43OTQ5NzkwNjMgKzAxMDAKQEAgLTU2OCw2ICs1NjgsNyBAQAogCXN0cnVjdCBk
cmJkX3BhdGggKmRyYmRfcGF0aDI7CiAJc3RydWN0IGR0dF9saXN0ZW5lciAqbGlzdGVuZXIg
PSBjb250YWluZXJfb2YoZHJiZF9saXN0ZW5lciwgc3RydWN0IGR0dF9saXN0ZW5lciwgbGlz
dGVuZXIpOwogCXN0cnVjdCBkdHRfcGF0aCAqcGF0aCA9IE5VTEw7CisJREVGSU5FX1dBSVRf
RlVOQyh3YWl0X2Nvbm5lY3QsIHdva2VuX3dha2VfZnVuY3Rpb24pOwogCiAJcmN1X3JlYWRf
bG9jaygpOwogCW5jID0gcmN1X2RlcmVmZXJlbmNlKHRyYW5zcG9ydC0+bmV0X2NvbmYpOwpA
QCAtNTgyLDkgKzU4MywxNSBAQAogCXRpbWVvICs9IChwcmFuZG9tX3UzMigpICYgMSkgPyB0
aW1lbyAvIDcgOiAtdGltZW8gLyA3OyAvKiAyOC41JSByYW5kb20gaml0dGVyICovCiAKIHJl
dHJ5OgotCXRpbWVvID0gd2FpdF9ldmVudF9pbnRlcnJ1cHRpYmxlX3RpbWVvdXQobGlzdGVu
ZXItPndhaXQsCi0JCQkocGF0aCA9IGR0dF93YWl0X2Nvbm5lY3RfY29uZCh0cmFuc3BvcnQp
KSwKLQkJCXRpbWVvKTsKKwlhZGRfd2FpdF9xdWV1ZSgmbGlzdGVuZXItPndhaXQsICZ3YWl0
X2Nvbm5lY3QpOworCXBhdGggPSBkdHRfd2FpdF9jb25uZWN0X2NvbmQodHJhbnNwb3J0KTsK
KwlpZighcGF0aCkgeworCQl3YWl0X3dva2VuKCZ3YWl0X2Nvbm5lY3QsIFRBU0tfSU5URVJS
VVBUSUJMRSwgdGltZW8pOworCQlwYXRoID0gZHR0X3dhaXRfY29ubmVjdF9jb25kKHRyYW5z
cG9ydCk7CisJCWlmKCFwYXRoKSB0aW1lbyA9IDA7CisJfQorCXJlbW92ZV93YWl0X3F1ZXVl
KCZsaXN0ZW5lci0+d2FpdCwgJndhaXRfY29ubmVjdCk7CisKIAlpZiAodGltZW8gPD0gMCkK
IAkJcmV0dXJuIC1FQUdBSU47CiAK
--------------2C3359E4680875E79FAF96C0--
