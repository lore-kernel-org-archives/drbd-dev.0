Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wr0-f196.google.com (mail-wr0-f196.google.com
	[209.85.128.196])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 33EAD1011BEC
	for <drbd-dev@lists.linbit.com>; Mon, 11 Jun 2018 15:40:05 +0200 (CEST)
Received: by mail-wr0-f196.google.com with SMTP id w7-v6so20459467wrn.6
	for <drbd-dev@lists.linbit.com>; Mon, 11 Jun 2018 06:40:05 -0700 (PDT)
Received: from soda.linbit (212-186-191-219.static.upcbusiness.at.
	[212.186.191.219]) by smtp.gmail.com with ESMTPSA id
	q17-v6sm35610524wrs.5.2018.06.11.06.32.22
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 11 Jun 2018 06:32:22 -0700 (PDT)
Resent-Message-ID: <20180611133217.GB5294@soda.linbit>
Received: from email.studentenwerk.mhn.de (mailin.studentenwerk.mhn.de
	[141.84.225.229])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 75C661012864
	for <drbd-dev@lists.linbit.com>; Mon, 11 Jun 2018 13:09:35 +0200 (CEST)
Received: from mailhub.studentenwerk.mhn.de (mailhub.studentenwerk.mhn.de
	[127.0.0.1])
	by email.studentenwerk.mhn.de (Postfix) with ESMTP id 41498M42tGzMkvW
	for <drbd-dev@lists.linbit.com>; Mon, 11 Jun 2018 13:02:27 +0200 (CEST)
From: Wolfgang Walter <linux@stwm.de>
To: drbd-dev@lists.linbit.com
Date: Mon, 11 Jun 2018 13:02:26 +0200
Message-ID: <2527777.WaVWHdIFCo@stwm.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Subject: [Drbd-dev] WARNING: CPU: 5 PID: 8321 at block/blk-core.c:172
	blk_status_to_errno+0x1a/0x30
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

After switching from 4.9.102 to 4.14.48 I got the following warning:


[204738.619214] ------------[ cut here ]------------
[204738.619225] WARNING: CPU: 5 PID: 8321 at block/blk-core.c:172 blk_s=
tatus_to_errno+0x1a/0x30
[204738.619226] Modules linked in: cbc cts rpcsec_gss_krb5 8021q garp m=
rp stp llc dm_cache_smq dm_cache dm_persistent_data dm_bio_prison dm_bu=
fio binfmt_misc iTCO_wdt iTCO_vendor_support intel_rapl sb_edac x86_pkg=
_temp_thermal intel_powerclamp coretemp kvm_intel kvm irqbypass crct10d=
if_pclmul crc32_pclmul ghash_clmulni_intel intel_cstate intel_uncore sn=
d_pcm snd_timer intel_rapl_perf snd soundcore pcspkr ast ttm joydev drm=
_kms_helper drm i2c_algo_bit lpc_ich mfd_core mei_me mei ioatdma sg shp=
chp evdev wmi ipmi_si ipmi_devintf ipmi_msghandler acpi_power_meter acp=
i_pad button poly1305_x86_64 poly1305_generic sha256_ssse3 sha1_ssse3 c=
hacha20_x86_64 chacha20_generic pcbc aesni_intel aes_x86_64 crypto_simd=
 glue_helper nfsd cryptd nfs_acl lockd grace drbd auth_rpcgss lru_cache=
 sunrpc ip_tables x_tables autofs4
[204738.619289]  ext4 crc16 mbcache jbd2 fscrypto raid10 raid456 async_=
raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq libcr=
c32c crc32c_generic raid0 multipath linear dm_mod raid1 hid_generic usb=
hid hid md_mod ses enclosure sd_mod ahci libahci ixgbe mpt3sas raid_cla=
ss xhci_pci dca crc32c_intel ehci_pci libata scsi_transport_sas xhci_hc=
d ehci_hcd ptp pps_core i2c_i801 usbcore mdio scsi_mod
[204738.619322] CPU: 5 PID: 8321 Comm: kworker/5:6 Not tainted 4.14.48-=
d64.all+1.1 #1
[204738.619324] Hardware name: Supermicro X10DRi/X10DRI-T, BIOS 1.1a 10=
/16/2015
[204738.619338] Workqueue: md md_submit_flush_data [md_mod]
[204738.619339] task: ffff92eb15a1d040 task.stack: ffffa0eb8dba4000
[204738.619342] RIP: 0010:blk_status_to_errno+0x1a/0x30
[204738.619343] RSP: 0018:ffffa0eb8dba7e30 EFLAGS: 00010296
[204738.619345] RAX: 00000000000000d1 RBX: ffff92eb0f7c8000 RCX: ffffd5=
11dbc9b6df
[204738.619346] RDX: 0000000000000023 RSI: ffffffffa4a3bd25 RDI: 000000=
00000000d1
[204738.619347] RBP: ffff92d64a8a78c0 R08: ffff930aef83e0c8 R09: ffffa0=
eb8dba7dc0
[204738.619348] R10: 0000000000000034 R11: 0000000000000075 R12: ffff92=
e9f00c9b00
[204738.619349] R13: 0000000000000015 R14: ffff92d4c15a8c00 R15: ffff92=
eb10790c20
[204738.619351] FS:  0000000000000000(0000) GS:ffff92eb1fb40000(0000) k=
nlGS:0000000000000000
[204738.619352] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[204738.619353] CR2: 00007fecbec70000 CR3: 00000021ef00a006 CR4: 000000=
00001606e0
[204738.619354] Call Trace:
[204738.619366]  drbd_request_endio+0x5d/0x280 [drbd]
[204738.619376]  clone_endio+0x88/0x130 [dm_mod]
[204738.619382]  process_one_work+0x172/0x3b0
[204738.619385]  worker_thread+0x2e/0x380
[204738.619387]  ? process_one_work+0x3b0/0x3b0
[204738.619389]  kthread+0x11a/0x130
[204738.619391]  ? kthread_create_on_node+0x70/0x70
[204738.619396]  ret_from_fork+0x35/0x40
[204738.619398] Code: 74 da e9 0a ff ff ff e8 25 79 d2 ff 0f 1f 44 00 0=
0 0f 1f 44 00 00 40 80 ff 0c 40 0f b6 c7 77 0b 48 c1 e0 04 8b 80 40 db =
86 a4 c3 <0f> 0b b8 fb ff ff ff c3 0f 1f 40 00 66 2e 0f 1f 84 00 00 00 =
00=20
[204738.619429] ---[ end trace 8bb05fa93f1d6add ]---

Regards,
--=20
Wolfgang Walter
Studentenwerk M=FCnchen
Anstalt des =F6ffentlichen Rechts

