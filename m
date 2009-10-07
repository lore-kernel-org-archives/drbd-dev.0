Return-Path: <axboe@kernel.dk>
Received: from kernel.dk (brick.kernel.dk [93.163.65.50])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id C61611062308
	for <drbd-dev@lists.linbit.com>; Wed,  7 Oct 2009 19:26:27 +0200 (CEST)
Date: Wed, 7 Oct 2009 19:26:26 +0200
From: Jens Axboe <jens.axboe@oracle.com>
To: Randy Dunlap <randy.dunlap@oracle.com>
Message-ID: <20091007172626.GG8703@kernel.dk>
References: <20091007173517.abfcfa2a.sfr@canb.auug.org.au>
	<20091007102153.1a19119b.randy.dunlap@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20091007102153.1a19119b.randy.dunlap@oracle.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH -next] drbd: needs __ratelimit()
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Wed, Oct 07 2009, Randy Dunlap wrote:
> From: Randy Dunlap <randy.dunlap@oracle.com>
> 
> drbd_int.h uses __ratelimit(), so it needs to #include ratelimit.h:
> 
> drivers/block/drbd/drbd_int.h:1765: error: implicit declaration of function '__ratelimit'

Thanks Randy, applied.

-- 
Jens Axboe

