Return-Path: <snitzer@redhat.com>
Received: from us-smtp-delivery-124.mimecast.com
	(us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id D084C420181
	for <drbd-dev@lists.linbit.com>; Wed,  2 Feb 2022 19:33:06 +0100 (CET)
Received: by mail-qk1-f199.google.com with SMTP id
	d130-20020a379b88000000b004e11e7b51c4so326438qke.17
	for <drbd-dev@lists.linbit.com>; Wed, 02 Feb 2022 10:33:04 -0800 (PST)
Date: Wed, 2 Feb 2022 13:33:02 -0500
From: Mike Snitzer <snitzer@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Message-ID: <YfrOXqVVwcwIoArj@redhat.com>
References: <20220202160109.108149-1-hch@lst.de>
	<20220202160109.108149-8-hch@lst.de>
MIME-Version: 1.0
In-Reply-To: <20220202160109.108149-8-hch@lst.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Cc: Jens Axboe <axboe@kernel.dk>, Philipp Reisner <philipp.reisner@linbit.com>,
	linux-block@vger.kernel.org, dm-devel@redhat.com,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Pavel Begunkov <asml.silence@gmail.com>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 07/13] dm: retun the clone bio from alloc_tio
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

On Wed, Feb 02 2022 at 11:01P -0500,
Christoph Hellwig <hch@lst.de> wrote:

> Return the clone bio embedded into the tio as that is what the callers
> actually want.  Similar for the free side.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Small nit, subject has typo: s/retun/return/

