Return-Path: <msnitzer@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 1CDC51028A55
	for <drbd-dev@lists.linbit.com>; Wed, 11 Nov 2015 18:37:23 +0100 (CET)
Date: Wed, 11 Nov 2015 12:37:20 -0500
From: Mike Snitzer <snitzer@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Message-ID: <20151111173719.GB12236@redhat.com>
References: <1446654807-6935-1-git-send-email-mchristi@redhat.com>
	<563A36FC.6010001@sandisk.com> <563A3813.5010604@cs.wisc.edu>
	<20151107102309.GE12117@infradead.org>
	<5642F3F4.2060007@cs.wisc.edu> <20151111112846.GA358@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20151111112846.GA358@infradead.org>
Cc: Mike Christie <michaelc@cs.wisc.edu>, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
	device-mapper development <dm-devel@redhat.com>,
	linux-fsdevel@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [RFC PATCH 00/32] separate operations from flags in
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

On Wed, Nov 11 2015 at  6:28am -0500,
Christoph Hellwig <hch@infradead.org> wrote:

> On Wed, Nov 11, 2015 at 01:53:24AM -0600, Mike Christie wrote:
> > We no longer have the bvec merge functions so the original reason given
> > in the thread/patch Bart referenced is no longer valid.
> > 
> > Offlist it was suggested that dropping the argument from submit_bio
> > might still improve performance, but I modified xfs and dm and did some
> > testing and did not see anything.
> > 
> > So the change is not needed, and it would only be done because people
> > feel it would improve the interface.
> 
> I would defintively prefer the changed interface, and to me it also
> looks like it would make your overall patch simpler.  If you disagree
> feel free to keep it as-is for now and I'll do another pass later.

The less churn the better.  But honestly, not quite following the logic
on why all this flag-day churn is needed.  BUT if it needs to happen,
because we'll soon hit a wall on supported operations via REQ_*, now is
as good a time as any -- but best to limit the change to the flags IMHO.
