Return-Path: <axboe@kernel.dk>
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com
	[209.85.215.194])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 00BCE420380
	for <drbd-dev@lists.linbit.com>; Tue, 28 Jul 2020 21:21:19 +0200 (CEST)
Received: by mail-pg1-f194.google.com with SMTP id z5so12610055pgb.6
	for <drbd-dev@lists.linbit.com>; Tue, 28 Jul 2020 12:21:19 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
References: <20200724073313.138789-1-hch@lst.de>
	<0b2b59d4-da4c-33df-82b4-0d4935b91e6e@kernel.dk>
Message-ID: <08ded32a-cf3a-55b0-6a88-19d201edac93@kernel.dk>
Date: Tue, 28 Jul 2020 13:20:09 -0600
MIME-Version: 1.0
In-Reply-To: <0b2b59d4-da4c-33df-82b4-0d4935b91e6e@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Cc: linux-raid@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
	Minchan Kim <minchan@kernel.org>, Richard Weinberger <richard@nod.at>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	Song Liu <song@kernel.org>, dm-devel@redhat.com,
	linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	cgroups@vger.kernel.org, linux-mm@kvack.org, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] bdi cleanups v3
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

On 7/28/20 9:41 AM, Jens Axboe wrote:
> On 7/24/20 1:32 AM, Christoph Hellwig wrote:
>> Hi Jens,
>>
>> this series contains a bunch of different BDI cleanups.  The biggest item
>> is to isolate block drivers from the BDI in preparation of changing the
>> lifetime of the block device BDI in a follow up series.
> 
> Applied, thanks.

Dropped:

  CC      block/blk-sysfs.o
block/blk-sysfs.c:608:16: error: ‘blk_throtl_sample_show’ undeclared here (not in a function); did you mean ‘blk_throtl_sample_entry’?
  608 | QUEUE_RW_ENTRY(blk_throtl_sample, "throttle_sample_time");
      |                ^~~~~~~~~~~~~~~~~
block/blk-sysfs.c:563:10: note: in definition of macro ‘QUEUE_RW_ENTRY’
  563 |  .show = _prefix##_show,   \
      |          ^~~~~~~
block/blk-sysfs.c:608:16: error: ‘blk_throtl_sample_store’ undeclared here (not in a function); did you mean ‘blk_throtl_sample_entry’?
  608 | QUEUE_RW_ENTRY(blk_throtl_sample, "throttle_sample_time");
      |                ^~~~~~~~~~~~~~~~~
block/blk-sysfs.c:564:11: note: in definition of macro ‘QUEUE_RW_ENTRY’
  564 |  .store = _prefix##_store,   \
      |           ^~~~~~~
block/blk-sysfs.c:657:3: error: ‘blk_throtl_sample_time_entry’ undeclared here (not in a function); did you mean ‘blk_throtl_sample_time_store’?
  657 |  &blk_throtl_sample_time_entry.attr,
      |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
      |   blk_throtl_sample_time_store
block/blk-sysfs.c:608:16: warning: ‘blk_throtl_sample_entry’ defined but not used [-Wunused-variable]
  608 | QUEUE_RW_ENTRY(blk_throtl_sample, "throttle_sample_time");
      |                ^~~~~~~~~~~~~~~~~
block/blk-sysfs.c:561:33: note: in definition of macro ‘QUEUE_RW_ENTRY’
  561 | static struct queue_sysfs_entry _prefix##_entry = { \
      |                                 ^~~~~~~
make[1]: *** [scripts/Makefile.build:281: block/blk-sysfs.o] Error 1
make: *** [Makefile:1756: block] Error 2

from "block: add helper macros for queue sysfs entries"

This has not seen a full compile test even...

-- 
Jens Axboe

