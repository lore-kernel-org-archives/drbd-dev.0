Return-Path: <BATV+d7add8a7bef99f8e6f52+4817+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.9])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id E7CA21056474
	for <drbd-dev@lists.linbit.com>; Mon, 31 Oct 2016 16:54:18 +0100 (CET)
Date: Mon, 31 Oct 2016 08:25:49 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <tom.leiming@gmail.com>
Message-ID: <20161031152549.GA30919@infradead.org>
References: <1477728600-12938-1-git-send-email-tom.leiming@gmail.com>
	<1477728600-12938-4-git-send-email-tom.leiming@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1477728600-12938-4-git-send-email-tom.leiming@gmail.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
	linux-kernel@vger.kernel.org, Philipp Reisner <philipp.reisner@linbit.com>,
	Jens Axboe <axboe@fb.com>, linux-fsdevel@vger.kernel.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	"open list:DRBD DRIVER" <drbd-dev@lists.linbit.com>
Subject: Re: [Drbd-dev] [PATCH 03/60] block: drbd: remove impossible failure
	handling
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

On Sat, Oct 29, 2016 at 04:08:02PM +0800, Ming Lei wrote:
> For a non-cloned bio, bio_add_page() only returns failure when
> the io vec table is full, but in that case, bio->bi_vcnt can't
> be zero at all.
> 
> So remove the impossible failure handling.
> 
> Acked-by: Lars Ellenberg <lars.ellenberg@linbit.com>
> Signed-off-by: Ming Lei <tom.leiming@gmail.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
