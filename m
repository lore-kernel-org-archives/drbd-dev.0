Return-Path: <ira.weiny@intel.com>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id BF06C4201F3
	for <drbd-dev@lists.linbit.com>; Fri,  4 Mar 2022 04:07:31 +0100 (CET)
Date: Thu, 3 Mar 2022 19:06:11 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: Christoph Hellwig <hch@lst.de>
Message-ID: <YiGCIzAwEO+o9pEj@iweiny-desk3>
References: <20220303111905.321089-1-hch@lst.de>
	<20220303111905.321089-8-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220303111905.321089-8-hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Chris Zankel <chris@zankel.net>,
	Justin Sanders <justin@coraid.com>, Minchan Kim <minchan@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>, linux-xtensa@linux-xtensa.org,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Denis Efremov <efremov@linux.com>, Coly Li <colyli@suse.de>,
	linux-block@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>,
	linux-bcache@vger.kernel.org, nvdimm@lists.linux.dev,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Nitin Gupta <ngupta@vflare.org>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 07/10] bcache: use bvec_kmap_local in bio_csum
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

On Thu, Mar 03, 2022 at 02:19:02PM +0300, Christoph Hellwig wrote:
> Using local kmaps slightly reduces the chances to stray writes, and
> the bvec interface cleans up the code a little bit.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
>  drivers/md/bcache/request.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/md/bcache/request.c b/drivers/md/bcache/request.c
> index 6869e010475a3..fdd0194f84dd0 100644
> --- a/drivers/md/bcache/request.c
> +++ b/drivers/md/bcache/request.c
> @@ -44,10 +44,10 @@ static void bio_csum(struct bio *bio, struct bkey *k)
>  	uint64_t csum = 0;
>  
>  	bio_for_each_segment(bv, bio, iter) {
> -		void *d = kmap(bv.bv_page) + bv.bv_offset;
> +		void *d = bvec_kmap_local(&bv);
>  
>  		csum = crc64_be(csum, d, bv.bv_len);
> -		kunmap(bv.bv_page);
> +		kunmap_local(d);
>  	}
>  
>  	k->ptr[KEY_PTRS(k)] = csum & (~0ULL >> 1);
> -- 
> 2.30.2
> 
