Return-Path: <BATV+d35b8156291902ea7f6c+6794+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id A989A4205A5
	for <drbd-dev@lists.linbit.com>; Thu, 31 Mar 2022 07:45:49 +0200 (CEST)
Date: Wed, 30 Mar 2022 22:45:47 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph.boehmwalder@linbit.com>
Message-ID: <YkVACyO7rReUAjqj@infradead.org>
References: <20220330185551.3553196-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220330185551.3553196-1-christoph.boehmwalder@linbit.com>
Cc: Philipp Reisner <philipp.reisner@linbit.com>, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	Jens Axboe <abxoe@kernel.dk>, Lars Ellenberg <lars.ellenberg@linbit.com>,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [RESEND PATCH] drbd: fix potential silent data
	corruption
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

The change looks good, but this really should grow a proper Fixes tag.

