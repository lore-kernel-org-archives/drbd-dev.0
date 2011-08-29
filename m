Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 0D16810556B2
	for <drbd-dev@lists.linbit.com>; Mon, 29 Aug 2011 13:51:14 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Kyle Moffett <kyle@moffetthome.net>, Jens Axboe <axboe@kernel.dk>,
	linux-kernel@vger.kernel.org
Date: Mon, 29 Aug 2011 13:51:05 +0200
References: <1314284934-17999-1-git-send-email-philipp.reisner@linbit.com>
	<20110826135402.GS14479@barkeeper1-xen.linbit>
	<CAGZ=bqJojmtfVjQdbx3j2vZyrz01dZZs7wVqBxNbqreejZu4JQ@mail.gmail.com>
In-Reply-To: <CAGZ=bqJojmtfVjQdbx3j2vZyrz01dZZs7wVqBxNbqreejZu4JQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201108291351.06092.philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [RFC 000/118] drbd: part 1 of adding multiple volume
	support to drbd
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Freitag, 26. August 2011, 17:18:53 schrieb Kyle Moffett:
> On Fri, Aug 26, 2011 at 09:54, Lars Ellenberg <lars.ellenberg@linbit.com> 
wrote:
> > On Fri, Aug 26, 2011 at 09:20:51AM -0400, Greg Freemyer wrote:
> >> On Thu, Aug 25, 2011 at 11:06 AM, Philipp Reisner <
> >> 
> >> philipp.reisner@linbit.com> wrote:
> >> > This the first request for review of drbd-8.4. The complete set has
> >> > 500 patches. In this first series there are only 118 of these.
> >> 
> >> I've only taken a quick glance, but is drbd functional between applying
> >> each patch?
> >> 
> >> It doesn't look like it to me, but I didn't look that close.  I also saw
> >> at least one patch that introduced a new function with no caller to
> >> test it.
> >> 
> >> The idea is that a patch series leave a testable / functional kernel
> >> after each patch in the series is applied sequentially.
> >> 
> >> That is the only way git bisect can do its job.
> > 
> > Very likely DRBD will not always be completely functional between
> > any arbitrary two of these patches.
> > 
> > The kernel as such will still be bisectable "just fine".
> 
> No.
> 
> That's not the way that kernel development works.
> 
> Besides which, that's not the way that "git bisect" works.
> 
> For example, say I have a driver bug that happens to be triggering
> on my server which also happens to use GFS on DRBD.  I try to
> bisect the bug and it happens to pick a commit right in the middle
> of this DRBD branch.
> 
> Suddenly DRBD is unusable or corrupting data or something, which
> is unacceptable for an unrelated bisection of a driver bug.
> 

No. It compiles after each and every patch. Verified. It is
functional after each and every patch, though providing the
feature set that was present before this whole patch series.

If you are looking for a regression with "git bisect" then
you are using DRBD with only the old features.

The new feature set, might be partially broken, but introducing
the new features is the whole point of this patch series.

Best,
 Phil

-- 
: Dipl-Ing Philipp Reisner
: LINBIT | Your Way to High Availability
: Tel: +43-1-8178292-50, Fax: +43-1-8178292-82
: http://www.linbit.com

DRBD(R) and LINBIT(R) are registered trademarks of LINBIT, Austria.
