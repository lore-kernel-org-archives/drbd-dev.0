Return-Path: <hch@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 8AA921057324
	for <drbd-dev@lists.linbit.com>; Fri, 18 May 2018 10:53:29 +0200 (CEST)
Date: Fri, 18 May 2018 10:58:12 +0200
From: Christoph Hellwig <hch@lst.de>
To: Paul Bolle <pebolle@tiscali.nl>
Message-ID: <20180518085812.GB24387@lst.de>
References: <20180516094346.20506-1-hch@lst.de>
	<20180516094346.20506-39-hch@lst.de>
	<4e7091873e8a220c454a7ce5a3f52edc5b5c3e3a.camel@tiscali.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e7091873e8a220c454a7ce5a3f52edc5b5c3e3a.camel@tiscali.nl>
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
Subject: Re: [Drbd-dev] [PATCH 38/42] isdn: replace ->proc_fops with
	->proc_show
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

On Fri, May 18, 2018 at 10:43:46AM +0200, Paul Bolle wrote:
> >  	iif->ctr.release_appl  = gigaset_release_appl;
> >  	iif->ctr.send_message  = gigaset_send_message;
> > -	iif->ctr.procinfo      = gigaset_procinfo;
> 
> Is this intentional? You didn't touch the procinfo method in the other ISDN
> drivers, as far as I can see.
> 
> (If it was intentional, gigaset_procinfo() can of course be removed.)

Already fixed in the branch in Als tree.
