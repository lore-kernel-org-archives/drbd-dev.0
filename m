Return-Path: <msnitzer@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id B8A7C100008C
	for <drbd-dev@lists.linbit.com>; Fri, 25 May 2012 22:47:08 +0200 (CEST)
Date: Fri, 25 May 2012 16:46:51 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Kent Overstreet <koverstreet@google.com>
Message-ID: <20120525204651.GA24246@redhat.com>
References: <1337977539-16977-1-git-send-email-koverstreet@google.com>
	<1337977539-16977-15-git-send-email-koverstreet@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1337977539-16977-15-git-send-email-koverstreet@google.com>
Cc: axboe@kernel.dk, dm-devel@redhat.com, Dave Chinner <dchinner@redhat.com>,
	linux-kernel@vger.kernel.org, tj@kernel.org,
	linux-bcache@vger.kernel.org, mpatocka@redhat.com,
	agk@redhat.com, bharrosh@panasas.com,
	linux-fsdevel@vger.kernel.org, yehuda@hq.newdream.net,
	drbd-dev@lists.linbit.com, vgoyal@redhat.com, sage@newdream.net
Subject: Re: [Drbd-dev] [PATCH v3 14/16] Gut bio_add_page()
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Fri, May 25 2012 at  4:25pm -0400,
Kent Overstreet <koverstreet@google.com> wrote:

> Since generic_make_request() can now handle arbitrary size bios, all we
> have to do is make sure the bvec array doesn't overflow.

I'd love to see the merge_bvec stuff go away but it does serve a
purpose: filesystems benefit from accurately building up much larger
bios (based on underlying device limits).  XFS has leveraged this for
some time and ext4 adopted this (commit bd2d0210cf) because of the
performance advantage.

So if you don't have a mechanism for the filesystem's IO to have
accurate understanding of the limits of the device the filesystem is
built on (merge_bvec was the mechanism) and are leaning on late
splitting does filesystem performance suffer?

Would be nice to see before and after XFS and ext4 benchmarks against a
RAID device (level 5 or 6).  I'm especially interested to get Dave
Chinner's and Ted's insight here.

Mike
