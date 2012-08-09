Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id A67091055F63
	for <drbd-dev@lists.linbit.com>; Fri, 10 Aug 2012 22:33:30 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id 9EEDA1B435C
	for <drbd-dev@lists.linbit.com>; Fri, 10 Aug 2012 22:33:30 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BCD486+HyZMU for <drbd-dev@lists.linbit.com>;
	Fri, 10 Aug 2012 22:33:30 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id 82D291B4206
	for <drbd-dev@lists.linbit.com>; Fri, 10 Aug 2012 22:33:30 +0200 (CEST)
Resent-Message-ID: <20120810203330.GB31190@soda.linbit>
Received: from mail-gg0-f182.google.com (mail-gg0-f182.google.com
	[209.85.161.182]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 483181045C2E
	for <drbd-dev@lists.linbit.com>; Thu,  9 Aug 2012 03:39:58 +0200 (CEST)
Received: by ggnk4 with SMTP id k4so2239221ggn.27
	for <drbd-dev@lists.linbit.com>; Wed, 08 Aug 2012 18:39:57 -0700 (PDT)
Date: Wed, 8 Aug 2012 18:39:23 -0700
From: Kent Overstreet <koverstreet@google.com>
To: Tejun Heo <tj@kernel.org>
Message-ID: <20120809013923.GH7262@moria.home.lan>
References: <1344290921-25154-1-git-send-email-koverstreet@google.com>
	<1344290921-25154-9-git-send-email-koverstreet@google.com>
	<20120808230532.GH6983@dhcp-172-17-108-109.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120808230532.GH6983@dhcp-172-17-108-109.mtv.corp.google.com>
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

On Wed, Aug 08, 2012 at 04:05:32PM -0700, Tejun Heo wrote:
> One more thing.
> 
> On Mon, Aug 06, 2012 at 03:08:37PM -0700, Kent Overstreet wrote:
> > +	if (bio_integrity(bio)) {
> > +		bio_integrity_clone(ret, bio, gfp, bs);
> > +		bio_integrity_trim(ret, 0, bio_sectors(ret));
> > +		bio_integrity_trim(bio, bio_sectors(ret), bio_sectors(bio));
> 
> Is this equivalent to bio_integrity_split() performance-wise?

Strictly speaking, no. But it has the advantage of being drastically
simpler - and the only one only worked for single page bios so I
would've had to come up with something new from scratch, and as
confusing as the integrity stuff is I wouldn't trust the result.

I'm skeptical that it's going to matter in practice given how much
iteration is done elsewhere in the course of processing a bio and given
that this stuff isn't used with high end SSDs...
