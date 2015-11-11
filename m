Return-Path: <BATV+66af426afb9dea266a66+4462+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.9])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id F13DD1055F58
	for <drbd-dev@lists.linbit.com>; Wed, 11 Nov 2015 12:28:52 +0100 (CET)
Date: Wed, 11 Nov 2015 03:28:46 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Mike Christie <michaelc@cs.wisc.edu>
Message-ID: <20151111112846.GA358@infradead.org>
References: <1446654807-6935-1-git-send-email-mchristi@redhat.com>
	<563A36FC.6010001@sandisk.com> <563A3813.5010604@cs.wisc.edu>
	<20151107102309.GE12117@infradead.org>
	<5642F3F4.2060007@cs.wisc.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5642F3F4.2060007@cs.wisc.edu>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-raid@vger.kernel.org,
	device-mapper development <dm-devel@redhat.com>,
	linux-fsdevel@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [dm-devel] [RFC PATCH 00/32] separate operations
 from flags in the bio/request structs
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

On Wed, Nov 11, 2015 at 01:53:24AM -0600, Mike Christie wrote:
> We no longer have the bvec merge functions so the original reason given
> in the thread/patch Bart referenced is no longer valid.
> 
> Offlist it was suggested that dropping the argument from submit_bio
> might still improve performance, but I modified xfs and dm and did some
> testing and did not see anything.
> 
> So the change is not needed, and it would only be done because people
> feel it would improve the interface.

I would defintively prefer the changed interface, and to me it also
looks like it would make your overall patch simpler.  If you disagree
feel free to keep it as-is for now and I'll do another pass later.
