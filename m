Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id AE0E41058DE2
	for <drbd-dev@lists.linbit.com>; Mon, 15 Nov 2010 18:03:13 +0100 (CET)
Date: Mon, 15 Nov 2010 18:03:13 +0100
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20101115170313.GE20084@barkeeper1-xen.linbit>
References: <20101115145304.121957du5vfxdv0g@groupware.intern.b1-systems.de>
	<20101115142144.GA20084@barkeeper1-xen.linbit>
	<20101115155546.15091v5tmmvzj75e@groupware.intern.b1-systems.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20101115155546.15091v5tmmvzj75e@groupware.intern.b1-systems.de>
Subject: Re: [Drbd-dev] drbd.ocf Split-Brain detection patch
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Mon, Nov 15, 2010 at 03:55:46PM +0100, Uwe Grawert wrote:
> 
> Zitat von Lars Ellenberg <lars.ellenberg@linbit.com>:
> 
> >>--- /usr/lib/ocf/resource.d/linbit/drbd	2010-10-28 14:58:05.000000000 +0200
> >>+++ drbd.split-brain.patch	2010-11-15 14:28:46.000000000 +0100
> >>@@ -405,6 +405,9 @@
> >> 	case "${DRBD_ROLE_LOCAL}" in
> >> 	Primary)
> >> 		rc=$OCF_RUNNING_MASTER
> >>+		# This Node is Primary but StandAlone, there must be a Split-Brain
> >>+		[[ $OCF_RESKEY_CRM_meta_master_max = 2 && $DRBD_CSTATE =
> >>"StandAlone" ]] \
> >>+		&& rc=$OCF_ERR_CONFIGURED
> >
> >If only it was so easy.  It it not.
> >There are other ways to end up in StandAlone.
> 
> Ok. Meaning there is no way to determine a Split-Brain at a central
> point like this? This one is off course what I experienced while
> setting up a cluster.

Not really, no.
Maybe you can use your "split-brain" notification handler to do it?


-- 
: Lars Ellenberg
: LINBIT | Your Way to High Availability
: DRBD/HA support and consulting http://www.linbit.com

DRBD® and LINBIT® are registered trademarks of LINBIT, Austria.
