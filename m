Return-Path: <axboe@kernel.dk>
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com
	[209.85.166.170])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 2D8BC4203D0
	for <drbd-dev@lists.linbit.com>; Tue, 28 Jul 2020 17:42:30 +0200 (CEST)
Received: by mail-il1-f170.google.com with SMTP id b18so11363434ilo.12
	for <drbd-dev@lists.linbit.com>; Tue, 28 Jul 2020 08:42:30 -0700 (PDT)
To: Christoph Hellwig <hch@lst.de>
References: <20200724073313.138789-1-hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <0b2b59d4-da4c-33df-82b4-0d4935b91e6e@kernel.dk>
Date: Tue, 28 Jul 2020 09:41:28 -0600
MIME-Version: 1.0
In-Reply-To: <20200724073313.138789-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: linux-raid@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
	Minchan Kim <minchan@kernel.org>, Richard Weinberger <richard@nod.at>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	Song Liu <song@kernel.org>, dm-devel@redhat.com,
	linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	cgroups@vger.kernel.org, linux-mm@kvack.org, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] bdi cleanups v3
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

On 7/24/20 1:32 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series contains a bunch of different BDI cleanups.  The biggest item
> is to isolate block drivers from the BDI in preparation of changing the
> lifetime of the block device BDI in a follow up series.

Applied, thanks.

-- 
Jens Axboe

