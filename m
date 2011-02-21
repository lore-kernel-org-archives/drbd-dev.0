Return-Path: <lars.ellenberg@linbit.com>
Date: Mon, 21 Feb 2011 09:44:19 +0100
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: Ilia Mirkin <imirkin@alum.mit.edu>
Message-ID: <20110221084419.GC20194@barkeeper1-xen.linbit>
References: <1298241914-1400-1-git-send-email-imirkin@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1298241914-1400-1-git-send-email-imirkin@alum.mit.edu>
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

On Sun, Feb 20, 2011 at 05:45:14PM -0500, Ilia Mirkin wrote:
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
> Signed-off-by: Ilia Mirkin <imirkin@alum.mit.edu>

  Acked-by: Lars Ellenberg <lars@linbit.com>

> 
> ---
>  lib/lru_cache.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> Note that in lc_reset, there is the line
> 
> memset(lc->lc_slot, 0, sizeof(struct hlist_head) * lc->nr_elements);
> 
> So this seems correct. But otherwise untested.
> 
> diff --git a/lib/lru_cache.c b/lib/lru_cache.c
> index 270de9d..b312c8f 100644
> --- a/lib/lru_cache.c
> +++ b/lib/lru_cache.c
> @@ -84,7 +84,7 @@ struct lru_cache *lc_create(const char *name, struct kmem_cache *cache,
>  	if (e_count > LC_MAX_ACTIVE)
>  		return NULL;
>  
> -	slot = kzalloc(e_count * sizeof(struct hlist_head*), GFP_KERNEL);
> +	slot = kzalloc(e_count * sizeof(struct hlist_head), GFP_KERNEL);

Luckily sizeof(struct hlist_head*) == sizeof(struct hlist_head),
so this went unnoticed, as it did not have any effect.

Thanks for having this spotted by semantic matching.

	Lars

>  	if (!slot)
>  		goto out_fail;
>  	element = kzalloc(e_count * sizeof(struct lc_element *), GFP_KERNEL);
> -- 
> 1.7.3.4
