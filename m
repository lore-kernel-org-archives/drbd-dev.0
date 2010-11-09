Return-Path: <BATV+59881b75a86bc7c2a8cd+2634+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [18.85.46.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id D6FA810590A1
	for <drbd-dev@lists.linbit.com>; Tue,  9 Nov 2010 11:37:42 +0100 (CET)
Date: Tue, 9 Nov 2010 05:36:20 -0500
From: Christoph Hellwig <hch@infradead.org>
To: Tejun Heo <tj@kernel.org>
Message-ID: <20101109103620.GA18355@infradead.org>
References: <1288628129-12811-1-git-send-email-tj@kernel.org>
	<1288628129-12811-5-git-send-email-tj@kernel.org>
	<20101103161059.GA13621@infradead.org>
	<4CD9239E.2080209@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4CD9239E.2080209@kernel.org>
Cc: jack@suse.cz, leochen@broadcom.com, neilb@suse.de,
	heiko.carstens@de.ibm.com, dm-devel@redhat.com,
	adilger.kernel@dilger.ca, konishi.ryusuke@lab.ntt.co.jp,
	shaggy@linux.vnet.ibm.com, drbd-dev@lists.linbit.com,
	joel.becker@oracle.com, Christoph Hellwig <hch@infradead.org>,
	aelder@sgi.com, mfasheh@suse.com, joern@logfs.org,
	reiserfs-devel@vger.kernel.org, viro@zeniv.linux.org.uk,
	swhiteho@redhat.com, chris.mason@oracle.com, axboe@kernel.dk,
	tytso@mit.edu, sbranden@broadcom.com, petero2@telia.com,
	linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com,
	akpm@linux-foundation.org
Subject: Re: [Drbd-dev] [PATCH 4/5] block: make blkdev_get/put() handle
	exclusive access
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Tue, Nov 09, 2010 at 11:34:06AM +0100, Tejun Heo wrote:
> So, after the above points, I decided to keep @mode.  It is a bit
> awkward but the other way didn't seem too hip either.  Any better
> ideas?

Let's keep it for now and revisit it later.

> That will make the number of functions multiplied by two -
> blkdev_get_by_path_stacked() and blkdev_get_by_dev_stacked().  The
> symlinking for stacked drivers is an oddball feature which is and will
> be only used by md and dm.  So, I think it's better to keep it
> separate and oddball.

Oh well.  I still don't like it, but let keeps it simple to make
progress for now.

