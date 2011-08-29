Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 4F6A610556B3
	for <drbd-dev@lists.linbit.com>; Mon, 29 Aug 2011 13:46:37 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Greg Freemyer <greg.freemyer@gmail.com>, Jens Axboe <axboe@kernel.dk>,
	linux-kernel@vger.kernel.org
Date: Mon, 29 Aug 2011 13:46:23 +0200
References: <1314284934-17999-1-git-send-email-philipp.reisner@linbit.com>
	<CAGpXXZKem-uEdF4SyUgpQFV6=d5Vo3v9p3wmcaygAKa4w4x01w@mail.gmail.com>
In-Reply-To: <CAGpXXZKem-uEdF4SyUgpQFV6=d5Vo3v9p3wmcaygAKa4w4x01w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201108291346.29847.philipp.reisner@linbit.com>
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

Am Freitag, 26. August 2011, 15:20:51 schrieb Greg Freemyer:
> On Thu, Aug 25, 2011 at 11:06 AM, Philipp Reisner <
> 
> philipp.reisner@linbit.com> wrote:
> > This the first request for review of drbd-8.4. The complete set has
> > 500 patches. In this first series there are only 118 of these.
> 
> Lars,
> 
> I've only taken a quick glance, but is drbd functional between applying
> each patch?
> 
> It doesn't look like it to me, but I didn't look that close.  I also saw at
> least one patch that introduced a new function with no caller to test it.
> 
> The idea is that a patch series leave a testable / functional kernel after
> each patch in the series is applied sequentially.
> 
> That is the only way git bisect can do its job.
> 
> ie. Introducing a new function but no new caller makes a change, but there
> is no way to test it.  Therefore there is no real value in not merging that
> patch with one that has the new call in it.
> 

Greg,

You replied to mail 000. Please point out to which patch/function you
refer, so that we can fix this.

Best,
 Phil
-- 
: Dipl-Ing Philipp Reisner
: LINBIT | Your Way to High Availability
: Tel: +43-1-8178292-50, Fax: +43-1-8178292-82
: http://www.linbit.com

DRBD(R) and LINBIT(R) are registered trademarks of LINBIT, Austria.
