Return-Path: <tj@kernel.org>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 11CE1105960E
	for <drbd-dev@lists.linbit.com>; Sat, 13 Nov 2010 12:18:54 +0100 (CET)
Message-ID: <4CDE73EB.2090208@kernel.org>
Date: Sat, 13 Nov 2010 12:18:03 +0100
From: Tejun Heo <tj@kernel.org>
MIME-Version: 1.0
To: dedekind1@gmail.com
References: <1288628129-12811-1-git-send-email-tj@kernel.org>	
	<1288628129-12811-2-git-send-email-tj@kernel.org>	
	<4CDE6FAA.9030605@kernel.org> <1289646865.2218.27.camel@localhost>
In-Reply-To: <1289646865.2218.27.camel@localhost>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: jack@suse.cz, leochen@broadcom.com, neilb@suse.de,
	heiko.carstens@de.ibm.com, dm-devel@redhat.com,
	adilger.kernel@dilger.ca, konishi.ryusuke@lab.ntt.co.jp,
	shaggy@linux.vnet.ibm.com, drbd-dev@lists.linbit.com,
	joel.becker@oracle.com, hch@infradead.org, aelder@sgi.com,
	mfasheh@suse.com, joern@logfs.org,
	reiserfs-devel@vger.kernel.org, viro@zeniv.linux.org.uk,
	swhiteho@redhat.com, chris.mason@oracle.com, axboe@kernel.dk,
	tytso@mit.edu, sbranden@broadcom.com, petero2@telia.com,
	linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com,
	linux-mtd@lists.infradead.org, akpm@linux-foundation.org
Subject: Re: [Drbd-dev] [PATCH UPDATED 1/5] mtd: fix bdev exclusive open
	bugs in block2mtd::add_device()
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hello,

On 11/13/2010 12:14 PM, Artem Bityutskiy wrote:
> On Sat, 2010-11-13 at 11:59 +0100, Tejun Heo wrote:
>> There are two bdev exclusive open bugs.
>>
>> * open_bdev_exclusive() must not be called with NULL holder.  Use dev
>>   as the holder.
>>
>> * open_by_devnum() doesn't open the bdev exclusively but
>>   block2mtd_free_device() always assumes it.  Explicitly claim the
>>   bdev.
>>
>> The latter is rather clumsy but will be simplified with future
>> blkdev_get/put() cleanups.
>>
>> - Updated to use local variable @mode to cache FMODE_* masks as
>>   suggested by Artem Bityutskiy.
> 
> Do you want this patch to go in via Jens' tree with the rest of the
> series, or as an independent patch via the mtd tree?

It probably would be easier if this is routed through Jens' tree as
it's necessary for later patches in the series, but this being a fix,
this should be merged during this cycle rather than the next one.
Jens, how do you want to proceed?

Thank you.

-- 
tejun
