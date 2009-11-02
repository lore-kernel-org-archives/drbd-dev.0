Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 8E77610745E8
	for <drbd-dev@lists.linbit.com>; Mon,  2 Nov 2009 23:48:57 +0100 (CET)
Date: Mon, 2 Nov 2009 23:48:57 +0100
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20091102224857.GG14841@barkeeper1-xen.linbit>
References: <BC2F8964429F14468EA0E6D6CF00E8C9390D64@EXHQ.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BC2F8964429F14468EA0E6D6CF00E8C9390D64@EXHQ.corp.stratus.com>
Subject: Re: [Drbd-dev] Supporting blktrace in DRBD
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Sun, Nov 01, 2009 at 05:10:24PM -0500, Graham, Simon wrote:
> I've been using blktrace to investigate performance of DRBD and have
> found a few places where DRBD needs to issue blktrace API calls that it
> does not - usually, the library routines in ll_rw_blk.c make these calls
> on behalf of block devices but those like DRBD that write their own
> routines need to also make some trace calls. Specifically, DRBD needs to
> trace request completion and calls to lower level unplug routines (it's
> hard to be sure but it looks to me like the caller of the unplug routine
> is supposed to make the trace call).
> 
>  
> 
> Patch against 8.2 (and tested with kernel 2.6.18) attached for your
> review

Will do...
though only for current git and the next kernel submission iteration.
BTW, our "homegrown" tracing framework has been ripped out upstream,
so we will probably replace it by trace_events "soonish".
Unless you beat us to it ;)

Thanks,


-- 
: Lars Ellenberg
: LINBIT | Your Way to High Availability
: DRBD/HA support and consulting http://www.linbit.com

DRBD® and LINBIT® are registered trademarks of LINBIT, Austria.
