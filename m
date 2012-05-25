Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id DB1D31012A92
	for <drbd-dev@lists.linbit.com>; Fri, 25 May 2012 23:14:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id D2FD31B4354
	for <drbd-dev@lists.linbit.com>; Fri, 25 May 2012 23:14:58 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kSTr+uwumNNA for <drbd-dev@lists.linbit.com>;
	Fri, 25 May 2012 23:14:58 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id 788571B4315
	for <drbd-dev@lists.linbit.com>; Fri, 25 May 2012 23:14:58 +0200 (CEST)
Resent-Message-ID: <20120525211457.GV1903@soda.linbit>
Received: from mail-pz0-f54.google.com (mail-pz0-f54.google.com
	[209.85.210.54]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id EA504100008C
	for <drbd-dev@lists.linbit.com>; Fri, 25 May 2012 23:09:49 +0200 (CEST)
Received: by dadv36 with SMTP id v36so2274508dad.27
	for <drbd-dev@lists.linbit.com>; Fri, 25 May 2012 14:09:47 -0700 (PDT)
Date: Fri, 25 May 2012 14:09:44 -0700
From: Kent Overstreet <koverstreet@google.com>
To: Mike Snitzer <snitzer@redhat.com>
Message-ID: <20120525210944.GB14196@google.com>
References: <1337977539-16977-1-git-send-email-koverstreet@google.com>
	<1337977539-16977-15-git-send-email-koverstreet@google.com>
	<20120525204651.GA24246@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120525204651.GA24246@redhat.com>
Cc: axboe@kernel.dk, dm-devel@redhat.com, Dave Chinner <dchinner@redhat.com>,
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

On Fri, May 25, 2012 at 04:46:51PM -0400, Mike Snitzer wrote:
> I'd love to see the merge_bvec stuff go away but it does serve a
> purpose: filesystems benefit from accurately building up much larger
> bios (based on underlying device limits).  XFS has leveraged this for
> some time and ext4 adopted this (commit bd2d0210cf) because of the
> performance advantage.

That commit only talks about skipping buffer heads, from the patch
description I don't see how merge_bvec_fn would have anything to do with
what it's after.

> So if you don't have a mechanism for the filesystem's IO to have
> accurate understanding of the limits of the device the filesystem is
> built on (merge_bvec was the mechanism) and are leaning on late
> splitting does filesystem performance suffer?

So is the issue that it may take longer for an IO to complete, or is it
CPU utilization/scalability?

If it's the former, we've got a real problem. If it's the latter - it
might be a problem in the interim (I don't expect generic_make_request()
to be splitting bios in the common case long term), but I doubt it's
going to be much of an issue.

> Would be nice to see before and after XFS and ext4 benchmarks against a
> RAID device (level 5 or 6).  I'm especially interested to get Dave
> Chinner's and Ted's insight here.

Yeah.

I can't remember who it was, but Ted knows someone who was able to
benchmark on a 48 core system. I don't think we need numbers from a 48
core machine for these patches, but whatever workloads they were testing
that were problematic CPU wise would be useful to test.
