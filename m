Return-Path: <BATV+c09a500acd4738b53c4f+4964+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [65.50.211.133])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id B16761057FBB
	for <drbd-dev@lists.linbit.com>; Mon, 27 Mar 2017 11:12:44 +0200 (CEST)
Date: Mon, 27 Mar 2017 02:12:39 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Mike Snitzer <snitzer@redhat.com>
Message-ID: <20170327091239.GC6879@infradead.org>
References: <20170323143341.31549-1-hch@lst.de>
	<20170323143341.31549-7-hch@lst.de>
	<20170323145522.GB17127@redhat.com> <20170323145651.GA31771@lst.de>
	<20170323151037.GC17127@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170323151037.GC17127@redhat.com>
Cc: axboe@kernel.dk, linux-raid@vger.kernel.org, linux-scsi@vger.kernel.org,
	martin.petersen@oracle.com, philipp.reisner@linbit.com,
	linux-block@vger.kernel.org, dm-devel@redhat.com,
	lars.ellenberg@linbit.com, shli@kernel.org,
	Christoph Hellwig <hch@lst.de>, agk@redhat.com, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 06/23] dm-kcopyd: switch to use
	REQ_OP_WRITE_ZEROES
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

On Thu, Mar 23, 2017 at 11:10:38AM -0400, Mike Snitzer wrote:
> Not sure why you've split out the dm-kcopyd patch, likely best to just
> fold it into the previous dm support patch.

The dm-kcopyd patch switches to using WRITE_ZEROES instead of write
same for dm as user of these interfaces.  The one before just adds
WRITE_ZEROES support to dm.

