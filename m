Return-Path: <BATV+6a48a0219c47f280597b+4530+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.9])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 206E21028A50
	for <drbd-dev@lists.linbit.com>; Mon, 18 Jan 2016 19:15:55 +0100 (CET)
Date: Mon, 18 Jan 2016 10:15:47 -0800
From: Christoph Hellwig <hch@infradead.org>
To: mchristi@redhat.com
Message-ID: <20160118181547.GA30789@infradead.org>
References: <1452543693-4440-1-git-send-email-mchristi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1452543693-4440-1-git-send-email-mchristi@redhat.com>
Cc: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org, xfs@oss.sgi.com,
	ocfs2-devel@oss.oracle.com, linux-scsi@vger.kernel.org,
	konrad.wilk@oracle.com, linux-kernel@vger.kernel.org,
	philipp.reisner@linbit.com, linux-f2fs-devel@lists.sourceforge.net,
	linux-raid@vger.kernel.org, dm-devel@redhat.com,
	target-devel@vger.kernel.org, linux-mtd@lists.infradead.org,
	osd-dev@open-osd.org, linux-fsdevel@vger.kernel.org,
	lars.ellenberg@linbit.com, linux-ext4@vger.kernel.org,
	linux-btrfs@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 00/35 v3] eparate operations from flags in
 the bio/request structs
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

The whole sries looks fine to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>

There are a few pieces of future work on top of this I'd rather see
sooner than later though:

 - use REQ_OP_FLUSH for all empty flushes, including those at the bio
   level.
 - merge the req->cmd_type values into req->op.  Right now that's
   basically only a new REQ_OP_BLOCK_PC (or better REQ_OP_SCSI while
   we're at it) and a REQ_OP_DRV_PRIV as the last value.
 - drop as many of the crazy defines based on REQ_* in fs.h (e.g.
   (READ_SYNC, WRITE_SYNC, WRITE_ODIRECT, WRITE_FLUSH, WRITE_FUA,
   WRITE_FLUSH_FUA, RW_MASK, RWA_MASK)
