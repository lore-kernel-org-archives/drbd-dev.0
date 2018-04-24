Return-Path: <hch@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 93C091056F9F
	for <drbd-dev@lists.linbit.com>; Tue, 24 Apr 2018 18:05:22 +0200 (CEST)
Date: Tue, 24 Apr 2018 18:06:53 +0200
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>
Message-ID: <20180424160652.GA28483@lst.de>
References: <20180419124140.9309-1-hch@lst.de> <20180419185750.GD2066@avx2>
	<20180424142304.GE26136@lst.de>
	<20180424081916.e94ca8463fb3c39ebc082bdd@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180424081916.e94ca8463fb3c39ebc082bdd@linux-foundation.org>
Cc: linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	devel@driverdev.osuosl.org, linux-afs@lists.infradead.org,
	linux-scsi@vger.kernel.org, Corey Minyard <minyard@acm.org>,
	linux-ide@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
	Alexey Dobriyan <adobriyan@gmail.com>,
	linux-acpi@vger.kernel.org, netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
	Jiri Slaby <jslaby@suse.com>, linux-ext4@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, megaraidlinux.pdl@broadcom.com,
	drbd-dev@lists.linbit.com
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

On Tue, Apr 24, 2018 at 08:19:16AM -0700, Andrew Morton wrote:
> > > I want to ask if it is time to start using poorman function overloading
> > > with _b_c_e(). There are millions of allocation functions for example,
> > > all slightly difference, and people will add more. Seeing /proc interfaces
> > > doubled like this is painful.
> > 
> > Function overloading is totally unacceptable.
> > 
> > And I very much disagree with a tradeoff that keeps 5000 lines of 
> > code vs a few new helpers.
> 
> OK, the curiosity and suspense are killing me.  What the heck is
> "function overloading with _b_c_e()"?

The way I understood Alexey was to use have a proc_create macro
that can take different ops types.  Although the short cut for
__builtin_types_compatible_p would be _b_t_c or similar, so maybe
I misunderstood him.
