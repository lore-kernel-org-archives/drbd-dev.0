Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 0D5C8103B4C6
	for <drbd-dev@lists.linbit.com>; Thu, 16 Aug 2012 20:17:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id 089881B4361
	for <drbd-dev@lists.linbit.com>; Thu, 16 Aug 2012 20:17:08 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id D0wRFuedUWAd for <drbd-dev@lists.linbit.com>;
	Thu, 16 Aug 2012 20:17:07 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id DE5811B435E
	for <drbd-dev@lists.linbit.com>; Thu, 16 Aug 2012 20:17:07 +0200 (CEST)
Resent-Message-ID: <20120816181707.GE8189@soda.linbit>
Received: from mail-ob0-f182.google.com (mail-ob0-f182.google.com
	[209.85.214.182]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id C65DA1019A78
	for <drbd-dev@lists.linbit.com>; Mon, 13 Aug 2012 23:55:16 +0200 (CEST)
Received: by obbun3 with SMTP id un3so13770202obb.27
	for <drbd-dev@lists.linbit.com>; Mon, 13 Aug 2012 14:55:14 -0700 (PDT)
Date: Mon, 13 Aug 2012 14:55:11 -0700
From: Kent Overstreet <koverstreet@google.com>
To: Tejun Heo <tj@kernel.org>
Message-ID: <20120813215511.GE9541@google.com>
References: <1344290921-25154-1-git-send-email-koverstreet@google.com>
	<1344290921-25154-9-git-send-email-koverstreet@google.com>
	<20120808225839.GG6983@dhcp-172-17-108-109.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120808225839.GG6983@dhcp-172-17-108-109.mtv.corp.google.com>
Cc: axboe@kernel.dk, dm-devel@redhat.com, neilb@suse.de,
	linux-kernel@vger.kernel.org, linux-bcache@vger.kernel.org,
	mpatocka@redhat.com, vgoyal@redhat.com, yehuda@hq.newdream.net,
	sage@newdream.net, agk@redhat.com, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH v5 08/12] block: Introduce new bio_split()
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Wed, Aug 08, 2012 at 03:58:39PM -0700, Tejun Heo wrote:
> On Mon, Aug 06, 2012 at 03:08:37PM -0700, Kent Overstreet wrote:
> > + *
> > + * BIG FAT WARNING:
> > + *
> > + * If you're calling this from under generic_make_request() (i.e.
> > + * current->bio_list != NULL), you should mask out __GFP_WAIT and punt to
> > + * workqueue if the allocation fails. Otherwise, your code will probably
> > + * deadlock.
> 
> If the condition is detectable, WARN_ON_ONCE() please.

I know I said I liked this idea, but I changed my mind.

Sticking a WARN_ON_ONCE() there is saying that passing __GFP_WAIT from
under generic_make_request() is always wrong - it might as well be a
BUG_ON() except warn is better for the user.

If that's true, then an assertion is completely wrong because we can
just do the right thing instead - mask out __GFP_WAIT if
current->bio_list != NULL and document that it can fail in that
situation.

Which is what my original code did.

The alternative is accepting that there are situations where it is
technically possible to pass __GFP_WAIT from under
generic_make_request() without deadlocking and allow it, but my position
is still that that is far too subtle to expect that it'll be gotten
right (especially considering the ways that the code is wrong today
wrt deadlocks).

But honestly this is turning into bikeshedding. The current bio
splitting and merge_bvec_fn stuff is crap, and there are worse potential
deadlocks/bugs in the existing code than what we're arguing over here.
