Return-Path: <htejun@gmail.com>
Received: from mail-yw0-f54.google.com (mail-yw0-f54.google.com
	[209.85.213.54]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id D7EBA1017A2C
	for <drbd-dev@lists.linbit.com>; Tue, 14 Aug 2012 00:05:40 +0200 (CEST)
Received: by yhfs35 with SMTP id s35so5534432yhf.27
	for <drbd-dev@lists.linbit.com>; Mon, 13 Aug 2012 15:05:39 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 13 Aug 2012 15:05:34 -0700
From: Tejun Heo <tj@kernel.org>
To: Kent Overstreet <koverstreet@google.com>
Message-ID: <20120813220534.GB25632@google.com>
References: <1344290921-25154-1-git-send-email-koverstreet@google.com>
	<1344290921-25154-9-git-send-email-koverstreet@google.com>
	<20120808225839.GG6983@dhcp-172-17-108-109.mtv.corp.google.com>
	<20120813215511.GE9541@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120813215511.GE9541@google.com>
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

Hello,

On Mon, Aug 13, 2012 at 02:55:11PM -0700, Kent Overstreet wrote:
> > If the condition is detectable, WARN_ON_ONCE() please.
> 
> I know I said I liked this idea, but I changed my mind.
> 
> Sticking a WARN_ON_ONCE() there is saying that passing __GFP_WAIT from
> under generic_make_request() is always wrong - it might as well be a
> BUG_ON() except warn is better for the user.

WARN_ON_ONCE(), as opposed to BUG_ON(), doesn't mean that something
isn't always wrong.  It's just better to always use WARN variant if
the system doesn't *need* to be put down immediately to avoid, say,
massive data corruption - limping machine is simply better than dead
one.

> If that's true, then an assertion is completely wrong because we can
> just do the right thing instead - mask out __GFP_WAIT if
> current->bio_list != NULL and document that it can fail in that
> situation.

That's worse because it confuses the reader.  Taking something which
is as well-known as __GFP_WAIT and then silently ignoring it isn't a
good idea.  Please just add a WARN_ON.

Thanks.

-- 
tejun
