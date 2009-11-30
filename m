Return-Path: <lars.ellenberg@linbit.com>
Received: from racke.rauchzart (p548CE2F9.dip.t-dialin.net [84.140.226.249])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPSA id BC0B5108496B
	for <drbd-dev@lists.linbit.com>; Mon, 30 Nov 2009 20:09:47 +0100 (CET)
Date: Mon, 30 Nov 2009 20:10:58 +0100
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20091130191058.GC12030@racke>
References: <BC2F8964429F14468EA0E6D6CF00E8C90ADFA2@EXHQ.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BC2F8964429F14468EA0E6D6CF00E8C90ADFA2@EXHQ.corp.stratus.com>
Subject: Re: [Drbd-dev] changing the fencing policy on the fly
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Mon, Nov 30, 2009 at 01:51:02PM -0500, Petrakis, Peter wrote:
> Hi All,
>  
> I have a challenge with the use of fencing and the state of flux in our
> cluster. The system 
> will setup drbd devices in advance and use them independent of it's
> peer, which will mirror
> it's config once it joins the cluster. Since the fencing helper makes
> use of drbdadm and thus
> the config file we have a problem. If fencing were to be triggered, it
> would immediately fail
> with a bad exit status because the config file is inconsistent. We use a
> naming convention
> for the disks in our cluster so the only piece of information I don't
> know at this time is my
> peers ip address.
> 
> To work around this bug I set the fencing policy to 'dont-care' and then
> once the resource
> is connected and uptodate, detach the backing store and then reattach it
> with the desired
> fencing policy. This leaves us vulnerable however, should the link go
> down for any reason we're
> in big trouble.
> 
> I'm trying to eliminate this hole without detaching the backing store. I
> can't play tricks with
> aliasing the eth interface to some address because I'm not physically in
> control of the box and don't
> want to ruin someone's network in case they hook up the wires
> incorrectly. DRBD doesn't seem to support
> IPV6 link local addressing which would help in this case because the
> nodes are directly attached.

IPv6 is supposed to work.

> What I'd like to do is to change the fencing policy on demand and the
> mechanism I wish to use is sysfs.
> Do you guys see any pitfalls with this approach, locking especially? The
> reason I want to use sysfs is two
> fold. I want to get away from using drbdadm for the userspace helper and
> it'll make writing software to
> manage drbd more straight forward. Thanks in advance.

modinfo drbd
usermode_helper:string
	(default: /sbin/drbdadm)
	also available via /sys/modules/drbd/parameters/usermode_helper

You can add your own wrapper around drbdadm as "hanlder" helper.

But feel free to write a patch to replace the DRBD config interface
(currently netlink/connector resp. genetlink based) to
a sysfs based one, and we might consider it ;)

Use a "DRBD" bus, each sub dir being a single drbd,
expose all parameters we currently have,
see that you don't step on each others toes when configuring those.
you probably need a "live" and a "pending" config set,
so you can change paramters when configuring in sequence,
then "commit" them in one go.

Post on drbd-dev and possibly on lkml.

Converting single parameters to sysfs in some ad-hoc fashion,
just because you feel _this_ one should be there,
is not useful und unmaintainable.

Thanks,

	Lars

