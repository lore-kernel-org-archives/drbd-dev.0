Return-Path: <lars.ellenberg@linbit.com>
Received: from johann (chello212017090083.12.15.vie.surfer.at [212.17.90.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPSA id 5A88310476FB
	for <drbd-dev@lists.linbit.com>; Wed,  6 May 2009 17:07:31 +0200 (CEST)
Date: Wed, 6 May 2009 17:07:31 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20090506150731.GC8830@johann>
References: <902001984.20090506163355@galatai.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <902001984.20090506163355@galatai.de>
Subject: Re: [Drbd-dev] DRDB abd Xen
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Wed, May 06, 2009 at 04:33:55PM +0200, Firi wrote:
> Hi at All,
> 
> i installed a xen cluster as the following how to explain:
> 
> http://asplund.nu/xencluster/xen-cluster-howto.html
> 
> That works realy realy realy fine.
> 
> Now, in updated the from 3.2 to 3.3 and now he isnt able to
> unterstand the disk port at the vps config.
> The Error is: Block device must have pyh file or tap.....
> 
> What i mean is that part:
> 
>     disk = [
>     'drbd:test-swap,xvda1,w',
>     'drbd:test-disk,xvda2,w',
>     ]
> 
> Is there any needed patch or something like this?
> The xen version is installed from a Ubuntu Backport reposity.
> 
> Maybe anyone here is able to tell me more about that.

please repost on drbd-user.
thanks.

-- 
: Lars Ellenberg
: LINBIT | Your Way to High Availability
: DRBD/HA support and consulting http://www.linbit.com

DRBD® and LINBIT® are registered trademarks of LINBIT, Austria.
