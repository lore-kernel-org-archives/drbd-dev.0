Return-Path: <axboe@kernel.dk>
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com
	[209.85.210.172])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 6002842177D
	for <drbd-dev@lists.linbit.com>; Thu,  8 Dec 2022 03:55:34 +0100 (CET)
Received: by mail-pf1-f172.google.com with SMTP id c7so196696pfc.12
	for <drbd-dev@lists.linbit.com>; Wed, 07 Dec 2022 18:55:34 -0800 (PST)
Message-ID: <4d118f20-9006-0af9-8d97-0d28d85a3585@kernel.dk>
Date: Wed, 7 Dec 2022 19:55:30 -0700
MIME-Version: 1.0
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>, Chaitanya Kulkarni <chaitanyak@nvidia.com>
References: <20221207223204.22459-1-gulam.mohamed@oracle.com>
	<abaa2003-4ddf-5ef9-d62c-1708a214609d@kernel.dk>
	<09be5cbe-9251-d28c-e91a-3f2e5e9e99f2@nvidia.com>
	<Y5Exa1TV/2VLcEWR@kbusch-mbp>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Y5Exa1TV/2VLcEWR@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"song@kernel.org" <song@kernel.org>,
	"dm-devel@redhat.com" <dm-devel@redhat.com>,
	"ira.weiny@intel.com" <ira.weiny@intel.com>,
	"agk@redhat.com" <agk@redhat.com>,
	"drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>,
	"dave.jiang@intel.com" <dave.jiang@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
	"konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
	"joe.jin@oracle.com" <joe.jin@oracle.com>,
	"kent.overstreet@gmail.com" <kent.overstreet@gmail.com>,
	"ngupta@vflare.org" <ngupta@vflare.org>,
	"senozhatsky@chromium.org" <senozhatsky@chromium.org>,
	Gulam Mohamed <gulam.mohamed@oracle.com>,
	"snitzer@kernel.org" <snitzer@kernel.org>,
	"colyli@suse.de" <colyli@suse.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-bcache@vger.kernel.org" <linux-bcache@vger.kernel.org>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>,
	"philipp.reisner@linbit.com" <philipp.reisner@linbit.com>,
	"junxiao.bi@oracle.com" <junxiao.bi@oracle.com>,
	"minchan@kernel.org" <minchan@kernel.org>,
	"lars.ellenberg@linbit.com" <lars.ellenberg@linbit.com>
Subject: Re: [Drbd-dev] [RFC for-6.2/block V2] block: Change the granularity
 of io ticks from ms to ns
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

On 12/7/22 5:35?PM, Keith Busch wrote:
> On Wed, Dec 07, 2022 at 11:17:12PM +0000, Chaitanya Kulkarni wrote:
>> On 12/7/22 15:08, Jens Axboe wrote:
>>>
>>> My default peak testing runs at 122M IOPS. That's also the peak IOPS of
>>> the devices combined, and with iostats disabled. If I enabled iostats,
>>> then the performance drops to 112M IOPS. It's no longer device limited,
>>> that's a drop of about 8.2%.
>>>
>>
>> Wow, clearly not acceptable that's exactly I asked for perf
>> numbers :).
> 
> For the record, we did say per-io ktime_get() has a measurable
> performance harm and should be aggregated.
> 
>   https://www.spinics.net/lists/linux-block/msg89937.html

Yes, I iterated that in the v1 posting as well, and mentioned it was the
reason the time batching was done. From the results I posted, if you
look at a profile of the run, here are the time related additions:

+   27.22%  io_uring  [kernel.vmlinux]  [k] read_tsc
+    4.37%  io_uring  [kernel.vmlinux]  [k] ktime_get

which are #1 and $4, respectively. That's a LOT of added overhead. Not
sure why people think time keeping is free, particularly high
granularity time keeping. It's definitely not, and adding 2-3 per IO is
very noticeable.

-- 
Jens Axboe

