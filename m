Return-Path: <hare@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 4707F420BB0
	for <drbd-dev@lists.linbit.com>; Sun, 23 May 2021 10:20:29 +0200 (CEST)
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
	<20210521055116.1053587-19-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <1a771bf9-5083-c440-f0e1-5f6920b5b017@suse.de>
Date: Sun, 23 May 2021 10:20:27 +0200
MIME-Version: 1.0
In-Reply-To: <20210521055116.1053587-19-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Cc: linux-bcache@vger.kernel.org, linux-xtensa@linux-xtensa.org,
	linux-raid@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-s390@vger.kernel.org, linux-mmc@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, dm-devel@redhat.com,
	linuxppc-dev@lists.ozlabs.org, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 18/26] nvme-multipath: convert to
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
> Convert the nvme-multipath driver to use the blk_alloc_disk and
> blk_cleanup_disk helpers to simplify gendisk and request_queue
> allocation.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/nvdimm/pmem.c         |  1 -
>   drivers/nvme/host/multipath.c | 45 ++++++++++-------------------------
>   2 files changed, 13 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
> index 9fcd05084564..31f3c4bd6f72 100644
> --- a/drivers/nvdimm/pmem.c
> +++ b/drivers/nvdimm/pmem.c
> @@ -472,7 +472,6 @@ static int pmem_attach_disk(struct device *dev,
>   		blk_queue_flag_set(QUEUE_FLAG_DAX, q);
>   
>   	disk->fops		= &pmem_fops;
> -	disk->queue		= q;
>   	disk->private_data	= pmem;
>   	nvdimm_namespace_disk_name(ndns, disk->disk_name);
>   	set_capacity(disk, (pmem->size - pmem->pfn_pad - pmem->data_offset)
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index a5d02f236cca..b5fbdb416022 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -427,7 +427,6 @@ static void nvme_requeue_work(struct work_struct *work)
>   
>   int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
>   {
> -	struct request_queue *q;
>   	bool vwc = false;
>   
>   	mutex_init(&head->lock);
> @@ -443,33 +442,24 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
>   	if (!(ctrl->subsys->cmic & NVME_CTRL_CMIC_MULTI_CTRL) || !multipath)
>   		return 0;
>   
> -	q = blk_alloc_queue(ctrl->numa_node);
> -	if (!q)
> -		goto out;
> -	blk_queue_flag_set(QUEUE_FLAG_NONROT, q);
> -	/* set to a default value for 512 until disk is validated */
> -	blk_queue_logical_block_size(q, 512);
> -	blk_set_stacking_limits(&q->limits);
> -
> -	/* we need to propagate up the VMC settings */
> -	if (ctrl->vwc & NVME_CTRL_VWC_PRESENT)
> -		vwc = true;
> -	blk_queue_write_cache(q, vwc, vwc);
> -
> -	head->disk = alloc_disk(0);
> +	head->disk = blk_alloc_disk(ctrl->numa_node);
>   	if (!head->disk)
> -		goto out_cleanup_queue;
> +		return -ENOMEM;
>   	head->disk->fops = &nvme_ns_head_ops;
>   	head->disk->private_data = head;
> -	head->disk->queue = q;
>   	sprintf(head->disk->disk_name, "nvme%dn%d",
>   			ctrl->subsys->instance, head->instance);
> -	return 0;
>   
> -out_cleanup_queue:
> -	blk_cleanup_queue(q);
> -out:
> -	return -ENOMEM;
> +	blk_queue_flag_set(QUEUE_FLAG_NONROT, head->disk->queue);
> +	/* set to a default value of 512 until the disk is validated */
> +	blk_queue_logical_block_size(head->disk->queue, 512);
> +	blk_set_stacking_limits(&head->disk->queue->limits);
> +
> +	/* we need to propagate up the VMC settings */
> +	if (ctrl->vwc & NVME_CTRL_VWC_PRESENT)
> +		vwc = true;
> +	blk_queue_write_cache(head->disk->queue, vwc, vwc);
> +	return 0;
>   }
>   
>   static void nvme_mpath_set_live(struct nvme_ns *ns)
> @@ -768,16 +758,7 @@ void nvme_mpath_remove_disk(struct nvme_ns_head *head)
>   	/* make sure all pending bios are cleaned up */
>   	kblockd_schedule_work(&head->requeue_work);
>   	flush_work(&head->requeue_work);
> -	blk_cleanup_queue(head->disk->queue);
> -	if (!test_bit(NVME_NSHEAD_DISK_LIVE, &head->flags)) {
> -		/*
> -		 * if device_add_disk wasn't called, prevent
> -		 * disk release to put a bogus reference on the
> -		 * request queue
> -		 */
> -		head->disk->queue = NULL;
> -	}
> -	put_disk(head->disk);
> +	blk_cleanup_disk(head->disk);
>   }
>   
>   void nvme_mpath_init_ctrl(struct nvme_ctrl *ctrl)
> 
What about the check for GENHD_FL_UP a bit further up in line 766?
Can this still happen with the new allocation scheme, ie is there still 
a difference in lifetime between ->disk and ->disk->queue?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
