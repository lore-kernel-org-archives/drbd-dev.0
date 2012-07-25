Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 40B231055F68
	for <drbd-dev@lists.linbit.com>; Thu, 26 Jul 2012 11:35:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id 3A0131B4369
	for <drbd-dev@lists.linbit.com>; Thu, 26 Jul 2012 11:35:49 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GlYL4LW1fWhR for <drbd-dev@lists.linbit.com>;
	Thu, 26 Jul 2012 11:35:49 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id 1FCB81B4368
	for <drbd-dev@lists.linbit.com>; Thu, 26 Jul 2012 11:35:49 +0200 (CEST)
Resent-Message-ID: <20120726093549.GC29767@soda.linbit>
Received: from natasha.panasas.com (natasha.panasas.com [67.152.220.90])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 069DE100542F
	for <drbd-dev@lists.linbit.com>; Wed, 25 Jul 2012 14:03:57 +0200 (CEST)
Message-ID: <500FE092.6010108@panasas.com>
Date: Wed, 25 Jul 2012 15:03:30 +0300
From: Boaz Harrosh <bharrosh@panasas.com>
MIME-Version: 1.0
To: Kent Overstreet <koverstreet@google.com>
References: <1343160689-12378-1-git-send-email-koverstreet@google.com>
	<1343160689-12378-10-git-send-email-koverstreet@google.com>
In-Reply-To: <1343160689-12378-10-git-send-email-koverstreet@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: axboe@kernel.dk, dm-devel@redhat.com, neilb@suse.de,
	linux-kernel@vger.kernel.org, linux-bcache@vger.kernel.org,
	mpatocka@redhat.com, vgoyal@redhat.com, yehuda@hq.newdream.net,
	tj@kernel.org, sage@newdream.net, agk@redhat.com, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH v4 09/12] block: Rework bio_pair_split()
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On 07/24/2012 11:11 PM, Kent Overstreet wrote:

> This changes bio_pair_split() to use the new bio_split() underneath,
> which gets rid of the single page bio limitation. The various callers
> are fixed up for the slightly different struct bio_pair, and to remove
> the unnecessary checks.
> 
> Signed-off-by: Kent Overstreet <koverstreet@google.com>

<snip>

> +
> +extern struct bio *bio_split(struct bio *bio, int sectors,
> +			     gfp_t gfp, struct bio_set *bs);


nit:

Just for taking pride in my work, I'd move this extern declaration
to the previous patch that actually introduces it.

Cheers
Boaz

>  extern struct bio_pair *bio_pair_split(struct bio *bi, int first_sectors);
>  extern void bio_pair_release(struct bio_pair *dbio);
>  
> @@ -512,7 +514,6 @@ extern int bio_integrity_prep(struct bio *);
>  extern void bio_integrity_endio(struct bio *, int);
>  extern void bio_integrity_advance(struct bio *, unsigned int);
>  extern void bio_integrity_trim(struct bio *, unsigned int, unsigned int);
> -extern void bio_integrity_split(struct bio *, struct bio_pair *, int);
>  extern int bio_integrity_clone(struct bio *, struct bio *, gfp_t, struct bio_set *);
>  extern int bioset_integrity_create(struct bio_set *, int);
>  extern void bioset_integrity_free(struct bio_set *);
> @@ -556,12 +557,6 @@ static inline int bio_integrity_clone(struct bio *bio, struct bio *bio_src,
>  	return 0;
>  }
>  
> -static inline void bio_integrity_split(struct bio *bio, struct bio_pair *bp,
> -				       int sectors)
> -{
> -	return;
> -}
> -
>  static inline void bio_integrity_advance(struct bio *bio,
>  					 unsigned int bytes_done)
>  {


