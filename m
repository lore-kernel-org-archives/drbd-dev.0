Return-Path: <BATV+c4519af19bc0c6ddca75+4520+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.9])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 626A91056307
	for <drbd-dev@lists.linbit.com>; Fri,  8 Jan 2016 15:00:02 +0100 (CET)
Date: Fri, 8 Jan 2016 05:32:37 -0800
From: Christoph Hellwig <hch@infradead.org>
To: mchristi@redhat.com
Message-ID: <20160108133237.GA7663@infradead.org>
References: <1452027218-32303-1-git-send-email-mchristi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1452027218-32303-1-git-send-email-mchristi@redhat.com>
Cc: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org, xfs@oss.sgi.com,
	ocfs2-devel@oss.oracle.com, linux-scsi@vger.kernel.org,
	konrad.wilk@oracle.com, linux-kernel@vger.kernel.org,
	philipp.reisner@linbit.com, linux-f2fs-devel@lists.sourceforge.net,
	linux-raid@vger.kernel.org, dm-devel@redhat.com,
	target-devel@vger.kernel.org, linux-mtd@lists.infradead.org,
	osd-dev@open-osd.org, linux-fsdevel@vger.kernel.org,
	lars.ellenberg@linbit.com, linux-ext4@vger.kernel.org,
	linux-btrfs@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 00/35 v2] separate operations from flags in
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

This looks good to me from a highlevel point of view.
Do you also have a git tree to take a look at all the changes in a
single big diff?
