Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 8DFA81056421
	for <drbd-dev@lists.linbit.com>; Tue, 29 Mar 2016 10:13:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 7CC9C3F0DC0
	for <drbd-dev@lists.linbit.com>; Tue, 29 Mar 2016 10:13:47 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id NmvlXcbiEYdp for <drbd-dev@lists.linbit.com>;
	Tue, 29 Mar 2016 10:13:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 598233F0DC5
	for <drbd-dev@lists.linbit.com>; Tue, 29 Mar 2016 10:13:47 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id u-eJxsignpGz for <drbd-dev@lists.linbit.com>;
	Tue, 29 Mar 2016 10:13:47 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 320373F0DC0
	for <drbd-dev@lists.linbit.com>; Tue, 29 Mar 2016 10:13:47 +0200 (CEST)
Resent-Message-ID: <20160329081346.GH15579@soda.linbit>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 1EE9D1056444
	for <drbd-dev@lists.linbit.com>; Tue, 29 Mar 2016 03:33:15 +0200 (CEST)
Received: from mail-yw0-f171.google.com ([209.85.161.171])
	by youngberry.canonical.com with esmtpsa
	(TLS1.0:RSA_AES_128_CBC_SHA1:16) (Exim 4.76)
	(envelope-from <ming.lei@canonical.com>) id 1akiWw-0002re-33
	for drbd-dev@lists.linbit.com; Tue, 29 Mar 2016 01:33:14 +0000
Received: by mail-yw0-f171.google.com with SMTP id g127so1699017ywf.2
	for <drbd-dev@lists.linbit.com>; Mon, 28 Mar 2016 18:33:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1458627149-12988-1-git-send-email-ming.lei@canonical.com>
References: <1458627149-12988-1-git-send-email-ming.lei@canonical.com>
Date: Tue, 29 Mar 2016 09:33:13 +0800
Message-ID: <CACVXFVPABFW=dnv_g6noXg5w-sdTTBxaickn8HSLSCd8KJcd0A@mail.gmail.com>
From: Ming Lei <ming.lei@canonical.com>
To: Jens Axboe <axboe@kernel.dk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Cc: Christoph Hellwig <hch@infradead.org>, Boaz Harrosh <boaz@plexistor.com>,
	Dave Chinner <david@fromorbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>, xfs@oss.sgi.com,
	linux-block@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Anton Altaparmakov <anton@tuxera.com>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 0/8] block: prepare for multipage bvecs
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

On Tue, Mar 22, 2016 at 2:12 PM, Ming Lei <ming.lei@canonical.com> wrote:
> Hi,
>
> Interests[1] have been shown in multipage bvecs, so this patchset
> try to prepare for the support and do two things:
>
> 1) the 1st 4 patches use bvec iterator to implement iterate_bvec(),
> then we can drop the non-standard way for iterating bvec
>
> 2) remove BIO_MAX_SECTORS & BIO_MAX_SIZE, and now there is only
> one user for each. Once multipage bvecs is introduced, one bio
> may hold lots of sectors, and we should always use sort of BIO_MAX_VECS
> which should be introduced in future and is similiar with current
> BIO_MAX_PAGES.
>
> xfstests(-a auto) have been run and no regression found by this
> patchset against linus v4.5+.

Hi Jens,

Looks no one objects this patchset, and the change of iov_iter.c
is a good cleanup too, so what do you think of the patchset?

Thanks,
Ming

>
>  drivers/block/drbd/drbd_int.h |  4 +--
>  fs/xfs/xfs_buf.c              |  2 +-
>  include/linux/bio.h           | 55 +------------------------------
>  include/linux/blk_types.h     |  4 +--
>  include/linux/bvec_iter.h     | 77 +++++++++++++++++++++++++++++++++++++++++++
>  lib/iov_iter.c                | 31 +++++++----------
>  6 files changed, 94 insertions(+), 79 deletions(-)
>
>
> [1], http://marc.info/?w=2&r=1&s=++[LSF%2FMM+ATTEND]+block%3A+multipage+bvecs&q=t
>
>
> Thanks,
> Ming
>
