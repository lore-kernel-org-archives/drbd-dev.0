Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id B8AA3105DB6C
	for <drbd-dev@lists.linbit.com>; Wed,  6 Jan 2010 12:35:56 +0100 (CET)
Date: Wed, 6 Jan 2010 12:35:56 +0100
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20100106113556.GZ23877@barkeeper1-xen.linbit>
References: <BC2F8964429F14468EA0E6D6CF00E8C969FBEF@EXHQ.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BC2F8964429F14468EA0E6D6CF00E8C969FBEF@EXHQ.corp.stratus.com>
Subject: Re: [Drbd-dev] syncsource -> sync completed ack lost
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Tue, Jan 05, 2010 at 06:11:17PM -0500, Petrakis, Peter wrote:
> Hi guys,
> 
> This is on drbd 8.2.7. The sync target was recently outdarted and
> resynced

8.2 is obsolete.
it has been superseeded by 8.3

what would have been 8.2.8 was relabeled 8.3.0,
because of a few feature enhancements (the folding of the previous
"plus" stuff into the GPL version)

8.2 is unmaintained, it will occasionally still receive updates in git,
but that is only to ease merging from 8.0 to 8.3.
it will miss many bugfixes, and we will not make any effort
for that branch to contain relevant bugfixes made on 8.3.


please go to 8.3 branch.
8.2 is obsolete.

if you can reproduce with 8.3,
we will certainly look into this.

but I think we fix a few things that would match your symptoms in 8.3.

we are currently (well, tomorrow) at 8.3.7 rc2

> Jan  5 14:36:18 node1 kernel: drbd5: helper command:
> /usr/lib/spine/bin/avance_drbd_helper after-resync-target minor-5

I'd be interessted in this /usr/lib/spine/bin/avance_drbd_helper.
what does it do, compared with drbdadm?

-- 
: Lars Ellenberg
: LINBIT | Your Way to High Availability
: DRBD/HA support and consulting http://www.linbit.com

DRBD® and LINBIT® are registered trademarks of LINBIT, Austria.
