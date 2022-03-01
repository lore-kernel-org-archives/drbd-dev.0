Return-Path: <ira.weiny@intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id C26514217A9
	for <drbd-dev@lists.linbit.com>; Tue,  1 Mar 2022 05:10:00 +0100 (CET)
Date: Mon, 28 Feb 2022 20:09:58 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: Christoph Hellwig <hch@lst.de>
Message-ID: <Yh2clo6ATYC/e8Jm@iweiny-desk3>
References: <20220222155156.597597-1-hch@lst.de>
	<20220222155156.597597-10-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222155156.597597-10-hch@lst.de>
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
Subject: Re: [Drbd-dev] [PATCH 09/10] drbd: use bvec_kmap_local in
	recv_dless_read
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

On Tue, Feb 22, 2022 at 04:51:55PM +0100, Christoph Hellwig wrote:
> Using local kmaps slightly reduces the chances to stray writes, and
> the bvec interface cleans up the code a little bit.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
>  drivers/block/drbd/drbd_receiver.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
> index 04e3ec12d8b49..fa00cf2ea9529 100644
> --- a/drivers/block/drbd/drbd_receiver.c
> +++ b/drivers/block/drbd/drbd_receiver.c
> @@ -2017,10 +2017,10 @@ static int recv_dless_read(struct drbd_peer_device *peer_device, struct drbd_req
>  	D_ASSERT(peer_device->device, sector == bio->bi_iter.bi_sector);
>  
>  	bio_for_each_segment(bvec, bio, iter) {
> -		void *mapped = kmap(bvec.bv_page) + bvec.bv_offset;
> +		void *mapped = bvec_kmap_local(&bvec);
>  		expect = min_t(int, data_size, bvec.bv_len);
>  		err = drbd_recv_all_warn(peer_device->connection, mapped, expect);
> -		kunmap(bvec.bv_page);
> +		kunmap_local(mapped);
>  		if (err)
>  			return err;
>  		data_size -= expect;
> -- 
> 2.30.2
> 
> 
