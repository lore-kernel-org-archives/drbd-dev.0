Return-Path: <jinpu.wang@ionos.com>
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com
	[209.85.218.49])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id E8F5C4205EC
	for <drbd-dev@lists.linbit.com>; Wed,  9 Feb 2022 10:13:18 +0100 (CET)
Received: by mail-ej1-f49.google.com with SMTP id m4so5308661ejb.9
	for <drbd-dev@lists.linbit.com>; Wed, 09 Feb 2022 01:13:18 -0800 (PST)
MIME-Version: 1.0
References: <20220209082828.2629273-1-hch@lst.de>
	<20220209082828.2629273-4-hch@lst.de>
	<4f1565b2-0f83-0cfa-58bd-86d5dee48e51@linux.dev>
In-Reply-To: <4f1565b2-0f83-0cfa-58bd-86d5dee48e51@linux.dev>
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Wed, 9 Feb 2022 10:13:07 +0100
Message-ID: <CAMGffE=FmVj26PJtu5fwtr3rNbtE+-dcfxOrmT4hEt3sO7Kw2A@mail.gmail.com>
To: Guoqing Jiang <guoqing.jiang@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Cc: axboe@kernel.dk, manoj@linux.ibm.com, linux-scsi@vger.kernel.org,
	martin.petersen@oracle.com, philipp.reisner@linbit.com,
	linux-block@vger.kernel.org, dm-devel@redhat.com,
	target-devel@vger.kernel.org, haris.iqbal@ionos.com,
	ukrishn@linux.ibm.com, lars.ellenberg@linbit.com,
	drbd-dev@lists.linbit.com, Christoph Hellwig <hch@lst.de>,
	mrochs@linux.ibm.com
Subject: Re: [Drbd-dev] [PATCH 3/7] rnbd: drop WRITE_SAME support
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

