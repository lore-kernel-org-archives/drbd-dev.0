Return-Path: <hch@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 61D8A1057315
	for <drbd-dev@lists.linbit.com>; Tue, 15 May 2018 15:54:29 +0200 (CEST)
Date: Tue, 15 May 2018 15:58:49 +0200
From: Christoph Hellwig <hch@lst.de>
To: Finn Thain <fthain@telegraphics.com.au>
Message-ID: <20180515135849.GB31296@lst.de>
References: <20180425154827.32251-1-hch@lst.de>
	<20180425154827.32251-7-hch@lst.de>
	<alpine.LNX.2.21.1804261118050.8@nippy.intranet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.21.1804261118050.8@nippy.intranet>
Cc: linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	devel@driverdev.osuosl.org, linux-afs@lists.infradead.org,
	linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
	Christoph Hellwig <hch@lst.de>, linux-acpi@vger.kernel.org,
	netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jiri Slaby <jslaby@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>, linux-ext4@vger.kernel.org,
	Alexey Dobriyan <adobriyan@gmail.com>,
	megaraidlinux.pdl@broadcom.com, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 06/40] proc: introduce proc_create_single{,
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

On Thu, Apr 26, 2018 at 11:45:50AM +1000, Finn Thain wrote:
> >  
> > -/*
> > - * /proc/nubus stuff
> > - */
> > -
> 
> I don't think that the introduction of proc_create_single{,_data} alters 
> the value of that comment. That comment and similar comments in the same 
> file do have a purpose, which is to keep separate the /proc/nubus 
> implementation is kept separate from the /proc/bus/nubus/devices 
> implementation and so on.

Added back.
