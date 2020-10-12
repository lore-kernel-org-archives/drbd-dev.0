Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
	[209.85.221.65])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 97F9D4206CF
	for <drbd-dev@lists.linbit.com>; Mon, 12 Oct 2020 17:43:13 +0200 (CEST)
Received: by mail-wr1-f65.google.com with SMTP id g12so19702912wrp.10
	for <drbd-dev@lists.linbit.com>; Mon, 12 Oct 2020 08:43:13 -0700 (PDT)
Received: from soda.linbit (62-99-137-214.static.upcbusiness.at.
	[62.99.137.214]) by smtp.gmail.com with ESMTPSA id
	z17sm12354666wrr.93.2020.10.12.08.43.12
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 12 Oct 2020 08:43:12 -0700 (PDT)
Resent-Message-ID: <20201012154310.GY2116@soda.linbit>
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com
	[209.85.208.66])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 0DF604203BA
	for <drbd-dev@lists.linbit.com>; Wed,  8 Jul 2020 15:53:03 +0200 (CEST)
Received: by mail-ed1-f66.google.com with SMTP id h28so41909953edz.0
	for <drbd-dev@lists.linbit.com>; Wed, 08 Jul 2020 06:53:03 -0700 (PDT)
To: Ming Lei <ming.lei@redhat.com>
References: <20200708075819.4531-1-guoqing.jiang@cloud.ionos.com>
	<20200708075819.4531-2-guoqing.jiang@cloud.ionos.com>
	<20200708132704.GB3340386@T590>
From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <ad89a0b2-3b40-b515-2120-85bc0274165b@cloud.ionos.com>
MIME-Version: 1.0
In-Reply-To: <20200708132704.GB3340386@T590>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH RFC 1/5] block: return ns precision from
 disk_start_io_acct
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
Date: Mon, 12 Oct 2020 15:44:15 -0000

Hi Ming,

On 7/8/20 3:27 PM, Ming Lei wrote:
> On Wed, Jul 08, 2020 at 09:58:15AM +0200, Guoqing Jiang wrote:
>> Currently the duration accounting of bio based driver is converted from
>> jiffies to ns, means it could be less accurate as request based driver.
>>
>> So let disk_start_io_acct return from ns precision, instead of convert
>> jiffies to ns in disk_end_io_acct.
>>
>> Cc: Philipp Reisner <philipp.reisner@linbit.com>
>> Cc: Lars Ellenberg <lars.ellenberg@linbit.com>
>> Cc: drbd-dev@lists.linbit.com
>> Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
>> ---
>>   block/blk-core.c | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/block/blk-core.c b/block/blk-core.c
>> index d9d632639bd1..0e806a8c62fb 100644
>> --- a/block/blk-core.c
>> +++ b/block/blk-core.c
>> @@ -1466,6 +1466,7 @@ unsigned long disk_start_io_acct(struct gendisk *disk, unsigned int sectors,
>>   	struct hd_struct *part = &disk->part0;
>>   	const int sgrp = op_stat_group(op);
>>   	unsigned long now = READ_ONCE(jiffies);
>> +	unsigned long start_ns = ktime_get_ns();
>>   
>>   	part_stat_lock();
>>   	update_io_ticks(part, now, false);
>> @@ -1474,7 +1475,7 @@ unsigned long disk_start_io_acct(struct gendisk *disk, unsigned int sectors,
>>   	part_stat_local_inc(part, in_flight[op_is_write(op)]);
>>   	part_stat_unlock();
>>   
>> -	return now;
>> +	return start_ns;
>>   }
>>   EXPORT_SYMBOL(disk_start_io_acct);
>>   
>> @@ -1484,11 +1485,11 @@ void disk_end_io_acct(struct gendisk *disk, unsigned int op,
>>   	struct hd_struct *part = &disk->part0;
>>   	const int sgrp = op_stat_group(op);
>>   	unsigned long now = READ_ONCE(jiffies);
>> -	unsigned long duration = now - start_time;
>> +	unsigned long duration = ktime_get_ns() - start_time;
>>   
>>   	part_stat_lock();
>>   	update_io_ticks(part, now, true);
>> -	part_stat_add(part, nsecs[sgrp], jiffies_to_nsecs(duration));
>> +	part_stat_add(part, nsecs[sgrp], duration);
>>   	part_stat_local_dec(part, in_flight[op_is_write(op)]);
>>   	part_stat_unlock();
> Hi Guoqing,
>
> Cost of ktime_get_ns() can be observed as not cheap in high IOPS device,

Could you share some links about it? Thanks.

> so not sure the conversion is good. Also could you share what benefit we can
> get with this change?

Without the conversion, we have to track io latency with jiffies in 4th 
patch.
Then with HZ=100, some rows (such as 1ms, 2ms and 4ms) in that table
don't make sense.

Thanks,
Guoqing
