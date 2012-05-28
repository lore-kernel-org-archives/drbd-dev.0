Return-Path: <htejun@gmail.com>
Received: from mail-pz0-f54.google.com (mail-pz0-f54.google.com
	[209.85.210.54]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 3FEA01019A78
	for <drbd-dev@lists.linbit.com>; Mon, 28 May 2012 03:52:28 +0200 (CEST)
Received: by dadv36 with SMTP id v36so4368864dad.27
	for <drbd-dev@lists.linbit.com>; Sun, 27 May 2012 18:52:27 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 28 May 2012 10:52:11 +0900
From: Tejun Heo <tj@kernel.org>
To: Kent Overstreet <koverstreet@google.com>
Message-ID: <20120528015211.GF9891@dhcp-172-17-108-109.mtv.corp.google.com>
References: <1337977539-16977-1-git-send-email-koverstreet@google.com>
	<1337977539-16977-7-git-send-email-koverstreet@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1337977539-16977-7-git-send-email-koverstreet@google.com>
Cc: axboe@kernel.dk, yehuda@hq.newdream.net, dm-devel@redhat.com, neilb@suse.de,
	linux-kernel@vger.kernel.org, linux-bcache@vger.kernel.org,
	mpatocka@redhat.com, vgoyal@redhat.com, bharrosh@panasas.com,
	linux-fsdevel@vger.kernel.org, sage@newdream.net, agk@redhat.com,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH v3 06/16] block: Add an explicit bio flag for
 bios that own their bvec
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Fri, May 25, 2012 at 01:25:29PM -0700, Kent Overstreet wrote:
> This is for the new bio splitting code. When we split a bio, if the
> split occured on a bvec boundry we reuse the bvec for the new bio. But
> that means bio_free() can't free it, hence the explicit flag.

I keep having the same complaints.  The explanation isn't detailed
enough.  So, the necessity for this patch arises from the fact that
the current bio_split doesn't use the usual bio allocation path to
create split bio - it just supports fixed bvec allocation via bio_pair
allocation which is allowable because of the severe restrictions the
current bio_split() - but the new bio_split() wants to do it in
general manner and thus wants the usual bvec allocation.

Why do I (or anyone for that matter) have to go forward in the patch
series to reconstruct the rationale?  Why doesn't the patch
description already explain this?  Why isn't this still fixed when
lack of proper patch description has already been pointed out multiple
times?

I'm gonna stop here on this series.

* *Please* spend more effort on patch description and understanding
  and applying the reviews.  If you don't like the opinions expressed
  in reviews, please argue.  If reviews get ignored, why would anyone
  review your patches at all?

* It would probably be better to split the series so that more
  experimental / constroversial stuff is in separate patch series.

Thanks.

-- 
tejun
