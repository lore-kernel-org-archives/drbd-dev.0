Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id D73BE106275E
	for <drbd-dev@lists.linbit.com>; Wed, 16 Sep 2009 08:06:07 +0200 (CEST)
Resent-Message-ID: <20090916060607.GA13782@barkeeper1-xen.linbit>
Received: from bombadil.infradead.org (bombadil.infradead.org [18.85.46.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id BF6A5106275F
	for <drbd-dev@lists.linbit.com>; Wed, 16 Sep 2009 01:42:17 +0200 (CEST)
Date: Tue, 15 Sep 2009 19:19:31 -0400
From: Christoph Hellwig <hch@infradead.org>
To: Philipp Reisner <philipp.reisner@linbit.com>
Message-ID: <20090915231931.GB7636@infradead.org>
References: <200909151645.14256.philipp.reisner@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200909151645.14256.philipp.reisner@linbit.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [GIT PULL] DRBD for 2.6.32
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Tue, Sep 15, 2009 at 04:45:13PM +0200, Philipp Reisner wrote:
> Hi Linus,
> 
> Please pull
> git://git.drbd.org/linux-2.6-drbd.git drbd
> 
> DRBD is a shared-nothing, replicated block device. It is designed to
> serve as a building block for high availability clusters and
> in this context, is a "drop-in" replacement for shared storage.
> 
> It has been discussed and reviewed on the list since March,
> and Andrew has asked us to send a pull request for 2.6.32-rc1.

The last thing we need is another bloody raid-reimplementation, coupled
with a propritary on the wire protocol.  NACK as far as I am concerned.

