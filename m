Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wr0-f195.google.com (mail-wr0-f195.google.com
	[209.85.128.195])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id E0157105732C
	for <drbd-dev@lists.linbit.com>; Fri, 20 Apr 2018 00:38:50 +0200 (CEST)
Received: by mail-wr0-f195.google.com with SMTP id h3-v6so18030886wrh.5
	for <drbd-dev@lists.linbit.com>; Thu, 19 Apr 2018 15:38:50 -0700 (PDT)
Received: from soda.linbit ([86.59.100.100]) by smtp.gmail.com with ESMTPSA id
	b18-v6sm1670008wrb.55.2018.04.19.15.38.49
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 19 Apr 2018 15:38:49 -0700 (PDT)
Resent-Message-ID: <20180419223849.GG3821@soda.linbit>
Received: from mail-wr0-f178.google.com (mail-wr0-f178.google.com
	[209.85.128.178])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id F24C91057315
	for <drbd-dev@lists.linbit.com>; Thu, 19 Apr 2018 20:47:15 +0200 (CEST)
Received: by mail-wr0-f178.google.com with SMTP id z73-v6so16693788wrb.0
	for <drbd-dev@lists.linbit.com>; Thu, 19 Apr 2018 11:47:15 -0700 (PDT)
Date: Thu, 19 Apr 2018 21:41:06 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Message-ID: <20180419184106.GA2066@avx2>
References: <20180419124140.9309-1-hch@lst.de>
	<20180419124140.9309-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180419124140.9309-3-hch@lst.de>
Cc: linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	devel@driverdev.osuosl.org, linux-scsi@vger.kernel.org,
	Corey Minyard <minyard@acm.org>, linux-ide@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	jfs-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jiri Slaby <jslaby@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-ext4@vger.kernel.org, linux-afs@lists.infradead.org,
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

On Thu, Apr 19, 2018 at 02:41:03PM +0200, Christoph Hellwig wrote:
> Variants of proc_create{,_data} that directly take a struct seq_operations
> argument and drastically reduces the boilerplate code in the callers.

> +static int proc_seq_open(struct inode *inode, struct file *file)
> +{
> +	struct proc_dir_entry *de = PDE(inode);
> +
> +	return seq_open(file, de->seq_ops);
> +}
> +
> +static const struct file_operations proc_seq_fops = {
> +	.open		= proc_seq_open,
> +	.read		= seq_read,
> +	.llseek		= seq_lseek,
> +	.release	= seq_release,
> +};
> +
> +struct proc_dir_entry *proc_create_seq_data(const char *name, umode_t mode,
> +		struct proc_dir_entry *parent, const struct seq_operations *ops,
> +		void *data)
> +{
> +	struct proc_dir_entry *p;
> +
> +	p = proc_create_data(name, mode, parent, &proc_seq_fops, data);
> +	if (p)
> +		p->seq_ops = ops;
> +	return p;
> +}

Should be oopsable.
Once proc_create_data() returns, entry is live, ->open can be called.

> --- a/fs/proc/internal.h
> +++ b/fs/proc/internal.h
> @@ -44,6 +44,7 @@ struct proc_dir_entry {
>  	struct completion *pde_unload_completion;
>  	const struct inode_operations *proc_iops;
>  	const struct file_operations *proc_fops;
> +	const struct seq_operations *seq_ops;
>  	void *data;
>  	unsigned int low_ino;
>  	nlink_t nlink;

"struct proc_dir_entry is 192/128 bytes now.
If someone knows how to pad array to certain size without union
please tell.
