Return-Path: <BATV+5516fb9bc7e0e97e7aa6+4458+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.9])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 5D01E1055F4A
	for <drbd-dev@lists.linbit.com>; Sat,  7 Nov 2015 11:21:50 +0100 (CET)
Date: Sat, 7 Nov 2015 02:21:47 -0800
From: Christoph Hellwig <hch@infradead.org>
To: mchristi@redhat.com
Message-ID: <20151107102147.GD12117@infradead.org>
References: <1446674909-5371-1-git-send-email-mchristi@redhat.com>
	<1446674909-5371-33-git-send-email-mchristi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1446674909-5371-33-git-send-email-mchristi@redhat.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-raid@vger.kernel.org, dm-devel@redhat.com,
	linux-fsdevel@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 32/32] block: remove __REQ op defs and reduce
 bi_op/bi_rw sizes
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

I love this series!

Also I think it's very good that we finally split the ioprio out to it's
own field.

Thanks a lot for doing this work.

> I was not sure if or how much or where people wanted to stick things.
> There also appears to be room in the bi_flags field. If bi_flags is
> only using 13 bits and there are only 16 REQ_XYZs bits related bios,
> I could put them all in one variable if we wanted to go wild with trying
> to shrink the bio while I am at it..

This sounds interesting, but I'd rather do it as a separate project
later.
