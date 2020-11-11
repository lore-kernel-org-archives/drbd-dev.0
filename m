Return-Path: <jinpu.wang@cloud.ionos.com>
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com
	[209.85.218.65])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id A0D1742080E
	for <drbd-dev@lists.linbit.com>; Wed, 11 Nov 2020 11:06:54 +0100 (CET)
Received: by mail-ej1-f65.google.com with SMTP id f20so1981209ejz.4
	for <drbd-dev@lists.linbit.com>; Wed, 11 Nov 2020 02:06:54 -0800 (PST)
MIME-Version: 1.0
References: <20201111082658.3401686-1-hch@lst.de>
	<20201111082658.3401686-18-hch@lst.de>
	<CAOi1vP-JjnNdAUqd9Gy6YdFgi8Ev4_Jt3zcB9DhAmdAvQhG7Eg@mail.gmail.com>
In-Reply-To: <CAOi1vP-JjnNdAUqd9Gy6YdFgi8Ev4_Jt3zcB9DhAmdAvQhG7Eg@mail.gmail.com>
From: Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date: Wed, 11 Nov 2020 11:06:43 +0100
Message-ID: <CAMGffEmU1ezUo68zF8DS4CRZZMosqhmDw3h7uiWzh2nL8tUs9g@mail.gmail.com>
To: Ilya Dryomov <idryomov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Cc: Justin Sanders <justin@coraid.com>, Mike Snitzer <snitzer@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>, linux-nvme@lists.infradead.org,
	Song Liu <song@kernel.org>,
	device-mapper development <dm-devel@redhat.com>,
	Christoph Hellwig <hch@lst.de>, Lars Ellenberg <drbd-dev@lists.linbit.com>,
	Linux SCSI Mailinglist <linux-scsi@vger.kernel.org>,
	xen-devel@lists.xenproject.org,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Josef Bacik <josef@toxicpanda.com>, nbd@other.debian.org,
	linux-raid <linux-raid@vger.kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
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

On Wed, Nov 11, 2020 at 10:55 AM Ilya Dryomov <idryomov@gmail.com> wrote:
>
> On Wed, Nov 11, 2020 at 9:27 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > Use set_capacity_and_notify to set the size of both the disk and block
> > device.  This also gets the uevent notifications for the resize for free.
> >
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > Acked-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> > ---
> >  drivers/block/rbd.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> > index f84128abade319..b7a194ffda55b4 100644
> > --- a/drivers/block/rbd.c
> > +++ b/drivers/block/rbd.c
> > @@ -4920,8 +4920,7 @@ static void rbd_dev_update_size(struct rbd_device *rbd_dev)
> >             !test_bit(RBD_DEV_FLAG_REMOVING, &rbd_dev->flags)) {
> >                 size = (sector_t)rbd_dev->mapping.size / SECTOR_SIZE;
> >                 dout("setting size to %llu sectors", (unsigned long long)size);
> > -               set_capacity(rbd_dev->disk, size);
> > -               revalidate_disk_size(rbd_dev->disk, true);
> > +               set_capacity_and_notify(rbd_dev->disk, size);
> >         }
> >  }
> >
> > --
> > 2.28.0
> >
>
> Hi Christoph,
>
> The Acked-by is wrong here.  I acked this patch (17/24, rbd), and Jack
> acked the next one (18/24, rnbd).
right. :)
>
> Thanks,
>
>                 Ilya
