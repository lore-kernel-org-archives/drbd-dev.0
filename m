Return-Path: <gulam.mohamed@oracle.com>
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
	[205.220.165.32])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 7CFFA421792
	for <drbd-dev@lists.linbit.com>; Fri, 23 Dec 2022 15:47:19 +0100 (CET)
From: Gulam Mohamed <gulam.mohamed@oracle.com>
To: Keith Busch <kbusch@kernel.org>
Date: Fri, 23 Dec 2022 14:47:06 +0000
Message-ID: <CO1PR10MB4563F566452B9D3035A82EE298E99@CO1PR10MB4563.namprd10.prod.outlook.com>
References: <20221221040506.1174644-1-gulam.mohamed@oracle.com>
	<20221221040506.1174644-2-gulam.mohamed@oracle.com>
	<Y6M9rJbw3ZMvOeDr@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <Y6M9rJbw3ZMvOeDr@kbusch-mbp.dhcp.thefacebook.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Cc: "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
	Shminderjit Singh <shminderjit.singh@oracle.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"song@kernel.org" <song@kernel.org>,
	"dm-devel@redhat.com" <dm-devel@redhat.com>,
	"ira.weiny@intel.com" <ira.weiny@intel.com>,
	"agk@redhat.com" <agk@redhat.com>,
	"drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>,
	"dave.jiang@intel.com" <dave.jiang@intel.com>,
	"minchan@kernel.org" <minchan@kernel.org>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
	Konrad Wilk <konrad.wilk@oracle.com>, Joe Jin <joe.jin@oracle.com>,
	"kent.overstreet@gmail.com" <kent.overstreet@gmail.com>,
	"ngupta@vflare.org" <ngupta@vflare.org>, "kch@nvidia.com" <kch@nvidia.com>,
	"senozhatsky@chromium.org" <senozhatsky@chromium.org>,
	"snitzer@kernel.org" <snitzer@kernel.org>,
	"colyli@suse.de" <colyli@suse.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-bcache@vger.kernel.org" <linux-bcache@vger.kernel.org>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>, Junxiao,
	"linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
	Martin Petersen <martin.petersen@oracle.com>,
	Rajesh Sivaramasubramaniom <rajesh.sivaramasubramaniom@oracle.com>,
	"philipp.reisner@linbit.com" <philipp.reisner@linbit.com>,
	Bi <junxiao.bi@oracle.com>,
	"lars.ellenberg@linbit.com" <lars.ellenberg@linbit.com>
Subject: Re: [Drbd-dev] [PATCH for-6.2/block V3 2/2] block: Change the
 granularity of io ticks from ms to ns
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

Hi Keith,

   Thanks for reviewing this request. Can you please see my inline comments=
?

Regards,
Gulam Mohamed.

-----Original Message-----
From: Keith Busch <kbusch@kernel.org>=20
Sent: Wednesday, December 21, 2022 10:39 PM
To: Gulam Mohamed <gulam.mohamed@oracle.com>
Cc: linux-block@vger.kernel.org; axboe@kernel.dk; philipp.reisner@linbit.co=
m; lars.ellenberg@linbit.com; christoph.boehmwalder@linbit.com; minchan@ker=
nel.org; ngupta@vflare.org; senozhatsky@chromium.org; colyli@suse.de; kent.=
overstreet@gmail.com; agk@redhat.com; snitzer@kernel.org; dm-devel@redhat.c=
om; song@kernel.org; dan.j.williams@intel.com; vishal.l.verma@intel.com; da=
ve.jiang@intel.com; ira.weiny@intel.com; Junxiao Bi <junxiao.bi@oracle.com>=
; Martin Petersen <martin.petersen@oracle.com>; kch@nvidia.com; drbd-dev@li=
sts.linbit.com; linux-kernel@vger.kernel.org; linux-bcache@vger.kernel.org;=
 linux-raid@vger.kernel.org; nvdimm@lists.linux.dev; Konrad Wilk <konrad.wi=
