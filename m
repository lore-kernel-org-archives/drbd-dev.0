Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 22AAC106E0E3
	for <drbd-dev@lists.linbit.com>; Sat, 25 Feb 2012 23:21:05 +0100 (CET)
Date: Sat, 25 Feb 2012 23:21:04 +0100
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20120225222104.GH28351@barkeeper1-xen.linbit>
References: <201202241728.29238.apollonskiy.e@digdes.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201202241728.29238.apollonskiy.e@digdes.com>
Subject: Re: [Drbd-dev] ko-count overflow
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Fri, Feb 24, 2012 at 05:28:29PM +0400, Apollonskiy Evgeniy wrote:
> Hello,
> 
> There is a strange code fragment in drbd_main.c:
> 
> 	drop_it = !--mdev->ko_count;
> 	if (!drop_it) {
> 		dev_err(DEV, "[%s/%d] sock_sendmsg time expired, ko = %u\n",
> 		       current->comm, current->pid, mdev->ko_count);
> 		request_ping(mdev);
> 	}
> 
> Default value of ko_count is 0, so --mdev->ko_count will be equal to 
> 4294967295 (ko_count is unsigned int).

That is intentional.

Configuring "0" should be equivalent to "disabled",
but we still want the recurring log message with the "count down".

-- 
: Lars Ellenberg
: LINBIT | Your Way to High Availability
: DRBD/HA support and consulting http://www.linbit.com
