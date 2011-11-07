Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 8EA3310556D2
	for <drbd-dev@lists.linbit.com>; Mon,  7 Nov 2011 10:32:40 +0100 (CET)
Date: Mon, 7 Nov 2011 10:32:40 +0100
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20111107093240.GD15431@barkeeper1-xen.linbit>
References: <1320595796-5181-1-git-send-email-florian@hastexo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1320595796-5181-1-git-send-email-florian@hastexo.com>
Subject: Re: [Drbd-dev] fix missing directory creation in "make install"
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Sun, Nov 06, 2011 at 05:09:55PM +0100, Florian Haas wrote:
> Lars/Phil,
> 
> please consider the following patch, which ensures that "make install"
> creates DRBD_RUN_DIR. Issue highlighted by Eric Robinson, see:
> 
> http://lists.linux-ha.org/pipermail/linux-ha/2011-November/044198.html

Can we just drop the configure nonsense again instead?

As /var/run/ is a tmpfs on many distros now, subdirs and other things in
it need to be recreated anyways as needed, which drbdsetup is actually
supposed to be doing.

And "someone" (the OS) is supposed to cleanup those dirs on reboot,
which won't happen with the braindead configure autofoo defautls,
which again may (or may not) confuse some things.

Ah, well, thanks for the patch, anyways ;)

-- 
: Lars Ellenberg
: LINBIT | Your Way to High Availability
: DRBD/HA support and consulting http://www.linbit.com
