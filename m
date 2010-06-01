Return-Path: <BATV+7118efa77cc3b6051839+2473+infradead.org+hch@bombadil.srs.infradead.org>
Date: Tue, 1 Jun 2010 04:32:44 -0400
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <jaxboe@fusionio.com>
Message-ID: <20100601083244.GA2496@infradead.org>
References: <20100601141324.edf41f7f.sfr@canb.auug.org.au>
	<20100601081823.GA29991@infradead.org>
	<20100601082246.GA3564@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100601082246.GA3564@kernel.dk>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Philipp Reisner <philipp.reisner@linbit.com>, linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	linux-next@vger.kernel.org, Julia Lawall <julia@diku.dk>,
	Al Viro <viro@zeniv.linux.org.uk>, drbd-dev@lists.linbit.com
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

Talking about the block tree: can we please get the two writeback
reverts in?  -rc1 is copletly unsuable under heavy I/O loads as it
stands.
