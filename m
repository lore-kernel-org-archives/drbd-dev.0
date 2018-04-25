Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wr0-f194.google.com (mail-wr0-f194.google.com
	[209.85.128.194])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 1A5B81057321
	for <drbd-dev@lists.linbit.com>; Wed,  2 May 2018 17:38:07 +0200 (CEST)
Received: by mail-wr0-f194.google.com with SMTP id c14-v6so14510794wrd.4
	for <drbd-dev@lists.linbit.com>; Wed, 02 May 2018 08:38:07 -0700 (PDT)
Received: from soda.linbit ([86.59.100.100]) by smtp.gmail.com with ESMTPSA id
	12sm17674428wmn.27.2018.05.02.08.38.06
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 02 May 2018 08:38:06 -0700 (PDT)
Resent-Message-ID: <20180502153805.GQ10032@soda.linbit>
Received: from mail.bootlin.com (mail.bootlin.com [62.4.15.54])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 783FA1057322
	for <drbd-dev@lists.linbit.com>; Wed, 25 Apr 2018 20:25:48 +0200 (CEST)
Date: Wed, 25 Apr 2018 20:25:37 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Christoph Hellwig <hch@lst.de>
Message-ID: <20180425182537.GG4813@piout.net>
References: <20180425154827.32251-1-hch@lst.de>
	<20180425154827.32251-28-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180425154827.32251-28-hch@lst.de>
Cc: linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
	jfs-discussion@lists.sourceforge.net, devel@driverdev.osuosl.org,
	linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-afs@lists.infradead.org,
	linux-acpi@vger.kernel.org, netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
	Jiri Slaby <jslaby@suse.com>, Andrew Morton <akpm@linux-foundation.org>,
	linux-ext4@vger.kernel.org, Alexey Dobriyan <adobriyan@gmail.com>,
	megaraidlinux.pdl@broadcom.com, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 27/40] rtc/proc: switch to
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

On 25/04/2018 17:48:14+0200, Christoph Hellwig wrote:
> And stop trying to get a reference on the submodule, procfs code deals
> with release after and unloaded module and thus removed proc entry.
small typo here        ^

> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>


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
