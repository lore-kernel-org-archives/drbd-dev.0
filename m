Return-Path: <ira.weiny@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 3973D421790
	for <drbd-dev@lists.linbit.com>; Tue,  1 Mar 2022 01:40:47 +0100 (CET)
Date: Mon, 28 Feb 2022 16:30:35 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: Christoph Hellwig <hch@lst.de>
Message-ID: <Yh1pKyX8z6R1l7mf@iweiny-desk3>
References: <20220222155156.597597-1-hch@lst.de>
	<20220222155156.597597-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222155156.597597-2-hch@lst.de>
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
Subject: Re: [Drbd-dev] [PATCH 01/10] iss-simdisk: use bvec_kmap_local in
 simdisk_submit_bio
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

On Tue, Feb 22, 2022 at 04:51:47PM +0100, Christoph Hellwig wrote:
> Using local kmaps slightly reduces the chances to stray writes, and
> the bvec interface cleans up the code a little bit.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
>  arch/xtensa/platforms/iss/simdisk.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/xtensa/platforms/iss/simdisk.c b/arch/xtensa/platforms/iss/simdisk.c
> index 8eb6ad1a3a1de..0f0e0724397f4 100644
> --- a/arch/xtensa/platforms/iss/simdisk.c
> +++ b/arch/xtensa/platforms/iss/simdisk.c
> @@ -108,13 +108,13 @@ static void simdisk_submit_bio(struct bio *bio)
>  	sector_t sector = bio->bi_iter.bi_sector;
>  
>  	bio_for_each_segment(bvec, bio, iter) {
> -		char *buffer = kmap_atomic(bvec.bv_page) + bvec.bv_offset;
> +		char *buffer = bvec_kmap_local(&bvec);
>  		unsigned len = bvec.bv_len >> SECTOR_SHIFT;
>  
>  		simdisk_transfer(dev, sector, len, buffer,
>  				bio_data_dir(bio) == WRITE);
>  		sector += len;
> -		kunmap_atomic(buffer);
> +		kunmap_local(buffer);
>  	}
>  
>  	bio_endio(bio);
> -- 
> 2.30.2
> 
> 
