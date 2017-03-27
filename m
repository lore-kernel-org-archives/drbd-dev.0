Return-Path: <BATV+c09a500acd4738b53c4f+4964+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [65.50.211.133])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 19CE51057FBB
	for <drbd-dev@lists.linbit.com>; Mon, 27 Mar 2017 11:11:02 +0200 (CEST)
Date: Mon, 27 Mar 2017 02:10:56 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
	martin.petersen@oracle.com, agk@redhat.com, snitzer@redhat.com,
	shli@kernel.org, philipp.reisner@linbit.com,
	linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
	drbd-dev@lists.linbit.com, dm-devel@redhat.com, linux-raid@vger.kernel.org
Message-ID: <20170327091056.GB6879@infradead.org>
References: <20170323143341.31549-1-hch@lst.de>
	<20170323155410.GD1138@soda.linbit>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170323155410.GD1138@soda.linbit>
Subject: Re: [Drbd-dev] RFC: always use REQ_OP_WRITE_ZEROES for zeroing
	offload
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

It sounds like you don't want to support traditional discard at all,
but only WRITE ZEROES.  So in many ways this series is the right way
forward.  It would be nice if we could do a full blown
REQ_OP_WRITE_ZEROES for dm_think that zeroes out partial blocks,
similar to what hardware that implements WRITE SAME of zeroes
or WRITE ZEROES would do.  I'll see if I could include that in my
series.
