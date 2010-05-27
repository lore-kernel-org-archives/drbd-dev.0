Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 999CB108714D
	for <drbd-dev@lists.linbit.com>; Thu, 27 May 2010 16:21:39 +0200 (CEST)
Date: Thu, 27 May 2010 16:21:39 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20100527142139.GM26213@soda.linbit>
References: <AANLkTim66dldWydThtZraIL6dqzVn0lxB1Q_chcOkkaa@mail.gmail.com>
	<20100527090125.GC26213@soda.linbit>
	<AANLkTimujV7rnDws-Mhvnba7nuIht2GyTC8pGCN63H9i@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AANLkTimujV7rnDws-Mhvnba7nuIht2GyTC8pGCN63H9i@mail.gmail.com>
Subject: Re: [Drbd-dev] DRBD + DM = EIO.
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Thu, May 27, 2010 at 10:14:42AM -0400, Ben Timby wrote:
> Lars, you rock! That fixes my problem. However...
> 
> I still get read error -5 warnings in my messages:
> 
> May 27 09:56:03 ragoon6 kernel: block drbd1: p read: error=-5
> May 27 09:59:48 ragoon6 last message repeated 26 times
> May 27 09:59:49 ragoon6 last message repeated 146 times

We quietened those messages in the upcomming 8.3.8 release.

Thanks,

-- 
: Lars Ellenberg
: LINBIT | Your Way to High Availability
: DRBD/HA support and consulting http://www.linbit.com

DRBD® and LINBIT® are registered trademarks of LINBIT, Austria.
