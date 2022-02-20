Return-Path: <martin.petersen@oracle.com>
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
	[205.220.165.32])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id DE2A64205EC
	for <drbd-dev@lists.linbit.com>; Sun, 20 Feb 2022 02:45:32 +0100 (CET)
To: Christoph Hellwig <hch@lst.de>
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Message-ID: <yq135kefh5j.fsf@ca-mkp.ca.oracle.com>
References: <20220209082828.2629273-1-hch@lst.de>
	<20220209082828.2629273-8-hch@lst.de>
Date: Sat, 19 Feb 2022 20:44:18 -0500
In-Reply-To: <20220209082828.2629273-8-hch@lst.de> (Christoph Hellwig's
	message of "Wed, 9 Feb 2022 09:28:28 +0100")
Content-Type: text/plain
MIME-Version: 1.0
Cc: axboe@kernel.dk, manoj@linux.ibm.com, linux-scsi@vger.kernel.org,
	martin.petersen@oracle.com, philipp.reisner@linbit.com,
	linux-block@vger.kernel.org, dm-devel@redhat.com,
	target-devel@vger.kernel.org, haris.iqbal@ionos.com,
	ukrishn@linux.ibm.com, lars.ellenberg@linbit.com,
	drbd-dev@lists.linbit.com, jinpu.wang@ionos.com, mrochs@linux.ibm.com
Subject: Re: [Drbd-dev] [PATCH 7/7] block: remove REQ_OP_WRITE_SAME support
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


Christoph,

> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index 9f32882ceb2f6..4a5bb47bee3ce 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -212,12 +212,6 @@ static ssize_t queue_discard_zeroes_data_show(struct request_queue *q, char *pag
>  	return queue_var_show(0, page);
>  }
>  
> -static ssize_t queue_write_same_max_show(struct request_queue *q, char *page)
> -{
> -	return sprintf(page, "%llu\n",
> -		(unsigned long long)q->limits.max_write_same_sectors << 9);
> -}
> -

This tripped one of my test scripts. We should probably return 0 here
like we did for discard_zeroes_data and leave the sysfs entry in place.

-- 
Martin K. Petersen	Oracle Linux Engineering
