Return-Path: <axboe@kernel.dk>
Received: from casper.infradead.org (casper.infradead.org [85.118.1.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 77A8E103B4BC
	for <drbd-dev@lists.linbit.com>; Fri,  9 Nov 2012 13:56:54 +0100 (CET)
Message-ID: <509CFD70.5020807@kernel.dk>
Date: Fri, 09 Nov 2012 13:56:16 +0100
From: Jens Axboe <axboe@kernel.dk>
MIME-Version: 1.0
To: Philipp Reisner <philipp.reisner@linbit.com>
References: <3042269.jrNem7z1LI@fat-tyre> <509CEB9F.8080705@kernel.dk>
	<4229483.8Hqs9YQUgX@fat-tyre>
In-Reply-To: <4229483.8Hqs9YQUgX@fat-tyre>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [GIT PULL] drbd-8.4.2 for the linux-3.8 merge window
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On 2012-11-09 13:42, Philipp Reisner wrote:
> [...]
>>> It has the sysfs bits in again. The reason for that is that we want to
>>> expose more information by that, and remove the /proc/drbd with the
>>> next evolutionary step. -- In case this is a show stopper, let me
>>> remove the sysfs bits.
>>
>> The exact same sysfs bits I complained about last time? If yes, then I
>> don't understand why you haven't changed yet. Or why you are trying to
>> push the same bits again that got rejected last time.
>>
> 
> I had the impression it was rejected because I submitted the pull request
> too late to you. In the sense of, it might go in, if it gets submitted
> for inclusion before the merge window opens...
> Apparently my impression was wrong. You will get an updated pull-request 
> with the sysfs bits removed

It was late, but that was a different issue. I just re-read the Oct 3rd
emails on this, and I definitely did recommend that you looked at
debugfs or similar for this. We're not putting another top-queue level
directory in for a block device that is specific to drbd.

-- 
Jens Axboe

