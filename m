Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wm0-f66.google.com (mail-wm0-f66.google.com [74.125.82.66])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 4C2B2100542C
	for <drbd-dev@lists.linbit.com>; Wed, 23 May 2018 15:40:43 +0200 (CEST)
Received: by mail-wm0-f66.google.com with SMTP id m129-v6so9304198wmb.3
	for <drbd-dev@lists.linbit.com>; Wed, 23 May 2018 06:40:43 -0700 (PDT)
Received: from soda.linbit ([86.59.100.100]) by smtp.gmail.com with ESMTPSA id
	a2-v6sm10348569edd.39.2018.05.23.06.40.41
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 23 May 2018 06:40:42 -0700 (PDT)
Resent-Message-ID: <20180523134040.GT499@soda.linbit>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 4013A101AC56
	for <drbd-dev@lists.linbit.com>; Mon, 21 May 2018 17:33:41 +0200 (CEST)
Date: Mon, 21 May 2018 17:12:51 +0200
From: David Sterba <dsterba@suse.cz>
To: Jens Axboe <axboe@kernel.dk>
Message-ID: <20180521151251.GX6649@twin.jikos.cz>
References: <20180520222558.7053-1-kent.overstreet@gmail.com>
	<20180521140348.GA19069@redhat.com>
	<686d7df6-c7d1-48a6-b7ff-48dc8aff6a62@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <686d7df6-c7d1-48a6-b7ff-48dc8aff6a62@kernel.dk>
Cc: hch@infradead.org, linux-xfs@vger.kernel.org, linux-raid@vger.kernel.org,
	Mike Snitzer <snitzer@redhat.com>, darrick.wong@oracle.com,
	linux-kernel@vger.kernel.org, colyli@suse.de,
	linux-block@vger.kernel.org, clm@fb.com, neilb@suse.com,
	bacik@fb.com, Kent Overstreet <kent.overstreet@gmail.com>,
	linux-btrfs@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 00/13] convert block layer to
	bioset_init()/mempool_init()
Reply-To: dsterba@suse.cz
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

On Mon, May 21, 2018 at 08:19:58AM -0600, Jens Axboe wrote:
> On 5/21/18 8:03 AM, Mike Snitzer wrote:
> > On Sun, May 20 2018 at  6:25pm -0400,
> > Kent Overstreet <kent.overstreet@gmail.com> wrote:
> > 
> >> Jens - this series does the rest of the conversions that Christoph wanted, and
> >> drops bioset_create().
> >>
> >> Only lightly tested, but the changes are pretty mechanical. Based on your
> >> for-next tree.
> > 
> > By switching 'mempool_t *' to 'mempool_t' and 'bio_set *' to 'bio_set'
> > you've altered the alignment of members in data structures.  So I'll
> > need to audit all the data structures you've modified in DM.
> > 
> > Could we get the backstory on _why_ you're making this change?
> > Would go a long way to helping me appreciate why this is a good use of
> > anyone's time.
> 
> Yeah, it's in the first series, it gets rid of a pointer indirection.

This should to be also mentioned the changelog of each patch. There are
12 subsystems changed, this could be about 10 maintainers and I guess
everybody has the same question why the change is made.

The conversion is not exactly the same in all patches, the simple
pointer -> static variable can be possibly covered by the same generic
text but as Mike points out the alignment changes should be at least
mentioned for consideration otherwise.
