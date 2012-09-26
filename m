Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 5836A103B4CB
	for <drbd-dev@lists.linbit.com>; Wed, 26 Sep 2012 17:16:49 +0200 (CEST)
Date: Wed, 26 Sep 2012 17:16:48 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: Kent Overstreet <koverstreet@google.com>
Message-ID: <20120926151648.GB17722@soda.linbit>
References: <1348526106-17074-1-git-send-email-koverstreet@google.com>
	<1348526106-17074-7-git-send-email-koverstreet@google.com>
	<20120925115452.GF8143@soda.linbit>
	<20120925220624.GC22647@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120925220624.GC22647@google.com>
Cc: axboe@kernel.dk, linux-s390@vger.kernel.org,
	Chris Mason <chris.mason@fusionio.com>, dm-devel@redhat.com,
	neilb@suse.de, Jiri Kosina <jkosina@suse.cz>,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	linux-kernel@vger.kernel.org, tj@kernel.org,
	linux-bcache@vger.kernel.org, vgoyal@redhat.com,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Steven Whitehouse <swhiteho@redhat.com>, Alasdair Kergon <agk@redhat.com>,
	Lars Ellenberg <drbd-dev@lists.linbit.com>
Subject: Re: [Drbd-dev] [PATCH v3 06/26] block: Add bio_end_sector()
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Tue, Sep 25, 2012 at 03:06:24PM -0700, Kent Overstreet wrote:
> On Tue, Sep 25, 2012 at 01:54:52PM +0200, Lars Ellenberg wrote:
> > On Mon, Sep 24, 2012 at 03:34:46PM -0700, Kent Overstreet wrote:
> > > Just a little convenience macro - main reason to add it now is preparing
> > > for immutable bio vecs, it'll reduce the size of the patch that puts
> > > bi_sector/bi_size/bi_idx into a struct bvec_iter.
> > 
> > 
> > For the DRBD part:

> Version below look good?
> 
> diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
> index 01b2ac6..47f55db 100644
> --- a/drivers/block/drbd/drbd_req.c
> +++ b/drivers/block/drbd/drbd_req.c
> @@ -1144,7 +1144,7 @@ void drbd_make_request(struct request_queue *q, struct bio *bio)
>  	/* to make some things easier, force alignment of requests within the
>  	 * granularity of our hash tables */
>  	s_enr = bio->bi_sector >> HT_SHIFT;
> -	e_enr = bio->bi_size ? (bio->bi_sector+(bio->bi_size>>9)-1) >> HT_SHIFT : s_enr;
> +	e_enr = bio->bi_size ? (bio_end_sector(bio) - 1) >> HT_SHIFT : s_enr;
>  
>  	if (likely(s_enr == e_enr)) {
>  		do {

Sure.

Cheers,

	Lars

