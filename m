Return-Path: <hch@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 721FD1057315
	for <drbd-dev@lists.linbit.com>; Tue, 15 May 2018 15:59:06 +0200 (CEST)
Date: Tue, 15 May 2018 16:03:26 +0200
From: Christoph Hellwig <hch@lst.de>
To: Alexey Dobriyan <adobriyan@gmail.com>
Message-ID: <20180515140326.GC31296@lst.de>
References: <20180425154827.32251-1-hch@lst.de> <20180506171948.GA769@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180506171948.GA769@avx2>
Cc: linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	jfs-discussion@lists.sourceforge.net,
	linux-afs@lists.infradead.org, linux-acpi@vger.kernel.org,
	netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jiri Slaby <jslaby@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-ext4@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	megaraidlinux.pdl@broadcom.com, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] simplify procfs code for seq_file instances V2
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

On Sun, May 06, 2018 at 08:19:49PM +0300, Alexey Dobriyan wrote:
> On Wed, Apr 25, 2018 at 05:47:47PM +0200, Christoph Hellwig wrote:
> > Changes since V1:
> >  - open code proc_create_data to avoid setting not fully initialized
> >    entries live
> >  - use unsigned int for state_size
> 
> Need this to maintain sizeof(struct proc_dir_entry):

I'll fold your changes into the relevant patches.

> Otherwise ACK fs/proc/ part.

I'll take this as a formal ACK-ed by for all patches touching
procfs.  If I was wrong please scream.
