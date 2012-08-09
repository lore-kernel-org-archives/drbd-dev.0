Return-Path: <htejun@gmail.com>
Received: from mail-gh0-f182.google.com (mail-gh0-f182.google.com
	[209.85.160.182]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id A9BBF1012A92
	for <drbd-dev@lists.linbit.com>; Thu,  9 Aug 2012 19:32:24 +0200 (CEST)
Received: by ghrr13 with SMTP id r13so1076540ghr.27
	for <drbd-dev@lists.linbit.com>; Thu, 09 Aug 2012 10:32:23 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 9 Aug 2012 10:32:17 -0700
From: Tejun Heo <tj@kernel.org>
To: Kent Overstreet <koverstreet@google.com>
Message-ID: <20120809173217.GA6644@dhcp-172-17-108-109.mtv.corp.google.com>
References: <1344290921-25154-1-git-send-email-koverstreet@google.com>
	<1344290921-25154-9-git-send-email-koverstreet@google.com>
	<20120808230532.GH6983@dhcp-172-17-108-109.mtv.corp.google.com>
	<20120809013923.GH7262@moria.home.lan>
	<20120809072217.GH2845@dhcp-172-17-108-109.mtv.corp.google.com>
	<20120809073334.GD9128@dhcp-172-18-216-138.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120809073334.GD9128@dhcp-172-18-216-138.mtv.corp.google.com>
Cc: axboe@kernel.dk, martin.petersen@oracle.com, dm-devel@redhat.com,
	neilb@suse.de, linux-kernel@vger.kernel.org,
	linux-bcache@vger.kernel.org, mpatocka@redhat.com,
	vgoyal@redhat.com, yehuda@hq.newdream.net, sage@newdream.net,
	agk@redhat.com, drbd-dev@lists.linbit.com
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

On Thu, Aug 09, 2012 at 03:33:34AM -0400, Kent Overstreet wrote:
> > If you think the active dropping is justified, please let the change
> > and justification clearly stated.  You're burying the active change in
> > two separate patches without even mentioning it or cc'ing people who
> > care about bio-integrity (Martin K. Petersen). 
> 
> Not intentionally, he isn't in MAINTAINERS so get_maintainers.pl missed
> it and it slipped by while I was looking for people to CC. Added him.

git-log is your friend.  For one-off patches, doing it this way might
be okay.  Higher layer maintainer would be able to redirect it but if
you intend to change block layer APIs significantly as you try to do
in this patch series, you need to be *way* more diligent than you
currently are.  At least I feel risky about acking patches in this
series.

* Significant change is buried without explicitly mentioning it or
  discussing its implications.

* The patchset makes block layer API changes which impact multiple
  stacking and low level drivers which are not particularly known for
  simplicity and robustness, but there's no mention of how the patches
  are tested and/or why the patches would be safe (e.g. reviewed all
  the users and tested certain code paths and am fairly sure all the
  changes should be safe because xxx sort of deal).  When asked about
  testing, not much seems to have been done.

* Responses and iterations across patch postings aren't responsive or
  reliable, making it worrisome what will happen when things go south
  after this hits mainline.

You're asking reviewers and maintainers to take a lot more risks than
they usually have to, which isn't a good way to make forward progress.

Thanks.

-- 
tejun
