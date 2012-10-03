Return-Path: <axboe@kernel.dk>
Received: from casper.infradead.org (casper.infradead.org [85.118.1.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id DE956100540F
	for <drbd-dev@lists.linbit.com>; Wed,  3 Oct 2012 16:04:45 +0200 (CEST)
Message-ID: <506C45D8.7000306@kernel.dk>
Date: Wed, 03 Oct 2012 16:04:08 +0200
From: Jens Axboe <axboe@kernel.dk>
MIME-Version: 1.0
To: Philipp Reisner <philipp.reisner@linbit.com>
References: <8391701.3EY4hQfmFv@fat-tyre> <10403443.3yRLLBkj5b@fat-tyre>
	<506C343E.60203@kernel.dk> <1646250.CkOtqoMF8x@fat-tyre>
In-Reply-To: <1646250.CkOtqoMF8x@fat-tyre>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [GIT PULL] drbd-8.3 updates
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On 2012-10-03 15:49, Philipp Reisner wrote:
>> Thanks, one question before this is pulled in:
>>> Philipp Reisner (6):
>>>       drbd: Add a drbd directory to sysfs
>>>       drbd: expose the data generation identifiers via sysfs
>>
>> What are these? It's sitting in /sys/block/<dev>/drbd/, I don't see any
>> documentation or justification for that.
>>
>> Why isn't it off in debugfs or similar instead?
> 
> The long-time goal is to get rid of the /proc/drbd virtual file, and
> present the information that was there in a more structured way in /sys.
> 
> This patch adds a very first step into that direction. Later we intend to
> have here things like the connections state, device roles, statistics
> counters there.
> 
> When coming up with the layout we used the sysfs presence of software raid 
> as example.

Software raid is different, though, in that it's a class/type of device.
So for drbd, I'd still recommend you look outside of the regular
/sys/block hierarchy for adding something like this.

> I have removed it from this pull-request, so that there is more time for
> consideration before the next merge window.

Thanks, pulled.

-- 
Jens Axboe

