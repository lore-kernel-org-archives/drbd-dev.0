Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 56F3C100EC11
	for <drbd-dev@lists.linbit.com>; Tue, 18 Aug 2015 17:03:20 +0200 (CEST)
Date: Tue, 18 Aug 2015 17:03:19 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: Nick Wang <nwang@suse.com>
Message-ID: <20150818150319.GL19958@soda.linbit>
References: <1950665.2mvfrclfR5@fat-tyre>
	<1438855462-3757-1-git-send-email-nwang@suse.com>
	<1438855462-3757-2-git-send-email-nwang@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1438855462-3757-2-git-send-email-nwang@suse.com>
Cc: linux-kernel@vger.kernel.org, Philipp Reisner <philipp.reisner@linbit.com>,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] drbd: Support zeroout device instead of
	initial full sync
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

On Thu, Aug 06, 2015 at 06:04:22PM +0800, Nick Wang wrote:
> Patch set for zeroing out device on both side
> instead of initial full sync. Useful for high
> latency network environment.
> 
> Implement --zeroout-devices and --discard-devices
> for new-current-uuid

I still think this does not belong into the kernel at all.
I may not yet have properly explained why.

This is a lot of stuff to add to the DRBD module,
introducing write protocol incompatibility/protocol version bump.

For no good reason.

you want to create a new drbd,
and want to make sure the backing devices are discarded:

# blkdiscard /dev/backing
and then proceed with
# drbdadm create-md ...
as normal, and skip the initial sync as documented.

You want to grow an existing drbd,
you have to grow the backend first, anyways,
you can then (if necessary)
# blkdiscard --offset $o --length $l /dev/backing,
# drbdadm resize ... --assume-clean ...

No need to touch either the DRBD module, or the DRBD utils at all.
All there already.

	Lars Ellenberg

