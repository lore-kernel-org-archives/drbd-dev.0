Return-Path: <BATV+78b913441a3cb29668e4+7690+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 01A6B420471
	for <drbd-dev@lists.linbit.com>; Thu, 12 Sep 2024 15:38:13 +0200 (CEST)
Date: Thu, 12 Sep 2024 06:19:46 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Qiu-ji Chen <chenqiuji666@gmail.com>
Subject: Re: [PATCH] brbd: Fix atomicity violation in drbd_uuid_set_bm()
Message-ID: <ZuLqcjFuPtmq_7Nj@infradead.org>
References: <20240911091619.4430-1-chenqiuji666@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911091619.4430-1-chenqiuji666@gmail.com>
Cc: axboe@kernel.dk, philipp.reisner@linbit.com, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	baijiaju1990@gmail.com, lars.ellenberg@linbit.com,
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

I can't really comment on the code here, but the subject needs a

s/brbd/drbd/

