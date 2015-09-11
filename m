Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 12D7C1055731
	for <drbd-dev@lists.linbit.com>; Fri, 11 Sep 2015 15:20:13 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 001C32BEE36
	for <drbd-dev@lists.linbit.com>; Fri, 11 Sep 2015 15:20:13 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id RhRy8GHN-4p8 for <drbd-dev@lists.linbit.com>;
	Fri, 11 Sep 2015 15:20:12 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id D1F4E2BEE45
	for <drbd-dev@lists.linbit.com>; Fri, 11 Sep 2015 15:20:12 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id OVEV_CGIlZGw for <drbd-dev@lists.linbit.com>;
	Fri, 11 Sep 2015 15:20:12 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id AFC0D2BEE36
	for <drbd-dev@lists.linbit.com>; Fri, 11 Sep 2015 15:20:12 +0200 (CEST)
Resent-Message-ID: <20150911132012.GS3436@soda.linbit>
From: Kent Overstreet <kent.overstreet@gmail.com>
To: Ming Lin <mlin@kernel.org>
Message-ID: <20150808052226.GA7050@kmo-pixel>
References: <20150731213831.GA16464@redhat.com>
	<1438412290.26596.14.camel@hasee>
	<20150801163356.GA21478@redhat.com>
	<1438581502.26596.24.camel@hasee> <20150804113626.GA12682@lst.de>
	<1438754604.29731.31.camel@hasee> <20150807073001.GA17485@lst.de>
	<1438990806.24452.8.camel@ssi> <20150808003057.GA1811@kmo-pixel>
	<CAF1ivSYAiRqG1RhxiHE+cfogB_VKyDDs0aE7YbtZ2o6UeGhZcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF1ivSYAiRqG1RhxiHE+cfogB_VKyDDs0aE7YbtZ2o6UeGhZcQ@mail.gmail.com>
Cc: Mike Snitzer <snitzer@redhat.com>, Neil Brown <neilb@suse.de>,
	Ming Lei <ming.lei@canonical.com>, dm-devel@redhat.com,
	Christoph Hellwig <hch@lst.de>, Alasdair Kergon <agk@redhat.com>,
	Lars Ellenberg <drbd-dev@lists.linbit.com>,
	Philip Kelleher <pjk1939@linux.vnet.ibm.com>,
	Christoph Hellwig <hch@infradead.org>, Nitin Gupta <ngupta@vflare.org>,
	Ming Lin <ming.l@ssi.samsung.com>, Oleg Drokin <oleg.drokin@intel.com>,
	Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>,
	Andreas Dilger <andreas.dilger@intel.com>,
	Geoff Levand <geoff@infradead.org>, Jiri Kosina <jkosina@suse.cz>,
	lkml <linux-kernel@vger.kernel.org>, Jim Paris <jim@jtan.com>,
	Minchan Kim <minchan@kernel.org>, Dongsu Park <dpark@posteo.net>,
	drbd-user@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH v5 01/11] block: make generic_make_request
 handle arbitrarily sized bios
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
Date: Fri, 11 Sep 2015 13:20:37 -0000

On Fri, Aug 07, 2015 at 10:17:43PM -0700, Ming Lin wrote:
> On Fri, Aug 7, 2015 at 5:30 PM, Kent Overstreet
> > Ideally we'd get upper layers out of the business of knowing about the queue
> > limits at all - that was the point of the patch series, after all.
> >
> > Instead of using UINT_MAX, would it work to just make the max 1 << 31 sectors?'
> 
> 1 << 31 = 2G bytes = 0x400000 sectors.
> 
> Yes, that works as long as it's multiple of granularity.

Is granularity required to be a power of two? One would hope, but looking at the
code that doesn't appear to be a requirement... ugh, that's terrible...
