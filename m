Return-Path: <Lars.Ellenberg@linbit.com>
Received: from minna.local (dialin-145-254-065-155.arcor-ip.net
	[145.254.65.155])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 43462142F3
	for <drbd-dev@lists.linbit.com>; Tue, 19 Oct 2004 23:01:52 +0200 (CEST)
Date: Tue, 19 Oct 2004 23:02:00 +0200
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] drbd kernel module makefile
Message-ID: <KnjlR5jIsWQ08DQdxQvrA+4=lge@web.de>
References: <026001c4b5e8$f47e6220$532210ac@morpheus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <026001c4b5e8$f47e6220$532210ac@morpheus>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

/ 2004-10-19 16:36:00 +0200
\ Philipp Hug:
> Is there a reason, why the drbd module Makefile calls "make module" from 
> the kernel-source instead of just compiling itself with the header files 
> from $(KDIR)/include?

because we want to be able to support as many kernel flavours and archs
as possible.  this is the kernel way to do build external modules, see
Documentation/kbuild/modules.txt.

> this makes it quiet inconvient to use it with module-assistant (debian 
> tool, to build kernel-modules from their source packages) because you need 
> to have the complete source with correct config installed instead of just 
> using the kernel-header modules...

drbd is just happy with (preconfigured) kernel-headers, or at least it
should be. to be able to build external modules against preconfigured
kernel-headers, they should of course include the Makefile and
neccessary scripts, with more recent 2.6 kernels even some more stuff.
but they do, typically, because if they don't, they are pointless.
[this works pretty well for me on a SuSE box]

> in debian you can just do the following:
> m-a install cloop

well, provided you have your (preconfigured) kernel headers in
$KERNEL_INCLUDES,
you with DRBD you can just do
make KDIR=$KERNEL_INCLUDES -C drbd
and it should just work.

I'm sure you can figure out how you do this the debian way.

	lge
