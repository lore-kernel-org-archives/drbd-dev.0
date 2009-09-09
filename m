Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 1EF4E1084953
	for <drbd-dev@lists.linbit.com>; Wed,  9 Sep 2009 17:03:51 +0200 (CEST)
Date: Wed, 9 Sep 2009 17:03:50 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20090909150350.GE8081@barkeeper1-xen.linbit>
References: <4AA7BA11.7040909@lthd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4AA7BA11.7040909@lthd.com>
Subject: Re: [Drbd-dev] I have found a bug in version 8.3.3rc1
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Wed, Sep 09, 2009 at 05:22:09PM +0300, Dinu-Razvan Chis-Serban wrote:
> The symptoms: the second server goes into diskless mode after a while if  
> on-io-error is set to detach, but if it is set to pass_on, nothing  
> happens. The underlying device is a md-raid in RAID10 and it works OK.

configuration?
drbdadm dump
for d in /dev/drbd[0-9]* ; do drbdsetup $d show ; done

kernel logs of both servers from such an incident please?

-- 
: Lars Ellenberg
: LINBIT | Your Way to High Availability
: DRBD/HA support and consulting http://www.linbit.com

DRBD® and LINBIT® are registered trademarks of LINBIT, Austria.
