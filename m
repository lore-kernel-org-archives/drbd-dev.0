Return-Path: <htejun@gmail.com>
Received: from mail-pb0-f54.google.com (mail-pb0-f54.google.com
	[209.85.160.54]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id BD2391019A78
	for <drbd-dev@lists.linbit.com>; Mon, 28 May 2012 03:15:40 +0200 (CEST)
Received: by pbbro2 with SMTP id ro2so5009375pbb.27
	for <drbd-dev@lists.linbit.com>; Sun, 27 May 2012 18:15:38 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 28 May 2012 10:15:22 +0900
From: Tejun Heo <tj@kernel.org>
To: Kent Overstreet <koverstreet@google.com>
Message-ID: <20120528011522.GA9891@dhcp-172-17-108-109.mtv.corp.google.com>
References: <1337977539-16977-1-git-send-email-koverstreet@google.com>
	<1337977539-16977-2-git-send-email-koverstreet@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1337977539-16977-2-git-send-email-koverstreet@google.com>
Cc: axboe@kernel.dk, yehuda@hq.newdream.net, dm-devel@redhat.com, neilb@suse.de,
	linux-kernel@vger.kernel.org, linux-bcache@vger.kernel.org,
	mpatocka@redhat.com, vgoyal@redhat.com, bharrosh@panasas.com,
	linux-fsdevel@vger.kernel.org, sage@newdream.net, agk@redhat.com,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH v3 01/16] block: Generalized bio pool freeing
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hello, Kent.

On Fri, May 25, 2012 at 01:25:24PM -0700, Kent Overstreet wrote:
> With the old code, when you allocate a bio from a bio pool you have to
> implement your own destructor that knows how to find the bio pool the
> bio was originally allocated from.
> 
> This adds a new field to struct bio (bi_pool) and changes
> bio_alloc_bioset() to use it. This makes various bio destructors
> unnecessary, so they're then deleted.
> 
> Signed-off-by: Kent Overstreet <koverstreet@google.com>
> Change-Id: I5eb66c1d6910757f4af8755b8857dcbe4619cf8d

In the previous review, I made two requests about this patch.

* Please improve description.

* Please lose Change-Id.

None of which seems to have happened and my Acked-by isn't added
either.  Come on.  Give me some reason to keep reviewing this stuff.
A couple more suggestions.

* If this goes in, it will go through Jens' block tree.  Better keep
  him cc'd.

* It's generally a good idea to have Cc: tags in the description
  footer for the maintainers of the affected subsystems.

Thanks.

-- 
tejun
