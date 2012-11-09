Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 4BC9F103B4BC
	for <drbd-dev@lists.linbit.com>; Fri,  9 Nov 2012 13:42:27 +0100 (CET)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Date: Fri, 09 Nov 2012 13:42:26 +0100
Message-ID: <4229483.8Hqs9YQUgX@fat-tyre>
In-Reply-To: <509CEB9F.8080705@kernel.dk>
References: <3042269.jrNem7z1LI@fat-tyre> <509CEB9F.8080705@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
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

[...]
> > It has the sysfs bits in again. The reason for that is that we want to
> > expose more information by that, and remove the /proc/drbd with the
> > next evolutionary step. -- In case this is a show stopper, let me
> > remove the sysfs bits.
> 
> The exact same sysfs bits I complained about last time? If yes, then I
> don't understand why you haven't changed yet. Or why you are trying to
> push the same bits again that got rejected last time.
> 

I had the impression it was rejected because I submitted the pull request
too late to you. In the sense of, it might go in, if it gets submitted
for inclusion before the merge window opens...
Apparently my impression was wrong. You will get an updated pull-request 
with the sysfs bits removed

> > Here is the git-pull-request test:
> > (The patch subjects removed to make the mail more digestible)
> 
> Please don't do that, it basically makes the pull request useless! A few
> hundred extra lines is not an issue.

Ok.

I intend to send the updated pull-request later today.

