Return-Path: <prvs=6551138a8=Damien.LeMoal@wdc.com>
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id DEF6E42062E
	for <drbd-dev@lists.linbit.com>; Thu, 28 Jan 2021 08:28:56 +0100 (CET)
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"dm-devel@redhat.com" <dm-devel@redhat.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "drbd-dev@lists.linbit.com"
	<drbd-dev@lists.linbit.com>, "xen-devel@lists.xenproject.org"
	<xen-devel@lists.xenproject.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "linux-scsi@vger.kernel.org"
	<linux-scsi@vger.kernel.org>, "target-devel@vger.kernel.org"
	<target-devel@vger.kernel.org>, "linux-fscrypt@vger.kernel.org"
	<linux-fscrypt@vger.kernel.org>, "jfs-discussion@lists.sourceforge.net"
	<jfs-discussion@lists.sourceforge.net>, "linux-nilfs@vger.kernel.org"
	<linux-nilfs@vger.kernel.org>, "ocfs2-devel@oss.oracle.com"
	<ocfs2-devel@oss.oracle.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>
Date: Thu, 28 Jan 2021 07:21:42 +0000
Message-ID: <BL0PR04MB6514C554B4AC96866BC1B16FE7BA9@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210128071133.60335-1-chaitanya.kulkarni@wdc.com>
	<20210128071133.60335-3-chaitanya.kulkarni@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Cc: "shaggy@kernel.org" <shaggy@kernel.org>,
	"sergey.senozhatsky.work@gmail.com" <sergey.senozhatsky.work@gmail.com>,
	"snitzer@redhat.com" <snitzer@redhat.com>,
	"len.brown@intel.com" <len.brown@intel.com>,
	"tiwai@suse.de" <tiwai@suse.de>, "djwong@kernel.org" <djwong@kernel.org>,
	"gustavoars@kernel.org" <gustavoars@kernel.org>,
	"joseph.qi@linux.alibaba.com" <joseph.qi@linux.alibaba.com>,
	"pavel@ucw.cz" <pavel@ucw.cz>,
	"alex.shi@linux.alibaba.com" <alex.shi@linux.alibaba.com>,
	"hch@lst.de" <hch@lst.de>, "agk@redhat.com" <agk@redhat.com>,
	"sagi@grimberg.me" <sagi@grimberg.me>, "mark@fasheh.com" <mark@fasheh.com>,
	"osandov@fb.com" <osandov@fb.com>,
	"ebiggers@kernel.org" <ebiggers@kernel.org>,
	"ngupta@vflare.org" <ngupta@vflare.org>,
	Naohiro Aota <Naohiro.Aota@wdc.com>,
	"konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
	"hare@suse.de" <hare@suse.de>, "ming.lei@redhat.com" <ming.lei@redhat.com>,
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
	"jefflexu@linux.alibaba.com" <jefflexu@linux.alibaba.com>,
	"jaegeuk@kernel.org" <jaegeuk@kernel.org>,
	"konishi.ryusuke@gmail.com" <konishi.ryusuke@gmail.com>,
	"bvanassche@acm.org" <bvanassche@acm.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>, "jth@kernel.org" <jth@kernel.org>,
	"tytso@mit.edu" <tytso@mit.edu>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>,
	"rjw@rjwysocki.net" <rjw@rjwysocki.net>,
	"philipp.reisner@linbit.com" <philipp.reisner@linbit.com>,
	"minchan@kernel.org" <minchan@kernel.org>, "tj@kernel.org" <tj@kernel.org>,
	"lars.ellenberg@linbit.com" <lars.ellenberg@linbit.com>,
	"roger.pau@citrix.com" <roger.pau@citrix.com>,
	"asml.silence@gmail.com" <asml.silence@gmail.com>,
	"jlbec@evilplan.org" <jlbec@evilplan.org>
Subject: Re: [Drbd-dev] [RFC PATCH 02/34] block: introduce and use bio_new
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

