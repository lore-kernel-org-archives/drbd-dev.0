Return-Path: <idryomov@gmail.com>
Received: from mail-il1-f194.google.com (mail-il1-f194.google.com
	[209.85.166.194])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id A2EC6420662
	for <drbd-dev@lists.linbit.com>; Mon,  9 Nov 2020 14:52:08 +0100 (CET)
Received: by mail-il1-f194.google.com with SMTP id z2so8305506ilh.11
	for <drbd-dev@lists.linbit.com>; Mon, 09 Nov 2020 05:52:08 -0800 (PST)
MIME-Version: 1.0
References: <20201106190337.1973127-1-hch@lst.de>
	<20201106190337.1973127-18-hch@lst.de>
In-Reply-To: <20201106190337.1973127-18-hch@lst.de>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Mon, 9 Nov 2020 14:52:08 +0100
Message-ID: <CAOi1vP83cOt_FOFLXQmgBpDgmaq8o8OQcUYWOb97jzkgOw6r4A@mail.gmail.com>
To: Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Cc: Justin Sanders <justin@coraid.com>, Mike Snitzer <snitzer@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>, linux-nvme@lists.infradead.org,
	Song Liu <song@kernel.org>, dm-devel@redhat.com,
	Lars Ellenberg <drbd-dev@lists.linbit.com>,
	linux-scsi@vger.kernel.org, xen-devel@lists.xenproject.org,
	Jack Wang <jinpu.wang@cloud.ionos.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Josef Bacik <josef@toxicpanda.com>, nbd@other.debian.org,
	linux-raid@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
	Ceph Development <ceph-devel@vger.kernel.org>,
	Jens Axboe <axboe@kernel.dk>, linux-block <linux-block@vger.kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Minchan Kim <minchan@kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>
Subject: Re: [Drbd-dev] [PATCH 17/24] rbd: use set_capacity_and_notify
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

On Fri, Nov 6, 2020 at 8:04 PM Christoph Hellwig <hch@lst.de> wrote:
>
> Use set_capacity_and_notify to set the size of both the disk and block
> device.  This also gets the uevent notifications for the resize for free.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/block/rbd.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index f84128abade319..b7a194ffda55b4 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -4920,8 +4920,7 @@ static void rbd_dev_update_size(struct rbd_device *rbd_dev)
>             !test_bit(RBD_DEV_FLAG_REMOVING, &rbd_dev->flags)) {
>                 size = (sector_t)rbd_dev->mapping.size / SECTOR_SIZE;
>                 dout("setting size to %llu sectors", (unsigned long long)size);
> -               set_capacity(rbd_dev->disk, size);
> -               revalidate_disk_size(rbd_dev->disk, true);
> +               set_capacity_and_notify(rbd_dev->disk, size);
>         }
>  }
>
> --
> 2.28.0
>

Acked-by: Ilya Dryomov <idryomov@gmail.com>

Thanks,

                Ilya
