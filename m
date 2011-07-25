Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 98F04105678F
	for <drbd-dev@lists.linbit.com>; Mon, 25 Jul 2011 14:45:34 +0200 (CEST)
Resent-Message-ID: <20110725124532.GA4035@barkeeper1-xen.linbit>
Received: from swan.nt.tuwien.ac.at (swan.nt.tuwien.ac.at [128.131.67.158])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 23897105678F
	for <drbd-dev@lists.linbit.com>; Mon, 25 Jul 2011 14:36:58 +0200 (CEST)
Date: Mon, 25 Jul 2011 14:36:57 +0200
From: Thomas Zeitlhofer <thomas.zeitlhofer@nt.tuwien.ac.at>
To: Andreas Gruenbacher <agruen@linbit.com>
Message-ID: <20110725123657.GB25953@swan.nt.tuwien.ac.at>
References: <20110724233847.GA2356@swan.nt.tuwien.ac.at>
	<201107251139.45806.agruen@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201107251139.45806.agruen@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] initialize tconn->peer_integrity_tfm
	in	drbd_adm_connect()
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hello Andreas,

On Mon, Jul 25, 2011 at 11:39:45AM +0200, Andreas Gruenbacher wrote:
> Thomas,
> 
> On Monday 25 July 2011 01:38:48 Thomas Zeitlhofer wrote:
> > The support for data-integrity-alg seems to be broken with drbd-8.4.0.
> > E.g., when trying to resync, the SyncTarget hits:
> > 
> >    ASSERTION IS_ALIGNED(data_size, 512) FAILED in read_in_block
> >    error receiving RSDataReply, e: -5 l: 126996! read_in_block
> > 
> > This is caused by an uninitialized tconn->peer_integrity_tfm. Therefore,
> > the digest data is not used/removed at the receiver which leads to
> > additional 20 bytes that trigger the assertion above.
> 
> thanks for tracking this down.  Your analysis and the fix are correct.  As it 
> happens, we also ran into this bug here meanwhile.  

I stumbled upon this bug and was already wondering that it has not been
discussed so far.

> Here is what we did to address it:
> 
>   http://git.drbd.org/?p=drbd-8.4.git;a=commit;h=4811eceb393c274f94bfd8926e714d6271cf1f57
> 
> The two fixes are slightly different, but both should do the job.
> Sorry for not letting you know of our fix in time.
>
> The master branch in http://git.drbd.org/?p=drbd-8.4.git contains a few 
> additional minor fixes.

Thanks for the information - the public git repository did not show any
commits since the 8.4.0 release, so I just had a look at this issue.

Best Regards

Thomas
