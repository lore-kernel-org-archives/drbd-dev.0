Return-Path: <ira.weiny@intel.com>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id A5E644217A9
	for <drbd-dev@lists.linbit.com>; Tue,  1 Mar 2022 05:11:17 +0100 (CET)
Date: Mon, 28 Feb 2022 20:11:15 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: Christoph Hellwig <hch@lst.de>
Message-ID: <Yh2c41kEWmmGgWLG@iweiny-desk3>
References: <20220222155156.597597-1-hch@lst.de>
	<20220222155156.597597-11-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222155156.597597-11-hch@lst.de>
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
Subject: Re: [Drbd-dev] [PATCH 10/10] floppy: use memcpy_{to,from}_bvec
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

On Tue, Feb 22, 2022 at 04:51:56PM +0100, Christoph Hellwig wrote:
> Use the helpers instead of open coding them.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
>  drivers/block/floppy.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
> index 19c2d0327e157..8c647532e3ce9 100644
> --- a/drivers/block/floppy.c
> +++ b/drivers/block/floppy.c
> @@ -2485,11 +2485,9 @@ static void copy_buffer(int ssize, int max_sector, int max_sector_2)
>  		}
>  
>  		if (CT(raw_cmd->cmd[COMMAND]) == FD_READ)
> -			memcpy_to_page(bv.bv_page, bv.bv_offset, dma_buffer,
> -				       size);
> +			memcpy_to_bvec(&bv, dma_buffer);
>  		else
> -			memcpy_from_page(dma_buffer, bv.bv_page, bv.bv_offset,
> -					 size);
> +			memcpy_from_bvec(dma_buffer, &bv);
>  
>  		remaining -= size;
>  		dma_buffer += size;
> -- 
> 2.30.2
> 
> 
