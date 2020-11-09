Return-Path: <sagigrim@gmail.com>
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
	[209.85.128.46])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id EAF9A420662
	for <drbd-dev@lists.linbit.com>; Tue, 10 Nov 2020 00:28:52 +0100 (CET)
Received: by mail-wm1-f46.google.com with SMTP id c9so1228840wml.5
	for <drbd-dev@lists.linbit.com>; Mon, 09 Nov 2020 15:28:52 -0800 (PST)
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
References: <20201106190337.1973127-1-hch@lst.de>
	<20201106190337.1973127-4-hch@lst.de>
	<1d06cdfa-a904-30be-f3ec-08ae2fa85cbd@suse.de>
	<20201109085340.GB27483@lst.de>
	<e79f9a96-ef53-d6ea-f6e7-e141bdd2e2d2@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <d28042e3-3123-5dfc-d0a2-aab0012150c8@grimberg.me>
Date: Mon, 9 Nov 2020 15:28:44 -0800
MIME-Version: 1.0
In-Reply-To: <e79f9a96-ef53-d6ea-f6e7-e141bdd2e2d2@suse.de>
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
	ceph-devel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Minchan Kim <minchan@kernel.org>, linux-fsdevel@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>
Subject: Re: [Drbd-dev] [PATCH 03/24] nvme: let
 set_capacity_revalidate_and_notify update the bdev size
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


> [ .. ]
>>> Originally nvme multipath would update/change the size of the multipath
>>> device according to the underlying path devices.
>>> With this patch the size of the multipath device will _not_ change if 
>>> there
>>> is a change on the underlying devices.
>>
>> Yes, it will.  Take a close look at nvme_update_disk_info and how it is
>> called.
>>
> Okay, then: What would be the correct way of handling a size update for 
> NVMe multipath?
> Assuming we're getting an AEN for each path signalling the size change
> (or a controller reset leading to a size change).
> So if we're updating the size of the multipath device together with the 
> path device at the first AEN/reset we'll end up with the other paths 
> having a different size than the multipath device (and the path we've 
> just been updating).
> - Do we care, or cross fingers and hope for the best?
> - Shouldn't we detect the case where we won't get a size update for the 
> other paths, or, indeed, we have a genuine device size mismatch due to a 
> misconfiguration on the target?
> 
> IE shouldn't we have a flag 'size update pending' for the other paths,, 
> to take them out ouf use temporarily until the other AENs/resets have 
> been processed?

the mpath device will take the minimum size from all the paths, that is
what blk_stack_limits does. When the AEN for all the paths will arrive
the mpath size will update.

Not sure how this is different than what we have today...
