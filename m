Return-Path: <BATV+5516fb9bc7e0e97e7aa6+4458+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.9])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 2333E1045C37
	for <drbd-dev@lists.linbit.com>; Sat,  7 Nov 2015 11:17:17 +0100 (CET)
Date: Sat, 7 Nov 2015 02:17:13 -0800
From: Christoph Hellwig <hch@infradead.org>
To: mchristi@redhat.com
Message-ID: <20151107101713.GB12117@infradead.org>
References: <1446674909-5371-1-git-send-email-mchristi@redhat.com>
	<1446674909-5371-7-git-send-email-mchristi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1446674909-5371-7-git-send-email-mchristi@redhat.com>
Cc: linux-scsi@vger.kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-kernel@vger.kernel.org, RogerPauMonnérroger.pau@citrix.com, linux-raid@vger.kernel.org, dm-devel@redhat.com, linux-fsdevel@vger.kernel.org, xen-devel@lists.xenproject.org, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 06/32] xen blkback: prepare for bi_rw split
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

A little offtopic for this patch, but can some explain this whole
mess about bios in Xen blkfront?  We can happily do partial completions
at the request later.

Also since the blk-mq conversion the call to blk_end_request_all is
completely broken, so it doesn't look like this code path is exactly
well tested.
