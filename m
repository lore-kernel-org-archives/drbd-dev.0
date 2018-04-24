Return-Path: <hch@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 56DBB1057321
	for <drbd-dev@lists.linbit.com>; Tue, 24 Apr 2018 16:21:49 +0200 (CEST)
Date: Tue, 24 Apr 2018 16:15:24 +0200
From: Christoph Hellwig <hch@lst.de>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Message-ID: <20180424141524.GB26136@lst.de>
References: <20180419124140.9309-1-hch@lst.de>
	<20180419124140.9309-27-hch@lst.de>
	<20180419131027.GC7369@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180419131027.GC7369@piout.net>
Cc: linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
	jfs-discussion@lists.sourceforge.net, devel@driverdev.osuosl.org,
	linux-afs@lists.infradead.org, linux-scsi@vger.kernel.org,
	Corey Minyard <minyard@acm.org>, linux-ide@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	linux-acpi@vger.kernel.org, netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
	Jiri Slaby <jslaby@suse.com>, Andrew Morton <akpm@linux-foundation.org>,
	linux-ext4@vger.kernel.org, Alexey Dobriyan <adobriyan@gmail.com>,
	megaraidlinux.pdl@broadcom.com, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 26/39] rtc/proc: switch to
	proc_create_single_data
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

On Thu, Apr 19, 2018 at 03:10:27PM +0200, Alexandre Belloni wrote:
> On 19/04/2018 14:41:27+0200, Christoph Hellwig wrote:
> > And stop trying to get a reference on the submodule, procfs code deals
> > with release after and unloaded module and thus removed proc entry.
> > 
> 
> Are you sure about that? The rtc module is not the one adding the procfs
> file so I'm not sure how the procfs code can handle it.

The proc file is removed from this call chain:

  <driver>_exit (module_exit handler)
    -> rtc_device_unregister
      -> rtc_proc_del_device
        -> remove_proc_entry

remove_proc_entry takes care of waiting for currently active file
operation instances and makes sure every new operation never calls
into the actual proc file ops.  Same behavior as in RTC exists all
over the kernel.
