Return-Path: <jaxboe@fusionio.com>
Received: from kernel.dk (0122700014.0.fullrate.dk [95.166.99.235])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id A59CC106E12F
	for <drbd-dev@lists.linbit.com>; Tue, 24 Aug 2010 10:41:17 +0200 (CEST)
Message-ID: <4C7385BB.9080504@fusionio.com>
Date: Tue, 24 Aug 2010 10:41:31 +0200
From: Jens Axboe <jaxboe@fusionio.com>
MIME-Version: 1.0
To: Philipp Reisner <philipp.reisner@linbit.com>
References: <20100811223845.GE645@bicker>
	<201008241038.12979.philipp.reisner@linbit.com>
In-Reply-To: <201008241038.12979.philipp.reisner@linbit.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
	Sam Ravnborg <sam@ravnborg.org>, Dan Carpenter <error27@gmail.com>,
	Lars Ellenberg <drbd-dev@lists.linbit.com>
Subject: Re: [Drbd-dev] [patch] drbd: cleanup: change "<= 0" to "== 0"
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On 2010-08-24 10:38, Philipp Reisner wrote:
> Am Donnerstag, 12. August 2010, um 00:38:45 schrieb Dan Carpenter:
>> dt is unsigned so it's never less than zero.  We are calculating the
>> elapsed time, and that's never less than zero (unless there is a bug or
>> we invent time travel).  The comparison here is just to guard against
>> divide by zero bugs.
>>
>> Signed-off-by: Dan Carpenter <error27@gmail.com>
>>
>> diff --git a/drivers/block/drbd/drbd_proc.c
>> b/drivers/block/drbd/drbd_proc.c index be3374b..4c0c4aa 100644
>> --- a/drivers/block/drbd/drbd_proc.c
>> +++ b/drivers/block/drbd/drbd_proc.c
>> @@ -118,7 +118,7 @@ static void drbd_syncer_progress(struct drbd_conf
>> *mdev, struct seq_file *seq) /* mean speed since syncer started
>>  	 * we do account for PausedSync periods */
>>  	dt = (jiffies - mdev->rs_start - mdev->rs_paused) / HZ;
>> -	if (dt <= 0)
>> +	if (dt == 0)
>>  		dt = 1;
>>  	db = mdev->rs_total - rs_left;
>>  	dbdt = Bit2KB(db/dt);
> 
> Hi Dan,
> 
> Please elaborate the improvement this patch brings.
> dt can actually get negative, on jiffie wrap. I see
> little value in displaying then a negative resync speed...

Aren't all members unsigned long? If not, then you have
another bug.

-- 
Jens Axboe

