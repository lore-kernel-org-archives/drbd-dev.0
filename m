Return-Path: <snitzer@redhat.com>
Received: from us-smtp-delivery-124.mimecast.com
	(us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 5EBF8420012
	for <drbd-dev@lists.linbit.com>; Thu, 27 Jan 2022 17:59:04 +0100 (CET)
Received: by mail-qk1-f197.google.com with SMTP id
	u12-20020a05620a0c4c00b00475a9324977so2773498qki.13
	for <drbd-dev@lists.linbit.com>; Thu, 27 Jan 2022 08:52:53 -0800 (PST)
Date: Thu, 27 Jan 2022 11:52:51 -0500
From: Mike Snitzer <snitzer@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Message-ID: <YfLN4/2bYe4hebCy@redhat.com>
References: <20220127063546.1314111-1-hch@lst.de>
MIME-Version: 1.0
In-Reply-To: <20220127063546.1314111-1-hch@lst.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Cc: Jens Axboe <axboe@kernel.dk>, Philipp Reisner <philipp.reisner@linbit.com>,
	linux-block@vger.kernel.org, dm-devel@redhat.com,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Pavel Begunkov <asml.silence@gmail.com>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] improve the bio cloning interface
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <https://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <https://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Thu, Jan 27 2022 at  1:35P -0500,
Christoph Hellwig <hch@lst.de> wrote:

> Hi Jens,
> 
> this series changes the bio cloning interface to match the rest changes
> to the bio allocation interface and passes the block_device and operation
> to the cloning helpers.  In addition it renames the cloning helpers to
> be more descriptive.
> 
> To get there it requires a bit of refactoring in the device mapper code.

I'd like to take a closer look, do you happen to have this series
available in a git branch?

The changes generally look fine.  Any chance you could forecast what
you're planning for follow-on changes?

Or is it best to just wait for you to produce those follow-on changes?

Thanks,
Mike