On Wed, Feb 9, 2022 at 10:05 AM Guoqing Jiang <guoqing.jiang@linux.dev> wro=
te:
>
>
>
> On 2/9/22 4:28 PM, Christoph Hellwig wrote:
> > REQ_OP_WRITE_SAME was only ever submitted by the legacy Linux zeroing
> > code, which has switched to use REQ_OP_WRITE_ZEROES long before rnbd wa=
s
> > even merged.
> >
> > Signed-off-by: Christoph Hellwig<hch@lst.de>
> > ---
> >   drivers/block/rnbd/rnbd-clt.c   | 7 ++-----
> >   drivers/block/rnbd/rnbd-clt.h   | 1 -
> >   drivers/block/rnbd/rnbd-proto.h | 6 ------
> >   drivers/block/rnbd/rnbd-srv.c   | 3 +--
> >   4 files changed, 3 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-cl=
t.c
> > index c08971de369fc..dc192d2738854 100644
> > --- a/drivers/block/rnbd/rnbd-clt.c
> > +++ b/drivers/block/rnbd/rnbd-clt.c
> > @@ -82,7 +82,6 @@ static int rnbd_clt_set_dev_attr(struct rnbd_clt_dev =
*dev,
> >       dev->nsectors               =3D le64_to_cpu(rsp->nsectors);
> >       dev->logical_block_size     =3D le16_to_cpu(rsp->logical_block_si=
ze);
> >       dev->physical_block_size    =3D le16_to_cpu(rsp->physical_block_s=
ize);
> > -     dev->max_write_same_sectors =3D le32_to_cpu(rsp->max_write_same_s=
ectors);
> >       dev->max_discard_sectors    =3D le32_to_cpu(rsp->max_discard_sect=
ors);
> >       dev->discard_granularity    =3D le32_to_cpu(rsp->discard_granular=
ity);
> >       dev->discard_alignment      =3D le32_to_cpu(rsp->discard_alignmen=
t);
> > @@ -1359,8 +1358,6 @@ static void setup_request_queue(struct rnbd_clt_d=
ev *dev)
> >       blk_queue_logical_block_size(dev->queue, dev->logical_block_size)=
;
> >       blk_queue_physical_block_size(dev->queue, dev->physical_block_siz=
e);
> >       blk_queue_max_hw_sectors(dev->queue, dev->max_hw_sectors);
> > -     blk_queue_max_write_same_sectors(dev->queue,
> > -                                      dev->max_write_same_sectors);
> >
> >       /*
> >        * we don't support discards to "discontiguous" segments
> > @@ -1610,10 +1607,10 @@ struct rnbd_clt_dev *rnbd_clt_map_device(const =
char *sessname,
> >       }
> >
> >       rnbd_clt_info(dev,
> > -                    "map_device: Device mapped as %s (nsectors: %zu, l=
ogical_block_size: %d, physical_block_size: %d, max_write_same_sectors: %d,=
 max_discard_sectors: %d, discard_granularity: %d, discard_alignment: %d, s=
ecure_discard: %d, max_segments: %d, max_hw_sectors: %d, rotational: %d, wc=
: %d, fua: %d)\n",
> > +                    "map_device: Device mapped as %s (nsectors: %zu, l=
ogical_block_size: %d, physical_block_size: %d, max_discard_sectors: %d, di=
scard_granularity: %d, discard_alignment: %d, secure_discard: %d, max_segme=
nts: %d, max_hw_sectors: %d, rotational: %d, wc: %d, fua: %d)\n",
> >                      dev->gd->disk_name, dev->nsectors,
> >                      dev->logical_block_size, dev->physical_block_size,
> > -                    dev->max_write_same_sectors, dev->max_discard_sect=
ors,
> > +                    dev->max_discard_sectors,
> >                      dev->discard_granularity, dev->discard_alignment,
> >                      dev->secure_discard, dev->max_segments,
> >                      dev->max_hw_sectors, dev->rotational, dev->wc, dev=
->fua);
> > diff --git a/drivers/block/rnbd/rnbd-clt.h b/drivers/block/rnbd/rnbd-cl=
t.h
> > index 0c2cae7f39b9f..6946ba23d62e5 100644
> > --- a/drivers/block/rnbd/rnbd-clt.h
> > +++ b/drivers/block/rnbd/rnbd-clt.h
> > @@ -122,7 +122,6 @@ struct rnbd_clt_dev {
> >       bool                    wc;
> >       bool                    fua;
> >       u32                     max_hw_sectors;
> > -     u32                     max_write_same_sectors;
> >       u32                     max_discard_sectors;
> >       u32                     discard_granularity;
> >       u32                     discard_alignment;
>
> I am planning to remove more members inside struct rnbd_clt_dev.
>
> > diff --git a/drivers/block/rnbd/rnbd-proto.h b/drivers/block/rnbd/rnbd-=
proto.h
> > index de5d5a8df81d7..3eb8b34bd1886 100644
> > --- a/drivers/block/rnbd/rnbd-proto.h
> > +++ b/drivers/block/rnbd/rnbd-proto.h
> > @@ -249,9 +249,6 @@ static inline u32 rnbd_to_bio_flags(u32 rnbd_opf)
> >       case RNBD_OP_SECURE_ERASE:
> >               bio_opf =3D REQ_OP_SECURE_ERASE;
> >               break;
> > -     case RNBD_OP_WRITE_SAME:
> > -             bio_opf =3D REQ_OP_WRITE_SAME;
> > -             break;
> >       default:
> >               WARN(1, "Unknown RNBD type: %d (flags %d)\n",
> >                    rnbd_op(rnbd_opf), rnbd_opf);
> > @@ -284,9 +281,6 @@ static inline u32 rq_to_rnbd_flags(struct request *=
rq)
> >       case REQ_OP_SECURE_ERASE:
> >               rnbd_opf =3D RNBD_OP_SECURE_ERASE;
> >               break;
> > -     case REQ_OP_WRITE_SAME:
> > -             rnbd_opf =3D RNBD_OP_WRITE_SAME;
> > -             break;
> >       case REQ_OP_FLUSH:
> >               rnbd_opf =3D RNBD_OP_FLUSH;
> >               break;
> > diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-sr=
v.c
> > index 132e950685d59..0e6b5687f8321 100644
> > --- a/drivers/block/rnbd/rnbd-srv.c
> > +++ b/drivers/block/rnbd/rnbd-srv.c
> > @@ -548,8 +548,7 @@ static void rnbd_srv_fill_msg_open_rsp(struct rnbd_=
msg_open_rsp *rsp,
> >               cpu_to_le16(rnbd_dev_get_max_segs(rnbd_dev));
> >       rsp->max_hw_sectors =3D
> >               cpu_to_le32(rnbd_dev_get_max_hw_sects(rnbd_dev));
> > -     rsp->max_write_same_sectors =3D
> > -             cpu_to_le32(bdev_write_same(rnbd_dev->bdev));
> > +     rsp->max_write_same_sectors =3D 0;
>
> IIUC, I think we can delete max_write_same_sectors from rsp as well given
> the earlier change in setup_request_queue and rnbd_clt_set_dev_attr.
No, I don't think it's a good idea, we need to keep the protocol
compatible, so client for old kernel version
won't be confused.

The patch looks good to me, but I want to run a regression test before
give an acked.

Thanks!
Jinpu
>
> Thanks,
> Guoqing
