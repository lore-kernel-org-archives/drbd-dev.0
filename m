Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 985F11012A9D
	for <drbd-dev@lists.linbit.com>; Tue,  5 Jun 2012 09:36:21 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id 9120C1B4376
	for <drbd-dev@lists.linbit.com>; Tue,  5 Jun 2012 09:36:21 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kIEnpIXjQygA for <drbd-dev@lists.linbit.com>;
	Tue,  5 Jun 2012 09:36:21 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id 20B291B4365
	for <drbd-dev@lists.linbit.com>; Tue,  5 Jun 2012 09:36:21 +0200 (CEST)
Resent-Message-ID: <20120605073621.GG24621@soda.linbit>
Received: from ipmail05.adl6.internode.on.net (ipmail05.adl6.internode.on.net
	[150.101.137.143])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 639D31017A2C
	for <drbd-dev@lists.linbit.com>; Tue,  5 Jun 2012 02:33:27 +0200 (CEST)
Date: Tue, 5 Jun 2012 10:33:10 +1000
From: Dave Chinner <david@fromorbit.com>
To: Kent Overstreet <koverstreet@google.com>
Message-ID: <20120605003309.GD4347@dastard>
References: <1337977539-16977-1-git-send-email-koverstreet@google.com>
	<1337977539-16977-15-git-send-email-koverstreet@google.com>
	<20120525204651.GA24246@redhat.com>
	<20120525210944.GB14196@google.com> <20120529015438.GZ5091@dastard>
	<20120529033434.GC10175@dhcp-172-18-216-138.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120529033434.GC10175@dhcp-172-18-216-138.mtv.corp.google.com>
Cc: axboe@kernel.dk, Mike Snitzer <snitzer@redhat.com>,
	Dave Chinner <dchinner@redhat.com>, dm-devel@redhat.com,
	linux-kernel@vger.kernel.org, tj@kernel.org,
	linux-bcache@vger.kernel.org, tytso@google.com,
	mpatocka@redhat.com, agk@redhat.com, bharrosh@panasas.com,
	linux-fsdevel@vger.kernel.org, yehuda@hq.newdream.net,
	drbd-dev@lists.linbit.com, vgoyal@redhat.com, sage@newdream.net
Subject: Re: [Drbd-dev] [PATCH v3 14/16] Gut bio_add_page()
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Mon, May 28, 2012 at 11:34:34PM -0400, Kent Overstreet wrote:
> On Tue, May 29, 2012 at 11:54:38AM +1000, Dave Chinner wrote:
> > It also allowed us to build IOs that span
> > entire RAID stripe widths, thereby avoiding potential RAID RMW
> > cycles, and even allowing high end raid controllers to trigger BBWC
> > bypass fast paths that could double or triple the write throughput
> > of the arrays...
> 
> merge_bvec_fn has nothing to do with that though, since for one there

You're mistaking me for someone who cares about merge_bvec_fn().
Someone asked me to describe why XFS uses bio_add_page()....

> aren't any merge_bvec_fn's being called in the IO paths on these high
> end disk arrays,

Yes there are, because high bandwidth filesytem use software RAID 0
striping to stripe multiple hardware RAID luns together to acheive
the necessary bandwidth. Hardware RAID is used for disk failure
prevention and to manage 1000 disks more easily, while software RAID
(usually with multipathing) is used to scale the performance....

> and for our software raid implementations their
> merge_bvec_fns will keep you from sending them bios that span entire
> stripes.

Well, yeah, the lower layer has to break up large bios into chunks
for it's sub-devices.  What matters is that we build IOs that are
larger than what the lower layers break it up into. e.g. if your
hardware RAID5 stripe width is 1MB, then the software RAID chunks
size is 1MB (and the stripe width is N luns X 1MB), then all that
matters is that we build IOs larger than 1MB so that we get full
stripe writes at that hardware RAID level and so avoid RMW cycles
right at the bottom of the IO stack...

As long as the new code still allows us to achieve the same or
better IO sizes without any new overhead, then I simply don't care
what happens to the guts of bio_add_page().

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
