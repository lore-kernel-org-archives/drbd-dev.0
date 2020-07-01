Return-Path: <htejun@gmail.com>
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com
	[209.85.219.42])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id BBD724203EA
	for <drbd-dev@lists.linbit.com>; Wed,  1 Jul 2020 18:38:16 +0200 (CEST)
Received: by mail-qv1-f42.google.com with SMTP id p7so11286170qvl.4
	for <drbd-dev@lists.linbit.com>; Wed, 01 Jul 2020 09:38:16 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 1 Jul 2020 12:38:13 -0400
From: Tejun Heo <tj@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Message-ID: <20200701163813.GA5046@mtj.thefacebook.com>
References: <20200701090622.3354860-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200701090622.3354860-1-hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-raid@vger.kernel.org,
	linux-bcache@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-mm@kvack.org,
	dm-devel@redhat.com, cgroups@vger.kernel.org,
	linux-btrfs@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] remove dead bdi congestion leftovers
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

On Wed, Jul 01, 2020 at 11:06:18AM +0200, Christoph Hellwig wrote:
> Hi Jens,
> 
> we have a lot of bdi congestion related code that is left around without
> any use.  This series removes it in preparation of sorting out the bdi
> lifetime rules properly.

Acked-by: Tejun Heo <tj@kernel.org>

Thanks a lot for killing the dead code.

-- 
tejun
