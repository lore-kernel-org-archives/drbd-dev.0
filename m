Return-Path: <keescook@google.com>
Received: from mail-yb0-f196.google.com (mail-yb0-f196.google.com
	[209.85.213.196])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id AB4501018D73
	for <drbd-dev@lists.linbit.com>; Mon,  6 Aug 2018 19:27:24 +0200 (CEST)
Received: by mail-yb0-f196.google.com with SMTP id d18-v6so1661189ybq.5
	for <drbd-dev@lists.linbit.com>; Mon, 06 Aug 2018 10:27:24 -0700 (PDT)
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <20180803134357.GB28982@soda.linbit>
References: <20180724164936.37477-1-keescook@chromium.org>
	<20180724164936.37477-13-keescook@chromium.org>
	<CAGXu5jJB6V0r8LXOGL6+sO0NVZ0HK3VCthML=T3gLEwMABhSDQ@mail.gmail.com>
	<20180803134357.GB28982@soda.linbit>
From: Kees Cook <keescook@chromium.org>
Date: Mon, 6 Aug 2018 10:27:22 -0700
Message-ID: <CAGXu5j+i5UoPRd64hzNa6E1juzOHvL_ta5COn+vtUnWMjkV0=A@mail.gmail.com>
To: Kees Cook <keescook@chromium.org>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Jens Axboe <axboe@kernel.dk>, Herbert Xu <herbert@gondor.apana.org.au>,
	Arnd Bergmann <arnd@arndb.de>, Eric Biggers <ebiggers@google.com>,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	linux-crypto <linux-crypto@vger.kernel.org>,
	drbd-dev@lists.linbit.com, linux-block <linux-block@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Drbd-dev] [PATCH v6 12/18] drbd: Convert from ahash to shash
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Fri, Aug 3, 2018 at 6:44 AM, Lars Ellenberg
<lars.ellenberg@linbit.com> wrote:
> On Thu, Aug 02, 2018 at 04:43:19PM -0700, Kees Cook wrote:
>> On Tue, Jul 24, 2018 at 9:49 AM, Kees Cook <keescook@chromium.org> wrote:
>> > In preparing to remove all stack VLA usage from the kernel[1], this
>> > removes the discouraged use of AHASH_REQUEST_ON_STACK in favor of
>> > the smaller SHASH_DESC_ON_STACK by converting from ahash-wrapped-shash
>> > to direct shash. By removing a layer of indirection this both improves
>> > performance and reduces stack usage. The stack allocation will be made
>> > a fixed size in a later patch to the crypto subsystem.
>>
>> Philipp or Lars, what do you think of this? Can this go via your tree
>> or maybe via Jens?
>>
>> I'd love an Ack or Review.
>
> I'm sorry, summer time and all, limited online time ;-)
>
> I'm happy for this to go in via Jens, or any other way.
>
> Being not that fluent in the crypto stuff,
> I will just "believe" most of it.
>
> I still think I found something, comments below:
>
>> > diff --git a/drivers/block/drbd/drbd_worker.c b/drivers/block/drbd/drbd_worker.c
>> > index 1476cb3439f4..62dd3700dd84 100644
>> > --- a/drivers/block/drbd/drbd_worker.c
>> > +++ b/drivers/block/drbd/drbd_worker.c
>> > @@ -295,60 +295,54 @@ void drbd_request_endio(struct bio *bio)
>> >                 complete_master_bio(device, &m);
>> >  }
>> >
>> > -void drbd_csum_ee(struct crypto_ahash *tfm, struct drbd_peer_request *peer_req, void *digest)
>> > +void drbd_csum_ee(struct crypto_shash *tfm, struct drbd_peer_request *peer_req, void *digest)
>> >  {
>> > -       AHASH_REQUEST_ON_STACK(req, tfm);
>> > -       struct scatterlist sg;
>> > +       SHASH_DESC_ON_STACK(desc, tfm);
>> >         struct page *page = peer_req->pages;
>> >         struct page *tmp;
>> >         unsigned len;
>> >
>> > -       ahash_request_set_tfm(req, tfm);
>> > -       ahash_request_set_callback(req, 0, NULL, NULL);
>> > +       desc->tfm = tfm;
>> > +       desc->flags = 0;
>> >
>> > -       sg_init_table(&sg, 1);
>> > -       crypto_ahash_init(req);
>> > +       crypto_shash_init(desc);
>> >
>> >         while ((tmp = page_chain_next(page))) {
>> >                 /* all but the last page will be fully used */
>> > -               sg_set_page(&sg, page, PAGE_SIZE, 0);
>> > -               ahash_request_set_crypt(req, &sg, NULL, sg.length);
>> > -               crypto_ahash_update(req);
>> > +               crypto_shash_update(desc, page_to_virt(page), PAGE_SIZE);
>
> These pages may be "highmem", so page_to_virt() seem not appropriate.
> I think the crypto_ahash_update() thingy did an implicit kmap() for us
> in the crypto_hash_walk()?
> Maybe it is good enough to add a kmap() here,
> and a kunmap() on the next line?

Oooh, excellent point. Thanks, I'll see what I can do to sort this out.

-Kees

-- 
Kees Cook
Pixel Security
