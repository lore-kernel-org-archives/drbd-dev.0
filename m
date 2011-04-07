Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 51F731056A8A
	for <drbd-dev@lists.linbit.com>; Thu,  7 Apr 2011 23:19:46 +0200 (CEST)
Date: Thu, 7 Apr 2011 14:19:42 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Ilia Mirkin <imirkin@alum.mit.edu>
Message-Id: <20110407141942.9d303e8c.akpm@linux-foundation.org>
In-Reply-To: <1298241914-1400-1-git-send-email-imirkin@alum.mit.edu>
References: <1298241914-1400-1-git-send-email-imirkin@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] lru_cache: Use correct type in sizeof for
	allocation
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Sun, 20 Feb 2011 17:45:14 -0500
Ilia Mirkin <imirkin@alum.mit.edu> wrote:

> This has no actual effect, since sizeof(struct hlist_head) ==
> sizeof(struct hlist_head *), but it's still the wrong type to use.
> 
> The semantic match that finds this problem:
> // <smpl>
> @@
> type T;
> identifier x;
> @@
> T *x;
> ...
> * x = kzalloc(... * sizeof(T*) * ..., ...);
> // </smpl>
> 
> ...
>
> --- a/lib/lru_cache.c
> +++ b/lib/lru_cache.c
> @@ -84,7 +84,7 @@ struct lru_cache *lc_create(const char *name, struct kmem_cache *cache,
>  	if (e_count > LC_MAX_ACTIVE)
>  		return NULL;
>  
> -	slot = kzalloc(e_count * sizeof(struct hlist_head*), GFP_KERNEL);
> +	slot = kzalloc(e_count * sizeof(struct hlist_head), GFP_KERNEL);
>  	if (!slot)
>  		goto out_fail;
>  	element = kzalloc(e_count * sizeof(struct lc_element *), GFP_KERNEL);

This is one of the reasons why I think it's better to use

	foo = kmalloc(sizeof(*foo));

Then, you just *know* it's correct by looking at the code and you don't
need to scroll up and double-check the type of foo.

The code as you have it is still vulnerable to multiplicative overflow.
So, to be really really correct,


--- a/lib/lru_cache.c~lru_cache-use-correct-type-in-sizeof-for-allocation-fix
+++ a/lib/lru_cache.c
@@ -84,7 +84,7 @@ struct lru_cache *lc_create(const char *
 	if (e_count > LC_MAX_ACTIVE)
 		return NULL;
 
-	slot = kzalloc(e_count * sizeof(struct hlist_head), GFP_KERNEL);
+	slot = kcalloc(e_count, sizeof(struct hlist_head), GFP_KERNEL);
 	if (!slot)
 		goto out_fail;
 	element = kzalloc(e_count * sizeof(struct lc_element *), GFP_KERNEL);
_

