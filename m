Return-Path: <hch@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 6D5521057323
	for <drbd-dev@lists.linbit.com>; Tue, 24 Apr 2018 16:21:49 +0200 (CEST)
Date: Tue, 24 Apr 2018 16:16:01 +0200
From: Christoph Hellwig <hch@lst.de>
To: Corey Minyard <minyard@acm.org>
Message-ID: <20180424141601.GC26136@lst.de>
References: <20180419124140.9309-1-hch@lst.de>
	<20180419124140.9309-17-hch@lst.de>
	<f322f243-9ab1-7e9f-00a4-9652cd288ca2@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f322f243-9ab1-7e9f-00a4-9652cd288ca2@acm.org>
Cc: linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	devel@driverdev.osuosl.org, linux-afs@lists.infradead.org,
	linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
	Christoph Hellwig <hch@lst.de>, linux-acpi@vger.kernel.org,
	netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jiri Slaby <jslaby@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>, linux-ext4@vger.kernel.org,
	Alexey Dobriyan <adobriyan@gmail.com>,
	megaraidlinux.pdl@broadcom.com, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 16/39] ipmi: simplify procfs code
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

On Thu, Apr 19, 2018 at 10:29:29AM -0500, Corey Minyard wrote:
> On 04/19/2018 07:41 AM, Christoph Hellwig wrote:
>> Use remove_proc_subtree to remove the whole subtree on cleanup instead
>> of a hand rolled list of proc entries, unwind the registration loop into
>> individual calls.  Switch to use proc_create_single to further simplify
>> the code.
>
> I'm yanking all the proc code out of the IPMI driver in 3.18.  So this is 
> probably
> not necessary.

Ok, I'll drop this patch.
