Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 3903110567A6
	for <drbd-dev@lists.linbit.com>; Mon, 25 Jul 2011 17:04:04 +0200 (CEST)
Resent-Message-ID: <20110725150403.GC4035@barkeeper1-xen.linbit>
Received: from swan.nt.tuwien.ac.at (swan.nt.tuwien.ac.at [128.131.67.158])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 5983C1056792
	for <drbd-dev@lists.linbit.com>; Mon, 25 Jul 2011 15:09:56 +0200 (CEST)
Date: Mon, 25 Jul 2011 15:09:55 +0200
From: Thomas Zeitlhofer <thomas.zeitlhofer@nt.tuwien.ac.at>
To: Andreas Gruenbacher <agruen@linbit.com>
Message-ID: <20110725130955.GA19513@swan.nt.tuwien.ac.at>
References: <20110724233847.GA2356@swan.nt.tuwien.ac.at>
	<201107251139.45806.agruen@linbit.com>
	<20110725123657.GB25953@swan.nt.tuwien.ac.at>
	<201107251447.22654.agruen@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201107251447.22654.agruen@linbit.com>
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

On Mon, Jul 25, 2011 at 02:47:22PM +0200, Andreas Gruenbacher wrote:
> On Monday 25 July 2011 14:36:57 Thomas Zeitlhofer wrote:
> > On Mon, Jul 25, 2011 at 11:39:45AM +0200, Andreas Gruenbacher wrote:
> > > The master branch in http://git.drbd.org/?p=drbd-8.4.git contains a few 
> > > additional minor fixes.
> > 
> > Thanks for the information - the public git repository did not show any
> > commits since the 8.4.0 release, so I just had a look at this issue.
> 
> Yes ... you should see all commits up to "drbd: remove disfunctional 
> NLM_F_REPLACE usage" from Lars now.

Yes, these commits do show up now.

Thanks,

Thomas
