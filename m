Return-Path: <hare@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 0E99F420964
	for <drbd-dev@lists.linbit.com>; Sun, 23 May 2021 10:10:36 +0200 (CEST)
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>, Jim Paris <jim@jtan.com>,
	Philip Kelleher <pjk1939@linux.ibm.com>, Minchan Kim <minchan@kernel.org>,
	Nitin Gupta <ngupta@vflare.org>, Matias Bjorling <mb@lightnvm.io>,
	Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
	Song Liu <song@kernel.org>, Maxim Levitsky <maximlevitsky@gmail.com>,
	Alex Dubov <oakad@yahoo.com>, Ulf Hansson <ulf.hansson@linaro.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>
References: <20210521055116.1053587-1-hch@lst.de>
	<20210521055116.1053587-14-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <de3b0976-1299-17d8-240a-2ecd8b9fbc2d@suse.de>
Date: Sun, 23 May 2021 10:10:34 +0200
MIME-Version: 1.0
In-Reply-To: <20210521055116.1053587-14-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Cc: linux-bcache@vger.kernel.org, linux-xtensa@linux-xtensa.org,
	linux-raid@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-s390@vger.kernel.org, linux-mmc@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, dm-devel@redhat.com,
	linuxppc-dev@lists.ozlabs.org, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 13/26] dm: convert to
	blk_alloc_disk/blk_cleanup_disk
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

On 5/21/21 7:51 AM, Christoph Hellwig wrote:
> Convert the dm driver to use the blk_alloc_disk and blk_cleanup_disk
> helpers to simplify gendisk and request_queue allocation.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/md/dm.c | 16 +++++++---------
>   1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index ca2aedd8ee7d..3c7c2d257018 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -1801,13 +1801,13 @@ static void cleanup_mapped_device(struct mapped_device *md)
>   		md->disk->private_data = NULL;
>   		spin_unlock(&_minor_lock);
>   		del_gendisk(md->disk);
> -		put_disk(md->disk);
>   	}
>   
> -	if (md->queue) {
> +	if (md->queue)
>   		dm_queue_destroy_keyslot_manager(md->queue);
> -		blk_cleanup_queue(md->queue);
> -	}
> +
> +	if (md->disk)
> +		blk_cleanup_disk(md->disk);
>   
>   	cleanup_srcu_struct(&md->io_barrier);
>   

Can't these conditionals be merged into a single 'if (md->disk)'?
Eg like:

	if (md->disk) {
		spin_lock(&_minor_lock);
		md->disk->private_data = NULL;
		spin_unlock(&_minor_lock);
		del_gendisk(md->disk);
		dm_queue_destroy_keyslot_manager(md->queue);
		blk_cleanup_disk(md->queue);
	}

We're now always allocating 'md->disk' and 'md->queue' together,
so how can we end up in a situation where one is set without the other?

> @@ -1869,13 +1869,10 @@ static struct mapped_device *alloc_dev(int minor)
>   	 * established. If request-based table is loaded: blk-mq will
>   	 * override accordingly.
>   	 */
> -	md->queue = blk_alloc_queue(numa_node_id);
> -	if (!md->queue)
> -		goto bad;
> -
> -	md->disk = alloc_disk_node(1, md->numa_node_id);
> +	md->disk = blk_alloc_disk(md->numa_node_id);
>   	if (!md->disk)
>   		goto bad;
> +	md->queue = md->disk->queue;
>   
>   	init_waitqueue_head(&md->wait);
>   	INIT_WORK(&md->work, dm_wq_work);
> @@ -1888,6 +1885,7 @@ static struct mapped_device *alloc_dev(int minor)
>   
>   	md->disk->major = _major;
>   	md->disk->first_minor = minor;
> +	md->disk->minors = 1;
>   	md->disk->fops = &dm_blk_dops;
>   	md->disk->queue = md->queue;
>   	md->disk->private_data = md;
> 
Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
