Return-Path: <msnitzer@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 7439C100542F
	for <drbd-dev@lists.linbit.com>; Tue,  7 Aug 2012 05:19:33 +0200 (CEST)
Date: Mon, 6 Aug 2012 23:19:21 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Kent Overstreet <koverstreet@google.com>
Message-ID: <20120807031921.GA31977@redhat.com>
References: <1344290921-25154-1-git-send-email-koverstreet@google.com>
	<1344290921-25154-6-git-send-email-koverstreet@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1344290921-25154-6-git-send-email-koverstreet@google.com>
Cc: axboe@kernel.dk, dm-devel@redhat.com, linux-kernel@vger.kernel.org,
	linux-bcache@vger.kernel.org, mpatocka@redhat.com,
	agk@redhat.com, sage@newdream.net, tj@kernel.org,
	yehuda@hq.newdream.net, vgoyal@redhat.com, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH v5 05/12] block: Kill bi_destructor
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Mon, Aug 06 2012 at  6:08pm -0400,
Kent Overstreet <koverstreet@google.com> wrote:

> Now that we've got generic code for freeing bios allocated from bio
> pools, this isn't needed anymore.
> 
> This also changes the semantics of bio_free() a bit - it now also frees
> bios allocated by bio_kmalloc(). It's also no longer exported, as
> without bi_destructor there should be no need for it to be called
> anywhere else.

Seems you forgot to remove bio_free's EXPORT_SYMBOL
