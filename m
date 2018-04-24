Return-Path: <hch@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 875DF105731F
	for <drbd-dev@lists.linbit.com>; Tue, 24 Apr 2018 16:27:51 +0200 (CEST)
Date: Tue, 24 Apr 2018 16:29:22 +0200
From: Christoph Hellwig <hch@lst.de>
To: Alexey Dobriyan <adobriyan@gmail.com>
Message-ID: <20180424142922.GB26554@lst.de>
References: <20180419124140.9309-1-hch@lst.de>
	<20180419124140.9309-3-hch@lst.de> <20180419184106.GA2066@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180419184106.GA2066@avx2>
Cc: linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org, Corey Minyard <minyard@acm.org>,
	linux-ide@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	jfs-discussion@lists.sourceforge.net,
	linux-afs@lists.infradead.org, linux-acpi@vger.kernel.org,
	netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jiri Slaby <jslaby@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-ext4@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	megaraidlinux.pdl@broadcom.com, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 02/39] proc: introduce proc_create_seq{,
	_data}
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

On Thu, Apr 19, 2018 at 09:41:06PM +0300, Alexey Dobriyan wrote:
> Should be oopsable.
> Once proc_create_data() returns, entry is live, ->open can be called.

Ok, switching to opencoding proc_create_data instead.
