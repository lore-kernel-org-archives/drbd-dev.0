Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 024BC10003B1
	for <drbd-dev@lists.linbit.com>; Wed, 30 May 2012 10:41:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id ABFD11B435C
	for <drbd-dev@lists.linbit.com>; Wed, 30 May 2012 10:41:09 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KFWAPOyjbwKd for <drbd-dev@lists.linbit.com>;
	Wed, 30 May 2012 10:41:09 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id 7BE441B435B
	for <drbd-dev@lists.linbit.com>; Wed, 30 May 2012 10:41:09 +0200 (CEST)
Resent-Message-ID: <20120530084109.GQ4141@soda.linbit>
Received: from ipmail06.adl6.internode.on.net (ipmail06.adl6.internode.on.net
	[150.101.137.145])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id DA6B51019A78
	for <drbd-dev@lists.linbit.com>; Tue, 29 May 2012 03:59:48 +0200 (CEST)
Date: Tue, 29 May 2012 11:54:38 +1000
From: Dave Chinner <david@fromorbit.com>
To: Kent Overstreet <koverstreet@google.com>
Message-ID: <20120529015438.GZ5091@dastard>
References: <1337977539-16977-1-git-send-email-koverstreet@google.com>
	<1337977539-16977-15-git-send-email-koverstreet@google.com>
	<20120525204651.GA24246@redhat.com>
	<20120525210944.GB14196@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120525210944.GB14196@google.com>
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

On Fri, May 25, 2012 at 02:09:44PM -0700, Kent Overstreet wrote:
> On Fri, May 25, 2012 at 04:46:51PM -0400, Mike Snitzer wrote:
> > I'd love to see the merge_bvec stuff go away but it does serve a
> > purpose: filesystems benefit from accurately building up much larger
> > bios (based on underlying device limits).  XFS has leveraged this for
> > some time and ext4 adopted this (commit bd2d0210cf) because of the
> > performance advantage.
> 
> That commit only talks about skipping buffer heads, from the patch
> description I don't see how merge_bvec_fn would have anything to do with
> what it's after.

XFS has used it since 2.6.16 as building our own bios enabled the Io
path form IOs of sizes that are independent of the filesystem block
size.

http://oss.sgi.com/projects/xfs/papers/ols2006/ols-2006-paper.pdf

And it's not just the XFS write path that uses bio_add_page - the XFS
metadata read/write IO code uses it as well because we have metadata
constructs that are larger than a single page...

> > So if you don't have a mechanism for the filesystem's IO to have
> > accurate understanding of the limits of the device the filesystem is
> > built on (merge_bvec was the mechanism) and are leaning on late
> > splitting does filesystem performance suffer?
> 
> So is the issue that it may take longer for an IO to complete, or is it
> CPU utilization/scalability?

Both. Moving to this code reduced the CPU overhead per MB of data
written to disk by 80-90%. It also allowed us to build IOs that span
entire RAID stripe widths, thereby avoiding potential RAID RMW
cycles, and even allowing high end raid controllers to trigger BBWC
bypass fast paths that could double or triple the write throughput
of the arrays...

> If it's the former, we've got a real problem.

... then you have a real problem.

> If it's the latter - it
> might be a problem in the interim (I don't expect generic_make_request()
> to be splitting bios in the common case long term), but I doubt it's
> going to be much of an issue.

I think this will also be an issue - the typical sort of throughput
I've been hearing about over the past year for typical HPC
deployments is >20GB/s buffered write throughput to disk on a single
XFS filesystem, and that is typically limited by the flusher thread
being CPU bound. So if you changes have a CPU usage impact, then
these systems will definitely see reduced performance....

> > Would be nice to see before and after XFS and ext4 benchmarks against a
> > RAID device (level 5 or 6).  I'm especially interested to get Dave
> > Chinner's and Ted's insight here.
> 
> Yeah.
> 
> I can't remember who it was, but Ted knows someone who was able to
> benchmark on a 48 core system. I don't think we need numbers from a 48
> core machine for these patches, but whatever workloads they were testing
> that were problematic CPU wise would be useful to test.

Eric Whitney.

http://downloads.linux.hp.com/~enw/ext4/3.2/

His storage hardware probably isn't fast enough to demonstrate the
sort of problems I'm expecting that would occur...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
