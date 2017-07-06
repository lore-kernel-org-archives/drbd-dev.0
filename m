Return-Path: <roland.kammerer@linbit.com>
Received: from mail-wr0-f180.google.com (mail-wr0-f180.google.com
	[209.85.128.180])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 3E4D71057FCF
	for <drbd-dev@lists.linbit.com>; Thu,  6 Jul 2017 21:19:46 +0200 (CEST)
Received: by mail-wr0-f180.google.com with SMTP id c11so16027633wrc.3
	for <drbd-dev@lists.linbit.com>; Thu, 06 Jul 2017 12:19:46 -0700 (PDT)
Date: Thu, 6 Jul 2017 21:19:44 +0200
From: Roland Kammerer <roland.kammerer@linbit.com>
To: Greg KH <gregkh@linuxfoundation.org>
Message-ID: <20170706191943.GF1453@rck.sh>
References: <20170605092623.GA20170@kroah.com> <20170706175607.GE1453@rck.sh>
	<20170706180241.GA15474@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170706180241.GA15474@kroah.com>
Cc: linux-kernel@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>,
	drbd-dev@lists.linbit.com, Philipp Reisner <philipp.reisner@linbit.com>,
	Roland Kammerer <roland.kammerer@linbit.com>
Subject: Re: [Drbd-dev] [PATCH] drbd: rename "usermode_helper" to
 "drbd_usermode_helper"
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Thu, Jul 06, 2017 at 08:02:41PM +0200, Greg KH wrote:
> On Thu, Jul 06, 2017 at 07:56:07PM +0200, Roland Kammerer wrote:
> > On Mon, Jun 05, 2017 at 11:26:23AM +0200, Greg KH wrote:
> > > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > 
> > > Nothing like having a very generic global variable in a tiny driver
> > > subsystem to make a mess of the global namespace...
> > 
> > Thanks for the patch. As this did not happen magically in mainline, I
> > queued it up in our out-of-tree repo.
> 
> What does that mean, will it get sent to Linus for 4.14-rc1?

Yes. 

Cheers, rck
