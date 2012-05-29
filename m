Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 0E2F01005425
	for <drbd-dev@lists.linbit.com>; Wed, 30 May 2012 10:41:11 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id CD2B61B435E
	for <drbd-dev@lists.linbit.com>; Wed, 30 May 2012 10:41:10 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4WwxhITEuDrC for <drbd-dev@lists.linbit.com>;
	Wed, 30 May 2012 10:41:10 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id 660671B435D
	for <drbd-dev@lists.linbit.com>; Wed, 30 May 2012 10:41:10 +0200 (CEST)
Resent-Message-ID: <20120530084110.GS4141@soda.linbit>
Received: from ipmail06.adl6.internode.on.net (ipmail06.adl6.internode.on.net
	[150.101.137.145])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 456101019A78
	for <drbd-dev@lists.linbit.com>; Tue, 29 May 2012 04:08:18 +0200 (CEST)
Date: Tue, 29 May 2012 12:08:15 +1000
From: Dave Chinner <david@fromorbit.com>
To: Tejun Heo <tj@kernel.org>
Message-ID: <20120529020815.GB5091@dastard>
References: <1337977539-16977-1-git-send-email-koverstreet@google.com>
	<1337977539-16977-15-git-send-email-koverstreet@google.com>
	<20120525204651.GA24246@redhat.com>
	<20120525210944.GB14196@google.com>
	<20120525223937.GF5761@agk-dp.fab.redhat.com>
	<Pine.LNX.4.64.1205281129180.2227@file.rdu.redhat.com>
	<20120528202839.GA18537@dhcp-172-17-108-109.mtv.corp.google.com>
	<Pine.LNX.4.64.1205281659580.11763@file.rdu.redhat.com>
	<20120528213839.GB18537@dhcp-172-17-108-109.mtv.corp.google.com>
	<20120528230208.GA20954@dhcp-172-17-108-109.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120528230208.GA20954@dhcp-172-17-108-109.mtv.corp.google.com>
Cc: axboe@kernel.dk, dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
	Kent Overstreet <koverstreet@google.com>,
	Dave Chinner <dchinner@redhat.com>, linux-kernel@vger.kernel.org,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
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

On Tue, May 29, 2012 at 08:02:08AM +0900, Tejun Heo wrote:
> (cc'ing Martin K. Petersen, hi!)
> 
> On Tue, May 29, 2012 at 06:38:39AM +0900, Tejun Heo wrote:
> > > With this patchset, you don't have to expose all the limits. You can 
> > > expose just a few most useful limits to avoid bio split in the cases 
> > > described above.
> > 
> > Yeah, if that actually helps, sure.  From what I read, dm is already
> > (ab)using merge_bvec_fn() like that anyway.
> 
> i thought a bit more about it and the only thing which makes sense to
> me is exposing the stripe granularity for striped devices -
> ie. something which says "if you go across this boundary, the
> performance characteristics including latency might get affected",
> which should fit nicely with the rest of topology information.
> Martin, adding that shouldn't be difficult, right?

We already have the optimal IO size/alignment field in the topology.
Doesn't this fit what you want exactly?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
