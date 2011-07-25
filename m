Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id CCF9D1056792
	for <drbd-dev@lists.linbit.com>; Mon, 25 Jul 2011 17:03:51 +0200 (CEST)
Resent-Message-ID: <20110725150349.GB4035@barkeeper1-xen.linbit>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 38CE7105678F
	for <drbd-dev@lists.linbit.com>; Mon, 25 Jul 2011 14:47:32 +0200 (CEST)
From: Andreas Gruenbacher <agruen@linbit.com>
To: Thomas Zeitlhofer <thomas.zeitlhofer@nt.tuwien.ac.at>
Date: Mon, 25 Jul 2011 14:47:22 +0200
References: <20110724233847.GA2356@swan.nt.tuwien.ac.at>
	<201107251139.45806.agruen@linbit.com>
	<20110725123657.GB25953@swan.nt.tuwien.ac.at>
In-Reply-To: <20110725123657.GB25953@swan.nt.tuwien.ac.at>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201107251447.22654.agruen@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] initialize tconn->peer_integrity_tfm in
	drbd_adm_connect()
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Monday 25 July 2011 14:36:57 Thomas Zeitlhofer wrote:
> On Mon, Jul 25, 2011 at 11:39:45AM +0200, Andreas Gruenbacher wrote:
> > The master branch in http://git.drbd.org/?p=drbd-8.4.git contains a few 
> > additional minor fixes.
> 
> Thanks for the information - the public git repository did not show any
> commits since the 8.4.0 release, so I just had a look at this issue.

Yes ... you should see all commits up to "drbd: remove disfunctional 
NLM_F_REPLACE usage" from Lars now.

Thanks,
Andreas
