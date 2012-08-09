Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id CCB2610561B2
	for <drbd-dev@lists.linbit.com>; Fri, 10 Aug 2012 22:33:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id C28A71B4206
	for <drbd-dev@lists.linbit.com>; Fri, 10 Aug 2012 22:33:36 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2YNCr46LTCYZ for <drbd-dev@lists.linbit.com>;
	Fri, 10 Aug 2012 22:33:36 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id A19141B435C
	for <drbd-dev@lists.linbit.com>; Fri, 10 Aug 2012 22:33:36 +0200 (CEST)
Resent-Message-ID: <20120810203336.GM31190@soda.linbit>
Received: from mail-pb0-f54.google.com (mail-pb0-f54.google.com
	[209.85.160.54]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 10212103B4DA
	for <drbd-dev@lists.linbit.com>; Thu,  9 Aug 2012 09:33:34 +0200 (CEST)
Received: by pbbrp2 with SMTP id rp2so565678pbb.27
	for <drbd-dev@lists.linbit.com>; Thu, 09 Aug 2012 00:33:32 -0700 (PDT)
Date: Thu, 9 Aug 2012 03:33:34 -0400
From: Kent Overstreet <koverstreet@google.com>
To: Tejun Heo <tj@kernel.org>
Message-ID: <20120809073334.GD9128@dhcp-172-18-216-138.mtv.corp.google.com>
References: <1344290921-25154-1-git-send-email-koverstreet@google.com>
	<1344290921-25154-9-git-send-email-koverstreet@google.com>
	<20120808230532.GH6983@dhcp-172-17-108-109.mtv.corp.google.com>
	<20120809013923.GH7262@moria.home.lan>
	<20120809072217.GH2845@dhcp-172-17-108-109.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120809072217.GH2845@dhcp-172-17-108-109.mtv.corp.google.com>
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

On Thu, Aug 09, 2012 at 12:22:17AM -0700, Tejun Heo wrote:
> On Wed, Aug 08, 2012 at 06:39:23PM -0700, Kent Overstreet wrote:
> > On Wed, Aug 08, 2012 at 04:05:32PM -0700, Tejun Heo wrote:
> > > One more thing.
> > > 
> > > On Mon, Aug 06, 2012 at 03:08:37PM -0700, Kent Overstreet wrote:
> > > > +	if (bio_integrity(bio)) {
> > > > +		bio_integrity_clone(ret, bio, gfp, bs);
> > > > +		bio_integrity_trim(ret, 0, bio_sectors(ret));
> > > > +		bio_integrity_trim(bio, bio_sectors(ret), bio_sectors(bio));
> > > 
> > > Is this equivalent to bio_integrity_split() performance-wise?
> > 
> > Strictly speaking, no. But it has the advantage of being drastically
> > simpler - and the only one only worked for single page bios so I
> > would've had to come up with something new from scratch, and as
> > confusing as the integrity stuff is I wouldn't trust the result.
> 
> There's already bio_integrity_split() and you're actively dropping it.

Because it only works for single page bios, AFAICT. I'd have to start
from scratch.

> > I'm skeptical that it's going to matter in practice given how much
> > iteration is done elsewhere in the course of processing a bio and given
> > that this stuff isn't used with high end SSDs...
> 
> If you think the active dropping is justified, please let the change
> and justification clearly stated.  You're burying the active change in
> two separate patches without even mentioning it or cc'ing people who
> care about bio-integrity (Martin K. Petersen). 

Not intentionally, he isn't in MAINTAINERS so get_maintainers.pl missed
it and it slipped by while I was looking for people to CC. Added him.
