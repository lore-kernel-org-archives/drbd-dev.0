Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 7A8461005418
	for <drbd-dev@lists.linbit.com>; Wed, 30 May 2012 10:41:10 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id 4630E1B435C
	for <drbd-dev@lists.linbit.com>; Wed, 30 May 2012 10:41:10 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PPImbmJYYi-2 for <drbd-dev@lists.linbit.com>;
	Wed, 30 May 2012 10:41:10 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id E45651B435B
	for <drbd-dev@lists.linbit.com>; Wed, 30 May 2012 10:41:09 +0200 (CEST)
Resent-Message-ID: <20120530084109.GR4141@soda.linbit>
Received: from ipmail06.adl6.internode.on.net (ipmail06.adl6.internode.on.net
	[150.101.137.145])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 99CD31019A78
	for <drbd-dev@lists.linbit.com>; Tue, 29 May 2012 04:07:08 +0200 (CEST)
Date: Tue, 29 May 2012 12:07:02 +1000
From: Dave Chinner <david@fromorbit.com>
To: Tejun Heo <tj@kernel.org>
Message-ID: <20120529020702.GA5091@dastard>
References: <1337977539-16977-1-git-send-email-koverstreet@google.com>
	<1337977539-16977-15-git-send-email-koverstreet@google.com>
	<20120525204651.GA24246@redhat.com>
	<20120525210944.GB14196@google.com>
	<20120525223937.GF5761@agk-dp.fab.redhat.com>
	<Pine.LNX.4.64.1205281129180.2227@file.rdu.redhat.com>
	<20120528202839.GA18537@dhcp-172-17-108-109.mtv.corp.google.com>
	<Pine.LNX.4.64.1205281659580.11763@file.rdu.redhat.com>
	<20120528213839.GB18537@dhcp-172-17-108-109.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120528213839.GB18537@dhcp-172-17-108-109.mtv.corp.google.com>
Cc: axboe@kernel.dk, dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
	Kent Overstreet <koverstreet@google.com>,
	Dave Chinner <dchinner@redhat.com>, linux-kernel@vger.kernel.org,
	linux-bcache@vger.kernel.org, tytso@google.com,
	Mikulas Patocka <mpatocka@redhat.com>, vgoyal@redhat.com,
	bharrosh@panasas.com, linux-fsdevel@vger.kernel.org,
	yehuda@hq.newdream.net, drbd-dev@lists.linbit.com,
	Alasdair G Kergon <agk@redhat.com>, sage@newdream.net
Subject: Re: [Drbd-dev] [PATCH v3 14/16] Gut bio_add_page()
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Tue, May 29, 2012 at 06:38:39AM +0900, Tejun Heo wrote:
> On Mon, May 28, 2012 at 05:27:33PM -0400, Mikulas Patocka wrote:
> > > Isn't it more like you shouldn't be sending read requested by user and
> > > read ahead in the same bio?
> > 
> > If the user calls read with 512 bytes, you would send bio for just one 
> > sector. That's too small and you'd get worse performance because of higher 
> > command overhead. You need to send larger bios.
> 
> All modern FSes are page granular, so the granularity would be
> per-page.

Most modern filesystems support sparse files and block sizes smaller
than page size, so a single page may require multiple unmergable
bios to fill all the data in them. Hence IO granularity is
definitely not per-page even though that is the granularity of the
page cache.

> Also, RAHEAD is treated differently in terms of
> error-handling.  Do filesystems implement their own rahead
> (independent from the common logic in vfs layer) on their own?

Yes. Keep in mind there is no rule that says filesystems must use
the generic IO paths, or even the page cache for that matter.
Indeed, XFS (and I think btrfs now) do no use the page cache for
their metadata caching and IO.

So just off the top of my head, XFS has it's own readahead for
metadata constructs (btrees, directory data, etc) , and btrfs
implements it's own readpage/readpages and readahead paths (see the
btrfs compression support, for example).

And FWIW, XFS has variable sized metadata, so to complete the
circle, some metadata requires sector granularity, some filesystem
block size granularity, and some multiple page granularity.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
