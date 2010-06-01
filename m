Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id E1B401483779
	for <drbd-dev@lists.linbit.com>; Tue,  1 Jun 2010 14:07:43 +0200 (CEST)
Resent-Message-ID: <20100601120743.GH26706@soda.linbit>
Date: Tue, 1 Jun 2010 12:50:56 +0200
From: Jens Axboe <jaxboe@fusionio.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Message-ID: <20100601105055.GN3564@kernel.dk>
References: <20100601141324.edf41f7f.sfr@canb.auug.org.au>
	<20100601081823.GA29991@infradead.org>
	<20100601182213.479a777e.sfr@canb.auug.org.au>
	<20100601104515.GM3564@kernel.dk>
	<20100601204942.134965e5.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100601204942.134965e5.sfr@canb.auug.org.au>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Christoph Hellwig <hch@infradead.org>,
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

On Tue, Jun 01 2010, Stephen Rothwell wrote:
> HI Jens,
> 
> On Tue, 1 Jun 2010 12:45:15 +0200 Jens Axboe <jaxboe@fusionio.com> wrote:
> >
> > So the pipe patches were the same, the problem was that a fix for a
> > missing pipe_unlock() had gone into mainline and for-linus/for-next
> > weren't synced up to that. I'm guessing you pull drbd before for-next
> > and that is why it showed up there.
> 
> Actually, I merge the drbd tree after the block tree and this fell to the
> drbd tree only because your for-next branch had not been updated (and I
> don't merge your for-linus branch).

Ah I see, then it all adds up.

> > BTW, I would recommend moving for-next from the block tree up before any
> > potential other trees being based off it if that is the case.
> 
> That is already true.

Good!

-- 
Jens Axboe

