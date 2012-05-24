Return-Path: <htejun@gmail.com>
Received: from mail-pb0-f54.google.com (mail-pb0-f54.google.com
	[209.85.160.54]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 04ADA1017A2C
	for <drbd-dev@lists.linbit.com>; Thu, 24 May 2012 18:09:51 +0200 (CEST)
Received: by pbbro2 with SMTP id ro2so590019pbb.27
	for <drbd-dev@lists.linbit.com>; Thu, 24 May 2012 09:09:49 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 24 May 2012 09:09:44 -0700
From: Tejun Heo <tj@kernel.org>
To: Kent Overstreet <koverstreet@google.com>
Message-ID: <20120524160944.GB27983@google.com>
References: <1337817771-25038-1-git-send-email-koverstreet@google.com>
	<1337817771-25038-2-git-send-email-koverstreet@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1337817771-25038-2-git-send-email-koverstreet@google.com>
Cc: axboe@kernel.dk, yehuda@hq.newdream.net, dm-devel@redhat.com, neilb@suse.de,
	linux-kernel@vger.kernel.org, linux-bcache@vger.kernel.org,
	mpatocka@redhat.com, vgoyal@redhat.com, bharrosh@panasas.com,
	linux-fsdevel@vger.kernel.org, sage@newdream.net, agk@redhat.com,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH v2 01/14] block: Generalized bio pool freeing
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Wed, May 23, 2012 at 05:02:38PM -0700, Kent Overstreet wrote:
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

Please drop Change-ID tag and it would be great how you tested the
changes, other than that,

 Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
