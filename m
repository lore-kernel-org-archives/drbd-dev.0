Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id CC8A11059602
	for <drbd-dev@lists.linbit.com>; Thu,  4 Nov 2010 16:39:04 +0100 (CET)
Resent-Message-ID: <20101104153904.GG14148@barkeeper1-xen.linbit>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 6204B105960C
	for <drbd-dev@lists.linbit.com>; Thu,  4 Nov 2010 15:41:15 +0100 (CET)
Date: Wed, 3 Nov 2010 16:06:58 +0100
From: Jan Kara <jack@suse.cz>
To: Tejun Heo <tj@kernel.org>
Message-ID: <20101103150658.GA5627@quack.suse.cz>
References: <1288628129-12811-1-git-send-email-tj@kernel.org>
	<1288628129-12811-5-git-send-email-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1288628129-12811-5-git-send-email-tj@kernel.org>
Cc: jack@suse.cz, leochen@broadcom.com, neilb@suse.de,
	heiko.carstens@de.ibm.com, dm-devel@redhat.com,
	adilger.kernel@dilger.ca, konishi.ryusuke@lab.ntt.co.jp,
	shaggy@linux.vnet.ibm.com, drbd-dev@lists.linbit.com,
	joel.becker@oracle.com, hch@infradead.org, aelder@sgi.com,
	mfasheh@suse.com, joern@logfs.org,
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

On Mon 01-11-10 17:15:28, Tejun Heo wrote:
> Over time, block layer has accumulated a set of APIs dealing with bdev
> open, close, claim and release.
> 
> * blkdev_get/put() are the primary open and close functions.
> 
> * bd_claim/release() deal with exclusive open.
> 
> * open/close_bdev_exclusive() are combination of open and claim and
>   the other way around, respectively.
> 
> * bd_link/unlink_disk_holder() to create and remove holder/slave
>   symlinks.
> 
> * open_by_devnum() wraps bdget() + blkdev_get().
> 
> The interface is a bit confusing and the decoupling of open and claim
> makes it impossible to properly guarantee exclusive access as
> in-kernel open + claim sequence can disturb the existing exclusive
> open even before the block layer knows the current open if for another
> exclusive access.  Reorganize the interface such that,
...
  The patch looks OK to me as far as ext3, ext4, and reiserfs are
concerned. One thing I wondered about when I looked at it - does someone
use the 'mode' argument of the blkdev_put() function (well, apart from the
exclusive flag)? Because I've looked at a few random disk ->release()
functions and none of them used it...

								Honza
-- 
Jan Kara <jack@suse.cz>
SUSE Labs, CR
