Return-Path: <msnitzer@redhat.com>
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
	[205.139.110.120])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 66E5A4203EC
	for <drbd-dev@lists.linbit.com>; Wed,  1 Jul 2020 20:32:26 +0200 (CEST)
Date: Wed, 1 Jul 2020 13:24:48 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Message-ID: <20200701172448.GA27528@redhat.com>
References: <20200701085947.3354405-1-hch@lst.de>
	<20200701085947.3354405-11-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200701085947.3354405-11-hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-xtensa@linux-xtensa.org,
	linux-s390@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	linux-nvdimm@lists.01.org, dm-devel@redhat.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-raid@vger.kernel.org, linux-bcache@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 10/20] dm: stop using ->queuedata
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

On Wed, Jul 01 2020 at  4:59am -0400,
Christoph Hellwig <hch@lst.de> wrote:

> Instead of setting up the queuedata as well just use one private data
> field.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Mike Snitzer <snitzer@redhat.com>

