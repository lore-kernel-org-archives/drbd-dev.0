Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id D99E41050592
	for <drbd-dev@lists.linbit.com>; Wed, 10 Jun 2015 13:44:02 +0200 (CEST)
Date: Wed, 10 Jun 2015 13:44:02 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
	drbd-dev@lists.linbit.com
Message-ID: <20150610114402.GD22714@soda.linbit>
References: <1433922509-10280-1-git-send-email-nwang@suse.com>
	<20150610113515.GC22714@soda.linbit>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150610113515.GC22714@soda.linbit>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Drbd-dev] [PATCH 00/10] Zero out devices instead of initial
 full sync
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

resent, accidentally truncated the Cc list.
also added one paragraph.

On Wed, Jun 10, 2015 at 03:48:19PM +0800, Nick Wang wrote:
> Full sync for drbd initial usually take a long time, especically
> when network become the bottleneck the syncing. Simply skip the
> full sync with "--clear-bitmap" may not the perfect solution
> for all the cases. So this patches can be used to zero out 
> devices locally instead of a full sync,two make consistent block 
> device. This approach can be useful when lack of network bandwidth 
> to sync.
> 
> The patches add one new option "--zap-devices" to "new-current-uuid" 
> to zero out devices. Besides the change of drbd, also need to modify 
> drbd-utils for the flag.
> 
> All patches are compiled/tested against SLES12.

Completely unnecessary.
Zero out the devices in userspace, then set up DRBD,
and skip the initial sync.

On backends that support it,
you can already simply blkdiscard /dev/drbdX
(or use the implicit discard of some mkfs)
once you set it up for the first time,
even when the initial resync just began,
and that discard will finish the "initial resync",
without taking up any real network bandwidth.

In short: I don't see the point.

	Lars Ellenberg

