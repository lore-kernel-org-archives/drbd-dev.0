Return-Path: <miklos@szeredi.hu>
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com
	[209.85.166.175])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 286A5421798
	for <drbd-dev@lists.linbit.com>; Tue,  1 Mar 2022 14:00:35 +0100 (CET)
Received: by mail-il1-f175.google.com with SMTP id i14so642049ilv.4
	for <drbd-dev@lists.linbit.com>; Tue, 01 Mar 2022 05:00:35 -0800 (PST)
MIME-Version: 1.0
References: <164549971112.9187.16871723439770288255.stgit@noble.brown>
	<164549983736.9187.16755913785880819183.stgit@noble.brown>
In-Reply-To: <164549983736.9187.16755913785880819183.stgit@noble.brown>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 1 Mar 2022 14:00:24 +0100
Message-ID: <CAJfpegs=DhCO62EFV0Q_i2fmqJnziJy1t4itP9deS=FuWEA=TQ@mail.gmail.com>
To: NeilBrown <neilb@suse.de>
Content-Type: text/plain; charset="UTF-8"
Cc: Jan Kara <jack@suse.cz>, linux-doc@vger.kernel.org,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-kernel@vger.kernel.org, linux-mm <linux-mm@kvack.org>,
	drbd-dev@lists.linbit.com, Paolo Valente <paolo.valente@linaro.org>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Ext4 <linux-ext4@vger.kernel.org>, Chao Yu <chao@kernel.org>,
	linux-nilfs@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
	ceph-devel@vger.kernel.org, Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	Jens Axboe <axboe@kernel.dk>, Linux NFS list <linux-nfs@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jeff Layton <jlayton@kernel.org>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Wu Fengguang <fengguang.wu@intel.com>,
	Anna Schumaker <anna.schumaker@netapp.com>
Subject: Re: [Drbd-dev] [PATCH 03/11] MM: improve cleanup when ->readpages
 doesn't process all pages.
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

On Tue, 22 Feb 2022 at 04:18, NeilBrown <neilb@suse.de> wrote:
>
> If ->readpages doesn't process all the pages, then it is best to act as
> though they weren't requested so that a subsequent readahead can try
> again.
> So:
>   - remove any 'ahead' pages from the page cache so they can be loaded
>     with ->readahead() rather then multiple ->read()s
>   - update the file_ra_state to reflect the reads that were actually
>     submitted.
>
> This allows ->readpages() to abort early due e.g.  to congestion, which
> will then allow us to remove the inode_read_congested() test from
> page_Cache_async_ra().
>
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  mm/readahead.c |   19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/mm/readahead.c b/mm/readahead.c
> index 73b2bc5302e0..8a97bd408cf6 100644
> --- a/mm/readahead.c
> +++ b/mm/readahead.c
> @@ -104,7 +104,13 @@
>   * for necessary resources (e.g.  memory or indexing information) to
>   * become available.  Pages in the final ``async_size`` may be
>   * considered less urgent and failure to read them is more acceptable.
> - * They will eventually be read individually using ->readpage().
> + * In this case it is best to use delete_from_page_cache() to remove the
> + * pages from the page cache as is automatically done for pages that
> + * were not fetched with readahead_page().  This will allow a
> + * subsequent synchronous read ahead request to try them again.  If they
> + * are left in the page cache, then they will be read individually using
> + * ->readpage().
> + *
>   */
>
>  #include <linux/kernel.h>
> @@ -226,8 +232,17 @@ static void read_pages(struct readahead_control *rac, struct list_head *pages,
>
>         if (aops->readahead) {
>                 aops->readahead(rac);
> -               /* Clean up the remaining pages */
> +               /*
> +                * Clean up the remaining pages.  The sizes in ->ra
> +                * maybe be used to size next read-ahead, so make sure
> +                * they accurately reflect what happened.
> +                */
>                 while ((page = readahead_page(rac))) {
> +                       rac->ra->size -= 1;
> +                       if (rac->ra->async_size > 0) {
> +                               rac->ra->async_size -= 1;
> +                               delete_from_page_cache(page);
> +                       }

Does the  above imply that filesystem should submit at least ra->size
pages, regardless of congestion?

Thanks,
Miklos
