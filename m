Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wr0-f194.google.com (mail-wr0-f194.google.com
	[209.85.128.194])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 174C71057335
	for <drbd-dev@lists.linbit.com>; Fri, 20 Apr 2018 00:39:13 +0200 (CEST)
Received: by mail-wr0-f194.google.com with SMTP id d1-v6so18018223wrj.13
	for <drbd-dev@lists.linbit.com>; Thu, 19 Apr 2018 15:39:13 -0700 (PDT)
Received: from soda.linbit ([86.59.100.100]) by smtp.gmail.com with ESMTPSA id
	b18-v6sm1672064wrb.55.2018.04.19.15.39.11
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 19 Apr 2018 15:39:12 -0700 (PDT)
Resent-Message-ID: <20180419223911.GJ3821@soda.linbit>
Received: from mail-wr0-f172.google.com (mail-wr0-f172.google.com
	[209.85.128.172])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 0F26A1057335
	for <drbd-dev@lists.linbit.com>; Thu, 19 Apr 2018 20:57:54 +0200 (CEST)
Received: by mail-wr0-f172.google.com with SMTP id d19-v6so16756746wre.1
	for <drbd-dev@lists.linbit.com>; Thu, 19 Apr 2018 11:57:54 -0700 (PDT)
Date: Thu, 19 Apr 2018 21:57:50 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Message-ID: <20180419185750.GD2066@avx2>
References: <20180419124140.9309-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180419124140.9309-1-hch@lst.de>
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
Subject: Re: [Drbd-dev] simplify procfs code for seq_file instances
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

>     git://git.infradead.org/users/hch/misc.git proc_create


I want to ask if it is time to start using poorman function overloading
with _b_c_e(). There are millions of allocation functions for example,
all slightly difference, and people will add more. Seeing /proc interfaces
doubled like this is painful.
