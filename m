Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wr0-f196.google.com (mail-wr0-f196.google.com
	[209.85.128.196])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 982381057318
	for <drbd-dev@lists.linbit.com>; Fri, 20 Apr 2018 00:38:07 +0200 (CEST)
Received: by mail-wr0-f196.google.com with SMTP id d1-v6so18013683wrj.13
	for <drbd-dev@lists.linbit.com>; Thu, 19 Apr 2018 15:38:07 -0700 (PDT)
Received: from soda.linbit ([86.59.100.100])
	by smtp.gmail.com with ESMTPSA id c124sm95971wmd.36.2018.04.19.15.38.06
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 19 Apr 2018 15:38:06 -0700 (PDT)
Resent-Message-ID: <20180419223805.GD3821@soda.linbit>
Received: from mail.bootlin.com (mail.bootlin.com [62.4.15.54])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 949E11057311
	for <drbd-dev@lists.linbit.com>; Thu, 19 Apr 2018 15:16:55 +0200 (CEST)
Date: Thu, 19 Apr 2018 15:10:27 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Christoph Hellwig <hch@lst.de>
Message-ID: <20180419131027.GC7369@piout.net>
References: <20180419124140.9309-1-hch@lst.de>
	<20180419124140.9309-27-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180419124140.9309-27-hch@lst.de>
Cc: linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
	jfs-discussion@lists.sourceforge.net, devel@driverdev.osuosl.org,
	linux-scsi@vger.kernel.org, Corey Minyard <minyard@acm.org>,
	linux-ide@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-afs@lists.infradead.org,
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

On 19/04/2018 14:41:27+0200, Christoph Hellwig wrote:
> And stop trying to get a reference on the submodule, procfs code deals
> with release after and unloaded module and thus removed proc entry.
> 

Are you sure about that? The rtc module is not the one adding the procfs
file so I'm not sure how the procfs code can handle it.

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/rtc/rtc-proc.c | 33 ++-------------------------------
>  1 file changed, 2 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-proc.c b/drivers/rtc/rtc-proc.c
> index 31e7e23cc5be..a9dd9218fae2 100644
> --- a/drivers/rtc/rtc-proc.c
> +++ b/drivers/rtc/rtc-proc.c
> @@ -107,40 +107,11 @@ static int rtc_proc_show(struct seq_file *seq, void *offset)
>  	return 0;
>  }
>  
> -static int rtc_proc_open(struct inode *inode, struct file *file)
> -{
> -	int ret;
> -	struct rtc_device *rtc = PDE_DATA(inode);
> -
> -	if (!try_module_get(rtc->owner))
> -		return -ENODEV;
> -
> -	ret = single_open(file, rtc_proc_show, rtc);
> -	if (ret)
> -		module_put(rtc->owner);
> -	return ret;
> -}
> -
> -static int rtc_proc_release(struct inode *inode, struct file *file)
> -{
> -	int res = single_release(inode, file);
> -	struct rtc_device *rtc = PDE_DATA(inode);
> -
> -	module_put(rtc->owner);
> -	return res;
> -}
> -
> -static const struct file_operations rtc_proc_fops = {
> -	.open		= rtc_proc_open,
> -	.read		= seq_read,
> -	.llseek		= seq_lseek,
> -	.release	= rtc_proc_release,
> -};
> -
>  void rtc_proc_add_device(struct rtc_device *rtc)
>  {
>  	if (is_rtc_hctosys(rtc))
> -		proc_create_data("driver/rtc", 0, NULL, &rtc_proc_fops, rtc);
> +		proc_create_single_data("driver/rtc", 0, NULL, rtc_proc_show,
> +				rtc);
>  }
>  
>  void rtc_proc_del_device(struct rtc_device *rtc)
> -- 
> 2.17.0
> 

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
