Return-Path: <external.Martin.Konold@de.bosch.com>
Received: from imta21.fe.bosch.de (imta21.fe.bosch.de [139.15.243.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 7EBF710003F2
	for <drbd-dev@lists.linbit.com>; Thu,  5 Jul 2012 10:13:52 +0200 (CEST)
Received: from smtp2-v.fe.bosch.de (imta23.fe.bosch.de [139.15.243.227])
	by imta21.fe.bosch.de (Postfix) with ESMTP id 5449228075E
	for <drbd-dev@lists.linbit.com>; Thu,  5 Jul 2012 10:06:40 +0200 (CEST)
Received: from vsmta14.fe.internet.bosch.com (unknown [10.4.98.30])
	by imta23.fe.bosch.de (Postfix) with ESMTP id 86D4728C01B2
	for <drbd-dev@lists.linbit.com>; Thu,  5 Jul 2012 10:06:39 +0200 (CEST)
Received: from localhost (vsgw4.fe.internet.bosch.com [10.4.98.12])
	by vsmta14.fe.internet.bosch.com (Postfix) with SMTP id 938BD1B40316
	for <drbd-dev@lists.linbit.com>; Thu,  5 Jul 2012 10:06:39 +0200 (CEST)
From: "EXTERNAL Konold Martin (erfrakon, RtP2/TEF72)"
	<external.Martin.Konold@de.bosch.com>
To: "'drbd-dev@lists.linbit.com'" <drbd-dev@lists.linbit.com>
Date: Thu, 5 Jul 2012 10:06:27 +0200
Message-ID: <B326DCECA83A2E44BE98082EA1A715FA19CD0E4902@SI-MBX13.de.bosch.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Drbd-dev] drbdadm before-resync-source minor-0 causing kernel Oops
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hi there,

I occassionally get:

[150089.942545] d-con nfs: Handshake successful: Agreed network protocol ve=
rsion 100
[150089.942617] d-con nfs: conn( WFConnection -> WFReportParams )
[150089.942621] d-con nfs: Starting asender thread (from drbd_r_nfs [6702])
[150090.042528] block drbd0: drbd_sync_handshake:
[150090.042533] block drbd0: self 6A3E80E22EEDF071:82FD3B6A36E7FB83:82FC3B6=
A36E7FB83:82FB3B6A36E7FB83 bits:853028 flags:0
[150090.042538] block drbd0: peer 82FD3B6A36E7FB82:0000000000000000:4C4F909=
25216A812:0000000000000004 bits:850687 flags:2
[150090.042542] block drbd0: uuid_compare()=3D1 by rule 70
[150090.042545] block drbd0: Becoming sync source due to disk states.
[150090.042552] block drbd0: peer( Unknown -> Secondary ) conn( WFReportPar=
ams -> WFBitMapS )
[150090.045258] block drbd0: send bitmap stats [Bytes(packets)]: plain 0(0)=
, RLE 4814(2), total 4814; compression: 100.0%
[150090.048286] block drbd0: receive bitmap stats [Bytes(packets)]: plain 0=
(0), RLE 4814(2), total 4814; compression: 100.0%
[150090.048298] block drbd0: helper command: /sbin/drbdadm before-resync-so=
urce minor-0
[150090.048987] BUG: unable to handle kernel NULL pointer dereference at 00=
00000000000030
[150090.096560] IP: [<ffffffff81370188>] sock_ioctl+0x28/0x280
[150090.130087] PGD 5f3e0e067 PUD 5f3d0a067 PMD 0
[150090.158134] Oops: 0000 [#1] SMP
[150090.178181] CPU 0
[150090.189590] Modules linked in: md5 sctp ocfs2 jbd2 ocfs2_nodemanager qu=
ota_tree ocfs2_stack_user ocfs2_stackglue drbd nfsd lockd nfs_acl auth_rpcg=
ss crc32c libcrc32c dlm sunrpc configfs edd af_packet bridge stp llc cpufre=
q_conservative cpufreq_userspace cpufreq_powersave pcc_cpufreq mperf microc=
ode fuse loop vhost_net macvtap macvlan tun kvm_intel ipv6 kvm ipv6_lib iTC=
O_wdt i7core_edac edac_core bnx2 hpilo hpwdt iTCO_vendor_support be2net rtc=
_cmos button container pcspkr joydev acpi_power_meter ext3 jbd mbcache usbh=
id hid dm_mirror dm_region_hash dm_log linear uhci_hcd ehci_hcd usbcore usb=
_common thermal processor thermal_sys hwmon scsi_dh_emc scsi_dh_alua scsi_d=
h_hp_sw scsi_dh_rdac scsi_dh dm_snapshot dm_mod cciss scsi_mod
[150090.556157] Supported: Yes
[150090.571708]
[150090.581310] Pid: 8909, comm: drbdadm Not tainted 3.0.36-5-default #1 HP=
 ProLiant DL380 G7
[150090.630156] RIP: 0010:[<ffffffff81370188>]  [<ffffffff81370188>] sock_i=
octl+0x28/0x280
[150090.678348] RSP: 0018:ffff880bef429ee8  EFLAGS: 00010296
[150090.710376] RAX: 0000000000000000 RBX: 0000000000005401 RCX: 00007ffff4=
21ff70
[150090.753274] RDX: 00007ffff421ff70 RSI: 0000000000005401 RDI: ffff88061f=
559080
[150090.795798] RBP: 00007ffff421ff70 R08: 0000000000000000 R09: 00007fa279=
90f640
[150090.835744] R10: 00007ffff421fda0 R11: ffffffff811e0880 R12: 00007ffff4=
21ff70
[150090.876273] R13: 0000000000000000 R14: 0000000000005401 R15: 0000000000=
000000
[150090.917814] FS:  00007fa279ae0700(0000) GS:ffff88061fc00000(0000) knlGS=
:0000000000000000
[150090.963492] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[150090.996179] CR2: 0000000000000030 CR3: 00000005ec805000 CR4: 0000000000=
0006f0
[150091.037239] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000=
000000
[150091.077901] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000=
000400
[150091.120298] Process drbdadm (pid: 8909, threadinfo ffff880bef428000, ta=
sk ffff880bf19d0100)
[150091.171364] Stack:
[150091.183805]  0000000000000202 ffff8805f744dc80 00007ffff421ff70 00007ff=
ff421ff70
[150091.228475]  0000000000000000 ffffffff81160d6b 0000000000000006 0000000=
000000000
[150091.272904]  0000000000000000 ffff8805f744dc80 00007ffff421ff70 fffffff=
f81161131
[150091.317328] Call Trace:
[150091.332374]  [<ffffffff81160d6b>] do_vfs_ioctl+0x8b/0x3b0
[150091.363177]  [<ffffffff81161131>] sys_ioctl+0xa1/0xb0
[150091.391291]  [<ffffffff81449392>] system_call_fastpath+0x16/0x1b
[150091.424149]  [<00007fa27965c677>] 0x7fa27965c676
[150091.449033] Code: 00 00 00 48 83 ec 28 48 89 5c 24 08 48 89 6c 24 10 89=
 f3 4c 89 64 24 18 4c 89 6c 24 20 48 89 d5 48 8b bf a0 00 00 00 48 8b 47 20=
 <4c> 8b 60 30 8d 83 10 76 ff ff 83 f8 0f 0f 86 a5 00 00 00 8d 83
[150091.556971] RIP  [<ffffffff81370188>] sock_ioctl+0x28/0x280
[150091.588963]  RSP <ffff880bef429ee8>
[150091.609405] CR2: 0000000000000030
[150091.694250] ---[ end trace 3ac876cdc4b5faad ]---
[150091.722583] block drbd0: helper command: /sbin/drbdadm before-resync-so=
urce minor-0 exit code 0 (0x9)
[150091.777094] block drbd0: conn( WFBitMapS -> SyncSource )
[150091.777102] block drbd0: Began resync as SyncSource (will sync 3412112 =
KB [853028 bits set]).
[150091.777196] block drbd0: updated sync UUID 6A3E80E22EEDF071:82FE3B6A36E=
7FB83:82FD3B6A36E7FB83:82FC3B6A36E7FB83
[150106.644931] dlm: connecting to 33859776 sctp association 2
[150127.367459] block drbd0: Resync done (total 35 sec; paused 0 sec; 97488=
 K/sec)
[150127.411525] block drbd0: updated UUIDs 6A3E80E22EEDF071:000000000000000=
0:82FE3B6A36E7FB83:82FD3B6A36E7FB83
[150127.470500] block drbd0: conn( SyncSource -> Connected ) pdsk( Inconsis=
tent -> UpToDate )
[150127.470927] block drbd0: bitmap WRITE of 0 pages took 0 jiffies
[150127.470934] block drbd0: 0 KB (0 bits) marked out-of-sync by on disk bi=
t-map.

Is this report of some use to you?

Best regards

Martin Konold

Robert Bosch GmbH
Automotive Electronics
Postfach 13 42
72703 Reutlingen
GERMANY
www.bosch.com

Tel. +49 7121 35 3322

Sitz: Stuttgart, Registergericht: Amtsgericht Stuttgart, HRB 14000;
Aufsichtsratsvorsitzender: Franz Fehrenbach; Gesch=E4ftsf=FChrung: Volkmar =
Denner, Siegfried Dais;
Stefan Asenkerschbaumer, Bernd Bohr, Rudolf Colm, Dirk Hoheisel, Christoph =
K=FCbel, Uwe Raschke,
Wolf-Henning Scheider, Werner Struth, Peter Tyroller

