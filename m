Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 651851005418
	for <drbd-dev@lists.linbit.com>; Wed, 30 May 2012 10:41:13 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id 38B811B435D
	for <drbd-dev@lists.linbit.com>; Wed, 30 May 2012 10:41:13 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id d1tKxTwjqRtY for <drbd-dev@lists.linbit.com>;
	Wed, 30 May 2012 10:41:13 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id 0AA271B4361
	for <drbd-dev@lists.linbit.com>; Wed, 30 May 2012 10:41:13 +0200 (CEST)
Resent-Message-ID: <20120530084112.GW4141@soda.linbit>
Received: from mail-pz0-f54.google.com (mail-pz0-f54.google.com
	[209.85.210.54]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 2C5941019A78
	for <drbd-dev@lists.linbit.com>; Tue, 29 May 2012 05:36:33 +0200 (CEST)
Received: by dadv36 with SMTP id v36so6053711dad.27
	for <drbd-dev@lists.linbit.com>; Mon, 28 May 2012 20:36:32 -0700 (PDT)
Date: Mon, 28 May 2012 23:36:28 -0400
From: Kent Overstreet <koverstreet@google.com>
To: Tejun Heo <tj@kernel.org>
Message-ID: <20120529033628.GD10175@dhcp-172-18-216-138.mtv.corp.google.com>
References: <20120525204651.GA24246@redhat.com>
	<20120525210944.GB14196@google.com>
	<20120525223937.GF5761@agk-dp.fab.redhat.com>
	<Pine.LNX.4.64.1205281129180.2227@file.rdu.redhat.com>
	<20120528202839.GA18537@dhcp-172-17-108-109.mtv.corp.google.com>
	<Pine.LNX.4.64.1205281659580.11763@file.rdu.redhat.com>
	<20120528213839.GB18537@dhcp-172-17-108-109.mtv.corp.google.com>
	<20120528230208.GA20954@dhcp-172-17-108-109.mtv.corp.google.com>
	<20120529020815.GB5091@dastard>
	<20120529021558.GG20954@dhcp-172-17-108-109.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120529021558.GG20954@dhcp-172-17-108-109.mtv.corp.google.com>
Cc: axboe@kernel.dk, dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
	Dave Chinner <dchinner@redhat.com>,
	Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org,
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

On Tue, May 29, 2012 at 11:15:58AM +0900, Tejun Heo wrote:
> Hello,
> 
> On Tue, May 29, 2012 at 12:08:15PM +1000, Dave Chinner wrote:
> > > i thought a bit more about it and the only thing which makes sense to
> > > me is exposing the stripe granularity for striped devices -
> > > ie. something which says "if you go across this boundary, the
> > > performance characteristics including latency might get affected",
> > > which should fit nicely with the rest of topology information.
> > > Martin, adding that shouldn't be difficult, right?
> > 
> > We already have the optimal IO size/alignment field in the topology.
> > Doesn't this fit what you want exactly?
> 
> I don't know how xfs/ext4 is currently benefiting from
> merge_bvec_fn(), so I'm unsure.  If the existing ones are enough,
> great.

Excepting readahead I don't think they are at all.

For readahead all we need is a hint - call it "atomic IO size" or
something. Assuming one of the gazillion things in queue_limits doesn't
already mean that anyways.
