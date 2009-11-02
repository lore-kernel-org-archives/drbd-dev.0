Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id ECAA310745E8
	for <drbd-dev@lists.linbit.com>; Mon,  2 Nov 2009 23:42:23 +0100 (CET)
Date: Mon, 2 Nov 2009 23:42:23 +0100
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20091102224223.GE14841@barkeeper1-xen.linbit>
References: <BC2F8964429F14468EA0E6D6CF00E8C9390D66@EXHQ.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BC2F8964429F14468EA0E6D6CF00E8C9390D66@EXHQ.corp.stratus.com>
Subject: Re: [Drbd-dev] Primary/Diskless node cannot reconnect
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Sun, Nov 01, 2009 at 05:25:44PM -0500, Graham, Simon wrote:
> If you are in a situation where one node is Primary/Diskless and the
> other Secondary/UpToDate, DRDB works just fine, redirecting the I/O to
> the secondary node. However, if you then lose the network connection for
> any reasons (say some sort of transient issue), DRBD will not allow the
> connection to be re-established even though nothing has actually
> changed.
> 
> When the connect request comes in, you see this trace message:
> 
>        Can only connect to data with current UUID=XXXXX
> 
> Which is output by receive_uuids in drbd_receiver.c. I understand why
> this check should be made _if_ you actually have a local disk on the
> Primary, but if you are Diskless I think it is not necessary and results
> in unnecessary problems. My proposed fix is to add an explicit test for
> Diskless in the if statement so that it only does the check for current
> UUID if the disk state is > Diskless.
> 
> Proposed patch attached against 8.2.

8.2 is dead.
has been fixed differently in 8.3 already,
where the corresponding code looks like

 if (mdev->state.conn < C_CONNECTED &&
            mdev->state.disk < D_INCONSISTENT &&
            mdev->state.role == R_PRIMARY &&
            (mdev->ed_uuid & ~((u64)1)) != (p_uuid[UI_CURRENT] & ~((u64)1))) {


-- 
: Lars Ellenberg
: LINBIT | Your Way to High Availability
: DRBD/HA support and consulting http://www.linbit.com

DRBD® and LINBIT® are registered trademarks of LINBIT, Austria.
