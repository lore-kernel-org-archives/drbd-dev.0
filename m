Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id AB7E51012A92
	for <drbd-dev@lists.linbit.com>; Thu,  4 Oct 2012 14:39:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id A39D71B4369
	for <drbd-dev@lists.linbit.com>; Thu,  4 Oct 2012 14:39:09 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QnmNmWWarX-z for <drbd-dev@lists.linbit.com>;
	Thu,  4 Oct 2012 14:39:09 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id 8A8521B4368
	for <drbd-dev@lists.linbit.com>; Thu,  4 Oct 2012 14:39:09 +0200 (CEST)
Resent-Message-ID: <20121004123909.GM26479@soda.linbit>
Received: from mail-pa0-f54.google.com (mail-pa0-f54.google.com
	[209.85.220.54]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 73262100540F
	for <drbd-dev@lists.linbit.com>; Tue,  2 Oct 2012 22:26:29 +0200 (CEST)
Received: by padbi1 with SMTP id bi1so6382386pad.27
	for <drbd-dev@lists.linbit.com>; Tue, 02 Oct 2012 13:26:28 -0700 (PDT)
Date: Tue, 2 Oct 2012 13:20:26 -0700
From: Kent Overstreet <koverstreet@google.com>
To: Vivek Goyal <vgoyal@redhat.com>
Message-ID: <20121002202026.GN26488@google.com>
References: <1348526106-17074-1-git-send-email-koverstreet@google.com>
	<1348526106-17074-7-git-send-email-koverstreet@google.com>
	<20121002181001.GB3283@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20121002181001.GB3283@redhat.com>
Cc: axboe@kernel.dk, linux-s390@vger.kernel.org,
	Chris Mason <chris.mason@fusionio.com>, dm-devel@redhat.com,
	Jiri Kosina <jkosina@suse.cz>, Heiko Carstens <heiko.carstens@de.ibm.com>,
	linux-kernel@vger.kernel.org, tj@kernel.org, linux-bcache@vger.kernel.org,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Steven Whitehouse <swhiteho@redhat.com>, Alasdair Kergon <agk@redhat.com>,
	Lars Ellenberg <drbd-dev@lists.linbit.com>
Subject: Re: [Drbd-dev] [dm-devel] [PATCH v3 06/26] block: Add
	bio_end_sector()
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Tue, Oct 02, 2012 at 02:10:01PM -0400, Vivek Goyal wrote:
> On Mon, Sep 24, 2012 at 03:34:46PM -0700, Kent Overstreet wrote:
> 
> [..]
> > diff --git a/include/linux/bio.h b/include/linux/bio.h
> > index 4e32be1..d985e90 100644
> > --- a/include/linux/bio.h
> > +++ b/include/linux/bio.h
> > @@ -67,6 +67,7 @@
> >  #define bio_offset(bio)		bio_iovec((bio))->bv_offset
> >  #define bio_segments(bio)	((bio)->bi_vcnt - (bio)->bi_idx)
> >  #define bio_sectors(bio)	((bio)->bi_size >> 9)
> > +#define bio_end_sector(bio)	((bio)->bi_sector + bio_sectors(bio))
> 
> May be it is just me. But bio_end_sector() kind of sounds that it will
> calculate to the last sector of bio. So I thought of it more as
> bio_last_sector() and not the sector which is next to the last sector.
> 
> Will it make sense to introduce bio_last_sector() and use +1 everywhere.
> Or may be we need a better name. Can't think of one though.

Ugh, that sounds like it'd be just begging for fencepost errors. I've
never ran into a situation where I needed bio->bi_sector +
bio_sectors(bio) - 1, either.

I kind of see your point... it seems like there should be a name for
this concept (same as a pointer to the end of an array), but I can't
think of one.
