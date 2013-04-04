Return-Path: <lars.ellenberg@linbit.com>
Date: Thu, 4 Apr 2013 20:58:15 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: Wei Yongjun <weiyj.lk@gmail.com>
Message-ID: <20130404185815.GJ22095@soda.linbit>
References: <CAPgLHd9NdpPH74owO-5=h7G2Qmhb5OJSWnuo=gPWHhnUbE6ULQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPgLHd9NdpPH74owO-5=h7G2Qmhb5OJSWnuo=gPWHhnUbE6ULQ@mail.gmail.com>
Cc: yongjun_wei@trendmicro.com.cn, linux-kernel@vger.kernel.org,
	drbd-user@lists.linbit.com, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH -next] drbd: fix error return code in
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

On Thu, Apr 04, 2013 at 02:17:09PM +0800, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> Fix to return a negative error code from the error handling
> case instead of 0, as returned elsewhere in this function.

We used to have an err = -ENOMEM; "just in case"...

How about this instead:

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index e98da67..dfe52d6 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -2739,8 +2739,6 @@ int __init drbd_init(void)
 	/*
 	 * allocate all necessary structs
 	 */
-	err = -ENOMEM;
-
 	init_waitqueue_head(&drbd_pp_wait);
 
 	drbd_proc = NULL; /* play safe for drbd_cleanup */
@@ -2750,6 +2748,7 @@ int __init drbd_init(void)
 	if (err)
 		goto fail;
 
+	err = -ENOMEM;
 	drbd_proc = proc_create_data("drbd", S_IFREG | S_IRUGO , NULL, &drbd_proc_fops, NULL);
 	if (!drbd_proc)	{
 		printk(KERN_ERR "drbd: unable to register proc file\n");
@@ -2780,7 +2779,6 @@ int __init drbd_init(void)
 fail:
 	drbd_cleanup();
 	if (err == -ENOMEM)
-		/* currently always the case */
 		printk(KERN_ERR "drbd: ran out of memory\n");
 	else
 		printk(KERN_ERR "drbd: initialization failure\n");
