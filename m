Return-Path: <linux@roeck-us.net>
Received: from gateway22.websitewelcome.com (gateway22.websitewelcome.com
	[192.185.47.125])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 4F2CD420332
	for <drbd-dev@lists.linbit.com>; Wed, 23 Mar 2022 17:03:55 +0100 (CET)
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
	by gateway22.websitewelcome.com (Postfix) with ESMTP id 591F5377A
	for <drbd-dev@lists.linbit.com>; Wed, 23 Mar 2022 10:43:22 -0500 (CDT)
Date: Wed, 23 Mar 2022 08:43:19 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Christoph Hellwig <hch@lst.de>
Message-ID: <20220323154319.GA2268247@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Cc: Jens Axboe <axboe@kernel.dk>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	linux-nfs@vger.kernel.org, linux-nilfs <linux-nilfs@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mike Snitzer <snitzer@redhat.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Pavel Begunkov <asml.silence@gmail.com>, linux-block@vger.kernel.org,
	Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.co>,
	device-mapper development <dm-devel@redhat.com>,
	"Md . Haris Iqbal" <haris.iqbal@ionos.com>,
	linux-fsdevel@vger.kernel.org, xen-devel@lists.xenproject.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	ntfs3@lists.linux.dev, Jack Wang <jinpu.wang@ionos.com>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [dm-devel] [PATCH 01/19] fs: remove mpage_alloc
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

On Wed, Mar 23, 2022 at 07:42:48AM +0100, Christoph Hellwig wrote:
> On Wed, Mar 23, 2022 at 06:38:22AM +0900, Ryusuke Konishi wrote:
> > This looks because the mask of GFP_KERNEL is removed along with
> > the removal of mpage_alloc().
> > 
> 
> > The default value of the gfp flag is set to GFP_HIGHUSER_MOVABLE by
> > inode_init_always().
> > So, __GFP_HIGHMEM hits the gfp warning at bio_alloc() that
> > do_mpage_readpage() calls.
> 
> Yeah.  Let's try this to match the iomap code:
> 
> diff --git a/fs/mpage.c b/fs/mpage.c
> index 9ed1e58e8d70b..d465883edf719 100644
> --- a/fs/mpage.c
> +++ b/fs/mpage.c
> @@ -148,13 +148,11 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
>  	int op = REQ_OP_READ;
>  	unsigned nblocks;
>  	unsigned relative_block;
> -	gfp_t gfp;
> +	gfp_t gfp = mapping_gfp_constraint(page->mapping, GFP_KERNEL);
>  
>  	if (args->is_readahead) {
>  		op |= REQ_RAHEAD;
> -		gfp = readahead_gfp_mask(page->mapping);
> -	} else {
> -		gfp = mapping_gfp_constraint(page->mapping, GFP_KERNEL);
> +		gfp |= __GFP_NORETRY | __GFP_NOWARN;
>  	}
>  
>  	if (page_has_buffers(page))

That fixes the problem for me.

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
