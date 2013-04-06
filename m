Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 7CD6110566C2
	for <drbd-dev@lists.linbit.com>; Mon,  8 Apr 2013 22:45:56 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id 74532B0E002
	for <drbd-dev@lists.linbit.com>; Mon,  8 Apr 2013 22:45:56 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1tf3OoqdV95R for <drbd-dev@lists.linbit.com>;
	Mon,  8 Apr 2013 22:45:56 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id 50A41B0E001
	for <drbd-dev@lists.linbit.com>; Mon,  8 Apr 2013 22:45:56 +0200 (CEST)
Resent-Message-ID: <20130408204556.GC13761@soda.linbit>
MIME-Version: 1.0
Date: Sat, 6 Apr 2013 12:38:30 +0800
Message-ID: <CAPgLHd_TF5QwAL3Bibr7rPdRtJoCqmQQWNtHiH0GP7a8hnK5xA@mail.gmail.com>
From: Wei Yongjun <weiyj.lk@gmail.com>
To: drbd-dev@lists.linbit.com
Content-Type: text/plain; charset=ISO-8859-1
Cc: yongjun_wei@trendmicro.com.cn, linux-kernel@vger.kernel.org,
	drbd-user@lists.linbit.com
Subject: [Drbd-dev] [PATCH -next v2] drbd: fix error return code in
	drbd_init()
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

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Fix to return a negative error code from the error handling
case instead of 0, as returned elsewhere in this function.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/block/drbd/drbd_main.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 1b93a726..93b3505 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -2763,8 +2763,6 @@ int __init drbd_init(void)
 	/*
 	 * allocate all necessary structs
 	 */
-	err = -ENOMEM;
-
 	init_waitqueue_head(&drbd_pp_wait);
 
 	drbd_proc = NULL; /* play safe for drbd_cleanup */
@@ -2774,6 +2772,7 @@ int __init drbd_init(void)
 	if (err)
 		goto fail;
 
+	err = -ENOMEM;
 	drbd_proc = proc_create_data("drbd", S_IFREG | S_IRUGO , NULL, &drbd_proc_fops, NULL);
 	if (!drbd_proc)	{
 		printk(KERN_ERR "drbd: unable to register proc file\n");
@@ -2804,7 +2803,6 @@ int __init drbd_init(void)
 fail:
 	drbd_cleanup();
 	if (err == -ENOMEM)
-		/* currently always the case */
 		printk(KERN_ERR "drbd: ran out of memory\n");
 	else
 		printk(KERN_ERR "drbd: initialization failure\n");

