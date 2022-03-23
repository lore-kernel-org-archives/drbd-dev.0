Return-Path: <konishi.ryusuke@gmail.com>
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com
	[209.85.128.178])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id D09CB42034F
	for <drbd-dev@lists.linbit.com>; Wed, 23 Mar 2022 10:29:35 +0100 (CET)
Received: by mail-yw1-f178.google.com with SMTP id
	00721157ae682-2e5e176e1b6so9781057b3.13
	for <drbd-dev@lists.linbit.com>; Wed, 23 Mar 2022 02:29:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220124091107.642561-1-hch@lst.de>
	<20220124091107.642561-2-hch@lst.de>
	<20220322211915.GA2413063@roeck-us.net>
	<CAKFNMonRd5QQMzLoH3T=M=C=2Q_j9d86EYzZeY4DU2HQAE3E8w@mail.gmail.com>
	<20220323064248.GA24874@lst.de>
In-Reply-To: <20220323064248.GA24874@lst.de>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Wed, 23 Mar 2022 18:29:23 +0900
Message-ID: <CAKFNMonANUN7_99oVBOq=iCJpt6jQs3qhu1ez5SwMm2g7sZUyw@mail.gmail.com>
To: Christoph Hellwig <hch@lst.de>, Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Cc: Jens Axboe <axboe@kernel.dk>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	linux-nfs@vger.kernel.org, linux-nilfs <linux-nilfs@vger.kernel.org>,
	Mike Snitzer <snitzer@redhat.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Pavel Begunkov <asml.silence@gmail.com>, linux-block@vger.kernel.org,
	=?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.co>,
	device-mapper development <dm-devel@redhat.com>,
	"Md . Haris Iqbal" <haris.iqbal@ionos.com>,
	linux-fsdevel@vger.kernel.org, xen-devel@lists.xenproject.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	ntfs3@lists.linux.dev, Jack Wang <jinpu.wang@ionos.com>,
	Andrew Morton <akpm@linux-foundation.org>, drbd-dev@lists.linbit.com
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

On Wed, Mar 23, 2022 at 3:42 PM Christoph Hellwig <hch@lst.de> wrote:
>
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
>         int op = REQ_OP_READ;
>         unsigned nblocks;
>         unsigned relative_block;
> -       gfp_t gfp;
> +       gfp_t gfp = mapping_gfp_constraint(page->mapping, GFP_KERNEL);
>
>         if (args->is_readahead) {
>                 op |= REQ_RAHEAD;
> -               gfp = readahead_gfp_mask(page->mapping);
> -       } else {
> -               gfp = mapping_gfp_constraint(page->mapping, GFP_KERNEL);
> +               gfp |= __GFP_NORETRY | __GFP_NOWARN;
>         }
>
>         if (page_has_buffers(page))

I did not test for iomap, but this patch has fixed the same regression on the
latest mainline at least for ext2, exfat, vfat and nilfs2.  Thanks!

Ryusuke Konishi
