Return-Path: <lars.ellenberg@linbit.com>
Date: Thu, 17 Sep 2015 15:47:25 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com, drbd-user@lists.linbit.com
Message-ID: <20150917134725.GF7519@soda.linbit>
References: <1442146532-9100-1-git-send-email-Julia.Lawall@lip6.fr>
	<1442146532-9100-22-git-send-email-Julia.Lawall@lip6.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1442146532-9100-22-git-send-email-Julia.Lawall@lip6.fr>
Subject: Re: [Drbd-dev] [PATCH 21/39] drbd: drop null test before destroy
 functions
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

On Sun, Sep 13, 2015 at 02:15:14PM +0200, Julia Lawall wrote:
> Remove unneeded NULL test.
> 
> The semantic patch that makes this change is as follows:
> (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> @@ expression x; @@
> -if (x != NULL)
>   \(kmem_cache_destroy\|mempool_destroy\|dma_pool_destroy\)(x);
> // </smpl>

Thanks.

Just a note for our external module repo, which is supposed to be
compatible to "all" kernel versions: don't apply,
requires upstream commits
44d7175 mm/dmapool: allow NULL `pool' pointer in dma_pool_destroy()
4e3ca3e mm/mempool: allow NULL `pool' pointer in mempool_destroy()
3942d29 mm/slab_common: allow NULL cache pointer in kmem_cache_destroy()
(v4.3-rc1)


	Lars Ellenberg

