Return-Path: <hch@lst.de>
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 52DCF4209BF
	for <drbd-dev@lists.linbit.com>; Mon, 21 Sep 2020 20:19:12 +0200 (CEST)
Date: Mon, 21 Sep 2020 20:18:41 +0200
From: Christoph Hellwig <hch@lst.de>
To: Coly Li <colyli@suse.de>
Message-ID: <20200921181841.GB2067@lst.de>
References: <20200921080734.452759-1-hch@lst.de>
	<20200921080734.452759-4-hch@lst.de>
	<b547a1b6-ab03-0520-012d-86d112c83d92@suse.de>
	<20200921140010.GA14672@lst.de>
	<5bcc52dc-ca8f-bbdd-69ef-4b6312e7994a@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bcc52dc-ca8f-bbdd-69ef-4b6312e7994a@suse.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-raid@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>, Justin Sanders <justin@coraid.com>,
	Minchan Kim <minchan@kernel.org>, Richard Weinberger <richard@nod.at>,
	linux-bcache@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, Song Liu <song@kernel.org>,
	dm-devel@redhat.com, linux-mtd@lists.infradead.org, linux-mm@kvack.org,
	Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 03/13] bcache: inherit the optimal I/O size
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

On Mon, Sep 21, 2020 at 11:09:48PM +0800, Coly Li wrote:
> I feel this is something should be fixed. Indeed I overlooked it until
> you point out the issue now.
> 
> The optimal request size and read ahead pages hint are necessary, but
> current initialization is simple. A better way might be dynamically
> setting them depends on the cache mode and some special configuration.
> 
> By your inspiration, I want to ACK your original patch although it
> doesn't work fine for all condition. Then we may know these two settings
> (ra_pages and queue_io_opt) should be improved for more situations. At
> lease for most part of the situations they provide proper hints.
> 
> How do you think of the above idea ?

Sounds like a plan.  I'd reall like to get this series in to get
some soaking before the end of the merge window, but we should still
have plenty of time for localized bcache updates.
