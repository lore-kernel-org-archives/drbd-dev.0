Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wm0-f66.google.com (mail-wm0-f66.google.com [74.125.82.66])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 2974C100542B
	for <drbd-dev@lists.linbit.com>; Fri, 18 May 2018 14:56:01 +0200 (CEST)
Received: by mail-wm0-f66.google.com with SMTP id o78-v6so15082413wmg.0
	for <drbd-dev@lists.linbit.com>; Fri, 18 May 2018 05:56:01 -0700 (PDT)
Date: Fri, 18 May 2018 14:55:54 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: Christoph Hellwig <hch@lst.de>
Message-ID: <20180518125554.GA9238@soda.linbit>
References: <20180516094346.20506-1-hch@lst.de>
	<20180516094346.20506-29-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180516094346.20506-29-hch@lst.de>
Cc: linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	devel@driverdev.osuosl.org, linux-scsi@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jslaby@suse.com>, megaraidlinux.pdl@broadcom.com,
	linux-kernel@vger.kernel.org,
	Alexey Dobriyan <adobriyan@gmail.com>, linux-ide@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>, netdev@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-ext4@vger.kernel.org, linux-afs@lists.infradead.org,
	jfs-discussion@lists.sourceforge.net, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 28/42] drbd: switch to proc_create_single
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

On Wed, May 16, 2018 at 11:43:32AM +0200, Christoph Hellwig wrote:
> And stop messing with try_module_get on THIS_MODULE, which doesn't make
> any sense here.

The idea was to increase module count on /proc/drbd access.

If someone holds /proc/drbd open, previously rmmod would
"succeed" in starting the unload, but then block on remove_proc_entry,
leading to a situation where the lsmod does not show drbd anymore,
but /proc/drbd being still there (but no longer accessible).

I'd rather have rmmod fail up front in this case.
And try_module_get() seemed most appropriate.

    Lars

