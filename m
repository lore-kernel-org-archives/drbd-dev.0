Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id D3FE81012A9D
	for <drbd-dev@lists.linbit.com>; Wed, 30 May 2012 10:40:41 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id CE64F1B435C
	for <drbd-dev@lists.linbit.com>; Wed, 30 May 2012 10:40:41 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xq0vXoEMO-pp for <drbd-dev@lists.linbit.com>;
	Wed, 30 May 2012 10:40:41 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id AD5FC1B435B
	for <drbd-dev@lists.linbit.com>; Wed, 30 May 2012 10:40:41 +0200 (CEST)
Resent-Message-ID: <20120530084041.GE4141@soda.linbit>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id E8C8E100008C
	for <drbd-dev@lists.linbit.com>; Sat, 26 May 2012 00:59:05 +0200 (CEST)
Date: Fri, 25 May 2012 23:58:52 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Kent Overstreet <koverstreet@google.com>
Message-ID: <20120525225852.GG5761@agk-dp.fab.redhat.com>
References: <1337977539-16977-1-git-send-email-koverstreet@google.com>
	<1337977539-16977-14-git-send-email-koverstreet@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1337977539-16977-14-git-send-email-koverstreet@google.com>
Cc: axboe@kernel.dk, yehuda@hq.newdream.net, dm-devel@redhat.com, neilb@suse.de,
	linux-kernel@vger.kernel.org, tj@kernel.org,
	linux-bcache@vger.kernel.org, mpatocka@redhat.com,
	vgoyal@redhat.com, bharrosh@panasas.com,
	linux-fsdevel@vger.kernel.org, sage@newdream.net, agk@redhat.com,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH v3 13/16] Make generic_make_request handle
	arbitrarily	large bios
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Fri, May 25, 2012 at 01:25:36PM -0700, Kent Overstreet wrote:
> But this approach becomes unwieldy and eventually breaks down with
> stacked devices and devices with dynamic limits, and it adds a lot of
> complexity. If the block layer could split bios as needed, we could

Complexity - yes - but if people didn't observe a genuine benefit, why
did they go to the trouble of writing this and getting it included?

> eliminate a lot of complexity elsewhere - particularly in stacked
> drivers. 

> Code that creates bios can then create whatever size bios are
> convenient, and more importantly stacked drivers don't have to deal with
> both their own bio size limitations and the limitations of the
> (potentially multiple) devices underneath them.

A theoretical argument.  Perhaps it's the right assessment of this
issue.  Perhaps it's not.  Or perhaps it depends on the use-case.

I made a theoretical argument from a different point of view in my last email.

I think a body of *empirical* evidence should provide the justification
for this particular change, and until such evidence is forthcoming we
should keep the status quo.

Alasdair

