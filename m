Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 3C6661432B56
	for <drbd-dev@lists.linbit.com>; Tue,  3 Nov 2009 12:36:52 +0100 (CET)
Date: Tue, 3 Nov 2009 12:36:52 +0100
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20091103113652.GC12242@barkeeper1-xen.linbit>
References: <6ebabfd80911012210j144a25c9tdac8a88a26f4afd6@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6ebabfd80911012210j144a25c9tdac8a88a26f4afd6@mail.gmail.com>
Subject: Re: [Drbd-dev] Integrating iSCSI service to DRBD for iSCSI	failover
	- Heartbeat
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Mon, Nov 02, 2009 at 11:40:53AM +0530, sajan agr wrote:
> Hi
> 
> I am a naive user of pacemaker and have been trying to achieve iSCSI
> failover on Pacemaker.

Which is why this would be more appropriate for the pacemaker list.
Make sure you in clude the logs of the failed "takeover" attempt.

You should probably first grep yourself in those logs,
grep ERROR on the pacemaker logs do a good job usually.

Thanks,


-- 
: Lars Ellenberg
: LINBIT | Your Way to High Availability
: DRBD/HA support and consulting http://www.linbit.com

DRBD® and LINBIT® are registered trademarks of LINBIT, Austria.
