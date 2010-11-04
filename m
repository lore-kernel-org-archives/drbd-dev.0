Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 986C3105960C
	for <drbd-dev@lists.linbit.com>; Thu,  4 Nov 2010 16:39:08 +0100 (CET)
Resent-Message-ID: <20101104153908.GH14148@barkeeper1-xen.linbit>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 810141059382
	for <drbd-dev@lists.linbit.com>; Thu,  4 Nov 2010 16:05:28 +0100 (CET)
Date: Thu, 4 Nov 2010 11:04:00 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: device-mapper development <dm-devel@redhat.com>
Message-ID: <20101104150400.GA32504@redhat.com>
References: <1288628129-12811-1-git-send-email-tj@kernel.org>
	<1288628129-12811-5-git-send-email-tj@kernel.org>
	<20101103161059.GA13621@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20101103161059.GA13621@infradead.org>
Cc: jack@suse.cz, leochen@broadcom.com, heiko.carstens@de.ibm.com,
	adilger.kernel@dilger.ca, konishi.ryusuke@lab.ntt.co.jp,
	shaggy@linux.vnet.ibm.com, drbd-dev@lists.linbit.com,
	joel.becker@oracle.com, hch@infradead.org, aelder@sgi.com,
	mfasheh@suse.com, joern@logfs.org,
	reiserfs-devel@vger.kernel.org, schwidefsky@de.ibm.com,
	viro@zeniv.linux.org.uk, swhiteho@redhat.com,
	chris.mason@oracle.com, axboe@kernel.dk, tytso@mit.edu,
	sbranden@broadcom.com, petero2@telia.com,
	linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
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

On Wed, Nov 03 2010 at 12:10pm -0400,
Christoph Hellwig <hch@infradead.org> wrote:

> On Mon, Nov 01, 2010 at 05:15:28PM +0100, Tejun Heo wrote:
> > * blkdev_get() is extended to include exclusive access management.
> >   @holder argument is added and, if is @FMODE_EXCL specified, it will
> >   gain exclusive access atomically w.r.t. other exclusive accesses.
> > 
> > * blkdev_put() is similarly extended.  It now takes @mode argument and
> >   if @FMODE_EXCL is set, it releases an exclusive access.  Also, when
> >   the last exclusive claim is released, the holder/slave symlinks are
> >   removed automatically.
> 
> Could we get rid of FMODE_EXCL and just make a non-NULL holder field
> mean to open it exlusively (and pass a holder to the blkdev_put to
> release it)?

I agree that the need for a FMODE_EXCL flag is awkward.  Christoph's
proposed change should clean things up nicely.

Other than that, for the DM bits:

Acked-by: Mike Snitzer <snitzer@redhat.com>
