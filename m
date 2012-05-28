Return-Path: <htejun@gmail.com>
Received: from mail-pb0-f54.google.com (mail-pb0-f54.google.com
	[209.85.160.54]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 4AE5C1019A78
	for <drbd-dev@lists.linbit.com>; Tue, 29 May 2012 01:02:20 +0200 (CEST)
Received: by pbbro2 with SMTP id ro2so6454351pbb.27
	for <drbd-dev@lists.linbit.com>; Mon, 28 May 2012 16:02:18 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 29 May 2012 08:02:08 +0900
From: Tejun Heo <tj@kernel.org>
To: Mikulas Patocka <mpatocka@redhat.com>
Message-ID: <20120528230208.GA20954@dhcp-172-17-108-109.mtv.corp.google.com>
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
Cc: axboe@kernel.dk, "Martin K. Petersen" <martin.petersen@oracle.com>,
	Mike Snitzer <snitzer@redhat.com>,
	Kent Overstreet <koverstreet@google.com>,
	Dave Chinner <dchinner@redhat.com>, dm-devel@redhat.com,
	linux-kernel@vger.kernel.org, linux-bcache@vger.kernel.org,
	tytso@google.com, vgoyal@redhat.com, bharrosh@panasas.com,
	linux-fsdevel@vger.kernel.org, yehuda@hq.newdream.net,
	drbd-dev@lists.linbit.com, Alasdair G Kergon <agk@redhat.com>,
	sage@newdream.net
Subject: Re: [Drbd-dev] [PATCH v3 14/16] Gut bio_add_page()
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

(cc'ing Martin K. Petersen, hi!)

On Tue, May 29, 2012 at 06:38:39AM +0900, Tejun Heo wrote:
> > With this patchset, you don't have to expose all the limits. You can 
> > expose just a few most useful limits to avoid bio split in the cases 
> > described above.
> 
> Yeah, if that actually helps, sure.  From what I read, dm is already
> (ab)using merge_bvec_fn() like that anyway.

i thought a bit more about it and the only thing which makes sense to
me is exposing the stripe granularity for striped devices -
ie. something which says "if you go across this boundary, the
performance characteristics including latency might get affected",
which should fit nicely with the rest of topology information.
Martin, adding that shouldn't be difficult, right?

Thanks.

-- 
tejun
