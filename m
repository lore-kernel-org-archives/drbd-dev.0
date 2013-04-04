Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 2116710565B6
	for <drbd-dev@lists.linbit.com>; Thu,  4 Apr 2013 20:52:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id 17F781B435E
	for <drbd-dev@lists.linbit.com>; Thu,  4 Apr 2013 20:52:49 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IQSTtFdJ-Aig for <drbd-dev@lists.linbit.com>;
	Thu,  4 Apr 2013 20:52:48 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id E42A21B435A
	for <drbd-dev@lists.linbit.com>; Thu,  4 Apr 2013 20:52:48 +0200 (CEST)
Resent-Message-ID: <20130404185248.GI22095@soda.linbit>
MIME-Version: 1.0
Date: Thu, 4 Apr 2013 14:17:09 +0800
Message-ID: <CAPgLHd9NdpPH74owO-5=h7G2Qmhb5OJSWnuo=gPWHhnUbE6ULQ@mail.gmail.com>
From: Wei Yongjun <weiyj.lk@gmail.com>
To: drbd-dev@lists.linbit.com
Content-Type: text/plain; charset=ISO-8859-1
Cc: yongjun_wei@trendmicro.com.cn, linux-kernel@vger.kernel.org,
	drbd-user@lists.linbit.com
Subject: [Drbd-dev] [PATCH -next] drbd: fix error return code in drbd_init()
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
 drivers/block/drbd/drbd_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 1b93a726..768bca9 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -2777,6 +2777,7 @@ int __init drbd_init(void)
 	drbd_proc = proc_create_data("drbd", S_IFREG | S_IRUGO , NULL, &drbd_proc_fops, NULL);
 	if (!drbd_proc)	{
 		printk(KERN_ERR "drbd: unable to register proc file\n");
+		err = -ENOMEM;
 		goto fail;
 	}
 
@@ -2786,6 +2787,7 @@ int __init drbd_init(void)
 	retry.wq = create_singlethread_workqueue("drbd-reissue");
 	if (!retry.wq) {
 		printk(KERN_ERR "drbd: unable to create retry workqueue\n");
+		err = -ENOMEM;
 		goto fail;
 	}
 	INIT_WORK(&retry.worker, do_retry);

