Return-Path: <hch@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 7529B105731F
	for <drbd-dev@lists.linbit.com>; Tue, 24 Apr 2018 16:27:32 +0200 (CEST)
Date: Tue, 24 Apr 2018 16:29:02 +0200
From: Christoph Hellwig <hch@lst.de>
To: Alexey Dobriyan <adobriyan@gmail.com>
Message-ID: <20180424142902.GA26554@lst.de>
References: <20180419124140.9309-1-hch@lst.de>
	<20180419124140.9309-4-hch@lst.de> <20180419185027.GC2066@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180419185027.GC2066@avx2>
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
Subject: Re: [Drbd-dev] [PATCH 03/39] proc: introduce proc_create_seq_private
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

On Thu, Apr 19, 2018 at 09:50:27PM +0300, Alexey Dobriyan wrote:
> On Thu, Apr 19, 2018 at 02:41:04PM +0200, Christoph Hellwig wrote:
> > Variant of proc_create_data that directly take a struct seq_operations
> 
> > --- a/fs/proc/internal.h
> > +++ b/fs/proc/internal.h
> > @@ -45,6 +45,7 @@ struct proc_dir_entry {
> >  	const struct inode_operations *proc_iops;
> >  	const struct file_operations *proc_fops;
> >  	const struct seq_operations *seq_ops;
> > +	size_t state_size;
> 
> "unsigned int" please.
> 
> Where have you seen 4GB priv states?

We're passing the result of sizeof, which happens to be a size_t.
But if it makes you happy I can switch to unsigned int.
