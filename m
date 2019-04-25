Return-Path: <penguin-kernel@i-love.sakura.ne.jp>
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id BAEE91011BF6
	for <drbd-dev@lists.linbit.com>; Thu, 25 Apr 2019 11:29:21 +0200 (CEST)
Received: from fsav102.sakura.ne.jp (fsav102.sakura.ne.jp [27.133.134.229])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x3P9TJrc051535
	for <drbd-dev@lists.linbit.com>; Thu, 25 Apr 2019 18:29:19 +0900 (JST)
	(envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126012062002.bbtec.net [126.12.62.2])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x3P9TFaP051517
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO)
	for <drbd-dev@lists.linbit.com>; Thu, 25 Apr 2019 18:29:19 +0900 (JST)
	(envelope-from penguin-kernel@i-love.sakura.ne.jp)
To: drbd-dev@lists.linbit.com
From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <00660ec7-ef62-e376-2e2c-71e42f2f649b@i-love.sakura.ne.jp>
Date: Thu, 25 Apr 2019 18:29:11 +0900
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Drbd-dev] [PATCH] drbd: Avoid GFP_KERNEL allocation from
	alloc_send_buffer()
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

A customer's system using 3.10.0-862.3.3.el7.x86_64 + drbd-9.0.14 has
experienced hung up for two times. The khungtaskd messages contained a
backtrace indicating that the drbd_sender kernel thread was stuck at
GFP_KERNEL memory allocation from alloc_send_buffer().

  INFO: task drbd_s_r0:1541 blocked for more than 120 seconds.
  "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
  drbd_s_r0       D ffff924123fccf10     0  1541      2 0x00000000
  Call Trace:
  [<ffffffff9c62959e>] ? __switch_to+0xce/0x580
  [<ffffffff9cd13f79>] schedule+0x29/0x70
  [<ffffffff9cd118e9>] schedule_timeout+0x239/0x2c0
  [<ffffffff9c91cc04>] ? blk_finish_plug+0x14/0x40
  [<ffffffff9cd1432d>] wait_for_completion+0xfd/0x140
  [<ffffffff9c6cf1b0>] ? wake_up_state+0x20/0x20
  [<ffffffffc033d3a4>] ? xfs_bwrite+0x24/0x60 [xfs]
  [<ffffffffc033cfa9>] xfs_buf_submit_wait+0xf9/0x1d0 [xfs]
  [<ffffffffc033d3a4>] xfs_bwrite+0x24/0x60 [xfs]
  [<ffffffffc03451f1>] xfs_reclaim_inode+0x331/0x360 [xfs]
  [<ffffffffc0345487>] xfs_reclaim_inodes_ag+0x267/0x390 [xfs]
  [<ffffffffc03464c3>] xfs_reclaim_inodes_nr+0x33/0x40 [xfs]
  [<ffffffffc0356665>] xfs_fs_free_cached_objects+0x15/0x20 [xfs]
  [<ffffffff9c81dbbe>] prune_super+0xee/0x180
  [<ffffffff9c7a7645>] shrink_slab+0x175/0x340
  [<ffffffff9c8115d1>] ? vmpressure+0x21/0x90
  [<ffffffff9c7aa7c2>] do_try_to_free_pages+0x3c2/0x4e0
  [<ffffffff9c7aa9dc>] try_to_free_pages+0xfc/0x180
  [<ffffffff9c79eb06>] __alloc_pages_nodemask+0x806/0xbb0
  [<ffffffff9c7e8868>] alloc_pages_current+0x98/0x110
  [<ffffffffc058dd5c>] alloc_send_buffer+0x8c/0x110 [drbd]
  [<ffffffffc0591152>] __conn_prepare_command+0x62/0x80 [drbd]
  [<ffffffffc05911b1>] conn_prepare_command+0x41/0x80 [drbd]
  [<ffffffffc0592e97>] drbd_send_dblock+0xd7/0x480 [drbd]
  [<ffffffff9c66814e>] ? kvm_clock_get_cycles+0x1e/0x20
  [<ffffffffc0566e8d>] process_one_request+0x16d/0x320 [drbd]
  [<ffffffffc056c822>] drbd_sender+0x3c2/0x420 [drbd]
  [<ffffffffc058f320>] ? _get_ldev_if_state.part.30+0x110/0x110 [drbd]
  [<ffffffffc058f3a7>] drbd_thread_setup+0x87/0x1c0 [drbd]
  [<ffffffffc058f320>] ? _get_ldev_if_state.part.30+0x110/0x110 [drbd]
  [<ffffffff9c6bb161>] kthread+0xd1/0xe0
  [<ffffffff9c6bb090>] ? insert_kthread_work+0x40/0x40
  [<ffffffff9cd20677>] ret_from_fork_nospec_begin+0x21/0x21
  [<ffffffff9c6bb090>] ? insert_kthread_work+0x40/0x40

Since drbd needs to replicate synchronously with filesystem locks held,
the drbd_sender kernel thread can't involve __GFP_FS reclaim. Also,
since quickly completing replication will help reducing latency, and
avoiding unexpected delay for e.g. ping by the drbd_ack_receiver kernel
thread is better, let's use GFP_ATOMIC here rather than GFP_NOIO.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 drbd/drbd_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drbd/drbd_main.c b/drbd/drbd_main.c
index 80afdd8a..d48a5ea3 100644
--- a/drbd/drbd_main.c
+++ b/drbd/drbd_main.c
@@ -966,7 +966,7 @@ static void new_or_recycle_send_buffer_page(struct drbd_send_buffer *sbuf)
 		if (count == 1)
 			goto have_page;
 
-		page = alloc_page(GFP_KERNEL);
+		page = alloc_page(GFP_ATOMIC);
 		if (page) {
 			put_page(sbuf->page);
 			sbuf->page = page;
-- 
2.16.5
