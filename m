Return-Path: <sukumar@mvista.com>
Received: from mail-pg0-f46.google.com (mail-pg0-f46.google.com [74.125.83.46])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id E1D1A105630C
	for <drbd-dev@lists.linbit.com>; Thu, 23 Feb 2017 10:43:48 +0100 (CET)
Received: by mail-pg0-f46.google.com with SMTP id s67so13283939pgb.3
	for <drbd-dev@lists.linbit.com>; Thu, 23 Feb 2017 01:43:48 -0800 (PST)
Received: from [10.162.103.4] ([111.93.218.67])
	by smtp.gmail.com with ESMTPSA id
	j192sm8391480pfc.60.2017.02.23.01.15.25
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 23 Feb 2017 01:15:26 -0800 (PST)
To: drbd-dev@lists.linbit.com
From: Sunil Kumar <sukumar@mvista.com>
Message-ID: <1438f378-046d-e763-cbb4-c653b13a0bb9@mvista.com>
Date: Thu, 23 Feb 2017 14:45:24 +0530
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------75AC56DD7462BED046FA2842"
Subject: [Drbd-dev] NULL dereference in drbd_submit_peer_request
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
--------------75AC56DD7462BED046FA2842
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Everyone,

This is regarding the ASSERT in put_ldev discussed in drbd-user list

http://lists.linbit.com/pipermail/drbd-user/2017-February/023593.html

The assert got triggered during the drbd attach operation. Here's syslog 
snippet of BUG.

