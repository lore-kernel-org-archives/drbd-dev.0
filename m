Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id B90FD1055FD8
	for <drbd-dev@lists.linbit.com>; Wed, 24 Aug 2011 18:34:49 +0200 (CEST)
Resent-Message-ID: <20110824163449.GG14479@barkeeper1-xen.linbit>
Date: Wed, 24 Aug 2011 18:03:18 +0200
From: Lars Ellenberg <lars@linbit.com>
To: bugzilla-daemon@bugzilla.kernel.org
Message-ID: <20110824160318.GF14479@barkeeper1-xen.linbit>
References: <bug-41602-40662@https.bugzilla.kernel.org/>
	<201108241514.p7OFEliA003245@demeter2.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <201108241514.p7OFEliA003245@demeter2.kernel.org>
Cc: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [Bug 41602] DRBD: possible deadlock in Ahead mode
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Wed, Aug 24, 2011 at 03:14:47PM +0000, bugzilla-daemon@bugzilla.kernel.org wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=41602

> --- Comment #2 from Cyril B. <cbay@excellency.fr>  2011-08-24 15:14:47 ---
> I can't rule out a misconfiguration, but I've been using DRBD since 8.0 on many
> servers and I've never seen such a thing happen. It's only happened very
> recently since I began using Linux 3.0 on a few servers, a few days ago.
> 
> Even if it's a temporary network failure that I've never had before:
> 
>  - how comes even a drbdadm disconnect doesn't work (i.e. hangs), and I have to
> reboot the primary server to be able to write on my filesystem again?

Arguably a design bug, the default disconnect waits for all current
requests to be handled.

You can try to --force disconnect, though.

>  - isn't the Ahead mode supposed to not block IO if the buffer is full and/or
> the secondary server is not accessible?

Well, yes, but it still needs to send some bytes (as oposed to the full
data block) to the peer. And if sendmsg blocks/times out/makes no
progress for whatever reason, we cannot do anything about that.

-- 
: Lars Ellenberg
: LINBIT | Your Way to High Availability
: DRBD/HA support and consulting http://www.linbit.com

DRBD® and LINBIT® are registered trademarks of LINBIT, Austria.
