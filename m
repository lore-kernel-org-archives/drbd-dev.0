Return-Path: <lars.ellenberg@linbit.com>
Received: from johann (chello212017090083.12.15.vie.surfer.at [212.17.90.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPSA id 2C460107369D
	for <drbd-dev@lists.linbit.com>; Sun, 20 Sep 2009 21:26:09 +0200 (CEST)
Resent-Message-ID: <20090920192608.GB8824@johann>
Received: from mail-vw0-f195.google.com (mail-vw0-f195.google.com
	[209.85.212.195])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 3CA5710623B7
	for <drbd-dev@lists.linbit.com>; Sun, 20 Sep 2009 02:04:11 +0200 (CEST)
Received: by vws33 with SMTP id 33so1540119vws.33
	for <drbd-dev@lists.linbit.com>; Sat, 19 Sep 2009 17:04:11 -0700 (PDT)
MIME-Version: 1.0
Sender: dan.j.williams@gmail.com
In-Reply-To: <20090919220232.GB31849@suse.de>
References: <20090917161108.GA3361@infradead.org>
	<19122.65335.126937.476968@notabene.brown>
	<20090918200803.GM23126@kernel.dk>
	<20090919141334N.fujita.tomonori@lab.ntt.co.jp>
	<20090919220232.GB31849@suse.de>
Date: Sat, 19 Sep 2009 16:56:15 -0700
Message-ID: <e9c3a7c20909191656p625ccfa4pcef94cbe8a232bae@mail.gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
To: Lars Marowsky-Bree <lmb@suse.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: hch@infradead.org, kyle@moffetthome.net, sam@ravnborg.org,
	bart.vanassche@gmail.com, neilb@suse.de, knikanth@suse.de,
	gregkh@suse.de, linux-kernel@vger.kernel.org, philipp.reisner@linbit.com,
	FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
	James.Bottomley@suse.de, kosaki.motohiro@jp.fujitsu.com,
	jens.axboe@oracle.com, davej@redhat.com,
	lars.ellenberg@linbit.com, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [GIT PULL] DRBD for 2.6.32
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Sat, Sep 19, 2009 at 3:02 PM, Lars Marowsky-Bree <lmb@suse.de> wrote:
> On 2009-09-19T14:14:30, FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp> wrote:
>
>> I guess that Christoph is worry about adding another user interface
>> for kinda device management; once we merge this, we can't fix it (for
>> the raid unification).
>
> Why can't it be fixed?
>
> Either
>
> a) there's going to be a transition period during which the "old"
> interface is supported but depreciated and scheduled to be removed (all
> driving the new unified same back-end),
>
> or b) there's going to be a new kernel which requires new user-space
> tools sharp.
>
> In either case, dm/md are affected by this, so a third interface doesn't
> really make much difference. The refactoring needs to happen in the
> back-end anyway, and that actually becomes easier when all concurrent
> implementations are present and can be reworked at the same time.

It's actually four "raid" implementations in the kernel if you count
the multiple-disk functionality of btrfs.  The precedent is already
set for merging new multiple-disk management interfaces.

Neil has come the closest to actually trying to start (i.e. code) the
unification effort [1] and that was for the relatively straightforward
case of mapping the dm-raid5 backend to md-raid5... no uptake to date.
 There are no strictly equivalent drbd-backends in the kernel
presently, so leaving this out of tree is a net-loss for mainline.

--
Dan

[1]: http://marc.info/?l=dm-devel&m=124567352518676&w=2
