Return-Path: <ira.weiny@intel.com>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id D18604217A1
	for <drbd-dev@lists.linbit.com>; Tue,  1 Mar 2022 04:54:26 +0100 (CET)
Date: Mon, 28 Feb 2022 19:54:23 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: Christoph Hellwig <hch@lst.de>
Message-ID: <Yh2Y76PZxSHF1stE@iweiny-desk3>
References: <20220222155156.597597-1-hch@lst.de>
	<20220222155156.597597-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222155156.597597-6-hch@lst.de>
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
Subject: Re: [Drbd-dev] [PATCH 05/10] nvdimm-blk: use bvec_kmap_local in
 nd_blk_rw_integrity
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

On Tue, Feb 22, 2022 at 04:51:51PM +0100, Christoph Hellwig wrote:
> Using local kmaps slightly reduces the chances to stray writes, and
> the bvec interface cleans up the code a little bit.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
>  drivers/nvdimm/blk.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvdimm/blk.c b/drivers/nvdimm/blk.c
> index c1db43524d755..0a38738335941 100644
> --- a/drivers/nvdimm/blk.c
> +++ b/drivers/nvdimm/blk.c
> @@ -88,10 +88,9 @@ static int nd_blk_rw_integrity(struct nd_namespace_blk *nsblk,
>  		 */
>  
>  		cur_len = min(len, bv.bv_len);
> -		iobuf = kmap_atomic(bv.bv_page);
> -		err = ndbr->do_io(ndbr, dev_offset, iobuf + bv.bv_offset,
> -				cur_len, rw);
> -		kunmap_atomic(iobuf);
> +		iobuf = bvec_kmap_local(&bv);
> +		err = ndbr->do_io(ndbr, dev_offset, iobuf, cur_len, rw);
> +		kunmap_local(iobuf);
>  		if (err)
>  			return err;
>  
> -- 
> 2.30.2
> 
> 
