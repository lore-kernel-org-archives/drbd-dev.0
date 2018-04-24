Return-Path: <hch@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id A7E94105731F
	for <drbd-dev@lists.linbit.com>; Tue, 24 Apr 2018 16:26:49 +0200 (CEST)
Date: Tue, 24 Apr 2018 16:19:02 +0200
From: Christoph Hellwig <hch@lst.de>
To: Dan Carpenter <dan.carpenter@oracle.com>
Message-ID: <20180424141902.GD26136@lst.de>
References: <20180419124140.9309-1-hch@lst.de>
	<20180419124140.9309-4-hch@lst.de>
	<20180419141818.pjys7at4xmz2h6ho@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180419141818.pjys7at4xmz2h6ho@mwanda>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	jfs-discussion@lists.sourceforge.net, linux-ide@vger.kernel.org,
	linux-afs@lists.infradead.org, drbd-dev@lists.linbit.com,
	linux-rtc@vger.kernel.org, linux-scsi@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, linux-acpi@vger.kernel.org,
	Jiri Slaby <jslaby@suse.com>, linux-ext4@vger.kernel.org,
	Alexey Dobriyan <adobriyan@gmail.com>,
	devel@driverdev.osuosl.org, Corey Minyard <minyard@acm.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, megaraidlinux.pdl@broadcom.com,
	Alessandro Zummo <a.zummo@towertech.it>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
	netdev@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
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

On Thu, Apr 19, 2018 at 05:18:18PM +0300, Dan Carpenter wrote:
> > -static const struct file_operations cio_ignore_proc_fops = {
> > -	.open    = cio_ignore_proc_open,
> > -	.read    = seq_read,
> > -	.llseek  = seq_lseek,
> > -	.release = seq_release_private,
> > -	.write   = cio_ignore_write,
>                    ^^^^^^^^^^^^^^^^
> The cio_ignore_write() function isn't used any more so compilers will
> complain.

No compiler in the buildboot farm complained, but neverless this
