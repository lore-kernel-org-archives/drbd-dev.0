Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
	[209.85.128.66])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 4CE1B4206D0
	for <drbd-dev@lists.linbit.com>; Mon, 12 Oct 2020 17:43:15 +0200 (CEST)
Received: by mail-wm1-f66.google.com with SMTP id 13so17548467wmf.0
	for <drbd-dev@lists.linbit.com>; Mon, 12 Oct 2020 08:43:15 -0700 (PDT)
Received: from soda.linbit (62-99-137-214.static.upcbusiness.at.
	[62.99.137.214]) by smtp.gmail.com with ESMTPSA id
	71sm24524930wrm.20.2020.10.12.08.43.14
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 12 Oct 2020 08:43:14 -0700 (PDT)
Resent-Message-ID: <20201012154313.GZ2116@soda.linbit>
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com
	[209.85.208.66])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id CD8CB42034D
	for <drbd-dev@lists.linbit.com>; Wed,  8 Jul 2020 19:46:41 +0200 (CEST)
Received: by mail-ed1-f66.google.com with SMTP id a8so41317434edy.1
	for <drbd-dev@lists.linbit.com>; Wed, 08 Jul 2020 10:46:41 -0700 (PDT)
From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To: Ming Lei <ming.lei@redhat.com>
References: <20200708075819.4531-1-guoqing.jiang@cloud.ionos.com>
	<20200708075819.4531-2-guoqing.jiang@cloud.ionos.com>
	<20200708132704.GB3340386@T590>
	<ad89a0b2-3b40-b515-2120-85bc0274165b@cloud.ionos.com>
Message-ID: <1796891f-66c3-09c4-559f-15d1d350d817@cloud.ionos.com>
MIME-Version: 1.0
In-Reply-To: <ad89a0b2-3b40-b515-2120-85bc0274165b@cloud.ionos.com>
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
Date: Mon, 12 Oct 2020 15:44:45 -0000

On 7/8/20 3:53 PM, Guoqing Jiang wrote:
>>
>> Cost of ktime_get_ns() can be observed as not cheap in high IOPS device,
>
> Could you share some links about it? Thanks.
>
>> so not sure the conversion is good. Also could you share what benefit 
>> we can
>> get with this change?
>
> Without the conversion, we have to track io latency with jiffies in 
> 4th patch.
> Then with HZ=100, some rows (such as 1ms, 2ms and 4ms) in that table
> don't make sense. 

Hmm, I can still output those rows based on HZ_TO_MSEC_NUM, which means
this patch can be dropped since the cost of ktime_get_ns is more expensive.

Thanks,
Guoqing