===============================================================================
Jan 18 12:20:38 HOSTA_101 kernel: : [161228.600846] BUG: unable to
handle kernel NULL pointer dereference at (null)
Jan 18 12:20:38 HOSTA_101 kernel: : [161228.601807] IP:
[<ffffffffa010f07d>] drbd_submit_peer_request+0x8d/0x4c0 [drbd]
Jan 18 12:20:38 HOSTA_101 kernel: : [161228.610078] PGD 765c6067 PUD
7645d067 PMD 0
Jan 18 12:20:38 HOSTA_101 kernel: : [161228.610078] Oops: 0000 [#1]
PREEMPT SMP
Jan 18 12:20:38 HOSTA_101 kernel: : [161228.610078] last sysfs file:
/sys/devices/virtual/block/drbd7/removable
Jan 18 12:20:38 HOSTA_101 kernel: : [161228.644817] CPU 4
Jan 18 12:20:38 HOSTA_101 kernel: : [161228.660713] Modules linked in:
e1000 igb mlx4_core mlx4_en virtio_net virtio_balloon ipmi_msghandler
ipmi_watchdog kplugdr libcrc32c crc32c drbd scsi_transport_iscsi
libiscsi libiscsi_tcp iscsi_tcp [last unloaded: ipmi_msghandler]
Jan 18 12:20:38 HOSTA_101 kernel: : [161228.692781] Pid: 25503, comm:
drbd_r_r4 Tainted: G        W  2.6.32.59.cge 60-A64-N1.07 KVM
Jan 18 12:20:38 HOSTA_101 kernel: : [161228.710234] RIP:
0010:[<ffffffffa010f07d>]  [<ffffffffa010f07d>]
drbd_submit_peer_request+0x8d/0x4c0 [drbd]
Jan 18 12:20:38 HOSTA_101 kernel: : [161228.714138] RSP:
0018:ffff88004fc09d90  EFLAGS: 00010286
Jan 18 12:20:38 HOSTA_101 kernel: : [161228.725343] RAX:
0000000000000000 RBX: ffff88004fc09e60 RCX: ffff8800376bf8c0
Jan 18 12:20:38 HOSTA_101 kernel: : [161228.725343] RDX:
ffff88007b863800 RSI: 0000000000011200 RDI: 0000000000000246
Jan 18 12:20:38 HOSTA_101 kernel: : [161228.738464] RBP:
ffff88004fc09df0 R08: 0000000000000000 R09: 0000000000000000
Jan 18 12:20:38 HOSTA_101 kernel: : [161228.738464] R10:
0000000000000000 R11: 0000000000000000 R12: ffffea0001a1b550
Jan 18 12:20:38 HOSTA_101 kernel: : [161228.757103] R13:
0000000000064000 R14: 0000000000043400 R15: 0000000000000064
Jan 18 12:20:38 HOSTA_101 kernel: : [161228.777606] FS:
0000000000000000(0000) GS:ffff880001d00000(0000) knlGS:0000000000000000
Jan 18 12:20:38 HOSTA_101 kernel: : [161228.783633] CS:  0010 DS: 0018
ES: 0018 CR0: 000000008005003b
Jan 18 12:20:38 HOSTA_101 kernel: : [161228.796394] CR2:
0000000000000000 CR3: 000000004f345000 CR4: 00000000000406e0
Jan 18 12:20:38 HOSTA_101 kernel: : [161228.804852] DR0:
0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
Jan 18 12:20:38 HOSTA_101 kernel: : [161228.809335] DR3:
0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Jan 18 12:20:38 HOSTA_101 kernel: : [161228.809335] Process drbd_r_r4
(pid: 25503, threadinfo ffff88004fc08000, task ffff88007b6bb2a0)
Jan 18 12:20:38 HOSTA_101 kernel: : [161228.838090] Stack:
Jan 18 12:20:38 HOSTA_101 kernel: : [161228.838090] 0000000000000000
0000000000000001 0000000000000002 ffff88007b863800
Jan 18 12:20:38 HOSTA_101 kernel: : [161228.838090] <0> ffff88004ed31810
ffff8800376bf8c0 ffff88004fc09df0 ffff88004fc09e60
Jan 18 12:20:38 HOSTA_101 kernel: : [161228.838090] <0> ffff88007b863800
ffff88004ed31810 ffff88007b863800 0000000000043400
Jan 18 12:20:38 HOSTA_101 kernel: : [161228.852971] Call Trace:
Jan 18 12:20:38 HOSTA_101 kernel: : [161228.856040] [<ffffffffa01126ab>]
receive_RSDataReply+0x13b/0x490 [drbd]
Jan 18 12:20:38 HOSTA_101 kernel: : [161228.856040] [<ffffffffa0110880>]
drbd_receiver+0x100/0x2e0 [drbd]
Jan 18 12:20:38 HOSTA_101 kernel: : [161228.856040] [<ffffffffa0124740>]
? drbd_thread_setup+0x0/0x110 [drbd]
Jan 18 12:20:38 HOSTA_101 kernel: : [161228.856040] [<ffffffffa012476d>]
drbd_thread_setup+0x2d/0x110 [drbd]
Jan 18 12:20:38 HOSTA_101 kernel: : [161228.856040] [<ffffffffa0124740>]
? drbd_thread_setup+0x0/0x110 [drbd]
Jan 18 12:20:38 HOSTA_101 kernel: : [161228.871833] [<ffffffff811251b6>]
kthread+0x96/0xa0
Jan 18 12:20:38 HOSTA_101 kernel: : [161228.871833] [<ffffffff81125120>]
? kthread+0x0/0xa0
Jan 18 12:20:38 HOSTA_101 kernel: : [161228.871833] [<ffffffff810b445a>]
child_rip+0xa/0x20
Jan 18 12:20:38 HOSTA_101 kernel: : [161228.880486] [<ffffffff81125120>]
? kthread+0x0/0xa0
Jan 18 12:20:38 HOSTA_101 kernel: : [161228.880486] [<ffffffff81125120>]
? kthread+0x0/0xa0
Jan 18 12:20:38 HOSTA_101 kernel: : [161228.885895] [<ffffffff810b4450>]
? child_rip+0x0/0x20
Jan 18 12:20:38 HOSTA_101 kernel: : [161228.887926] Code: 00 00 00 e8 76
45 0f e1 48 85 c0 48 89 45 c8 4c 8b 4d a0 0f 84 f6 03 00 00 48 8b 4d c8
4c 89 31 48 8b 55 b8 48 8b 82 80 00 00 00 <48> 8b 00 48 89 41 10 48 8b
45 a8 48 89 41 20 48 8b 55 c0 48 c7
Jan 18 12:20:38 HOSTA_101 kernel: : [161228.894609] RIP
[<ffffffffa010f07d>] drbd_submit_peer_request+0x8d/0x4c0 [drbd]
Jan 18 12:20:38 HOSTA_101 kernel: : [161228.894609]  RSP <ffff88004fc09d90>
Jan 18 12:20:38 HOSTA_101 kernel: : [161228.894609] CR2: 0000000000000000
Jan 18 12:20:38 HOSTA_101 kernel: : [161228.924389] ---[ end trace
===============================================================================

Above issue takes approx 3-5 hours for ASSERT (in put_ldev) with the 
attached test script.
I have added debug prints in get_ldev() & put_ldev() (while exiting) to 
keep track of the 'local_cnt'and added a kernel panic when the 
'local_cnt' reference goes negative, the issue is reproducing during 
attach operation. Observed that the extra reference of the 'local_ldev' 
is decremented by the drbd_md_endio() routine.
===============================================================================
[ 8819.467228] block drbd6: disk( Failed -> Diskless )
[ 8819.467738] block drbd6: EXIT: put_ldev is called from 
after_state_ch, count=0 ds=0 thread=drbd_w_r4[2336]
[ 8825.141885] block drbd6: role( Secondary -> Primary )
[ 8826.838617] EXT3 FS on drbd6, internal journal
[ 8828.132369] block drbd6: role( Primary -> Secondary )
/* drbd_md_endio entry */
[ 8835.585126] block drbd6: drbd_md_endio: meta-data in used by 
drbd_md_read
[ 8835.587660] block drbd6: disk( Diskless -> Attaching )
[ 8835.587675] block drbd6: EXIT: put_ldev is called from 
__get_ldev_if_state, count=0 ds=1 thread=drbdsetup-84[11848]
[ 8835.587701] block drbd6: EXIT: get_ldev is called from 
drbd_adm_attach, count=1 ds=1 wds=1 thread=drbdsetup-84[11848]
[ 8835.587880] block drbd6: EXIT: put_ldev is called from 
__get_ldev_if_state, count=1 ds=1 thread=drbdsetup-84[11848]
[ 8835.587884] block drbd6: This kernel is too old, no WRITE_SAME support.
[ 8835.587890] block drbd6: EXIT: get_ldev is called from bm_rw, count=2 
ds=1 wds=1 thread=drbdsetup-84[11848]

/* drbd_md_endio exit, problem here */
[ 8835.587969] block drbd6: EXIT: put_ldev is called from drbd_md_endio, 
count=1 ds=1 thread=swapper[0]
[ 8835.590273] block drbd6: recounting of set bits took additional 0 jiffies
[ 8835.590276] block drbd6: 47 MB (12070 bits) marked out-of-sync by on 
disk bit-map.
[ 8835.590279] block drbd6: EXIT: put_ldev is called from 
drbd_bm_aio_ctx_destroy, count=0 ds=1 thread=drbdsetup-84[11848]
[ 8835.590284] block drbd6: EXIT: put_ldev is called from 
__get_ldev_if_state, count=0 ds=1 thread=drbdsetup-84[11848]
[ 8835.590286] block drbd6: EXIT: put_ldev is called from 
__get_ldev_if_state, count=0 ds=1 thread=drbdsetup-84[11848]
[ 8835.590289] block drbd6: disk( Attaching -> Negotiating )
[ 8835.590296] block drbd6: EXIT: get_ldev is called from 
drbd_print_uuids, count=1 ds=3 wds=3 thread=drbdsetup-84[11848]
[ 8835.590298] block drbd6: attached to UUIDs 
0000000000000004:0000000000000000:0000000000000000:0000000000000000
[ 8835.590300] block drbd6: EXIT: put_ldev is called from 
drbd_print_uuids, count=0 ds=3 thread=drbdsetup-84[11848]
[ 8835.590302] block drbd6: EXIT: put_ldev is called from 
__get_ldev_if_state, count=0 ds=3 thread=drbdsetup-84[11848]
[ 8835.590306] block drbd6: EXIT: get_ldev is called from drbd_md_sync, 
count=1 ds=3 wds=2 thread=drbdsetup-84[11848]
[ 8835.590310] block drbd6: EXIT: get_ldev is called from 
_drbd_md_sync_page_io, count=2 ds=3 wds=1 thread=drbdsetup-84[11848]
[ 8835.607888] block drbd6: drbd_md_endio: meta-data in used by drbd_md_sync
[ 8835.607912] block drbd6: EXIT: put_ldev is called from drbd_md_endio, 
count=1 ds=3 thread=swapper[0]
[ 8835.607927] block drbd6: EXIT: put_ldev is called from drbd_md_sync, 
count=0 ds=3 thread=drbdsetup-84[11848]
[ 8835.608016] block drbd6: ASSERT( i >= 0 ) in 
drivers/block/drbd/drbd_int.h:2287
[ 8835.608030] Kernel panic - not syncing: drbd_assert_breakpoint
[ 8835.608036] Pid: 11848, comm: drbdsetup-84 Not tainted 2.6.32.59+ #62
[ 8835.608038] Call Trace:
[ 8835.608127]  [<ffffffff8160bc03>] panic+0xfc/0x1c2
[ 8835.609436]  [<ffffffffa01baf04>] drbd_assert_breakpoint+0xa4/0xb0 [drbd]
[ 8835.609449]  [<ffffffffa01e4398>] __put_ldev+0x198/0x1c0 [drbd]
[ 8835.609458]  [<ffffffffa01f1d4d>] drbd_adm_attach+0xf1d/0x10f0 [drbd]
[ 8835.609476]  [<ffffffff812f451f>] ? nla_parse+0xef/0x110
[ 8835.609489]  [<ffffffff8151a186>] genl_rcv_msg+0x1e6/0x220
[ 8835.609495]  [<ffffffff81519fa0>] ? genl_rcv_msg+0x0/0x220
[ 8835.609498]  [<ffffffff81516fd9>] netlink_rcv_skb+0xa9/0xd0
[ 8835.609502]  [<ffffffff815189bc>] genl_rcv+0x2c/0x40
[ 8835.609506]  [<ffffffff81516d23>] netlink_unicast+0x2b3/0x2c0
[ 8835.609510]  [<ffffffff81517e09>] netlink_sendmsg+0x269/0x380
[ 8835.609520]  [<ffffffff81196b5a>] ? __blkdev_get+0x1da/0x410
[ 8835.609529]  [<ffffffff814e0644>] sock_aio_write+0x124/0x1a0
[ 8835.609536]  [<ffffffff812db6e7>] ? kobject_put+0x27/0x60
[ 8835.609549]  [<ffffffff81165d7a>] do_sync_write+0xfa/0x140
[ 8835.609563]  [<ffffffff810b5ce0>] ? autoremove_wake_function+0x0/0x40
[ 8835.609567]  [<ffffffff81167caf>] ? __fput+0x19f/0x210
[ 8835.609572]  [<ffffffff81166124>] vfs_write+0x184/0x1a0
[ 8835.609575]  [<ffffffff81167525>] ? fget_light+0x15/0xc0
[ 8835.609578]  [<ffffffff811669fc>] sys_write+0x5c/0xf0
[ 8835.609592]  [<ffffffff81073a70>] sysenter_dispatch+0x7/0x2e
===============================================================================

The drbd_md_endio() routine release the ldev reference even called from 
drbd_md_read(). Which should not happen as ldev reference is not taken 
in drbd_md_read() routine. The drbd_md_endio() calls 
drbd_md_put_buffer() which release the mdio usage count (i.e. 
mdio.in_use) and enables the drbd_adm_attach() to proceed further.
===============================================================================
BIO_ENDIO_TYPE drbd_md_endio BIO_ENDIO_ARGS(struct bio *bio, int error)
{
         ...
         drbd_md_put_buffer(device);
         device->md_io.done = 1;
         wake_up(&device->misc_wait);
         bio_put(bio);

         if (device->ldev) /* special case: drbd_md_read() during 
drbd_adm_attach() */
                 put_ldev(device);

         BIO_ENDIO_FN_RETURN;
}
===============================================================================

So when drbd_md_endio() calls the put_ldev(), it has valid 
'device->ldev' reference and it decrement the 'local_cnt' by calling the 
put_ldev(). Which brings the inconsistancy in the 'local_cnt'. And 
latter when put_ldev() called from drbd_adm_attach() triggers the ASSERT.
To make sure the put_ldev() is not getting called when called from the 
drbd_md_read(), I have added the below check
-------------------------------------------------------------------------------
Proposed changes/patch
-------------------------------------------------------------------------------
diff --git a/drivers/block/drbd/drbd_worker.c
b/drivers/block/drbd/drbd_worker.c
index fc9d266e9b40..0292bf16f4df 100644
--- a/drivers/block/drbd/drbd_worker.c
+++ b/drivers/block/drbd/drbd_worker.c
@@ -82,8 +82,12 @@ BIO_ENDIO_TYPE drbd_md_endio BIO_ENDIO_ARGS(struct 
bio *bio,
int error)
         device->md_io.done = 1;
         wake_up(&device->misc_wait);
         bio_put(bio);
-       if (device->ldev) /* special case: drbd_md_read() during 
drbd_adm_attach() */
+       /* special case: don't call put_ldev when endio initiated
+          from drbd_md_read() during drbd_adm_attach() */
+       if (device->ldev && 
strcmp(device->md_io.current_use,"drbd_md_read")) {
+               drbd_info(device, "%s: meta-data is used by 
%s\n",__func__,device->md_io.current_use);
                 put_ldev(device);
+       }

         BIO_ENDIO_FN_RETURN;
  }
-------------------------------------------------------------------------------

With the above changes the ASSERT is not getting triggered.

Regards
Sunil Kumar


--------------75AC56DD7462BED046FA2842
Content-Type: application/x-shellscript;
 name="test_drbd.sh"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="test_drbd.sh"

IyEvYmluL2Jhc2ggCiMgRHJiZCB0ZXN0IHNjcmlwdCAKCkRJUkU9JDAKRElSRT0ke0RJUkUl
Lyp9Ci4gIiR7RElSRX0iIi9DT05GSUciCgpMTF9ERVY9YGRyYmRhZG0gc2gtbGwtZGV2ICRS
RVNPVVJDRWAKCmZ1bmN0aW9uIG1vdW50X2RyYmRfYW5kX3N5bmMoKSB7CiAgICBudW09YGV4
cHIgJFJBTkRPTSAlIDEwYAogICAgc2xlZXAgJG51bQogICAgI2RyYmRhZG0gLS0gLS1vdmVy
d3JpdGUtZGF0YS1vZi1wZWVyIHByaW1hcnkgYWxsIAogICAgZHJiZGFkbSBwcmltYXJ5IGFs
bCAKICAgIG51bT1gZXhwciAkUkFORE9NICUgMTBgCiAgICBzbGVlcCAkbnVtCgoKICAgIE5F
V19EQVRBPWBkYXRlYAogICAgZm9yIFJFU08gaW4gJFJFU09VUkNFIDsKICAgIGRvCiAgICAg
ICAgREVWPWBkcmJkYWRtIHNoLWRldiAkUkVTT2AKICAgICAgICBta2RpciAtcCAgL21udC9k
cmJkX3Rlc3QvJFJFU08KICAgICAgICBtb3VudCAkREVWICAvbW50L2RyYmRfdGVzdC8kUkVT
TwogICAgICAgIGBlY2hvICRORVdfREFUQSA+IC9tbnQvZHJiZF90ZXN0LyRSRVNPL2RhdGFg
CiAgICAgICAgdW1vdW50ICAvbW50L2RyYmRfdGVzdC8kUkVTTwogICAgZG9uZQogICAgc2xl
ZXAgMSA7CgogICAgZHJiZGFkbSBzZWNvbmRhcnkgYWxsIAogICAgbnVtPWBleHByICRSQU5E
T00gJSAxMGAKICAgIHNsZWVwICRudW0KfQoKCndoaWxlIDoKZG8gCiAgICBkcmJkYWRtIGRl
dGFjaCAkUkVTT1VSQ0UgIAogICAgbnVtPWBleHByICRSQU5ET00gJSAxMGAKICAgIHNsZWVw
ICRudW0KICAgCiAgICBmb3IgTERFViBpbiAkTExfREVWIDsKICAgIGRvCiAgICAgICAgZGQg
aWY9L2Rldi9udWxsIG9mPSRMREVWICA+IC9kZXYvbnVsbCAyPiYxIDsKICAgIGRvbmUKICAg
IG51bT1gZXhwciAkUkFORE9NICUgMTBgCiAgICBzbGVlcCAkbnVtCgogICAgeWVzIHllcyB8
IGRyYmRhZG0gIGNyZWF0ZS1tZCAkUkVTT1VSQ0UgID4gL2Rldi9udWxsIDI+JjEKICAgIG51
bT1gZXhwciAkUkFORE9NICUgMTBgCiAgICBzbGVlcCAkbnVtCgogICAgZHJiZGFkbSBhdHRh
Y2ggJFJFU09VUkNFICAKICAgIG51bT1gZXhwciAkUkFORE9NICUgMTBgCiAgICBzbGVlcCAk
bnVtCgogICBtb3VudF9kcmJkX2FuZF9zeW5jICYKZG9uZQoKCgo=
--------------75AC56DD7462BED046FA2842--
