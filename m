Return-Path: <hch@lst.de>
Date: Wed, 20 May 2015 14:44:18 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lin <mlin@kernel.org>
Message-ID: <20150520124418.GA15594@lst.de>
References: <1430980461-5235-1-git-send-email-mlin@kernel.org>
	<1430980461-5235-2-git-send-email-mlin@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1430980461-5235-2-git-send-email-mlin@kernel.org>
Cc: Mike Snitzer <snitzer@redhat.com>, Neil Brown <neilb@suse.de>,
	Ming Lei <ming.lei@canonical.com>, dm-devel@redhat.com,
	Christoph Hellwig <hch@lst.de>, Alasdair Kergon <agk@redhat.com>,
	Lars Ellenberg <drbd-dev@lists.linbit.com>,
	Philip Kelleher <pjk1939@linux.vnet.ibm.com>,
	Joshua Morris <josh.h.morris@us.ibm.com>,
	Christoph Hellwig <hch@infradead.org>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Nitin Gupta <ngupta@vflare.org>, Oleg Drokin <oleg.drokin@intel.com>,
	Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>,
	Andreas Dilger <andreas.dilger@intel.com>,
	Geoff Levand <geoff@infradead.org>,
	Jiri Kosina <jkosina@suse.cz>, linux-kernel@vger.kernel.org,
	Jim Paris <jim@jtan.com>, Minchan Kim <minchan@kernel.org>,
	Dongsu Park <dpark@posteo.net>, drbd-user@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH v3 01/11] block: make generic_make_request
	handle	arbitrarily sized bios
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

This needs the patch below for the blk-mq case with multiple queues.

Also I wonder why we really want to push this below ->make_request.
Moving it just outside ->make_request would make the callchain more
obvious and avoid the recursion into the driver.


diff --git a/block/blk-mq.c b/block/blk-mq.c
index e9bbc04..e7fae76 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1256,6 +1256,8 @@ static void blk_mq_make_request(struct request_queue *q, struct bio *bio)
 		return;
 	}
 
+	blk_queue_split(q, &bio, q->bio_split);
+
 	rq = blk_mq_map_request(q, bio, &data);
 	if (unlikely(!rq))
 		return;
