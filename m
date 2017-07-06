Return-Path: <roland.kammerer@linbit.com>
Received: from mail-wr0-f174.google.com (mail-wr0-f174.google.com
	[209.85.128.174])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 537911057FE6
	for <drbd-dev@lists.linbit.com>; Thu,  6 Jul 2017 20:03:42 +0200 (CEST)
Received: by mail-wr0-f174.google.com with SMTP id 77so13341435wrb.1
	for <drbd-dev@lists.linbit.com>; Thu, 06 Jul 2017 11:03:42 -0700 (PDT)
Date: Thu, 6 Jul 2017 19:56:07 +0200
From: Roland Kammerer <roland.kammerer@linbit.com>
To: Greg KH <gregkh@linuxfoundation.org>
Message-ID: <20170706175607.GE1453@rck.sh>
References: <20170605092623.GA20170@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170605092623.GA20170@kroah.com>
Cc: Lars Ellenberg <lars.ellenberg@linbit.com>, drbd-dev@lists.linbit.com,
	Philipp Reisner <philipp.reisner@linbit.com>, linux-kernel@vger.kernel.org
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

Thanks for the patch. As this did not happen magically in mainline, I
queued it up in our out-of-tree repo.

> 
> Note, there are many other "generic" named global variables in the drbd
> subsystem, someone should fix those up one day before they hit a linking
> error.

Did that as well.

Both should hit some merge-window soon.

Thanks, rck
-- 
Roland Kammerer
roland.kammerer@linbit.com

LINBIT | Keeping the Digital World Running
DRBD – Corosync – Pacemaker

