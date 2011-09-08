Return-Path: <sim@netnation.com>
Received: from peace.netnation.com (peace.netnation.com [204.174.223.2])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id F2AE510556C5
	for <drbd-dev@lists.linbit.com>; Thu,  8 Sep 2011 19:44:01 +0200 (CEST)
Date: Thu, 8 Sep 2011 10:43:24 -0700
From: Simon Kirby <sim@hostway.ca>
To: drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
	xfs@oss.sgi.com
Message-ID: <20110908174324.GA8043@hostway.ca>
References: <20110907221505.GC21603@hostway.ca>
	<20110908151305.GJ14243@barkeeper1-xen.linbit>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110908151305.GJ14243@barkeeper1-xen.linbit>
Subject: Re: [Drbd-dev] [3.1-rc4] XFS+DRBD hangs
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Thu, Sep 08, 2011 at 05:13:05PM +0200, Lars Ellenberg wrote:

> Sorry for double posting on drbd-dev, I managed to strip the other lists from Cc.
> 
> > We upgraded from 2.6.36 which seemed to have a page leak (file pages left
> > on the LRU) and so would eventually perform very poorly. 2.6.37 and
> > 2.6.38 seemed to have some unix socket issue that caused heartbeat to
> > wedge. Shall we enable lock debugging or something here?
> 
> That could help us understand that stack trace.
> 
> It looks like cpu 1 blocks in
> 
> > [ 1532.427149]  [<ffffffff8103d512>] ? try_to_wake_up+0xc2/0x270
> > [ 1532.427149]  <<EOE>>  <IRQ>  [<ffffffff8103d6cd>] default_wake_function+0xd/0x10
> 
> Which does not make sense to me at all.

Well, good news, I think.. I believe this may be related to
"PCI: Set PCI-E Max Payload Size on fabric", added by b03e7495a862b02829.
3.1-rc5 is running now with a patch to basically disable those changes,
and has been stable for 12 hours. It usually hung in a few minutes
before.

The XFS peoples say it was very likely not 58d84c4ee0389ddeb86238d5 which
is the only other thing that changed between these versions that seems to
be at all in the hang path.

Also, when the thing hangs, it stops pinging immediately, and with the
PCI-E max payload thing active, the device that raises a bus error is
actually the PCI-E to PCI-X bridge chip used to support the BCM5708 NICs,
so that all seems related.

Simon-
