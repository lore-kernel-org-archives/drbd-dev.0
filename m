Return-Path: <akpm@linux-foundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
	[140.211.169.12])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 292D6105731F
	for <drbd-dev@lists.linbit.com>; Tue, 24 Apr 2018 17:29:16 +0200 (CEST)
Date: Tue, 24 Apr 2018 08:19:16 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Christoph Hellwig <hch@lst.de>
Message-Id: <20180424081916.e94ca8463fb3c39ebc082bdd@linux-foundation.org>
In-Reply-To: <20180424142304.GE26136@lst.de>
References: <20180419124140.9309-1-hch@lst.de> <20180419185750.GD2066@avx2>
	<20180424142304.GE26136@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-rtc@vger.kernel.org, Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org, Corey Minyard <minyard@acm.org>,
	linux-ide@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	jfs-discussion@lists.sourceforge.net,
	linux-afs@lists.infradead.org, linux-acpi@vger.kernel.org,
	Alessandro, netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jiri Slaby <jslaby@suse.com>, linux-ext4@vger.kernel.org,
	Alexey Dobriyan <adobriyan@gmail.com>,
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

On Tue, 24 Apr 2018 16:23:04 +0200 Christoph Hellwig <hch@lst.de> wrote:

> On Thu, Apr 19, 2018 at 09:57:50PM +0300, Alexey Dobriyan wrote:
> > >     git://git.infradead.org/users/hch/misc.git proc_create
> > 
> > 
> > I want to ask if it is time to start using poorman function overloading
> > with _b_c_e(). There are millions of allocation functions for example,
> > all slightly difference, and people will add more. Seeing /proc interfaces
> > doubled like this is painful.
> 
> Function overloading is totally unacceptable.
> 
> And I very much disagree with a tradeoff that keeps 5000 lines of 
> code vs a few new helpers.

OK, the curiosity and suspense are killing me.  What the heck is
"function overloading with _b_c_e()"?
