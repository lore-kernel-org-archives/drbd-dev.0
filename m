Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id EE3C21019A5D
	for <drbd-dev@lists.linbit.com>; Mon, 27 Jul 2009 13:19:58 +0200 (CEST)
Date: Mon, 27 Jul 2009 13:19:58 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20090727111958.GB8046@barkeeper1-xen.linbit>
References: <1248618960-3269-1-git-send-email-iustin@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1248618960-3269-1-git-send-email-iustin@google.com>
Subject: Re: [Drbd-dev] [PATCH] drbdmeta: also show negotiated size
	in	sectors
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Sun, Jul 26, 2009 at 04:36:00PM +0200, Iustin Pop wrote:
> Currently drbdmeta shows the last agreed size in "nice" units, e.g.
> 100GB. But this is imprecise, as the shifting of cfg->md.la_sect loses
> the low-order bits.
> 
> This small patch adds a new line to the output of drbdmeta that shows
> the exact negotiated size in sectors (for both new and initialized
> devices), such that the output of drbdmeta can be parsed.
> ---
>  This is against drbd 8.3 but should apply (and I would be grateful if this is
>  applied) to 8.0 too.

May I ask what the use case is?

-- 
: Lars Ellenberg
: LINBIT | Your Way to High Availability
: DRBD/HA support and consulting http://www.linbit.com

DRBD® and LINBIT® are registered trademarks of LINBIT, Austria.
