Return-Path: <christoph.boehmwalder@linbit.com>
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
	[209.85.221.47])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 6B54A160849
	for <drbd-dev@lists.linbit.com>; Wed,  8 Apr 2026 14:01:47 +0200 (CEST)
Received: by mail-wr1-f47.google.com with SMTP id
	ffacd0b85a97d-43cf5fbacc9so408592f8f.1
	for <drbd-dev@lists.linbit.com>; Wed, 08 Apr 2026 05:01:47 -0700 (PDT)
Date: Wed, 8 Apr 2026 14:01:43 +0200
From: Christoph =?utf-8?Q?B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 06/20] drbd: add RDMA transport implementation
Message-ID: <adZCPanS7iZlcPE9@localhost.localdomain>
References: <20260327223820.2244227-1-christoph.boehmwalder@linbit.com>
	<20260327223820.2244227-7-christoph.boehmwalder@linbit.com>
	<adXq36pbGLXMZc2r@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <adXq36pbGLXMZc2r@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org, Philipp Reisner <philipp.reisner@linbit.com>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>, Lars Ellenberg <lars.ellenberg@linbit.com>,
	drbd-dev@lists.linbit.com
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

On Tue, Apr 07, 2026 at 10:42:55PM -0700, Christoph Hellwig wrote:
>You really need to add the RDMA mailing list before adding new RDMA
>code.  I'll try to review the bits I still remember, but you also
>need a maintainer ACK.

Thanks for the hint and your detailed feedback. I'll address all that
in v2 (plus some other similar fixes).

Thanks,
Christoph
