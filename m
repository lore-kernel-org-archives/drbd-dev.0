Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 96AFC1483762
	for <drbd-dev@lists.linbit.com>; Tue,  1 Jun 2010 14:07:17 +0200 (CEST)
Resent-Message-ID: <20100601120717.GE26706@soda.linbit>
Date: Tue, 1 Jun 2010 10:36:13 +0200
From: Jens Axboe <jaxboe@fusionio.com>
To: Christoph Hellwig <hch@infradead.org>
Message-ID: <20100601083613.GC3564@kernel.dk>
References: <20100601141324.edf41f7f.sfr@canb.auug.org.au>
	<20100601081823.GA29991@infradead.org>
	<20100601082246.GA3564@kernel.dk>
	<20100601083244.GA2496@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100601083244.GA2496@infradead.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
	Julia Lawall <julia@diku.dk>, Al Viro <viro@zeniv.linux.org.uk>,
	"drbd-dev@linbit.com" <drbd-dev@lists.linbit.com>
Subject: Re: [Drbd-dev] linux-next: manual merge of the drbd tree with
	Linus' tree
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Tue, Jun 01 2010, Christoph Hellwig wrote:
> Talking about the block tree: can we please get the two writeback
> reverts in?  -rc1 is copletly unsuable under heavy I/O loads as it
> stands.

Yes, it'll go out today, it was supposed to land in -rc1 :/

-- 
Jens Axboe

