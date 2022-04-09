Return-Path: <christoph.boehmwalder@linbit.com>
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
	[209.85.221.49])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 01371420FC1
	for <drbd-dev@lists.linbit.com>; Sat,  9 Apr 2022 10:17:01 +0200 (CEST)
Received: by mail-wr1-f49.google.com with SMTP id v2so2353118wrv.6
	for <drbd-dev@lists.linbit.com>; Sat, 09 Apr 2022 01:17:01 -0700 (PDT)
Message-ID: <5a26cdb1-b63b-8d35-640b-bc0e0f78a181@linbit.com>
Date: Sat, 9 Apr 2022 10:16:58 +0200
MIME-Version: 1.0
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
References: <20220409045043.23593-1-hch@lst.de>
	<20220409045043.23593-5-hch@lst.de>
From: =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= <christoph.boehmwalder@linbit.com>
In-Reply-To: <20220409045043.23593-5-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Cc: jfs-discussion@lists.sourceforge.net, linux-nvme@lists.infradead.org,
	virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
	dm-devel@redhat.com, target-devel@vger.kernel.org,
	linux-mtd@lists.infradead.org, drbd-dev@lists.linbit.com,
	linux-s390@vger.kernel.org, linux-nilfs@vger.kernel.org,
	linux-scsi@vger.kernel.org, cluster-devel@redhat.com,
	xen-devel@lists.xenproject.org, linux-ext4@vger.kernel.org,
	linux-um@lists.infradead.org, nbd@other.debian.org,
	linux-raid@vger.kernel.org, linux-bcache@vger.kernel.org,
	ceph-devel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, linux-mmc@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, ntfs3@lists.linux.dev,
	ocfs2-devel@oss.oracle.com
Subject: Re: [Drbd-dev] [PATCH 04/27] drbd: remove assign_p_sizes_qlim
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

On 09.04.22 06:50, Christoph Hellwig wrote:
> Fold each branch into its only caller.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/block/drbd/drbd_main.c | 47 +++++++++++++++-------------------
>   1 file changed, 20 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
> index 9676a1d214bc5..1262fe1c33618 100644
> --- a/drivers/block/drbd/drbd_main.c
> +++ b/drivers/block/drbd/drbd_main.c
> @@ -903,31 +903,6 @@ void drbd_gen_and_send_sync_uuid(struct drbd_peer_device *peer_device)
>   	}
>   }
>   
> -/* communicated if (agreed_features & DRBD_FF_WSAME) */
> -static void
> -assign_p_sizes_qlim(struct drbd_device *device, struct p_sizes *p,
> -					struct request_queue *q)
> -{
> -	if (q) {
> -		p->qlim->physical_block_size = cpu_to_be32(queue_physical_block_size(q));
> -		p->qlim->logical_block_size = cpu_to_be32(queue_logical_block_size(q));
> -		p->qlim->alignment_offset = cpu_to_be32(queue_alignment_offset(q));
> -		p->qlim->io_min = cpu_to_be32(queue_io_min(q));
> -		p->qlim->io_opt = cpu_to_be32(queue_io_opt(q));
> -		p->qlim->discard_enabled = blk_queue_discard(q);
> -		p->qlim->write_same_capable = 0;
> -	} else {
> -		q = device->rq_queue;
> -		p->qlim->physical_block_size = cpu_to_be32(queue_physical_block_size(q));
> -		p->qlim->logical_block_size = cpu_to_be32(queue_logical_block_size(q));
> -		p->qlim->alignment_offset = 0;
> -		p->qlim->io_min = cpu_to_be32(queue_io_min(q));
> -		p->qlim->io_opt = cpu_to_be32(queue_io_opt(q));
> -		p->qlim->discard_enabled = 0;
> -		p->qlim->write_same_capable = 0;
> -	}
> -}
> -
>   int drbd_send_sizes(struct drbd_peer_device *peer_device, int trigger_reply, enum dds_flags flags)
>   {
>   	struct drbd_device *device = peer_device->device;
> @@ -957,14 +932,32 @@ int drbd_send_sizes(struct drbd_peer_device *peer_device, int trigger_reply, enu
>   		q_order_type = drbd_queue_order_type(device);
>   		max_bio_size = queue_max_hw_sectors(q) << 9;
>   		max_bio_size = min(max_bio_size, DRBD_MAX_BIO_SIZE);
> -		assign_p_sizes_qlim(device, p, q);
> +		p->qlim->physical_block_size =
> +			cpu_to_be32(queue_physical_block_size(q));
> +		p->qlim->logical_block_size =
> +			cpu_to_be32(queue_logical_block_size(q));
> +		p->qlim->alignment_offset =
> +			cpu_to_be32(queue_alignment_offset(q));
> +		p->qlim->io_min = cpu_to_be32(queue_io_min(q));
> +		p->qlim->io_opt = cpu_to_be32(queue_io_opt(q));
> +		p->qlim->discard_enabled = blk_queue_discard(q);
>   		put_ldev(device);
>   	} else {
> +		struct request_queue *q = device->rq_queue;
> +
> +		p->qlim->physical_block_size =
> +			cpu_to_be32(queue_physical_block_size(q));
> +		p->qlim->logical_block_size =
> +			cpu_to_be32(queue_logical_block_size(q));
> +		p->qlim->alignment_offset = 0;
> +		p->qlim->io_min = cpu_to_be32(queue_io_min(q));
> +		p->qlim->io_opt = cpu_to_be32(queue_io_opt(q));
> +		p->qlim->discard_enabled = 0;
> +
>   		d_size = 0;
>   		u_size = 0;
>   		q_order_type = QUEUE_ORDERED_NONE;
>   		max_bio_size = DRBD_MAX_BIO_SIZE; /* ... multiple BIOs per peer_request */
> -		assign_p_sizes_qlim(device, p, NULL);
>   	}
>   
>   	if (peer_device->connection->agreed_pro_version <= 94)

LGTM now, thanks.

Acked-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
