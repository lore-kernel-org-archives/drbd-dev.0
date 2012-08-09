Return-Path: <htejun@gmail.com>
Received: from mail-gg0-f182.google.com (mail-gg0-f182.google.com
	[209.85.161.182]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 49EE0103B4DA
	for <drbd-dev@lists.linbit.com>; Thu,  9 Aug 2012 09:22:24 +0200 (CEST)
Received: by ggnk4 with SMTP id k4so187992ggn.27
	for <drbd-dev@lists.linbit.com>; Thu, 09 Aug 2012 00:22:23 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 9 Aug 2012 00:22:17 -0700
From: Tejun Heo <tj@kernel.org>
To: Kent Overstreet <koverstreet@google.com>
Message-ID: <20120809072217.GH2845@dhcp-172-17-108-109.mtv.corp.google.com>
References: <1344290921-25154-1-git-send-email-koverstreet@google.com>
	<1344290921-25154-9-git-send-email-koverstreet@google.com>
	<20120808230532.GH6983@dhcp-172-17-108-109.mtv.corp.google.com>
	<20120809013923.GH7262@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120809013923.GH7262@moria.home.lan>
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

On Wed, Aug 08, 2012 at 06:39:23PM -0700, Kent Overstreet wrote:
> On Wed, Aug 08, 2012 at 04:05:32PM -0700, Tejun Heo wrote:
> > One more thing.
> > 
> > On Mon, Aug 06, 2012 at 03:08:37PM -0700, Kent Overstreet wrote:
> > > +	if (bio_integrity(bio)) {
> > > +		bio_integrity_clone(ret, bio, gfp, bs);
> > > +		bio_integrity_trim(ret, 0, bio_sectors(ret));
> > > +		bio_integrity_trim(bio, bio_sectors(ret), bio_sectors(bio));
> > 
> > Is this equivalent to bio_integrity_split() performance-wise?
> 
> Strictly speaking, no. But it has the advantage of being drastically
> simpler - and the only one only worked for single page bios so I
> would've had to come up with something new from scratch, and as
> confusing as the integrity stuff is I wouldn't trust the result.

There's already bio_integrity_split() and you're actively dropping it.

> I'm skeptical that it's going to matter in practice given how much
> iteration is done elsewhere in the course of processing a bio and given
> that this stuff isn't used with high end SSDs...

If you think the active dropping is justified, please let the change
and justification clearly stated.  You're burying the active change in
two separate patches without even mentioning it or cc'ing people who
care about bio-integrity (Martin K. Petersen).  Ummm.... this is
simply unacceptable and makes me a lot more suspicious about the
patchset.  Please be explicit about changes you make.  Peer-review
breaks down unless such trust can be maintained.

Thanks.

-- 
tejun
