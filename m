Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 814F0101380C
	for <drbd-dev@lists.linbit.com>; Fri, 19 Jun 2009 18:01:06 +0200 (CEST)
Date: Fri, 19 Jun 2009 18:01:06 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20090619160106.GG9526@soda.linbit>
References: <4A3BA30F.70406@grad.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4A3BA30F.70406@grad.hr>
Subject: Re: [Drbd-dev] Compatibility with 2.6.30 and current git
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Fri, Jun 19, 2009 at 04:39:11PM +0200, Ante Karamatić wrote:
> Hi
> 
> I've mentioned this during Ubuntu 8.10 time frame, but nothing much has
> changed since then.
> 
> Looking at linux/drbd.h, there's this part:
> 
> #ifndef CN_IDX_DRBD
> # define CN_IDX_DRBD                    0x4
> /* Ubuntu "intrepid ibex" release defined CN_IDX_DRBD as 0x6 */
> #endif
> 
> Ubuntu defined CN_IDX_DRBD as 0x6 cause 0x4 was taken by vesa
> framebuffer device. Linux kernels 2.6.30 and latest git has both 0x4 and
> 0x6 taken by other modules (include/linux/connector.h):
> 
> #define CN_IDX_V86D			0x4
> 
> #define CN_DST_IDX			0x6
> 
> These IDs should be unique (hence the name 'Process Events connector
> unique ids'). If you want 2.6.30 compatibility (at least), change it to
> 0x7. That one is free. But keep an eye on it for 2.6.31. So, something
> like this:

NOnono.
the userland needs to be backwards compatible,
and must be able to find the connector index used by the kernel module.

there is now a module parameter cn_idx,
which shows up in /sys/modules/drbd/parameters/cn_idx,
so the userland finds it.
you can set it to whatever you want.
if not set, it defaults to what old drbd userland expected.
and when drbd tries to register that connector index,
and it fails, it will simply add 6977, and try again.
it tries 10 times.

> In current state, if vesa frame buffer module is loaded, drbd won't
> work.  Module will load, but userspace tools won't be able to connect
> to it - they'll be connecting to frame buffer :)

get your facts straight.

-- 
: Lars Ellenberg
: LINBIT | Your Way to High Availability
: DRBD/HA support and consulting http://www.linbit.com

DRBD® and LINBIT® are registered trademarks of LINBIT, Austria.
