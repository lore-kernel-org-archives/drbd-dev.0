Return-Path: <hch@lst.de>
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 46D774201E2
	for <drbd-dev@lists.linbit.com>; Thu, 20 Jan 2022 09:40:36 +0100 (CET)
Date: Thu, 20 Jan 2022 09:34:07 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Message-ID: <20220120083407.GA5321@lst.de>
References: <20220118071952.1243143-1-hch@lst.de>
	<20220118071952.1243143-15-hch@lst.de>
	<245eaa0a-0796-0227-4abf-d1b78953557e@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <245eaa0a-0796-0227-4abf-d1b78953557e@nvidia.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	Pavel Begunkov <asml.silence@gmail.com>, Mike Snitzer <snitzer@redhat.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Christoph Hellwig <hch@lst.de>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.co>,
	"dm-devel@redhat.com" <dm-devel@redhat.com>,
	"linux-nilfs@vger.kernel.org" <linux-nilfs@vger.kernel.org>,
	"Md . Haris Iqbal" <haris.iqbal@ionos.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"ntfs3@lists.linux.dev" <ntfs3@lists.linux.dev>,
	Jack Wang <jinpu.wang@ionos.com>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	"drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>
Subject: Re: [Drbd-dev] [PATCH 14/19] block: pass a block_device and opf to
 blk_next_bio
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

On Tue, Jan 18, 2022 at 10:11:06PM +0000, Chaitanya Kulkarni wrote:
> On 1/17/22 11:19 PM, Christoph Hellwig wrote:
> > All callers need to set the block_device and operation, so lift that into
> > the common code.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> 
> I sent out the exact patch for this one, anyways looks good.
> 
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>

I'll switch attribution to you.
