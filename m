Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 7B9B1101AC79
	for <drbd-dev@lists.linbit.com>; Wed,  2 Jul 2014 11:39:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 6C1A33C7282
	for <drbd-dev@lists.linbit.com>; Wed,  2 Jul 2014 11:39:52 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 249TMBkp_10J for <drbd-dev@lists.linbit.com>;
	Wed,  2 Jul 2014 11:39:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 4AF313C7298
	for <drbd-dev@lists.linbit.com>; Wed,  2 Jul 2014 11:39:52 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id PL3hRcBLc1ue for <drbd-dev@lists.linbit.com>;
	Wed,  2 Jul 2014 11:39:52 +0200 (CEST)
Received: from fat-tyre.localnet (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPSA id 2EF5C3C7282
	for <drbd-dev@lists.linbit.com>; Wed,  2 Jul 2014 11:39:52 +0200 (CEST)
Message-ID: <1404232237.14624.2.camel@joe-AO725>
From: Joe Perches <joe@perches.com>
Date: Tue, 01 Jul 2014 09:30:37 -0700
In-Reply-To: <1404231410-29852-16-git-send-email-philipp.reisner@linbit.com>
References: <1404231410-29852-1-git-send-email-philipp.reisner@linbit.com>
	<1404231410-29852-16-git-send-email-philipp.reisner@linbit.com>
Content-Type: text/plain; charset="ISO-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Resent-Message-ID: <201407021139.51746.>
To: Philipp Reisner <philipp.reisner@linbit.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 15/20] drbd: cosmetic: change all
	printk(level, ...) to pr_<level>(...)
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

On Tue, 2014-07-01 at 18:16 +0200, Philipp Reisner wrote:
> From: Lars Ellenberg <lars.ellenberg@linbit.com>
> 
> Cosmetic change only.
[]
> diff --git a/drivers/block/drbd/drbd_bitmap.c b/drivers/block/drbd/drbd_bitmap.c
[]
> @@ -353,9 +353,8 @@ static void bm_free_pages(struct page **pages, unsigned long number)
>  
>  	for (i = 0; i < number; i++) {
>  		if (!pages[i]) {
> -			printk(KERN_ALERT "drbd: bm_free_pages tried to free "
> -					  "a NULL pointer; i=%lu n=%lu\n",
> -					  i, number);
> +			pr_alert("bm_free_pages tried to free a NULL pointer; i=%lu n=%lu\n",
> +				 i, number);

Cosmetic yes, but these won't be prefixed with "drbd: "
unless there's a #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
somewhere above this and before any other #include.

> diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
[]
> @@ -26,6 +26,8 @@
>  
>   */
>  
> +#define pr_fmt(fmt)	"drbd: " fmt

like this one, though I think KBUILD_MODNAME would be better.




