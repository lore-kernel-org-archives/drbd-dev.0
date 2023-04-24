Return-Path: <senozhatsky@chromium.org>
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com
	[209.85.210.181])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id C45144202F5
	for <drbd-dev@lists.linbit.com>; Mon, 24 Apr 2023 04:36:31 +0200 (CEST)
Received: by mail-pf1-f181.google.com with SMTP id
	d2e1a72fcca58-63b4e5fdb1eso4965573b3a.1
	for <drbd-dev@lists.linbit.com>; Sun, 23 Apr 2023 19:36:31 -0700 (PDT)
Date: Mon, 24 Apr 2023 11:36:23 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Message-ID: <20230424023623.GC1496740@google.com>
References: <20230421195807.2804512-1-mcgrof@kernel.org>
	<20230421195807.2804512-6-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421195807.2804512-6-mcgrof@kernel.org>
Cc: djwong@kernel.org, philipp.reisner@linbit.com, linux-mm@kvack.org,
	dm-devel@redhat.com, agk@redhat.com, drbd-dev@lists.linbit.com,
	willy@infradead.org, hch@infradead.org, p.raghav@samsung.com,
	senozhatsky@chromium.org, snitzer@kernel.org,
	linux-block@vger.kernel.org, hare@suse.de, kbusch@kernel.org,
	axboe@kernel.dk, da.gomez@samsung.com,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	minchan@kernel.org, patches@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, lars.ellenberg@linbit.com
Subject: Re: [Drbd-dev] [PATCH 5/5] zram: use generic PAGE_SECTORS and
	PAGE_SECTORS_SHIFT
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

On (23/04/21 12:58), Luis Chamberlain wrote:
> 
> Instead of re-defining the already existing constants use the provided ones:
> 
> So replace:
> 
>  o SECTORS_PER_PAGE_SHIFT with PAGE_SECTORS_SHIFT
>  o SECTORS_PER_PAGE       with PAGE_SECTORS
> 
> This produces no functional changes.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
