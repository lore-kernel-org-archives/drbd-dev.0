Return-Path: <ira.weiny@intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 4FBDC420347
	for <drbd-dev@lists.linbit.com>; Fri,  4 Mar 2022 04:06:15 +0100 (CET)
Date: Thu, 3 Mar 2022 19:05:13 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: Christoph Hellwig <hch@lst.de>
Message-ID: <YiGB6bQGr4Yq6vpn@iweiny-desk3>
References: <20220303111905.321089-1-hch@lst.de>
	<20220303111905.321089-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220303111905.321089-7-hch@lst.de>
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
Subject: Re: [Drbd-dev] [PATCH 06/10] nvdimm-btt: use bvec_kmap_local in
	btt_rw_integrity
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

On Thu, Mar 03, 2022 at 02:19:01PM +0300, Christoph Hellwig wrote:
> Using local kmaps slightly reduces the chances to stray writes, and
> the bvec interface cleans up the code a little bit.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
>  drivers/nvdimm/btt.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/nvdimm/btt.c b/drivers/nvdimm/btt.c
> index cbd994f7f1fe6..9613e54c7a675 100644
> --- a/drivers/nvdimm/btt.c
> +++ b/drivers/nvdimm/btt.c
> @@ -1163,17 +1163,15 @@ static int btt_rw_integrity(struct btt *btt, struct bio_integrity_payload *bip,
>  		 */
>  
>  		cur_len = min(len, bv.bv_len);
> -		mem = kmap_atomic(bv.bv_page);
> +		mem = bvec_kmap_local(&bv);
>  		if (rw)
> -			ret = arena_write_bytes(arena, meta_nsoff,
> -					mem + bv.bv_offset, cur_len,
> +			ret = arena_write_bytes(arena, meta_nsoff, mem, cur_len,
>  					NVDIMM_IO_ATOMIC);
>  		else
> -			ret = arena_read_bytes(arena, meta_nsoff,
> -					mem + bv.bv_offset, cur_len,
> +			ret = arena_read_bytes(arena, meta_nsoff, mem, cur_len,
>  					NVDIMM_IO_ATOMIC);
>  
> -		kunmap_atomic(mem);
> +		kunmap_local(mem);
>  		if (ret)
>  			return ret;
>  
> -- 
> 2.30.2
> 
