Return-Path: <ira.weiny@intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id A5CF2421790
	for <drbd-dev@lists.linbit.com>; Tue,  1 Mar 2022 01:39:57 +0100 (CET)
Date: Mon, 28 Feb 2022 16:31:46 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: Christoph Hellwig <hch@lst.de>
Message-ID: <Yh1pclDpq6iImDAu@iweiny-desk3>
References: <20220222155156.597597-1-hch@lst.de>
	<20220222155156.597597-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222155156.597597-3-hch@lst.de>
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
Subject: Re: [Drbd-dev] [PATCH 02/10] aoe: use bvec_kmap_local in bvcpy
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

On Tue, Feb 22, 2022 at 04:51:48PM +0100, Christoph Hellwig wrote:
> Using local kmaps slightly reduces the chances to stray writes, and
> the bvec interface cleans up the code a little bit.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/block/aoe/aoecmd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/aoe/aoecmd.c b/drivers/block/aoe/aoecmd.c
> index cc11f89a0928f..093996961d452 100644
> --- a/drivers/block/aoe/aoecmd.c
> +++ b/drivers/block/aoe/aoecmd.c
> @@ -1018,7 +1018,7 @@ bvcpy(struct sk_buff *skb, struct bio *bio, struct bvec_iter iter, long cnt)
>  	iter.bi_size = cnt;
>  
>  	__bio_for_each_segment(bv, bio, iter, iter) {
> -		char *p = kmap_atomic(bv.bv_page) + bv.bv_offset;
> +		char *p = bvec_kmap_local(&bv);
>  		skb_copy_bits(skb, soff, p, bv.bv_len);
>  		kunmap_atomic(p);

kunmap_local()

Ira

>  		soff += bv.bv_len;
> -- 
> 2.30.2
> 
> 
