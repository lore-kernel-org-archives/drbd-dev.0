Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 3EC2B103B4DA
	for <drbd-dev@lists.linbit.com>; Thu, 16 Aug 2012 20:17:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id 394971B4361
	for <drbd-dev@lists.linbit.com>; Thu, 16 Aug 2012 20:17:09 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rzM31kQWPEmN for <drbd-dev@lists.linbit.com>;
	Thu, 16 Aug 2012 20:17:09 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id 202E91B435E
	for <drbd-dev@lists.linbit.com>; Thu, 16 Aug 2012 20:17:09 +0200 (CEST)
Resent-Message-ID: <20120816181709.GH8189@soda.linbit>
Received: from mail-pb0-f54.google.com (mail-pb0-f54.google.com
	[209.85.160.54]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id C1EB41013809
	for <drbd-dev@lists.linbit.com>; Wed, 15 Aug 2012 22:46:24 +0200 (CEST)
Received: by pbbrp2 with SMTP id rp2so442097pbb.27
	for <drbd-dev@lists.linbit.com>; Wed, 15 Aug 2012 13:46:22 -0700 (PDT)
Date: Wed, 15 Aug 2012 13:46:18 -0700
From: Kent Overstreet <koverstreet@google.com>
To: Jun'ichi Nomura <j-nomura@ce.jp.nec.com>
Message-ID: <20120815204618.GB2758@google.com>
References: <1344290921-25154-1-git-send-email-koverstreet@google.com>
	<1344290921-25154-3-git-send-email-koverstreet@google.com>
	<5029E320.3050603@ce.jp.nec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5029E320.3050603@ce.jp.nec.com>
Cc: axboe@kernel.dk, dm-devel@redhat.com, neilb@suse.de,
	linux-kernel@vger.kernel.org, linux-bcache@vger.kernel.org,
	mpatocka@redhat.com, vgoyal@redhat.com, yehuda@hq.newdream.net,
	tj@kernel.org, sage@newdream.net, agk@redhat.com, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH v5 02/12] dm: Use bioset's front_pad for
 dm_rq_clone_bio_info
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Tue, Aug 14, 2012 at 02:33:20PM +0900, Jun'ichi Nomura wrote:
> On 08/07/12 07:08, Kent Overstreet wrote:
> >  struct dm_rq_clone_bio_info {
> >  	struct bio *orig;
> >  	struct dm_rq_target_io *tio;
> > +	struct bio clone;
> >  };
> ...
> > -	pools->bs = bioset_create(pool_size, 0);
> > +	pools->bs = bioset_create(pool_size,
> > +				  offsetof(struct dm_rq_clone_bio_info, orig));
> >  	if (!pools->bs)
> >  		goto free_tio_pool_and_out;
> 
> Shouldn't this be offsetof(struct dm_rq_clone_bio_info, clone)?

Ouch! Yes, it definitely should be. Good catch, and thanks.
