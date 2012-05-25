Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 582B7100008C
	for <drbd-dev@lists.linbit.com>; Wed, 30 May 2012 10:40:43 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id 3A45B1B435D
	for <drbd-dev@lists.linbit.com>; Wed, 30 May 2012 10:40:43 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3In0auwF9jdN for <drbd-dev@lists.linbit.com>;
	Wed, 30 May 2012 10:40:43 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id 1016A1B435B
	for <drbd-dev@lists.linbit.com>; Wed, 30 May 2012 10:40:43 +0200 (CEST)
Resent-Message-ID: <20120530084043.GG4141@soda.linbit>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id E0956100008C
	for <drbd-dev@lists.linbit.com>; Sat, 26 May 2012 01:12:45 +0200 (CEST)
Date: Sat, 26 May 2012 00:12:33 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Kent Overstreet <koverstreet@google.com>, linux-kernel@vger.kernel.org,
	linux-bcache@vger.kernel.org, dm-devel@redhat.com,
	linux-fsdevel@vger.kernel.org, tj@kernel.org, axboe@kernel.dk,
	agk@redhat.com, neilb@suse.de, drbd-dev@lists.linbit.com,
	bharrosh@panasas.com, vgoyal@redhat.com, mpatocka@redhat.com,
	sage@newdream.net, yehuda@hq.newdream.net
Message-ID: <20120525231232.GH5761@agk-dp.fab.redhat.com>
References: <1337977539-16977-1-git-send-email-koverstreet@google.com>
	<1337977539-16977-14-git-send-email-koverstreet@google.com>
	<20120525225852.GG5761@agk-dp.fab.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120525225852.GG5761@agk-dp.fab.redhat.com>
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

On Fri, May 25, 2012 at 11:58:52PM +0100, Alasdair G Kergon wrote:
> I think a body of *empirical* evidence should provide the justification
> for this particular change, and until such evidence is forthcoming we
> should keep the status quo.
 
What I'm trying to say is, by all means, let's continue to clean up this
patch set, but then give it some serious performance testing under
different regimes, compare it against the status quo, do whatever
tuning seems appropriate then let the results guide us.

Alasdair

