Return-Path: <lmb@suse.de>
Date: Wed, 26 Jan 2005 17:46:12 +0100
From: Lars Marowsky-Bree <lmb@suse.de>
To: Philipp Reisner <philipp.reisner@linbit.com>
Message-ID: <20050126164612.GH5511@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="YZ5djTAD1cGYuMQK"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [patch] __bio_clone() behaviour
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

With the __bio_clone() bugfix by Jens Axboe (in the recent 2.6.10-ac
kernels or SLES9 SP1) which causes __bio_clone() to copy the bi_io_vec,
it would always try to copy the _maximum_ size, as defined by
bio_src->bi_max_vecs:

inline void __bio_clone(struct bio *bio, struct bio *bio_src)
{
        request_queue_t *q = bdev_get_queue(bio_src->bi_bdev);
        memcpy(bio->bi_io_vec, bio_src->bi_io_vec, bio_src->bi_max_vecs * sizeof(struct bio_vec));
...

drbd however only has space for a single iovec (because it's all
statically allocated right now), and so the memcpy would silently
overwrite memory.

The attached patch 'fixes' this up.

Note that it is a bit ugly but safe, as drbd already asserts that
bi_vcnt == 1 anyway.

FWIW, drbd seems to be the only user of __bio_clone() I could find,
there's no in-tree users, everything goes through bio_clone() otherwise,
which would have dynamically allocated the properly sized structures.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX Products GmbH - A Novell Business


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="drbd-0.7.9-2.diff"

Index: drbd_compat_wrappers.h
===================================================================
--- drbd_compat_wrappers.h	(revision 1736)
+++ drbd_compat_wrappers.h	(working copy)
@@ -538,7 +538,9 @@
 	bio_init(bio); // bio->bi_flags   = 0;
 	bio->bi_io_vec = bvec;
 	bio->bi_max_vecs = 1;
-
+	
+	/* FIXME: __bio_clone() workaround, fix me properly later! */
+	bio_src->bi_max_vecs = 1;
 	__bio_clone(bio,bio_src);
 	bio->bi_bdev    = mdev->backing_bdev;
 	bio->bi_private = mdev;
@@ -559,6 +561,8 @@
 	bio->bi_io_vec = bvec;
 	bio->bi_max_vecs = 1;
 
+	/* FIXME: __bio_clone() workaround, fix me properly later! */
+	bio_src->bi_max_vecs = 1;
 	__bio_clone(bio,bio_src);
 	bio->bi_bdev    = mdev->backing_bdev;
 	bio->bi_private = mdev;

--YZ5djTAD1cGYuMQK--
