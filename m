Return-Path: <axboe@suse.de>
Date: Tue, 15 Mar 2005 21:24:39 +0100
From: Jens Axboe <axboe@suse.de>
To: Philipp Reisner <philipp.reisner@linbit.com>
Message-ID: <20050315202439.GH4237@suse.de>
References: <200503152115.58219.philipp.reisner@linbit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503152115.58219.philipp.reisner@linbit.com>
Cc: drbd-dev@linbit.com
Subject: [Drbd-dev] Re: bio_split()...
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Tue, Mar 15 2005, Philipp Reisner wrote:
> Hi Jens,
> 
> bio_split only works for bios with a single page...
> 
> [ from bio.c: ]
> /*
>  * split a bio - only worry about a bio with a single page
>  * in it's iovec
>  */
> struct bio_pair *bio_split(struct bio *bi, mempool_t *pool, int first_sectors)
> {
>  struct bio_pair *bp = mempool_alloc(pool, GFP_NOIO);
> 
>  if (!bp)
>   return bp;
> 
>  BUG_ON(bi->bi_vcnt != 1);
> [...]
> 
> In DRBD-0.8 I want to split BIO's that cross a 16 MB boundary. 
> In DRBD-0.8 I accept BIOs with more than one page (currently up to
> 32 kB in a single BIO), I thought that bio_split is here
> to handle such situations....
> 
> Is there an other way to go ?
> Would you accept a patch that would make bio_split to work with bigger
> BIOs ?

The trick is usually to avoid such build-up in the first place - does
the merge_bvec_fn() not work for you there? bio_split() is just there to
cater to cases of a single page nature, because you cannot refuse to add
a single page.

-- 
Jens Axboe

