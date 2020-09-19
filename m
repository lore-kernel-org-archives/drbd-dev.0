Return-Path: <hch@lst.de>
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id DAE17420375
	for <drbd-dev@lists.linbit.com>; Sat, 19 Sep 2020 08:58:18 +0200 (CEST)
Date: Sat, 19 Sep 2020 08:58:16 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jan Kara <jack@suse.cz>
Message-ID: <20200919065816.GA8237@lst.de>
References: <20200910144833.742260-1-hch@lst.de>
	<20200910144833.742260-4-hch@lst.de>
	<20200917095507.GJ7347@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917095507.GJ7347@quack2.suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>, linux-raid@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>, Minchan Kim <minchan@kernel.org>,
	Richard Weinberger <richard@nod.at>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	Song Liu <song@kernel.org>, dm-devel@redhat.com,
	linux-mtd@lists.infradead.org, linux-mm@kvack.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 03/12] drbd: remove RB_CONGESTED_REMOTE
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

On Thu, Sep 17, 2020 at 11:55:07AM +0200, Jan Kara wrote:
> On Thu 10-09-20 16:48:23, Christoph Hellwig wrote:
> > This case isn't ever used.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> Are you sure it's never used? As far as I'm reading drdb code the contents
> of the disk_conf structure seems to be received through netlink (that code
> is really a macro hell) and so read_balancing attribute passed to
> remote_due_to_read_balancing() can have any value userspace passed to it.

You are right, looking at how disk_conf is used I can't convince myself
that it is indeed not set through netlink and I've thus dropped the
patch.
