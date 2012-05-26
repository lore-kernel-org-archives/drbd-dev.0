Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id C9C6E100008C
	for <drbd-dev@lists.linbit.com>; Wed, 30 May 2012 10:40:43 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id B2E181B435D
	for <drbd-dev@lists.linbit.com>; Wed, 30 May 2012 10:40:43 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GRGjXJaIT-qR for <drbd-dev@lists.linbit.com>;
	Wed, 30 May 2012 10:40:43 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id 84EC31B435C
	for <drbd-dev@lists.linbit.com>; Wed, 30 May 2012 10:40:43 +0200 (CEST)
Resent-Message-ID: <20120530084043.GH4141@soda.linbit>
Received: from mail-pz0-f54.google.com (mail-pz0-f54.google.com
	[209.85.210.54]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 0ED2E1013804
	for <drbd-dev@lists.linbit.com>; Sat, 26 May 2012 02:19:01 +0200 (CEST)
Received: by dadv36 with SMTP id v36so2438674dad.27
	for <drbd-dev@lists.linbit.com>; Fri, 25 May 2012 17:19:00 -0700 (PDT)
Date: Fri, 25 May 2012 17:18:56 -0700
From: Kent Overstreet <koverstreet@google.com>
To: linux-kernel@vger.kernel.org, linux-bcache@vger.kernel.org,
	dm-devel@redhat.com, linux-fsdevel@vger.kernel.org, tj@kernel.org,
	axboe@kernel.dk, agk@redhat.com, neilb@suse.de,
	drbd-dev@lists.linbit.com, bharrosh@panasas.com, vgoyal@redhat.com,
	mpatocka@redhat.com, sage@newdream.net, yehuda@hq.newdream.net
Message-ID: <20120526001856.GA10959@google.com>
References: <1337977539-16977-1-git-send-email-koverstreet@google.com>
	<1337977539-16977-14-git-send-email-koverstreet@google.com>
	<20120525225852.GG5761@agk-dp.fab.redhat.com>
	<20120525231232.GH5761@agk-dp.fab.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120525231232.GH5761@agk-dp.fab.redhat.com>
Subject: Re: [Drbd-dev] [PATCH v3 13/16] Make generic_make_request handle
 arbitrarily large bios
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Sat, May 26, 2012 at 12:12:33AM +0100, Alasdair G Kergon wrote:
> What I'm trying to say is, by all means, let's continue to clean up this
> patch set, but then give it some serious performance testing under
> different regimes, compare it against the status quo, do whatever
> tuning seems appropriate then let the results guide us.

Ok, that is certainly fair. I'm not _terribly_ worried about the
performance impact but it's certainly possible performance will require
some more work, we do need that testing.

What's also going to help with performance is for stacking block devices
(and possibly drivers at some point) to be changed to handle arbitrary
sized bios, so the splitting code in generic_make_request() can be
disabled for them - that should also be pretty easy at this point.

I have some other ideas/cleanups that should improve performance too but
I'll leave that for later. I really do care deeply about performance -
and it's been my experience that really the most important thing for
performance is clean, simple code and interfaces - much more than people
seem to generally assume, too...
