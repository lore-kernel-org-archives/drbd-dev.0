Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wr0-f171.google.com (mail-wr0-f171.google.com
	[209.85.128.171])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 504F1105630C
	for <drbd-dev@lists.linbit.com>; Thu,  8 Jun 2017 14:56:36 +0200 (CEST)
Received: by mail-wr0-f171.google.com with SMTP id v111so18182673wrc.3
	for <drbd-dev@lists.linbit.com>; Thu, 08 Jun 2017 05:56:36 -0700 (PDT)
Date: Thu, 8 Jun 2017 14:50:42 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: Greg KH <gregkh@linuxfoundation.org>
Message-ID: <20170608125042.GE13239@soda.linbit>
References: <20170605092623.GA20170@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170605092623.GA20170@kroah.com>
Cc: linux-kernel@vger.kernel.org, Philipp Reisner <philipp.reisner@linbit.com>,
	drbd-dev@lists.linbit.com
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

On Mon, Jun 05, 2017 at 11:26:23AM +0200, Greg KH wrote:
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Nothing like having a very generic global variable in a tiny driver
> subsystem to make a mess of the global namespace...
> 
> Note, there are many other "generic" named global variables in the drbd
> subsystem, someone should fix those up one day before they hit a linking
> error.

Thanks. We'll prepare a patch to that effect, probably converting some
of them to static, fixing up the rest, and submit with the updates for
the next merge window.

    Lars

