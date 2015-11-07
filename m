Return-Path: <BATV+5516fb9bc7e0e97e7aa6+4458+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.9])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 526F01056192
	for <drbd-dev@lists.linbit.com>; Sat,  7 Nov 2015 11:24:05 +0100 (CET)
Date: Sat, 7 Nov 2015 02:10:23 -0800
From: Christoph Hellwig <hch@infradead.org>
To: mchristi@redhat.com
Message-ID: <20151107101023.GA12117@infradead.org>
References: <1446674909-5371-1-git-send-email-mchristi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1446674909-5371-1-git-send-email-mchristi@redhat.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-raid@vger.kernel.org, dm-devel@redhat.com,
	linux-fsdevel@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [RESEND RFC PATCH 00/32] separate operations from
 flags in the bio/request structs
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

On Wed, Nov 04, 2015 at 04:07:57PM -0600, mchristi@redhat.com wrote:
> Known issues:
> - REQ_FLUSH is still a flag, but should probably be a operation.
>  For lower level drivers like SCSI where we only get a flush, it makes
> more sense to be a operation. However, upper layers like filesystems
> can send down flushes with writes, so it is more of a flag for them.
> I am still working on this.

Actually it should be both.  REQ_OP_FLUSH for a real flush operation,
and a REQ_PREFLUSH bio flag that the request layer will sequence into
an actual write an a flush operation.
