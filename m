Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wr0-f195.google.com (mail-wr0-f195.google.com
	[209.85.128.195])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 4640E1057321
	for <drbd-dev@lists.linbit.com>; Wed,  2 May 2018 17:38:20 +0200 (CEST)
Received: by mail-wr0-f195.google.com with SMTP id o4-v6so14511429wrm.0
	for <drbd-dev@lists.linbit.com>; Wed, 02 May 2018 08:38:20 -0700 (PDT)
Received: from soda.linbit ([86.59.100.100]) by smtp.gmail.com with ESMTPSA id
	131sm8642799wms.34.2018.05.02.08.38.19
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 02 May 2018 08:38:19 -0700 (PDT)
Resent-Message-ID: <20180502153819.GS10032@soda.linbit>
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
	[98.124.60.144])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id EC49A105731F
	for <drbd-dev@lists.linbit.com>; Thu, 26 Apr 2018 03:54:12 +0200 (CEST)
Date: Thu, 26 Apr 2018 11:45:50 +1000 (AEST)
From: Finn Thain <fthain@telegraphics.com.au>
To: Christoph Hellwig <hch@lst.de>
In-Reply-To: <20180425154827.32251-7-hch@lst.de>
Message-ID: <alpine.LNX.2.21.1804261118050.8@nippy.intranet>
References: <20180425154827.32251-1-hch@lst.de>
	<20180425154827.32251-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	jfs-discussion@lists.sourceforge.net,
	linux-afs@lists.infradead.org, linux-acpi@vger.kernel.org,
	netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jiri Slaby <jslaby@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>, linux-ext4@vger.kernel.org,
	Alexey Dobriyan <adobriyan@gmail.com>,
	megaraidlinux.pdl@broadcom.com, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 06/40] proc: introduce proc_create_single{,
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

On Wed, 25 Apr 2018, Christoph Hellwig wrote:

>  
> -/*
> - * /proc/nubus stuff
> - */
> -

I don't think that the introduction of proc_create_single{,_data} alters 
the value of that comment. That comment and similar comments in the same 
file do have a purpose, which is to keep separate the /proc/nubus 
implementation is kept separate from the /proc/bus/nubus/devices 
implementation and so on.

-- 
