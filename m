Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 4B0CE1012A9D
	for <drbd-dev@lists.linbit.com>; Wed, 30 May 2012 10:40:41 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id 401E01B435C
	for <drbd-dev@lists.linbit.com>; Wed, 30 May 2012 10:40:41 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KlJAz4zIQePd for <drbd-dev@lists.linbit.com>;
	Wed, 30 May 2012 10:40:41 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id 22C381B435B
	for <drbd-dev@lists.linbit.com>; Wed, 30 May 2012 10:40:41 +0200 (CEST)
Resent-Message-ID: <20120530084041.GD4141@soda.linbit>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 3486D100008C
	for <drbd-dev@lists.linbit.com>; Sat, 26 May 2012 00:39:50 +0200 (CEST)
Date: Fri, 25 May 2012 23:39:37 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Kent Overstreet <koverstreet@google.com>,
	Mike Snitzer <snitzer@redhat.com>, linux-kernel@vger.kernel.org,
	linux-bcache@vger.kernel.org, dm-devel@redhat.com,
	linux-fsdevel@vger.kernel.org, axboe@kernel.dk, yehuda@hq.newdream.net,
	mpatocka@redhat.com, vgoyal@redhat.com, bharrosh@panasas.com,
	tj@kernel.org, sage@newdream.net, agk@redhat.com,
	drbd-dev@lists.linbit.com, Dave Chinner <dchinner@redhat.com>,
	tytso@google.com
Message-ID: <20120525223937.GF5761@agk-dp.fab.redhat.com>
References: <1337977539-16977-1-git-send-email-koverstreet@google.com>
	<1337977539-16977-15-git-send-email-koverstreet@google.com>
	<20120525204651.GA24246@redhat.com>
	<20120525210944.GB14196@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120525210944.GB14196@google.com>
Subject: Re: [Drbd-dev] [PATCH v3 14/16] Gut bio_add_page()
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Where's the urge to remove merge_bvec coming from?

I think it's premature to touch this, and that the other changes, if
fixed and integrated, should be allowed to bed themselves down first.


Ideally every bio would be the best size on submission and no bio would
ever need to be split.

But there is a cost involved in calculating the best size - we use
merge_bvec for this, which gives a (probable) maximum size.  It's
usually very cheap to calculate - but not always.  [In dm, we permit
some situations where the answer we give will turn out to be wrong, but
ensure dm will always fix up those particular cases itself later and
still process the over-sized bio correctly.]

Similarly there is a performance penalty incurred when the size is wrong
- the bio has to be split, requiring memory, potential delays etc.

There is a trade-off between those two, and our experience with the current
code has that tilted strongly in favour of using merge_bvec all the time.
The wasted overhead in cases where it is of no benefit seem to be
outweighed by the benefit where it does avoid lots of splitting and help
filesystems optimise their behaviour.


If the splitting mechanism is changed as proposed, then that balance
might shift.  My gut feeling though is that any shift would strengthen
the case for merge_bvec.

Alasdair

