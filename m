Return-Path: <hch@lst.de>
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id AE76B42000B
	for <drbd-dev@lists.linbit.com>; Wed, 27 May 2020 07:23:43 +0200 (CEST)
Date: Wed, 27 May 2020 07:23:41 +0200
From: Christoph Hellwig <hch@lst.de>
To: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <20200527052341.GA17530@lst.de>
References: <20200525113014.345997-1-hch@lst.de>
	<20200525113014.345997-2-hch@lst.de>
	<fafb94a9-cdce-5ea0-e73f-9463766a9f19@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fafb94a9-cdce-5ea0-e73f-9463766a9f19@yandex-team.ru>
Cc: Jens Axboe <axboe@kernel.dk>, linux-nvdimm@lists.01.org,
	linux-bcache@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, Minchan Kim <minchan@kernel.org>,
	dm-devel@redhat.com, Christoph Hellwig <hch@lst.de>,
	Nitin Gupta <ngupta@vflare.org>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 01/16] block: add disk/bio-based accounting
	helpers
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

On Mon, May 25, 2020 at 03:28:07PM +0300, Konstantin Khlebnikov wrote:
> I think it would be better to leave this jiffies legacy nonsense in
> callers and pass here request duration in nanoseconds.

jiffies is what the existing interfaces uses.  But now that they come
from the start helper fixing this will become easier.  I'll do that
as a follow on, as I'd rather not bloat this series even more.
