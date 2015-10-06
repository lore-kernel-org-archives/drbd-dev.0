Return-Path: <hch@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id B8D9610518B6
	for <drbd-dev@lists.linbit.com>; Tue,  6 Oct 2015 10:44:44 +0200 (CEST)
Date: Tue, 6 Oct 2015 10:38:05 +0200
From: Christoph Hellwig <hch@lst.de>
To: Arnd Bergmann <arnd@arndb.de>
Message-ID: <20151006083805.GA28030@lst.de>
References: <1440746842-19029-1-git-send-email-hch@lst.de>
	<22516156.tfGZvl13aG@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22516156.tfGZvl13aG@wuerfel>
Cc: linux-arch@vger.kernel.org, herbert@gondor.apana.org.au,
	linux-kernel@vger.kernel.org, oded.gabbay@amd.com,
	dhowells@redhat.com, linux-gpio@vger.kernel.org,
	eli@mellanox.com, james_p_freyensee@linux.intel.com,
	drbd-dev@lists.linbit.com, Christoph Hellwig <hch@lst.de>,
	mitake@dcl.info.waseda.ac.jp
Subject: Re: [Drbd-dev] fix various asm-generic abuses
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Fri, Aug 28, 2015 at 09:16:51PM +0200, Arnd Bergmann wrote:
> with asm-generic patches is to have changes go through the tree of
> whichever maintainer needs the changes for their own work with my
> Ack, but I guess in this case you don't actually have other patches
> depending on them, right?
> 
> If driver maintainers want to pick individual patches from this series,
> please add my
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> otherwise let me know if I should put them into my asm-generic git
> tree (which is currently empty, but part of linux-next).

Seems like none of them made it into 4.3-rc - was that intentional or an
oversight?
