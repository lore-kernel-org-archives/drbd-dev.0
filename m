Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wr0-f195.google.com (mail-wr0-f195.google.com
	[209.85.128.195])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 5FA51105732C
	for <drbd-dev@lists.linbit.com>; Wed,  2 May 2018 17:38:37 +0200 (CEST)
Received: by mail-wr0-f195.google.com with SMTP id v15-v6so14514147wrm.10
	for <drbd-dev@lists.linbit.com>; Wed, 02 May 2018 08:38:37 -0700 (PDT)
Received: from soda.linbit ([86.59.100.100]) by smtp.gmail.com with ESMTPSA id
	44-v6sm10493079wrv.47.2018.05.02.08.38.36
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 02 May 2018 08:38:36 -0700 (PDT)
Resent-Message-ID: <20180502153835.GU10032@soda.linbit>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 2063B1057315
	for <drbd-dev@lists.linbit.com>; Mon, 30 Apr 2018 17:38:24 +0200 (CEST)
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20180425154827.32251-1-hch@lst.de>
References: <20180425154827.32251-1-hch@lst.de>
To: Christoph Hellwig <hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <15621.1525102698.1@warthog.procyon.org.uk>
Date: Mon, 30 Apr 2018 16:38:18 +0100
Message-ID: <15622.1525102698@warthog.procyon.org.uk>
Cc: linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	devel@driverdev.osuosl.org, linux-scsi@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jslaby@suse.com>, megaraidlinux.pdl@broadcom.com,
	linux-kernel@vger.kernel.org,
	Alexey Dobriyan <adobriyan@gmail.com>, dhowells@redhat.com,
	linux-ide@vger.kernel.org, netfilter-devel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>, netdev@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-ext4@vger.kernel.org, linux-afs@lists.infradead.org,
	jfs-discussion@lists.sourceforge.net, drbd-dev@lists.linbit.com
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

Note that your kernel hits the:

	inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage.
	swapper/0/0 [HC1[1]:SC0[0]:HE0:SE1] takes:
		(ptrval) (fs_reclaim){?.+.}, at: fs_reclaim_acquire+0x12/0x35
	{HARDIRQ-ON-W} state was registered at:
	  fs_reclaim_acquire+0x32/0x35
	  kmem_cache_alloc_node_trace+0x49/0x2cf
	  alloc_worker+0x1d/0x49
	  init_rescuer.part.7+0x19/0x8f
	  workqueue_init+0xc0/0x1fe
	  kernel_init_freeable+0xdc/0x433
	  kernel_init+0xa/0xf5
	  ret_from_fork+0x24/0x30

bug, as described here:

	https://groups.google.com/forum/#!msg/syzkaller-bugs/sJC3Y3hOM08/aO3z9JXoAgAJ

David
