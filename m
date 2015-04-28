Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 0352F10518BE
	for <drbd-dev@lists.linbit.com>; Thu,  7 May 2015 11:35:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id F1CB744A5E5
	for <drbd-dev@lists.linbit.com>; Thu,  7 May 2015 11:35:38 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id LcRLyJtma14U for <drbd-dev@lists.linbit.com>;
	Thu,  7 May 2015 11:35:38 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id D3D8044A1C0
	for <drbd-dev@lists.linbit.com>; Thu,  7 May 2015 11:35:38 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Y9qQ07McjP0G for <drbd-dev@lists.linbit.com>;
	Thu,  7 May 2015 11:35:38 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id AA829449119
	for <drbd-dev@lists.linbit.com>; Thu,  7 May 2015 11:35:38 +0200 (CEST)
Resent-Message-ID: <20150507093538.GS18767@soda.linbit>
Date: Tue, 28 Apr 2015 18:31:37 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Ming Lin <mlin@kernel.org>
Message-ID: <20150428173137.GC12975@agk-dp.fab.redhat.com>
References: <1430203717-13307-1-git-send-email-mlin@kernel.org>
	<1430203717-13307-8-git-send-email-mlin@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1430203717-13307-8-git-send-email-mlin@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>,
	Alex Elder <elder@kernel.org>, Sage Weil <sage@inktank.com>,
	Mike Snitzer <snitzer@redhat.com>, Neil Brown <neilb@suse.de>,
	Jiri Kosina <jkosina@suse.cz>,
	Dave Chinner <dchinner@redhat.com>, linux-kernel@vger.kernel.org,
	Yehuda Sadeh <yehuda@inktank.com>, linux-raid@vger.kernel.org,
	dm-devel@redhat.com, Alasdair Kergon <agk@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	ceph-devel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Kent Overstreet <kent.overstreet@gmail.com>, drbd-user@lists.linbit.com,
	Lars Ellenberg <drbd-dev@lists.linbit.com>
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

On Mon, Apr 27, 2015 at 11:48:34PM -0700, Ming Lin wrote:
> As generic_make_request() is now able to handle arbitrarily sized bios,
> it's no longer necessary for each individual block driver to define its
> own ->merge_bvec_fn() callback. Remove every invocation completely.

merge_bvec_fn is also about telling the code building up bios what optimum
maximum size to use.
 
Have you got some test data to demonstrate that we won't find some situations
where performance is now lost by code building up bios that are far too big
and are always going to have to be split up later?

Alasdair

