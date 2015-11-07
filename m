Return-Path: <BATV+5516fb9bc7e0e97e7aa6+4458+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.9])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id DB9FD1055F4A
	for <drbd-dev@lists.linbit.com>; Sat,  7 Nov 2015 11:19:35 +0100 (CET)
Date: Sat, 7 Nov 2015 02:19:32 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Mike Christie <mchristi@redhat.com>
Message-ID: <20151107101932.GC12117@infradead.org>
References: <1446674909-5371-1-git-send-email-mchristi@redhat.com>
	<1446674909-5371-20-git-send-email-mchristi@redhat.com>
	<563A8A33.3000002@sandisk.com> <563B930F.7040705@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <563B930F.7040705@redhat.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-raid@vger.kernel.org,
	device-mapper development <dm-devel@redhat.com>,
	linux-fsdevel@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [dm-devel] [PATCH 19/32] block: add helper to get
 data dir from op
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

On Thu, Nov 05, 2015 at 11:34:07AM -0600, Mike Christie wrote:
> I can do that. You are right in how they are used. I just did the above,
> to follow the other *_data_dir calls.

I think the *_data_dir calls are horrible interfaces.  But your series
already is huge, so if it makes your life easier I'd say keep it as-is
for now.  But in the long run we should have the interfaces that Bart
suggested, and one that gives you a dma_data_direction from a request,
as that's what a lot of the driver ultimatively want.
