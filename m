Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wr0-f196.google.com (mail-wr0-f196.google.com
	[209.85.128.196])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 47CD11057335
	for <drbd-dev@lists.linbit.com>; Fri, 20 Apr 2018 00:38:14 +0200 (CEST)
Received: by mail-wr0-f196.google.com with SMTP id m26-v6so166806wrb.3
	for <drbd-dev@lists.linbit.com>; Thu, 19 Apr 2018 15:38:14 -0700 (PDT)
Received: from soda.linbit ([86.59.100.100]) by smtp.gmail.com with ESMTPSA id
	n23-v6sm1287787wra.39.2018.04.19.15.38.12
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 19 Apr 2018 15:38:13 -0700 (PDT)
Resent-Message-ID: <20180419223812.GE3821@soda.linbit>
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 59F2F1057314
	for <drbd-dev@lists.linbit.com>; Thu, 19 Apr 2018 16:19:01 +0200 (CEST)
Date: Thu, 19 Apr 2018 17:18:18 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Christoph Hellwig <hch@lst.de>
Message-ID: <20180419141818.pjys7at4xmz2h6ho@mwanda>
References: <20180419124140.9309-1-hch@lst.de>
	<20180419124140.9309-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180419124140.9309-4-hch@lst.de>
Cc: linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	devel@driverdev.osuosl.org, Corey Minyard <minyard@acm.org>,
	linux-scsi@vger.kernel.org, linux-acpi@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jslaby@suse.com>, megaraidlinux.pdl@broadcom.com,
	linux-kernel@vger.kernel.org,
	Alexey Dobriyan <adobriyan@gmail.com>, linux-ide@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>, netdev@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-ext4@vger.kernel.org, linux-afs@lists.infradead.org,
	jfs-discussion@lists.sourceforge.net, drbd-dev@lists.linbit.com
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

On Thu, Apr 19, 2018 at 02:41:04PM +0200, Christoph Hellwig wrote:
> diff --git a/drivers/s390/cio/blacklist.c b/drivers/s390/cio/blacklist.c
> index 2a3f874a21d5..ad35cddcf6af 100644
> --- a/drivers/s390/cio/blacklist.c
> +++ b/drivers/s390/cio/blacklist.c
> @@ -391,28 +391,15 @@ static const struct seq_operations cio_ignore_proc_seq_ops = {
>  	.show  = cio_ignore_proc_seq_show,
>  };
>  
> -static int
> -cio_ignore_proc_open(struct inode *inode, struct file *file)
> -{
> -	return seq_open_private(file, &cio_ignore_proc_seq_ops,
> -				sizeof(struct ccwdev_iter));
> -}
> -
> -static const struct file_operations cio_ignore_proc_fops = {
> -	.open    = cio_ignore_proc_open,
> -	.read    = seq_read,
> -	.llseek  = seq_lseek,
> -	.release = seq_release_private,
> -	.write   = cio_ignore_write,
                   ^^^^^^^^^^^^^^^^
The cio_ignore_write() function isn't used any more so compilers will
complain.

> -};
> -
>  static int
>  cio_ignore_proc_init (void)
>  {
>  	struct proc_dir_entry *entry;
>  
> -	entry = proc_create("cio_ignore", S_IFREG | S_IRUGO | S_IWUSR, NULL,
> -			    &cio_ignore_proc_fops);
> +	entry = proc_create_seq_private("cio_ignore",
> +			S_IFREG | S_IRUGO | S_IWUSR, NULL,
> +			&cio_ignore_proc_seq_ops, sizeof(struct ccwdev_iter),
> +			NULL);
>  	if (!entry)
>  		return -ENOENT;
>  	return 0;

regards,
dan carpenter

