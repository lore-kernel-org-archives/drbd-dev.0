Return-Path: <colyli@suse.de>
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id B152D4201D4
	for <drbd-dev@lists.linbit.com>; Sat,  5 Mar 2022 15:12:00 +0100 (CET)
Message-ID: <a6296031-4a73-170a-2505-dc6d902179d8@suse.de>
Date: Sat, 5 Mar 2022 22:02:13 +0800
MIME-Version: 1.0
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
References: <20220303111905.321089-1-hch@lst.de>
	<20220303111905.321089-8-hch@lst.de>
From: Coly Li <colyli@suse.de>
In-Reply-To: <20220303111905.321089-8-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jens Axboe <axboe@kernel.dk>, Chris Zankel <chris@zankel.net>,
	Justin Sanders <justin@coraid.com>, Minchan Kim <minchan@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>, linux-xtensa@linux-xtensa.org,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Denis Efremov <efremov@linux.com>, linux-block@vger.kernel.org,
	Max Filippov <jcmvbkbc@gmail.com>, linux-bcache@vger.kernel.org,
	nvdimm@lists.linux.dev, Lars Ellenberg <lars.ellenberg@linbit.com>,
	Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Nitin Gupta <ngupta@vflare.org>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 07/10] bcache: use bvec_kmap_local in bio_csum
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

On 3/3/22 7:19 PM, Christoph Hellwig wrote:
> Using local kmaps slightly reduces the chances to stray writes, and
> the bvec interface cleans up the code a little bit.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>


Acked-by: Coly Li <colyli@suse.de>


Thanks.


Coly Li


> ---
>   drivers/md/bcache/request.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/md/bcache/request.c b/drivers/md/bcache/request.c
> index 6869e010475a3..fdd0194f84dd0 100644
> --- a/drivers/md/bcache/request.c
> +++ b/drivers/md/bcache/request.c
> @@ -44,10 +44,10 @@ static void bio_csum(struct bio *bio, struct bkey *k)
>   	uint64_t csum = 0;
>   
>   	bio_for_each_segment(bv, bio, iter) {
> -		void *d = kmap(bv.bv_page) + bv.bv_offset;
> +		void *d = bvec_kmap_local(&bv);
>   
>   		csum = crc64_be(csum, d, bv.bv_len);
> -		kunmap(bv.bv_page);
> +		kunmap_local(d);
>   	}
>   
>   	k->ptr[KEY_PTRS(k)] = csum & (~0ULL >> 1);


