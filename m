Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 505041011B9B
	for <drbd-dev@lists.linbit.com>; Tue,  2 Jun 2015 21:09:37 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 169052A98C6
	for <drbd-dev@lists.linbit.com>; Tue,  2 Jun 2015 21:09:37 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id R4jW3aXY0lrn for <drbd-dev@lists.linbit.com>;
	Tue,  2 Jun 2015 21:09:37 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id E8AB43FA3A1
	for <drbd-dev@lists.linbit.com>; Tue,  2 Jun 2015 21:09:36 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id EC_KGbTghURZ for <drbd-dev@lists.linbit.com>;
	Tue,  2 Jun 2015 21:09:36 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 6502C2A98C6
	for <drbd-dev@lists.linbit.com>; Tue,  2 Jun 2015 21:09:36 +0200 (CEST)
Resent-Message-ID: <20150602190936.GM18767@soda.linbit>
Date: Thu, 28 May 2015 01:36:27 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Ming Lin <mlin@kernel.org>
Message-ID: <20150528003627.GD32216@agk-dp.fab.redhat.com>
References: <1432318723-18829-1-git-send-email-mlin@kernel.org>
	<1432318723-18829-2-git-send-email-mlin@kernel.org>
	<20150526143626.GA4315@redhat.com>
	<CAF1ivSb3ptYObS3_8bJwWhq98EcNgAgRhN_L-c3uyFfCzdn=9A@mail.gmail.com>
	<20150526160400.GB4715@redhat.com>
	<CAF1ivSZ351yV4re1Ghf5yqPjgq6aXjrZT4yWd+T9msAFsBnDSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF1ivSZ351yV4re1Ghf5yqPjgq6aXjrZT4yWd+T9msAFsBnDSw@mail.gmail.com>
Cc: Mike Snitzer <snitzer@redhat.com>, Neil Brown <neilb@suse.de>,
	Ming Lei <ming.lei@canonical.com>, dm-devel@redhat.com,
	Christoph Hellwig <hch@lst.de>, Alasdair Kergon <agk@redhat.com>,
	Lars Ellenberg <drbd-dev@lists.linbit.com>,
	Philip Kelleher <pjk1939@linux.vnet.ibm.com>,
	Joshua Morris <josh.h.morris@us.ibm.com>,
	Christoph Hellwig <hch@infradead.org>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Nitin Gupta <ngupta@vflare.org>, Oleg Drokin <oleg.drokin@intel.com>,
	Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>,
	Andreas Dilger <andreas.dilger@intel.com>,
	Geoff Levand <geoff@infradead.org>, Jiri Kosina <jkosina@suse.cz>,
	lkml <linux-kernel@vger.kernel.org>, Jim Paris <jim@jtan.com>,
	Minchan Kim <minchan@kernel.org>, Dongsu Park <dpark@posteo.net>,
	drbd-user@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH v4 01/11] block: make generic_make_request
	handle	arbitrarily sized bios
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

On Wed, May 27, 2015 at 04:42:44PM -0700, Ming Lin wrote:
> Here are fio results of XFS on a DM stripped target with 2 SSDs + 1 HDD.
> Does it make sense?

To stripe across devices with different characteristics?

Some suggestions.

Prepare 3 kernels.
  O - Old kernel.
  M - Old kernel with merge_bvec_fn disabled.
  N - New kernel.

You're trying to search for counter-examples to the hypothesis that 
"Kernel N always outperforms Kernel O".  Then if you find any, trying 
to show either that the performance impediment is small enough that
it doesn't matter or that the cases are sufficiently rare or obscure
that they may be ignored because of the greater benefits of N in much more
common cases.

(1) You're looking to set up configurations where kernel O performs noticeably
better than M.  Then you're comparing the performance of O and N in those
situations.

(2) You're looking at other sensible configurations where O and M have
similar performance, and comparing that with the performance of N.

In each case you find, you expect to be able to vary some parameter (such as
stripe size) to show a progression of the effect.

When running tests you've to take care the system is reset into the same
initial state before each test, so you'll normally also try to include some
baseline test between tests that should give the same results each time
and also take the average of a number of runs (while also reporting some
measure of the variation within each set to make sure that remains low,
typically a low single digit percentage).

Since we're mostly concerned about splitting, you'll want to monitor
iostat to see if that gives you enough information to home in on 
suitable configurations for (1).  Failing that, you might need to
instrument the kernels to tell you the sizes of the bios being
created and the amount of splitting actually happening.

Striping was mentioned because it forces splitting.  So show the progression
from tiny stripes to huge stripes.  (Ensure all the devices providing the
stripes have identical characteristics, but you can test with slow and
fast underlying devices.)

You may also want to test systems with a restricted amount of available
memory to show how the splitting via worker thread performs.  (Again,
instrument to prove the extent to which the new code is being exercised.)

Alasdair

