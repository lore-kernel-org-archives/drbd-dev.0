Return-Path: <axboe@suse.de>
Date: Thu, 3 Feb 2005 09:38:49 +0100
From: Jens Axboe <axboe@suse.de>
To: Philipp Reisner <philipp.reisner@linbit.com>
Subject: Re: [Drbd-dev] Re: [DRBD-cvs] r1743 - in branches/drbd-0.7: . drbd
Message-ID: <20050203083848.GA2728@suse.de>
References: <20050131111921.EE6F83BE6D@garcon.linbit.com>
	<200502011836.43449.philipp.reisner@linbit.com>
	<20050202101322.GQ7628@marowsky-bree.de>
	<200502021859.10633.philipp.reisner@linbit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200502021859.10633.philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Wed, Feb 02 2005, Philipp Reisner wrote:
> Am Mittwoch, 2. Februar 2005 11:13 schrieb Lars Marowsky-Bree:
> > On 2005-02-01T18:36:43, Philipp Reisner <philipp.reisner@linbit.com> wrote:
> > > I did not look at the comments, I read the code. And what I read there
> > > was: a BIO has after bio_init() a refcount (bi_cnt) of 1. It is freed
> > > when the refcount drops to zero.
> > >
> > > bio_alloc();
> > > do something with it
> >
> > "submit_bio()" is slightly different from just "something".
> 
> in which regard ?  We should not free it while we do something
> with it.. that is true for something and for submit_bio() :)
> 
> > > bio_put();
> > >
> > > is right.
> > >
> > > What you did is:
> > >
> > > bio_alloc();
> > > bio_get();   // increase to 2
> > > bio_put();   // decreat to 1
> > >
> > > and let it live forever...
> >
> > The cleanup at the end of the bio processing however should drop the bio
> > reference count too. Which is why the comment in bio.h says what it is.
> > Either the comment is wrong (and Jens's very same fix for the md code,
> > too), or you have introduced a race condition into the actlog.
> 
> Why do you not simply read the code ? 
> 
> Right in case you return from the function that alocated the bio, then
> it is a good idea to use the reference counting to make the completion
> handler to free it. This would be something like this:
> 
> STATIC int _drbd_md_async_page_io(...)
> {
>  struct bio *bio = bio_alloc(GFP_KERNEL, 1);
> 
>  bio->bi_end_io = drbd_md_io_complete_a;
>  submit_bio(rw, bio);
> 
>  return;
> }
> 
> You see, there is no single bio_get() or bio_put() ... What refcount
> will the bio have ? Right it will have one (1), so the bio lives on...

That's because you don't touch the bio after submit_bio(), if you did
you would need to grab a reference to it.

> After some while, when the disk was so nice to write our request the
> bio completion function would be called:
> 
> int drbd_md_io_complete_a(struct bio *bio, unsigned int bytes_done, int error)
> {
>  if (bio->bi_size)
>   return 1;
> 
>  put_bio(bio);
>  return 0;
> }
> 
> And here we would decrease the BIOs refcount to 0 and free it.
> 
> BUT the function we talk about has SYNCHRONOUS semantics! Otherwise
> it would have never worked with a BIO on the stack... Read carefull:
> 
> STATIC int _drbd_md_sync_page_io(drbd_dev *mdev, struct page *page, 
>      sector_t sector, int rw, int size)
> {
>  struct bio *bio = bio_alloc(GFP_KERNEL, 1);
> 
>  bio->bi_end_io = drbd_md_io_complete;
> 
>  wait_for_completion(&event);
> 
>  bio_put(bio);
>  return ok;
> }
> 
> and the corresponding io-completion function:
> 
> int drbd_md_io_complete(struct bio *bio, unsigned int bytes_done, int error)
> {
>  if (bio->bi_size)
>   return 1;
> 
>  complete((struct completion*)bio->bi_private);
>  return 0;
> }

That matching pair is fine.

> So our _drbd_md_sync_page_io() sleeps in wait_for_completion() until the
> whole action is carried out, and then ... in the same scope where I allocated
> the bio I free it by calling bio_put() --- 
> I could do it on the stack -- But I should use bio_init() the... 
> 
> Jens: 
>       Please tell Lars that I am right on how the refcounting works.

It seems you are. The md fix is actually leaky, since the bio_end_io
doesn't put the bio. An oversight on my behalf. It's only called only
called on init so no continual leak.

>       And, BTW, is there any reason to not have a BIO on the stack ?
>       Besides people return from the function before the completion callback
>       was called ?
>
>       In other words: Might something below me increase the refcount of the
>       BIO and keep the reference even after my IO completion function was
>       called ?

That's a good point. On-stack objects really interfer with reference
counting, such as used by bios. We had trouble with this and struct
requests in the future as well, so I would really discourage on-stack
bios completely. I'll make sure that there are no in-kernel uses of this
soonish, probably with a little WARN_ON() to catch out of tree uses as
well.

-- 
Jens Axboe

