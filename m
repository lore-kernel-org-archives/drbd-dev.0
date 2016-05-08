Return-Path: <BATV+1e7556648fcfd1aa67a6+4641+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.9])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 71BF91056443
	for <drbd-dev@lists.linbit.com>; Sun,  8 May 2016 11:45:36 +0200 (CEST)
Date: Sun, 8 May 2016 02:27:58 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <ming.lei@canonical.com>
Message-ID: <20160508092758.GA29621@infradead.org>
References: <1460928615-20894-1-git-send-email-ming.lei@canonical.com>
	<CACVXFVOw2dnO0tw5n2dPXUQh_tkGLCo742AXpJ8mMQG6LQZVUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACVXFVOw2dnO0tw5n2dPXUQh_tkGLCo742AXpJ8mMQG6LQZVUA@mail.gmail.com>
Cc: linux-block@vger.kernel.org, Jan Kara <jack@suse.cz>,
	Mike Snitzer <snitzer@redhat.com>, Christoph Hellwig <hch@infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"open list:XFS FILESYSTEM" <xfs@oss.sgi.com>,
	Jens Axboe <axboe@fb.com>, Al Viro <viro@zeniv.linux.org.uk>,
	Shaohua Li <shli@fb.com>, Tejun Heo <tj@kernel.org>,
	Keith Busch <keith.busch@intel.com>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	"open list:DRBD DRIVER" <drbd-dev@lists.linbit.com>
Subject: Re: [Drbd-dev] [PATCH v5 0/8] block: prepare for multipage bvecs
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

On Tue, May 03, 2016 at 09:03:58AM +0800, Ming Lei wrote:
> Any possibility to make v5 into v4.7 so that we can move on about
> multipage bvecs?
> 
> BTW, even though not considering mp bvecs, this patchset is still a
> good cleanup.

Agreed.  I'm fine with the series and it looks harmless enough for
4.7.
