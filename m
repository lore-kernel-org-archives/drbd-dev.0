Return-Path: <BATV+5516fb9bc7e0e97e7aa6+4458+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.9])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 90B791056192
	for <drbd-dev@lists.linbit.com>; Sat,  7 Nov 2015 11:23:15 +0100 (CET)
Date: Sat, 7 Nov 2015 02:23:09 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Mike Christie <michaelc@cs.wisc.edu>
Message-ID: <20151107102309.GE12117@infradead.org>
References: <1446654807-6935-1-git-send-email-mchristi@redhat.com>
	<563A36FC.6010001@sandisk.com> <563A3813.5010604@cs.wisc.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <563A3813.5010604@cs.wisc.edu>
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

On Wed, Nov 04, 2015 at 10:53:39AM -0600, Mike Christie wrote:
> > If you have to touch submit_bio() and submit_bio_wait(), how about
> > requiring the callers of these functions to set the cmd and flags
> > arguments in the bio structure and to leave out the cmd and flags
> > arguments from the submit_bio() and submit_bio_wait() functions ? A
> > (compile tested only) patch that implements this idea is available at
> > https://lkml.org/lkml/2014/6/2/173.
> > 
> 
> Yeah, I can do that.

I think this would be useful to do at the beginning of the series.
While this will have a huge trickle effect through the series it should
make thing a bit simpler overall.  By leaving op 0 undefined it should
also help to create a nice error trap for unconverted code.
