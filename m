Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 405D610556B0
	for <drbd-dev@lists.linbit.com>; Thu,  7 May 2015 11:35:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 22614444287
	for <drbd-dev@lists.linbit.com>; Thu,  7 May 2015 11:35:42 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id n41PlrminEZF for <drbd-dev@lists.linbit.com>;
	Thu,  7 May 2015 11:35:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 05D46449119
	for <drbd-dev@lists.linbit.com>; Thu,  7 May 2015 11:35:42 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 0VPBGi23qnEN for <drbd-dev@lists.linbit.com>;
	Thu,  7 May 2015 11:35:41 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id D1AB6444287
	for <drbd-dev@lists.linbit.com>; Thu,  7 May 2015 11:35:41 +0200 (CEST)
Resent-Message-ID: <20150507093541.GV18767@soda.linbit>
Message-ID: <5549AFD4.5020803@kernel.org>
Date: Tue, 05 May 2015 23:08:20 -0700
From: Ming Lin <mlin@kernel.org>
MIME-Version: 1.0
To: Christoph Hellwig <hch@lst.de>
References: <1430203717-13307-1-git-send-email-mlin@kernel.org>
	<1430203717-13307-2-git-send-email-mlin@kernel.org>
	<20150428114320.GA9790@lst.de>
In-Reply-To: <20150428114320.GA9790@lst.de>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Mike Snitzer <snitzer@redhat.com>, Neil Brown <neilb@suse.de>,
	Ming Lei <ming.lei@canonical.com>,
	Keith Busch <keith.busch@intel.com>, dm-devel@redhat.com,
	Joshua Morris <josh.h.morris@us.ibm.com>, Alasdair Kergon <agk@redhat.com>,
	Lars Ellenberg <drbd-dev@lists.linbit.com>,
	Philip Kelleher <pjk1939@linux.vnet.ibm.com>,
	Christoph Hellwig <hch@infradead.org>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Nitin Gupta <ngupta@vflare.org>, Oleg Drokin <oleg.drokin@intel.com>,
	Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>,
	Andreas Dilger <andreas.dilger@intel.com>,
	Geoff Levand <geoff@infradead.org>,
	Jiri Kosina <jkosina@suse.cz>, linux-kernel@vger.kernel.org,
	Jim Paris <jim@jtan.com>, Minchan Kim <minchan@kernel.org>,
	drbd-user@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 01/10] block: make generic_make_request
 handle arbitrarily sized bios
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

On 04/28/2015 04:43 AM, Christoph Hellwig wrote:
> This seems to lack support for QUEUE_FLAG_SG_GAPS to work around
> the retarded PPR format in the NVMe driver.  I'm actually not
> sure we have a way to reproduce them for BLOCK_PC requests, but I think
> we should make sure to properly handle them.

How about below incremental patch?

 block/bio.c       | 8 --------
 block/blk-merge.c | 8 ++++++++
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index ae31cdb..3f6bd9a 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -743,14 +743,6 @@ int bio_add_pc_page(struct request_queue *q, struct bio *bio, struct page
 			bio->bi_iter.bi_size += len;
 			goto done;
 		}
-
-		/*
-		 * If the queue doesn't support SG gaps and adding this
-		 * offset would create a gap, disallow it.
-		 */
-		if (q->queue_flags & (1 << QUEUE_FLAG_SG_GAPS) &&
-		    bvec_gap_to_prev(prev, offset))
-			return 0;
 	}
 
 	if (bio->bi_vcnt >= bio->bi_max_vecs)
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 9d565a0..32f6d6c 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -78,6 +78,14 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
 		if (sectors > queue_max_sectors(q))
 			goto split;
 
+		/*
+		 * If the queue doesn't support SG gaps and adding this
+		 * offset would create a gap, disallow it.
+		 */
+		if (q->queue_flags & (1 << QUEUE_FLAG_SG_GAPS) &&
+		    prev && bvec_gap_to_prev(&bvprv, bv.bv_offset))
+			goto split;
+
 		if (prev && blk_queue_cluster(q)) {
 			if (seg_size + bv.bv_len > queue_max_segment_size(q))
 				goto new_segment;

