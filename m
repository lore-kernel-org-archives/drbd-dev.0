Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id E300E105815B
	for <drbd-dev@lists.linbit.com>; Fri,  5 Jul 2013 21:55:29 +0200 (CEST)
Date: Fri, 5 Jul 2013 21:55:29 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: Kei Kurono <kuronense@outlook.com>
Message-ID: <20130705195529.GC17905@soda.linbit>
References: <BLU173-W45773F4F7B7B69A6A949B8AC8E0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BLU173-W45773F4F7B7B69A6A949B8AC8E0@phx.gbl>
Cc: "drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>
Subject: Re: [Drbd-dev] DRBD Replication Modes
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

On Thu, Jun 20, 2013 at 11:19:21PM +0000, Kei Kurono wrote:
> Hi,
> I just want to propose a new feature that implements a synchrnous mode
> were the I/O is blocked (in the primary node) in the case when the
> remote node (secondary node) is down. This could help us achieve
> absolute confidence that both nodes are trully identical. This would
> be very helpul for paranoid organizations.

We already have "fencing resource-and-stonith",
which freezes IO when the replication link breaks,
and calls out to a user space helper,
which is supposed to implement policy,
and exit with meaningful exit code
(e.g. "Successfully fenced peer", or "Don't know what to do, either").

You are of course free to implement that handler any way you like,
including "exit 1", which will keep IO frozen.

"Thanks, but we already have that" ...

Cheers,

-- 
: Lars Ellenberg
: LINBIT | Your Way to High Availability
: DRBD/HA support and consulting http://www.linbit.com

DRBD® and LINBIT® are registered trademarks of LINBIT, Austria.
