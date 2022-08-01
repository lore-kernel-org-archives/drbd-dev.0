Return-Path: <christoph.boehmwalder@linbit.com>
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com
	[209.85.218.41])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id AEF004203DF
	for <drbd-dev@lists.linbit.com>; Mon,  1 Aug 2022 17:40:54 +0200 (CEST)
Received: by mail-ej1-f41.google.com with SMTP id k26so5363196ejx.5
	for <drbd-dev@lists.linbit.com>; Mon, 01 Aug 2022 08:40:54 -0700 (PDT)
Message-ID: <4d88538d-c401-ebaf-8f63-8e8b7ad9e632@linbit.com>
Date: Mon, 1 Aug 2022 17:40:52 +0200
MIME-Version: 1.0
Content-Language: en-US
To: John Sanpe <sanpeqf@gmail.com>
References: <20220723075931.163245-1-sanpeqf@gmail.com>
From: =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= <christoph.boehmwalder@linbit.com>
In-Reply-To: <20220723075931.163245-1-sanpeqf@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: lars.ellenberg@linbit.com, philipp.reisner@linbit.com,
	linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] lib/lru_cache: Fixed array overflow caused
 by incorrect boundary handling.
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <https://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <https://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am 23.07.22 um 09:59 schrieb John Sanpe:
> This problem occurs when malloc element failed on the first time.
> At this time, the counter i is 0. When it's released, we subtract 1
> in advance without checking, which will cause i to become UINT_MAX,
> resulting in array overflow.
> 
> Signed-off-by: John Sanpe <sanpeqf@gmail.com>
> ---
>  lib/lru_cache.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/lru_cache.c b/lib/lru_cache.c
> index 52313acbfa62..04d95de92602 100644
> --- a/lib/lru_cache.c
> +++ b/lib/lru_cache.c
> @@ -147,7 +147,7 @@ struct lru_cache *lc_create(const char *name, struct kmem_cache *cache,
>  		return lc;
>  
>  	/* else: could not allocate all elements, give up */
> -	for (i--; i; i--) {
> +	while (i--) {
>  		void *p = element[i];
>  		kmem_cache_free(cache, p - e_off);
>  	}

Thanks for the fix, looks good to me.

Reviewed-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>

-- 
Christoph Böhmwalder
LINBIT | Keeping the Digital World Running
DRBD HA —  Disaster Recovery — Software defined Storage
