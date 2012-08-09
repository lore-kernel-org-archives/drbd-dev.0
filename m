Return-Path: <htejun@gmail.com>
Received: from mail-yx0-f182.google.com (mail-yx0-f182.google.com
	[209.85.213.182]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 967A9104C146
	for <drbd-dev@lists.linbit.com>; Thu,  9 Aug 2012 08:05:23 +0200 (CEST)
Received: by yenl7 with SMTP id l7so122923yen.27
	for <drbd-dev@lists.linbit.com>; Wed, 08 Aug 2012 23:05:22 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 8 Aug 2012 23:05:17 -0700
From: Tejun Heo <tj@kernel.org>
To: Kent Overstreet <koverstreet@google.com>
Message-ID: <20120809060517.GB2845@dhcp-172-17-108-109.mtv.corp.google.com>
References: <1344290921-25154-1-git-send-email-koverstreet@google.com>
	<1344290921-25154-6-git-send-email-koverstreet@google.com>
	<20120808222223.GD6983@dhcp-172-17-108-109.mtv.corp.google.com>
	<20120809002154.GE7262@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120809002154.GE7262@moria.home.lan>
Cc: axboe@kernel.dk, dm-devel@redhat.com, neilb@suse.de,
	linux-kernel@vger.kernel.org, linux-bcache@vger.kernel.org,
	mpatocka@redhat.com, vgoyal@redhat.com, yehuda@hq.newdream.net,
	sage@newdream.net, agk@redhat.com, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH v5 05/12] block: Kill bi_destructor
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hello,

On Wed, Aug 08, 2012 at 05:21:54PM -0700, Kent Overstreet wrote:
> > What's wrong with good ol' NULL?
> 
> If it's NULL, we can't distinguish between bios where that field wasn't
> set (i.e. bios that were statically allocated somewhere) from bios that
> were allocated by bio_kmalloc().
> 
> It's just there to make debugging easier - if bi_cnt goes to 0 on a bio
> where it shouldn't we'll catch it at the BUG_ON() in bio_free() instead
> of kfreeing a bad pointer.

I fail to see how that improves anything.  slab will complain clearly
if it gets passed in a pointer to static area.  The benefit is
imaginery.  If there's no bioset, it's NULL.  Let's please keep things
usual.

Thanks.

-- 
tejun
