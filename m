Return-Path: <tj@kernel.org>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 6CC8010590A1
	for <drbd-dev@lists.linbit.com>; Tue,  9 Nov 2010 11:34:59 +0100 (CET)
Message-ID: <4CD9239E.2080209@kernel.org>
Date: Tue, 09 Nov 2010 11:34:06 +0100
From: Tejun Heo <tj@kernel.org>
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
References: <1288628129-12811-1-git-send-email-tj@kernel.org>
	<1288628129-12811-5-git-send-email-tj@kernel.org>
	<20101103161059.GA13621@infradead.org>
In-Reply-To: <20101103161059.GA13621@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: jack@suse.cz, leochen@broadcom.com, neilb@suse.de,
	heiko.carstens@de.ibm.com, dm-devel@redhat.com,
	adilger.kernel@dilger.ca, konishi.ryusuke@lab.ntt.co.jp,
	shaggy@linux.vnet.ibm.com, drbd-dev@lists.linbit.com,
	joel.becker@oracle.com, aelder@sgi.com, mfasheh@suse.com,
	joern@logfs.org, reiserfs-devel@vger.kernel.org,
	viro@zeniv.linux.org.uk, swhiteho@redhat.com,
	chris.mason@oracle.com, axboe@kernel.dk, tytso@mit.edu,
	sbranden@broadcom.com, petero2@telia.com,
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

Hello,

On 11/03/2010 05:10 PM, Christoph Hellwig wrote:
> On Mon, Nov 01, 2010 at 05:15:28PM +0100, Tejun Heo wrote:
>> * blkdev_get() is extended to include exclusive access management.
>>   @holder argument is added and, if is @FMODE_EXCL specified, it will
>>   gain exclusive access atomically w.r.t. other exclusive accesses.
>>
>> * blkdev_put() is similarly extended.  It now takes @mode argument and
>>   if @FMODE_EXCL is set, it releases an exclusive access.  Also, when
>>   the last exclusive claim is released, the holder/slave symlinks are
>>   removed automatically.
> 
> Could we get rid of FMODE_EXCL and just make a non-NULL holder field
> mean to open it exlusively (and pass a holder to the blkdev_put to
> release it)?

Yeah, I agree it's a bit awkward.  I'd really like to force one way or
the other tho.  ie. if non-NULL holder is gonna be required, I'll add
WARN_ON_ONCE(mode & FMODE_EXCL).  There are several issues to
consider.

* As Jan suggested, @mode in blkdev_put() isn't too useful.  I decided
  to keep it and use FMODE_EXCL for exclusive releases as that it is
  at least useful for something.  If we're gonna add @holder to
  blkdev_put(), it would make more sense to drop @mode.  It's not like
  there's a way to enforce restrictions according to open @mode during
  device access if there are mixed r/w opens.

* Some users don't keep @holder easily accessible until blkdev_put()
  is called, so the conversion will take a bit more effort.  No big
  deal in itself.

* What if @holder on blkdev_put() mismatches the current holder?
  Probably WARN_ON_ONCE() is the only recourse.  At that point, it's a
  bit silly to have to keep @holder around till blkdev_put().  Holders
  and opners counting already provide meaningful warning mechanism
  against spurious or missing exclusive releases.  Maybe we can have
  blkdev_put() and blkdev_put_exclusive()?  Or make it take boolean
  @excl?

So, after the above points, I decided to keep @mode.  It is a bit
awkward but the other way didn't seem too hip either.  Any better
ideas?

>> * bd_link_disk_holder() remains the same but bd_unlink_disk_holder()
>>   is no longer necessary and removed.
> 
> That's a rather asymetric interface.  What about having
> blkdev_get_stacked that require a gendisk as holder and set up the
> links underneath?

That will make the number of functions multiplied by two -
blkdev_get_by_path_stacked() and blkdev_get_by_dev_stacked().  The
symlinking for stacked drivers is an oddball feature which is and will
be only used by md and dm.  So, I think it's better to keep it
separate and oddball.

>> open_bdev_exclusive() and open_by_devnum() can use further cleanup -
>> rename to blkdev_get_by_path() and blkdev_get_by_devt() and drop
>> special features.  Well, let's leave them for another day.
> 
> s/blkdev_get_by_devt/blkdev_get_by_dev/
> 
> And yes, that rename is a good idea and should go in ASAP after this
> patch.

Alright, will do it.

Thanks.

-- 
tejun
