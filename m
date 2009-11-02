Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 97EDF10745E8
	for <drbd-dev@lists.linbit.com>; Mon,  2 Nov 2009 23:46:42 +0100 (CET)
Date: Mon, 2 Nov 2009 23:46:42 +0100
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20091102224642.GF14841@barkeeper1-xen.linbit>
References: <BC2F8964429F14468EA0E6D6CF00E8C9390D65@EXHQ.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BC2F8964429F14468EA0E6D6CF00E8C9390D65@EXHQ.corp.stratus.com>
Subject: Re: [Drbd-dev] DRBD does not always send UnplugRemote when it	should
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Sun, Nov 01, 2009 at 05:16:07PM -0500, Graham, Simon wrote:
> In looking at DRBD performance, I noticed that DRBD does not always send
> an UnplugRemote command when (I think) it should - I believe this is
> because it uses the mdev UNPLUG_REMOTE flag to control whether or not
> the command would be helpful and this flag is set in the worker thread
> as part of actually sending the data packet.
> 
> This means that an unplug call can be made from above between the time
> the bio is submitted and the time the worker thread starts processing it
> - this call will be ignored because the flag it not set yet.
> Subsequently, the flag gets set but it's too late by then and you can
> see a very long delay on the secondary until the unplug timeout expires
> there.
> 
> I think the fix is to set the flag in the queue_for_net_write action in
> _req_mod - this is called inline with the bio so the flag will be set
> before the unplug routine is called.
> 
> Proposed patch against 8.2 attached.

Thanks, that looks reasonable.
I *think* we had it like that once sometime, and then changed it again.
After all, the queue_for_net_read does it, too...

Will apply to 8.3.


-- 
: Lars Ellenberg
: LINBIT | Your Way to High Availability
: DRBD/HA support and consulting http://www.linbit.com

DRBD® and LINBIT® are registered trademarks of LINBIT, Austria.
