Return-Path: <lmb@suse.de>
Date: Tue, 25 Jan 2005 11:05:16 +0100
From: Lars Marowsky-Bree <lmb@suse.de>
To: Philipp Reisner <philipp.reisner@linbit.com>
Subject: Re: [Drbd-dev] [fix] drbd uses wrong API for struct bio
Message-ID: <20050125100516.GC5638@marowsky-bree.de>
References: <20050123161633.GH24350@marowsky-bree.de>
	<200501251026.11669.philipp.reisner@linbit.com>
	<20050125093933.GD2751@suse.de>
	<200501251058.15982.philipp.reisner@linbit.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="5UGlQXeG3ziZS81+"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200501251058.15982.philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>


--5UGlQXeG3ziZS81+
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On 2005-01-25T10:58:13, Philipp Reisner <philipp.reisner@linbit.com> wrote:

> When are you taking the code for SuSE ?

Today. We're in a bit of a hurry because we screwed up and shipped the
oopsing drbd in SP1 ;-)

> I guess it would make sense to tag drbd-0.7.8 at that moment, so
> that this time SuSE and the rest of the world have the same
> "drbd-0.7.8" :)

Sure. Attached is the minimal cleanup Jens suggested relative to svn
1732.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX Products GmbH - A Novell Business


--5UGlQXeG3ziZS81+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=drbd-50103

Index: drbd/drbd_compat_wrappers.h
===================================================================
--- drbd/drbd_compat_wrappers.h	(revision 1732)
+++ drbd/drbd_compat_wrappers.h	(working copy)
@@ -471,8 +471,7 @@
 	bio->bi_destructor = NULL;
 	vec->bv_page = page;
 	bio->bi_size = vec->bv_len = PAGE_SIZE;
-	bio->bi_max_vecs = bio->bi_vcnt = 
-	bio->bi_phys_segments = bio->bi_hw_segments = 1;
+	bio->bi_max_vecs = bio->bi_vcnt = 1;
 	vec->bv_offset = 0;
 
 	e->block_id = ID_VACANT;
@@ -504,8 +503,7 @@
 	bio->bi_destructor = NULL;
 	vec->bv_page = page;
 	vec->bv_offset = 0;
-	bio->bi_max_vecs = bio->bi_vcnt = 
-	bio->bi_phys_segments = bio->bi_hw_segments = 1;
+	bio->bi_max_vecs = bio->bi_vcnt = 1;
 
 	bio->bi_bdev = mdev->backing_bdev;
 	bio->bi_private = mdev;

--5UGlQXeG3ziZS81+--
