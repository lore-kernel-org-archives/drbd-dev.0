Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wr0-f193.google.com (mail-wr0-f193.google.com
	[209.85.128.193])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 8A4411057328
	for <drbd-dev@lists.linbit.com>; Fri, 20 Apr 2018 00:38:56 +0200 (CEST)
Received: by mail-wr0-f193.google.com with SMTP id d19-v6so18041631wre.1
	for <drbd-dev@lists.linbit.com>; Thu, 19 Apr 2018 15:38:56 -0700 (PDT)
Received: from soda.linbit ([86.59.100.100]) by smtp.gmail.com with ESMTPSA id
	n23-v6sm1293647wra.39.2018.04.19.15.38.55
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 19 Apr 2018 15:38:55 -0700 (PDT)
Resent-Message-ID: <20180419223855.GH3821@soda.linbit>
Received: from mail-wr0-f169.google.com (mail-wr0-f169.google.com
	[209.85.128.169])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id A4EDA1057335
	for <drbd-dev@lists.linbit.com>; Thu, 19 Apr 2018 20:50:31 +0200 (CEST)
Received: by mail-wr0-f169.google.com with SMTP id z73-v6so16715474wrb.0
	for <drbd-dev@lists.linbit.com>; Thu, 19 Apr 2018 11:50:31 -0700 (PDT)
Date: Thu, 19 Apr 2018 21:50:27 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Message-ID: <20180419185027.GC2066@avx2>
References: <20180419124140.9309-1-hch@lst.de>
	<20180419124140.9309-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180419124140.9309-4-hch@lst.de>
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
> Variant of proc_create_data that directly take a struct seq_operations

> --- a/fs/proc/internal.h
> +++ b/fs/proc/internal.h
> @@ -45,6 +45,7 @@ struct proc_dir_entry {
>  	const struct inode_operations *proc_iops;
>  	const struct file_operations *proc_fops;
>  	const struct seq_operations *seq_ops;
> +	size_t state_size;

"unsigned int" please.

Where have you seen 4GB priv states?
