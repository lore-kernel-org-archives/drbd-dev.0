Return-Path: <neilb@suse.de>
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 20D454201F3
	for <drbd-dev@lists.linbit.com>; Fri,  4 Mar 2022 03:42:39 +0100 (CET)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Miklos Szeredi" <miklos@szeredi.hu>
In-reply-to: <CAJfpegsGOFD46KM8pxFAemokv9OOsCSHk=ag6jZZ=VscijMXZQ@mail.gmail.com>
References: <164549971112.9187.16871723439770288255.stgit@noble.brown>,
	<164549983737.9187.2627117501000365074.stgit@noble.brown>,
	<CAJfpegsGOFD46KM8pxFAemokv9OOsCSHk=ag6jZZ=VscijMXZQ@mail.gmail.com>
Date: Fri, 04 Mar 2022 13:42:29 +1100
Message-id: <164636174972.29369.5216919060965840586@noble.neil.brown.name>
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
Subject: Re: [Drbd-dev] [PATCH 04/11] fuse: remove reliance on bdi congestion
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

On Wed, 02 Mar 2022, Miklos Szeredi wrote:
> On Tue, 22 Feb 2022 at 04:18, NeilBrown <neilb@suse.de> wrote:
> >
> > The bdi congestion tracking in not widely used and will be removed.
> >
> > Fuse is one of a small number of filesystems that uses it, setting both
> > the sync (read) and async (write) congestion flags at what it determines
> > are appropriate times.
> >
> > The only remaining effect of the sync flag is to cause read-ahead to be
> > skipped.
> > The only remaining effect of the async flag is to cause (some)
> > WB_SYNC_NONE writes to be skipped.
> >
> > So instead of setting the flags, change:
> >  - .readahead to stop when it has submitted all non-async pages
> >     for read.
> >  - .writepages to do nothing if WB_SYNC_NONE and the flag would be set
> >  - .writepage to return AOP_WRITEPAGE_ACTIVATE if WB_SYNC_NONE
> >     and the flag would be set.
> >
> > The writepages change causes a behavioural change in that pageout() can
> > now return PAGE_ACTIVATE instead of PAGE_KEEP, so SetPageActive() will
> > be called on the page which (I think) will further delay the next attempt
> > at writeout.  This might be a good thing.
> >
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> >  fs/fuse/control.c |   17 -----------------
> >  fs/fuse/dev.c     |    8 --------
> >  fs/fuse/file.c    |   17 +++++++++++++++++
> >  3 files changed, 17 insertions(+), 25 deletions(-)
> >
> > diff --git a/fs/fuse/control.c b/fs/fuse/control.c
> > index 000d2e5627e9..7cede9a3bc96 100644
> > --- a/fs/fuse/control.c
> > +++ b/fs/fuse/control.c
> > @@ -164,7 +164,6 @@ static ssize_t fuse_conn_congestion_threshold_write(s=
truct file *file,
> >  {
> >         unsigned val;
> >         struct fuse_conn *fc;
> > -       struct fuse_mount *fm;
> >         ssize_t ret;
> >
> >         ret =3D fuse_conn_limit_write(file, buf, count, ppos, &val,
> > @@ -178,22 +177,6 @@ static ssize_t fuse_conn_congestion_threshold_write(=
struct file *file,
> >         down_read(&fc->killsb);
> >         spin_lock(&fc->bg_lock);
> >         fc->congestion_threshold =3D val;
> > -
> > -       /*
> > -        * Get any fuse_mount belonging to this fuse_conn; s_bdi is
> > -        * shared between all of them
> > -        */
> > -
> > -       if (!list_empty(&fc->mounts)) {
> > -               fm =3D list_first_entry(&fc->mounts, struct fuse_mount, f=
c_entry);
> > -               if (fc->num_background < fc->congestion_threshold) {
> > -                       clear_bdi_congested(fm->sb->s_bdi, BLK_RW_SYNC);
> > -                       clear_bdi_congested(fm->sb->s_bdi, BLK_RW_ASYNC);
> > -               } else {
> > -                       set_bdi_congested(fm->sb->s_bdi, BLK_RW_SYNC);
> > -                       set_bdi_congested(fm->sb->s_bdi, BLK_RW_ASYNC);
> > -               }
> > -       }
> >         spin_unlock(&fc->bg_lock);
> >         up_read(&fc->killsb);
> >         fuse_conn_put(fc);
> > diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> > index cd54a529460d..e1b4a846c90d 100644
> > --- a/fs/fuse/dev.c
> > +++ b/fs/fuse/dev.c
> > @@ -315,10 +315,6 @@ void fuse_request_end(struct fuse_req *req)
> >                                 wake_up(&fc->blocked_waitq);
> >                 }
> >
> > -               if (fc->num_background =3D=3D fc->congestion_threshold &&=
 fm->sb) {
> > -                       clear_bdi_congested(fm->sb->s_bdi, BLK_RW_SYNC);
> > -                       clear_bdi_congested(fm->sb->s_bdi, BLK_RW_ASYNC);
> > -               }
> >                 fc->num_background--;
> >                 fc->active_background--;
> >                 flush_bg_queue(fc);
> > @@ -540,10 +536,6 @@ static bool fuse_request_queue_background(struct fus=
e_req *req)
> >                 fc->num_background++;
> >                 if (fc->num_background =3D=3D fc->max_background)
> >                         fc->blocked =3D 1;
> > -               if (fc->num_background =3D=3D fc->congestion_threshold &&=
 fm->sb) {
> > -                       set_bdi_congested(fm->sb->s_bdi, BLK_RW_SYNC);
> > -                       set_bdi_congested(fm->sb->s_bdi, BLK_RW_ASYNC);
> > -               }
> >                 list_add_tail(&req->list, &fc->bg_queue);
> >                 flush_bg_queue(fc);
> >                 queued =3D true;
> > diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> > index 829094451774..94747bac3489 100644
> > --- a/fs/fuse/file.c
> > +++ b/fs/fuse/file.c
> > @@ -966,6 +966,14 @@ static void fuse_readahead(struct readahead_control =
*rac)
> >                 struct fuse_io_args *ia;
> >                 struct fuse_args_pages *ap;
> >
> > +               if (fc->num_background >=3D fc->congestion_threshold &&
> > +                   rac->ra->async_size >=3D readahead_count(rac))
> > +                       /*
> > +                        * Congested and only async pages left, so skip t=
he
> > +                        * rest.
> > +                        */
> > +                       break;
>=20
> Ah, you are taking care of it here...
>=20
> Regarding the async part: a potential (corner?) case is if task A is
> reading region X and triggering readahead for region Y and at the same
> time task B is reading region Y.  In the congestion case it can happen
> that non-uptodate pages in Y are truncated off the pagecache while B
> is waiting for them to become uptodate.

I don't think that is a problem.
If the second reader finds the non-uptodate page that is waiting for
attention from the readahead of the first reader, then it will wait
until the page is unlocked.  Once it gets the lock, it will find that
->mapping is NULL (in the middle of filemap_update_page() for example)
and so will drop the page and try again.
Second time around (in e.g. filemap_get_pages()) it will find that there
is no page, and so will call pagE_cache_sync_readahead() which allocates
some pages as appropriate and calls ->readahead() on them.

It might be best for the discarding of pages to having in reverse index
order so that there is no risk of waiting and retrying a series of
times, but I suspect that wouldn't happen very often.

>=20
> This shouldn't be too hard to trigger, just need two sequential
> readers of the same file, where one is just ahead of the other.  I'll
> try to do a test program for this case specifically.

Thanks - I'd love to hear of any test results you can produce.

Thanks,
NeilBrown
