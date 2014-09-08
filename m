Return-Path: <imrep.amz@gmail.com>
Received: from mail-we0-f174.google.com (mail-we0-f174.google.com
	[74.125.82.174]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 6D9FC101AC7E
	for <drbd-dev@lists.linbit.com>; Mon,  8 Sep 2014 15:05:38 +0200 (CEST)
Received: by mail-we0-f174.google.com with SMTP id t60so1090198wes.33
	for <drbd-dev@lists.linbit.com>; Mon, 08 Sep 2014 06:05:38 -0700 (PDT)
Message-ID: <540DA998.7060807@gmail.com>
Date: Mon, 08 Sep 2014 15:05:28 +0200
From: Imre Palik <imrep.amz@gmail.com>
MIME-Version: 1.0
To: Lars <lars.ellenberg@linbit.com>
References: <1409942478-29135-1-git-send-email-imrep.amz@gmail.com>
	<20140907095834.GA2332@hein>
In-Reply-To: <20140907095834.GA2332@hein>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, "Palik, Imre" <imrep@amazon.de>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Matt Wilson <msw@amazon.com>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH v3] drbd: fix throttling on newly created DM
	backing devices
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On 09/07/14 11:58, Lars wrote:
> On Fri, Sep 05, 2014 at 08:41:18PM +0200, Imre Palik wrote:
>> From: "Palik, Imre" <imrep@amazon.de>
>>
>> If the drbd backing device is a new device mapper device (e.g., a
>> dm-linear mapping of an existing block device that contains data), the
>> counters are initially 0 even though the device contains useful
>> data. This causes throttling until something accesses the drbd device
>> or the backing device.
>
> What was wrong with my previous proposal?

Sorry, I haven't realised you added a proposal to your reply.  It seems, 
I really needed that extra sleep during the weekend ...

Your proposal is good.  Of course, I like my last one a slightly better. 
  But as they say, beauty is in the eye of the beholder :-)

> How does changing the signedness help with
> rs_last_events not being properly initialized?

It only helps with reasoning.  I reason with modular arithmetic way 
easier than with signed integer overflows.  Accidentally, 0 is a good 
initialisation value in case of unsigned arithmetic.

> Are you sure you have also considered all wrap-around cases?
>
> Maybe you are too focused on your particular corner case
> (disk_stats starting with 0).
> Maybe I'm just thick right now, so please explain.

The idea is that 0 is the smallest possible value for an unsigned, and 
curr_events is monotonically increasing (mod 2^32) .  This means, 
initially either curr_events > 64, that is, we enter the loop, and do 
the initialisation, or it will be bigger than 64 at most when we want to 
start throttle in an ideal world (after no more than 64 sectors of 
activity).

Basically, while you initialise rs_last_events to an ideal value with 
some calculation, I choose a safe static value.  I am content with both 
approaches.  I think, as a subsystem maintainer, you should choose the 
one you like better.  If you choose yours, then you can add
Reviewed-by: Imre Palik <imrep@amazon.de>

Imre

>
> 	Lars
>
>> The patch disables throttling, as long as only resync is responsible
>> for disk activity on a freshly created device.
>>
>> Reported-by: Mikhail Sugakov <msugakov@amazon.de>
>> Cc: Matt Wilson <msw@amazon.com>
>> Signed-off-by: Imre Palik <imrep@amazon.de>
>> ---
>>   drivers/block/drbd/drbd_int.h      |    4 ++--
>>   drivers/block/drbd/drbd_receiver.c |   10 +++++-----
>>   2 files changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
>> index 1a00001..298b1dc 100644
>> --- a/drivers/block/drbd/drbd_int.h
>> +++ b/drivers/block/drbd/drbd_int.h
>> @@ -960,8 +960,8 @@ struct drbd_device {
>>   	atomic_t rs_sect_in; /* for incoming resync data rate, SyncTarget */
>>   	atomic_t rs_sect_ev; /* for submitted resync data rate, both */
>>   	int rs_last_sect_ev; /* counter to compare with */
>> -	int rs_last_events;  /* counter of read or write "events" (unit sectors)
>> -			      * on the lower level device when we last looked. */
>> +	unsigned int rs_last_events;  /* counter of read or write "events" (unit sectors)
>> +				       * on the lower level device when we last looked. */
>>   	int c_sync_rate; /* current resync rate after syncer throttle magic */
>>   	struct fifo_buffer *rs_plan_s; /* correction values of resync planer (RCU, connection->conn_update) */
>>   	int rs_in_flight; /* resync sectors in flight (to proxy, in proxy and from proxy) */
>> diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
>> index 9342b8d..147c917 100644
>> --- a/drivers/block/drbd/drbd_receiver.c
>> +++ b/drivers/block/drbd/drbd_receiver.c
>> @@ -2467,7 +2467,7 @@ bool drbd_rs_c_min_rate_throttle(struct drbd_device *device)
>>   	struct gendisk *disk = device->ldev->backing_bdev->bd_contains->bd_disk;
>>   	unsigned long db, dt, dbdt;
>>   	unsigned int c_min_rate;
>> -	int curr_events;
>> +	unsigned int curr_events;
>>
>>   	rcu_read_lock();
>>   	c_min_rate = rcu_dereference(device->ldev->disk_conf)->c_min_rate;
>> @@ -2477,12 +2477,12 @@ bool drbd_rs_c_min_rate_throttle(struct drbd_device *device)
>>   	if (c_min_rate == 0)
>>   		return false;
>>
>> -	curr_events = (int)part_stat_read(&disk->part0, sectors[0]) +
>> -		      (int)part_stat_read(&disk->part0, sectors[1]) -
>> -			atomic_read(&device->rs_sect_ev);
>> +	curr_events = (unsigned int)part_stat_read(&disk->part0, sectors[0]) +
>> +		      (unsigned int)part_stat_read(&disk->part0, sectors[1]) -
>> +		(unsigned int)atomic_read(&device->rs_sect_ev);
>>
>>   	if (atomic_read(&device->ap_actlog_cnt)
>> -	    || !device->rs_last_events || curr_events - device->rs_last_events > 64) {
>> +		|| curr_events - device->rs_last_events > 64) {
>>   		unsigned long rs_left;
>>   		int i;
>>
>> --
>> 1.7.9.5
>>

