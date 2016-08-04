Return-Path: <BATV+b244dc37f40e53d0e5a9+4729+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.9])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id F17CB1056446
	for <drbd-dev@lists.linbit.com>; Thu,  4 Aug 2016 18:29:07 +0200 (CEST)
Date: Thu, 4 Aug 2016 08:46:22 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Shaun Tancheff <shaun.tancheff@seagate.com>
Message-ID: <20160804154622.GB15656@infradead.org>
References: <1465155145-10812-1-git-send-email-mchristi@redhat.com>
	<1465155145-10812-38-git-send-email-mchristi@redhat.com>
	<CAOxpaSUMsgfTYsL0bL6VCnwxz7bpgpKO-ZfC5J8dFG9PN-hzvg@mail.gmail.com>
	<87fbe31f-27b3-ff7a-e381-34fc1aad337e@redhat.com>
	<CAJVOszAd9Eu88P2=QoNVArd0jwDH7KRe=OB82tCNMpjfv9B4KA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJVOszAd9Eu88P2=QoNVArd0jwDH7KRe=OB82tCNMpjfv9B4KA@mail.gmail.com>
Cc: philipp.reisner@linbit.com, dm-devel@redhat.com,
	target-devel@vger.kernel.org, linux-mtd@lists.infradead.org,
	drbd-dev@lists.linbit.com, linux-scsi@vger.kernel.org,
	Mike Christie <mchristi@redhat.com>,
	Ross Zwisler <ross.zwisler@linux.intel.com>,
	linux-ext4 <linux-ext4@vger.kernel.org>, konrad.wilk@oracle.com,
	XFS Developers <xfs@oss.sgi.com>, linux-block@vger.kernel.org,
	linux-bcache@vger.kernel.org, osd-dev@open-osd.org,
	Ross Zwisler <zwisler@gmail.com>, Jens Axboe <axboe@fb.com>,
	linux-raid@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net, linux-btrfs@vger.kernel.org,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	lars.ellenberg@linbit.com, ocfs2-devel@oss.oracle.com
Subject: Re: [Drbd-dev] [PATCH 37/45] drivers: use req op accessor
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

On Wed, Aug 03, 2016 at 07:30:29PM -0500, Shaun Tancheff wrote:
> I think the translation in loop.c is suspicious here:
> 
>     "if use DIO && not (a flush_flag or discard_flag)"
> should translate to:
>     "if use DIO && not ((a flush_flag) || op == discard)"
> 
> But in the patch I read:
>     "if use DIO && ((not a flush_flag) || op == discard)
> 
> Which would have DIO && discards follow the AIO path?

Indeed.  Sorry for missing out on your patch, I just sent a fix
in reply to Dave's other report earlier which is pretty similar to
yours.
