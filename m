Return-Path: <lee.jones@linaro.org>
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
	[209.85.221.47])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id C12014205D8
	for <drbd-dev@lists.linbit.com>; Tue,  6 Apr 2021 10:52:26 +0200 (CEST)
Received: by mail-wr1-f47.google.com with SMTP id a6so7291903wrw.8
	for <drbd-dev@lists.linbit.com>; Tue, 06 Apr 2021 01:52:26 -0700 (PDT)
Date: Tue, 6 Apr 2021 09:52:23 +0100
From: Lee Jones <lee.jones@linaro.org>
To: linux-kernel@vger.kernel.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	drbd-dev@lists.linbit.com, Jens Axboe <axboe@kernel.dk>,
	Joshua Morris <josh.h.morris@us.ibm.com>, Juergen Gross <jgross@suse.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>, linux-block@vger.kernel.org,
	Philip Kelleher <pjk1939@linux.ibm.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>,
	Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org
Message-ID: <20210406085223.GR2916463@dell>
References: <20210312105530.2219008-1-lee.jones@linaro.org>
	<20210330132130.GK2916463@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210330132130.GK2916463@dell>
Subject: Re: [Drbd-dev] [PATCH 00/11] Rid W=1 warnings from Block
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <https://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <https://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Tue, 30 Mar 2021, Lee Jones wrote:

> On Fri, 12 Mar 2021, Lee Jones wrote:
> 
> > This set is part of a larger effort attempting to clean-up W=1
> > kernel builds, which are currently overwhelmingly riddled with
> > niggly little warnings.
> > 
> > Lee Jones (11):
> >   block: rsxx: core: Remove superfluous const qualifier
> >   block: drbd: drbd_interval: Demote some kernel-doc abuses and fix
> >     another header
> >   block: mtip32xx: mtip32xx: Mark debugging variable 'start' as
> >     __maybe_unused
> >   block: drbd: drbd_state: Fix some function documentation issues
> >   block: drbd: drbd_receiver: Demote non-conformant kernel-doc headers
> >   block: drbd: drbd_main: Remove duplicate field initialisation
> >   block: drbd: drbd_nl: Make conversion to 'enum drbd_ret_code' explicit
> >   block: drbd: drbd_main: Fix a bunch of function documentation
> >     discrepancies
> >   block: drbd: drbd_receiver: Demote less than half complete kernel-doc
> >     header
> >   block: xen-blkfront: Demote kernel-doc abuses
> >   block: drbd: drbd_nl: Demote half-complete kernel-doc headers
> 
> Would you like me to resubmit these?

It's been 3.5 weeks since these were submitted.

We are now at -rc6, so these should be merged soon.

Is there anything you'd like me to do to help?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