On 2021/01/28 16:12, Chaitanya Kulkarni wrote:=0A=
> Introduce bio_new() helper and use it in blk-lib.c to allocate and=0A=
> initialize various non-optional or semi-optional members of the bio=0A=
> along with bio allocation done with bio_alloc(). Here we also calmp the=
=0A=
> max_bvecs for bio with BIO_MAX_PAGES before we pass to bio_alloc().=0A=
> =0A=
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
> ---=0A=
>  block/blk-lib.c     |  6 +-----=0A=
>  include/linux/bio.h | 25 +++++++++++++++++++++++++=0A=
>  2 files changed, 26 insertions(+), 5 deletions(-)=0A=
> =0A=
> diff --git a/block/blk-lib.c b/block/blk-lib.c=0A=
> index fb486a0bdb58..ec29415f00dd 100644=0A=
> --- a/block/blk-lib.c=0A=
> +++ b/block/blk-lib.c=0A=
> @@ -14,17 +14,13 @@ struct bio *blk_next_bio(struct bio *bio, struct bloc=
k_device *bdev,=0A=
>  			sector_t sect, unsigned op, unsigned opf,=0A=
>  			unsigned int nr_pages, gfp_t gfp)=0A=
>  {=0A=
> -	struct bio *new =3D bio_alloc(gfp, nr_pages);=0A=
> +	struct bio *new =3D bio_new(bdev, sect, op, opf, gfp, nr_pages);=0A=
>  =0A=
>  	if (bio) {=0A=
>  		bio_chain(bio, new);=0A=
>  		submit_bio(bio);=0A=
>  	}=0A=
>  =0A=
> -	new->bi_iter.bi_sector =3D sect;=0A=
> -	bio_set_dev(new, bdev);=0A=
> -	bio_set_op_attrs(new, op, opf);=0A=
> -=0A=
>  	return new;=0A=
>  }=0A=
>  =0A=
> diff --git a/include/linux/bio.h b/include/linux/bio.h=0A=
> index c74857cf1252..2a09ba100546 100644=0A=
> --- a/include/linux/bio.h=0A=
> +++ b/include/linux/bio.h=0A=
> @@ -826,5 +826,30 @@ static inline void bio_set_polled(struct bio *bio, s=
truct kiocb *kiocb)=0A=
>  	if (!is_sync_kiocb(kiocb))=0A=
>  		bio->bi_opf |=3D REQ_NOWAIT;=0A=
>  }=0A=
> +/**=0A=
> + * bio_new -	allcate and initialize new bio=0A=
> + * @bdev:	blockdev to issue discard for=0A=
> + * @sector:	start sector=0A=
> + * @op:		REQ_OP_XXX from enum req_opf=0A=
> + * @op_flags:	REQ_XXX from enum req_flag_bits=0A=
> + * @max_bvecs:	maximum bvec to be allocated for this bio=0A=
> + * @gfp_mask:	memory allocation flags (for bio_alloc)=0A=
> + *=0A=
> + * Description:=0A=
> + *    Allocates, initializes common members, and returns a new bio.=0A=
> + */=0A=
> +static inline struct bio *bio_new(struct block_device *bdev, sector_t se=
ctor,=0A=
> +				  unsigned int op, unsigned int op_flags,=0A=
> +				  unsigned int max_bvecs, gfp_t gfp_mask)=0A=
> +{=0A=
> +	unsigned nr_bvec =3D clamp_t(unsigned int, max_bvecs, 0, BIO_MAX_PAGES)=
;=0A=
> +	struct bio *bio =3D bio_alloc(gfp_mask, nr_bvec);=0A=
=0A=
I think that depending on the gfp_mask passed, bio can be NULL. So this sho=
uld=0A=
be checked.=0A=
=0A=
> +=0A=
> +	bio_set_dev(bio, bdev);=0A=
> +	bio->bi_iter.bi_sector =3D sector;=0A=
> +	bio_set_op_attrs(bio, op, op_flags);=0A=
=0A=
This function is obsolete. Open code this.=0A=
=0A=
> +=0A=
> +	return bio;=0A=
> +}=0A=
>  =0A=
>  #endif /* __LINUX_BIO_H */=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
