Return-Path: <hare@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 6D1B94207AF
	for <drbd-dev@lists.linbit.com>; Fri, 20 Nov 2020 08:37:17 +0100 (CET)
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
References: <20201116145809.410558-1-hch@lst.de>
	<20201116145809.410558-61-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <317d324a-f4a2-7fc4-3546-0048c38c55da@suse.de>
Date: Fri, 20 Nov 2020 08:37:15 +0100
MIME-Version: 1.0
In-Reply-To: <20201116145809.410558-61-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Cc: Justin Sanders <justin@coraid.com>, Mike Snitzer <snitzer@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>, linux-nvme@lists.infradead.org,
	Song Liu <song@kernel.org>, dm-devel@redhat.com,
	drbd-dev@lists.linbit.com, linux-scsi@vger.kernel.org,
	xen-devel@lists.xenproject.org, Ilya Dryomov <idryomov@gmail.com>,
	Jack Wang <jinpu.wang@cloud.ionos.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Josef Bacik <josef@toxicpanda.com>, nbd@other.debian.org,
	linux-raid@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
	ceph-devel@vger.kernel.org, linux-block@vger.kernel.org,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Minchan Kim <minchan@kernel.org>, linux-fsdevel@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>
Subject: Re: [Drbd-dev] [PATCH 60/78] zram: remove the claim mechanism
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

On 11/16/20 3:57 PM, Christoph Hellwig wrote:
> The zram claim mechanism was added to ensure no new opens come in
> during teardown.  But the proper way to archive that is to call
> del_gendisk first, which takes care of all that.  Once del_gendisk
> is called in the right place, the reset side can also be simplified
> as no I/O can be outstanding on a block device that is not open.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/block/zram/zram_drv.c | 76 ++++++++++-------------------------
>   1 file changed, 21 insertions(+), 55 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