lk@oracle.com>; Joe Jin <joe.jin@oracle.com>; Rajesh Sivaramasubramaniom <r=
ajesh.sivaramasubramaniom@oracle.com>; Shminderjit Singh <shminderjit.singh=
@oracle.com>
Subject: Re: [PATCH for-6.2/block V3 2/2] block: Change the granularity of =
io ticks from ms to ns

On Wed, Dec 21, 2022 at 04:05:06AM +0000, Gulam Mohamed wrote:
> +u64  blk_get_iostat_ticks(struct request_queue *q) {
> +       return (blk_queue_precise_io_stat(q) ? ktime_get_ns() :=20
> +jiffies); } EXPORT_SYMBOL_GPL(blk_get_iostat_ticks);
> +
>  void update_io_ticks(struct block_device *part, u64 now, bool end)  {
>  	u64 stamp;
> @@ -968,20 +980,26 @@ EXPORT_SYMBOL(bdev_start_io_acct);
>  u64 bio_start_io_acct(struct bio *bio)  {
>  	return bdev_start_io_acct(bio->bi_bdev, bio_sectors(bio),
> -				  bio_op(bio), jiffies);
> +				  bio_op(bio),
> +				  blk_get_iostat_ticks(bio->bi_bdev->bd_queue));
>  }
>  EXPORT_SYMBOL_GPL(bio_start_io_acct);
> =20
>  void bdev_end_io_acct(struct block_device *bdev, enum req_op op,
>  		      u64 start_time)
>  {
> +	u64 now;
> +	u64 duration;
> +	struct request_queue *q =3D bdev_get_queue(bdev);
>  	const int sgrp =3D op_stat_group(op);
> -	u64 now =3D READ_ONCE(jiffies);
> -	u64 duration =3D (unsigned long)now -(unsigned long) start_time;
> +	now =3D blk_get_iostat_ticks(q);;

I don't think you can rely on the blk_queue_precise_io_stat() flag in the c=
ompletion side. The user can toggle this with data in flight, which means t=
he completion may use different tick units than the start. I think you'll n=
eed to add a flag to the request in the start accounting side to know which=
 method to use for the completion.

[GULAM]: As per my understanding, this may work for a single request_queue =
implemetation. But this request based accounting, as per my understanding, =
may be an issue with the Multi-QUEUE as there is a separate queue for each =
CPU and the time-stamp being recorded for the block device is a global one.=
 Also, the issue you mentioned about the start and end accounting may updat=
e the ticks in different=20
units for the inflight IOs, may be just for a while. So, even if it works f=
or MQ, I am trying to understand how much is it feasible to do this request=
-based change for an issue which may be there for just a moment?
So, can you please correct me if I am wrong and explore more on your sugges=
tion so that I can understand properly?

> @@ -951,6 +951,7 @@ ssize_t part_stat_show(struct device *dev,
>  	struct request_queue *q =3D bdev_get_queue(bdev);
>  	struct disk_stats stat;
>  	unsigned int inflight;
> +	u64 stat_ioticks;
> =20
>  	if (queue_is_mq(q))
>  		inflight =3D blk_mq_in_flight(q, bdev); @@ -959,10 +960,13 @@ ssize_t=
=20
> part_stat_show(struct device *dev,
> =20
>  	if (inflight) {
>  		part_stat_lock();
> -		update_io_ticks(bdev, jiffies, true);
> +		update_io_ticks(bdev, blk_get_iostat_ticks(q), true);
>  		part_stat_unlock();
>  	}
>  	part_stat_read_all(bdev, &stat);
> +	stat_ioticks =3D (blk_queue_precise_io_stat(q) ?
> +				div_u64(stat.io_ticks, NSEC_PER_MSEC) :
> +				jiffies_to_msecs(stat.io_ticks));


With the user able to change the precision at will, I think these io_ticks =
need to have a consistent unit size. Mixing jiffies and nsecs is going to c=
reate garbage stats output. Could existing io_ticks using jiffies be conver=
ted to jiffies_to_nsecs() so that you only have one unit to consider?
[GULAM]: I am not sure if this will work as we just multiply with 1000000 t=
o convert jiffies to nano-seconds.



