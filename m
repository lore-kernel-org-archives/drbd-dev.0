Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id E35B710620AB
	for <drbd-dev@lists.linbit.com>; Fri, 16 Oct 2009 13:20:01 +0200 (CEST)
Date: Fri, 16 Oct 2009 13:20:01 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20091016112001.GB8041@barkeeper1-xen.linbit>
References: <20091016103845.GA15975@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20091016103845.GA15975@suse.de>
Subject: Re: [Drbd-dev] SCTP support for drbd
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Fri, Oct 16, 2009 at 12:38:45PM +0200, Lars Marowsky-Bree wrote:
> Hi all,
> 
> Florian asked me to post this to the list.
> 
> As you know, OpenAIS/corosync supports, similar to but slightly more
> broken than heartbeat, redundant rings to provide redundant networking.
> 
> On SLE HA 11 GA, we recommended that customers not use this, but instead
> use bonded NICs. This was not just because of the limitations in
> OpenAIS, but also because of the limitations of the services we consider
> essential.
> 
> The DLM, for example, was not able to take automatic advantage of the
> redundant links - SCTP support was a bit flakey then. This is changed
> (the kernel DLM already supports SCTP, and the patch for automatic
> enablement in libdlm is bound to be done in a few days).
> 
> The other service is drbd, which also uses TCP-only right now. It'd be
> nice if it also supported SCTP; it can't be that hard, since the
> in-kernel dlm also supports TCP and SCTP.

Is somewhere on our todo list,
but may have to wait for DRBD 9.
Feature sponsoring accepted ;)

> As a further consideration, I'd like to point out how cool it'd be if
> drbd could also, like the DLM, default to gathering its network
> information from the OpenAIS/corosync layer (perhaps via a
> drbd_controld); the peers could auto-detect each other based on the
> UUID/label of the drbd instance being activated.  It'd reduce the need
> to duplicate information between configuration files for the most common
> scenarios.
>
> (This would also be an extremely convenient and even neater way for
> floating peers.)

-EPONIES

proof of concept implementations may be reviewed, though ;)

-- 
: Lars Ellenberg
: LINBIT | Your Way to High Availability
: DRBD/HA support and consulting http://www.linbit.com

DRBD® and LINBIT® are registered trademarks of LINBIT, Austria.
