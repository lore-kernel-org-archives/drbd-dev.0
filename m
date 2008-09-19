Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (office.linbit [86.59.100.100])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 65BAC2E2E5EF
	for <drbd-dev@lists.linbit.com>; Fri, 19 Sep 2008 17:53:44 +0200 (CEST)
Date: Fri, 19 Sep 2008 17:53:43 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] New Features
Message-ID: <20080919155343.GD9779@soda.linbit>
References: <48D3378E.3020201@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <48D3378E.3020201@gmail.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Thu, Sep 18, 2008 at 11:24:30PM -0600, Morey Roof wrote:
> I have been using DRBD and really like but I have wanted to add some new  
> features to it and I wanted to ask you guys what you need and  
> requirements you may have on patches to DRBD.

Could you tell us about your background, and prior coding experience,
and how much time you think you want to spend on this?

In the drbd module, we currently do not actively work on new features
that would be suitable to be implemented by anyone not very familiar
with the drbd code base.  If you think you are, let me know...

Finding and squashing bugs is always a wellcome contribution.

Userland could be improved, e.g. adding an "include" statement
to the drbd.conf grammar, which would allow to have the configuration
split out in /etc/drbd.conf.d/*.conf.

Error messages can be improved, in both kernel and userland.

The community would be happy to see some detailed walk-throughs from
scratch for drbd integration with pacemaker, including various typically
deployed services on top of drbd.

I'd be happy to see a recent and solid HA-DRBD-NFS howto,
so if you feel that would be a task for you,
set up an HA-DRBD-NFSv4 server, and document everything needed to make
it behave as expected (document the expectations as well) in face of
failover, switchover, node reboot, cluster reboot, replication link failure,
other component failures, various administrative tasks.
  An advanced variation on the theme: "load balancing" HA-DRBD-NFSv4
cluster, using multiple drbd, each with its own file system, fsid, and
HA-ip, and then switchover at will, without causing server nor client
hickups.

-- 
: Lars Ellenberg
: LINBIT | Your Way to High Availability
: DRBD/HA support and consulting http://www.linbit.com

DRBD® and LINBIT® are registered trademarks of LINBIT, Austria.
