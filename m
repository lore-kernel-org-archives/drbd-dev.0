Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 74FD01055F7D
	for <drbd-dev@lists.linbit.com>; Fri, 10 Aug 2012 22:33:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id 6F0B71B4206
	for <drbd-dev@lists.linbit.com>; Fri, 10 Aug 2012 22:33:28 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XpdAw6Bzd8WC for <drbd-dev@lists.linbit.com>;
	Fri, 10 Aug 2012 22:33:28 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id 4664A1B435C
	for <drbd-dev@lists.linbit.com>; Fri, 10 Aug 2012 22:33:28 +0200 (CEST)
Resent-Message-ID: <20120810203328.GX31190@soda.linbit>
Received: from mail-gg0-f182.google.com (mail-gg0-f182.google.com
	[209.85.161.182]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 7ACDF1045C2E
	for <drbd-dev@lists.linbit.com>; Thu,  9 Aug 2012 02:20:04 +0200 (CEST)
Received: by ggnk4 with SMTP id k4so2167472ggn.27
	for <drbd-dev@lists.linbit.com>; Wed, 08 Aug 2012 17:20:03 -0700 (PDT)
Date: Wed, 8 Aug 2012 17:14:27 -0700
From: Kent Overstreet <koverstreet@google.com>
To: Mike Snitzer <snitzer@redhat.com>
Message-ID: <20120809001427.GD7262@moria.home.lan>
References: <1344290921-25154-1-git-send-email-koverstreet@google.com>
	<1344290921-25154-6-git-send-email-koverstreet@google.com>
	<20120807031921.GA31977@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120807031921.GA31977@redhat.com>
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

On Mon, Aug 06, 2012 at 11:19:21PM -0400, Mike Snitzer wrote:
> On Mon, Aug 06 2012 at  6:08pm -0400,
> Kent Overstreet <koverstreet@google.com> wrote:
> 
> > Now that we've got generic code for freeing bios allocated from bio
> > pools, this isn't needed anymore.
> > 
> > This also changes the semantics of bio_free() a bit - it now also frees
> > bios allocated by bio_kmalloc(). It's also no longer exported, as
> > without bi_destructor there should be no need for it to be called
> > anywhere else.
> 
> Seems you forgot to remove bio_free's EXPORT_SYMBOL

Whoops - thanks, fixed.
