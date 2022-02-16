Return-Path: <snitzer@redhat.com>
Received: from us-smtp-delivery-124.mimecast.com
	(us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id B6DA94201F0
	for <drbd-dev@lists.linbit.com>; Wed, 16 Feb 2022 19:45:12 +0100 (CET)
Received: by mail-qk1-f200.google.com with SMTP id
	q24-20020a05620a0c9800b0060d5d0b7a90so641474qki.11
	for <drbd-dev@lists.linbit.com>; Wed, 16 Feb 2022 10:45:10 -0800 (PST)
Date: Wed, 16 Feb 2022 13:45:08 -0500
From: Mike Snitzer <snitzer@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Message-ID: <Yg1GNMD6jIrKOxBE@redhat.com>
References: <20220209082828.2629273-1-hch@lst.de>
	<20220209082828.2629273-7-hch@lst.de>
MIME-Version: 1.0
In-Reply-To: <20220209082828.2629273-7-hch@lst.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Cc: axboe@kernel.dk, manoj@linux.ibm.com, linux-scsi@vger.kernel.org,
	martin.petersen@oracle.com, philipp.reisner@linbit.com,
	linux-block@vger.kernel.org, dm-devel@redhat.com,
	target-devel@vger.kernel.org, haris.iqbal@ionos.com,
	ukrishn@linux.ibm.com, lars.ellenberg@linbit.com,
	drbd-dev@lists.linbit.com, jinpu.wang@ionos.com, mrochs@linux.ibm.com
Subject: Re: [Drbd-dev] [PATCH 6/7] dm: remove write same support
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

On Wed, Feb 09 2022 at  3:28P -0500,
Christoph Hellwig <hch@lst.de> wrote:

> There are no more end-users of REQ_OP_WRITE_SAME left, so we can start
> deleting it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Thanks.

Reviewed-by: Mike Snitzer <snitzer@redhat.com>

