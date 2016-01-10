Return-Path: <BATV+aab932a23b7e96aeb608+4522+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.9])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 7E2411056317
	for <drbd-dev@lists.linbit.com>; Sun, 10 Jan 2016 08:16:08 +0100 (CET)
Date: Sat, 9 Jan 2016 23:15:58 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Mike Christie <michaelc@cs.wisc.edu>
Message-ID: <20160110071558.GB12831@infradead.org>
References: <1452027218-32303-1-git-send-email-mchristi@redhat.com>
	<1452027218-32303-3-git-send-email-mchristi@redhat.com>
	<20160109133716.GB26660@infradead.org>
	<5691AC2E.2050403@cs.wisc.edu> <5691B208.9060001@cs.wisc.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5691B208.9060001@cs.wisc.edu>
Cc: linux-raid@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	target-devel@vger.kernel.org, linux-scsi@vger.kernel.org,
	konrad.wilk@oracle.com, linux-kernel@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-bcache@vger.kernel.org,
	xfs@oss.sgi.com, linux-block@vger.kernel.org,
	device-mapper development <dm-devel@redhat.com>,
	mchristi@redhat.com, linux-mtd@lists.infradead.org,
	osd-dev@open-osd.org, linux-fsdevel@vger.kernel.org,
	lars.ellenberg@linbit.com, philipp.reisner@linbit.com,
	drbd-dev@lists.linbit.com, ocfs2-devel@oss.oracle.com,
	linux-btrfs@vger.kernel.org
Subject: Re: [Drbd-dev] [dm-devel] [PATCH 02/35] block: add REQ_OP
 definitions and bi_op/op fields
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

On Sat, Jan 09, 2016 at 07:21:12PM -0600, Mike Christie wrote:
> Oh yeah, to answer the second part of your question, REQ_OP_FLUSH is
> only a flush operation like what request_fn drivers wanted.

And that's the odd part that trips me up.

> 
> REQ_PREFLUSH can be set with a REQ_OP_WRITE bio when filesystems want to
> do both.
> 
> There is then the case where filesystems and blkdev_issue_flush could
> just want to request a flush. I left them as a REQ_PREFLUSH with
> REQ_OP_WRITE set, so there would be a single code path.

But the pure flush without data transfer case is pretty different,
so it seems rather odd to handle it like that.  But I suspec we could
just fix that up later.
