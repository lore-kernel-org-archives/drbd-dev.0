Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 2B27310556B4
	for <drbd-dev@lists.linbit.com>; Fri, 23 Sep 2011 16:18:20 +0200 (CEST)
Date: Fri, 23 Sep 2011 16:18:20 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20110923141820.GD11992@barkeeper1-xen.linbit>
References: <201108241641.42676.philipp.reisner@linbit.com>
	<j5hkl1$o4o$1@dough.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <j5hkl1$o4o$1@dough.gmane.org>
Subject: Re: [Drbd-dev] [GIT PULL] drbd-8.4 for mainline
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Fri, Sep 23, 2011 at 11:48:17AM +0200, Lutz Vieweg wrote:
> On 08/24/2011 04:41 PM, Philipp Reisner wrote:
> >   This release brings a new meta-data format. Forward (8.3 ->  8.4)
> >   conversion happens complete seamless.
> 
> Well, it may happen seamless unless you reboot the machine before
> it has completed the resyncing with the other (still 8.3 running)
> machine.
> 
> I happened to require yet some other kernel setting (unrelated to DRBD),
> installed the changed kernel, while one DRBD resource was still syncing
> (for the first time after upgrading to 8.4), and rebooted (clean shutdown/restart).
> 
> After the reboot, DRBD complained about not finding valid meta data
> on the device, and I had to write new metadata and perform a full sync
> to rectify the situation.

You probably had 8.4 userland already, but 8.3 module loaded still?

If you then unload the 8.3 module (no more /proc/drbd),
then do "drbdadm apply-al all".  That should "fix" it.

Otherwise, please tell us how to reproduce, and we will figure out what
needs to be improved during the upgrade/downgrade paths.

> (Luckily, since the other machine was still running, so no data was lost
> in the process.)
> 
> Regards,
> 
> Lutz Vieweg

-- 
: Lars Ellenberg
: LINBIT | Your Way to High Availability
: DRBD/HA support and consulting http://www.linbit.com
