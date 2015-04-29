Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 9CB3610518BF
	for <drbd-dev@lists.linbit.com>; Thu,  7 May 2015 11:35:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 92B2D449119
	for <drbd-dev@lists.linbit.com>; Thu,  7 May 2015 11:35:40 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id YLE8NA9g8KU1 for <drbd-dev@lists.linbit.com>;
	Thu,  7 May 2015 11:35:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 76A7E44A5E5
	for <drbd-dev@lists.linbit.com>; Thu,  7 May 2015 11:35:40 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id I8mZ5F6XxLyC for <drbd-dev@lists.linbit.com>;
	Thu,  7 May 2015 11:35:40 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 2B68D449119
	for <drbd-dev@lists.linbit.com>; Thu,  7 May 2015 11:35:39 +0200 (CEST)
Resent-Message-ID: <20150507093538.GT18767@soda.linbit>
MIME-Version: 1.0
In-Reply-To: <20150428173137.GC12975@agk-dp.fab.redhat.com>
References: <1430203717-13307-1-git-send-email-mlin@kernel.org>
	<1430203717-13307-8-git-send-email-mlin@kernel.org>
	<20150428173137.GC12975@agk-dp.fab.redhat.com>
Date: Tue, 28 Apr 2015 23:32:00 -0700
Message-ID: <CAF1ivSb0OfbH8diZwep+ay-gYy3eV8yaY_RbdMjTs7Vp2t=WOg@mail.gmail.com>
From: Ming Lin <mlin@kernel.org>
To: lkml <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, Kent Overstreet <kent.overstreet@gmail.com>,
	Dongsu Park <dongsu.park@profitbricks.com>,
	Lars Ellenberg <drbd-dev@lists.linbit.com>,
	drbd-user@lists.linbit.com, Jiri Kosina <jkosina@suse.cz>,
	Yehuda Sadeh <yehuda@inktank.com>, Sage Weil <sage@inktank.com>,
	Alex Elder <elder@kernel.org>,
	ceph-devel@vger.kernel.org, Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
	Neil Brown <neilb@suse.de>,
	linux-raid@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Dave Chinner <dchinner@redhat.com>, Wu Fengguang <fengguang.wu@intel.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Drbd-dev] [PATCH 07/10] block: kill merge_bvec_fn() completely
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

On Tue, Apr 28, 2015 at 10:31 AM, Alasdair G Kergon <agk@redhat.com> wrote:
> On Mon, Apr 27, 2015 at 11:48:34PM -0700, Ming Lin wrote:
>> As generic_make_request() is now able to handle arbitrarily sized bios,
>> it's no longer necessary for each individual block driver to define its
>> own ->merge_bvec_fn() callback. Remove every invocation completely.
>
> merge_bvec_fn is also about telling the code building up bios what optimum
> maximum size to use.
>
> Have you got some test data to demonstrate that we won't find some situations
> where performance is now lost by code building up bios that are far too big
> and are always going to have to be split up later?

Not yet.
Fengguang will help to run some tests.

Thanks.

>
> Alasdair
>
