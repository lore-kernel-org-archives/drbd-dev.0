Return-Path: <lmb@suse.de>
Date: Tue, 1 Feb 2005 17:48:20 +0100
From: Lars Marowsky-Bree <lmb@suse.de>
To: drbd-dev@lists.linbit.com
Message-ID: <20050201164820.GL7628@marowsky-bree.de>
References: <20050131111921.EE6F83BE6D@garcon.linbit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050131111921.EE6F83BE6D@garcon.linbit.com>
Subject: [Drbd-dev] Re: [DRBD-cvs] r1743 - in branches/drbd-0.7: . drbd
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On 2005-01-31T12:19:21, svn@svn.drbd.org wrote:

> Modified:
>    branches/drbd-0.7/ChangeLog
>    branches/drbd-0.7/drbd.spec.in
>    branches/drbd-0.7/drbd/drbd_actlog.c
>    branches/drbd-0.7/drbd/drbd_compat_wrappers.h
> Log:
> No longer leak of BIOs.

Good goal, but ...

> Modified: branches/drbd-0.7/drbd/drbd_actlog.c
> ===================================================================
> --- branches/drbd-0.7/drbd/drbd_actlog.c	2005-01-31 09:20:39 UTC (rev 1742)
> +++ branches/drbd-0.7/drbd/drbd_actlog.c	2005-01-31 11:19:19 UTC (rev 1743)
> @@ -68,8 +68,6 @@
>  	struct completion event;
>  	int ok;
>  
> -	bio_get(bio);
> -
>  	bio->bi_bdev = mdev->md_bdev;
>  	bio->bi_sector = sector;
>  	bio_add_page(bio, page, size, 0);

I think this is a bug. If you look at the comments in
linux/include/linux/bio.h, you'll find that this is just how the bio is
supposed to be used:

/*
 * get a reference to a bio, so it won't disappear. the intended use is
 * something like:
 *
 * bio_get(bio);
 * submit_bio(rw, bio);
 * if (bio->bi_flags ...)
 *      do_something
 * bio_put(bio);
 *
 * without the bio_get(), it could potentially complete I/O before submit_bio
 * returns. and then bio would be freed memory when if (bio->bi_flags ...)
 * runs
 */
#define bio_get(bio)    atomic_inc(&(bio)->bi_cnt)

The fix I did was not the right way (removing the bio embedding was much
better), but it also wasn't completely wrong.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX Products GmbH - A Novell Business

