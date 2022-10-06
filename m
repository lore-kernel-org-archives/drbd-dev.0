Return-Path: <andriy.shevchenko@linux.intel.com>
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 3555B4201C4
	for <drbd-dev@lists.linbit.com>; Thu,  6 Oct 2022 15:20:45 +0200 (CEST)
Date: Thu, 6 Oct 2022 16:20:31 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Message-ID: <Yz7WHyD+teLOh2ho@smile.fi.intel.com>
References: <20221005214844.2699-1-Jason@zx2c4.com>
	<20221005214844.2699-4-Jason@zx2c4.com> <Yz7OdfKZeGkpZSKb@ziepe.ca>
	<CAHmME9r_vNRFFjUvqx8QkBddg_kQU=FMgpk9TqOVZdvX6zXHNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9r_vNRFFjUvqx8QkBddg_kQU=FMgpk9TqOVZdvX6zXHNg@mail.gmail.com>
Cc: linux-fbdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-wireless@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-mm@kvack.org, linux-sctp@vger.kernel.org,
	target-devel@vger.kernel.org, linux-mtd@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	drbd-dev@lists.linbit.com, dev@openvswitch.org,
	rds-devel@oss.oracle.com, linux-scsi@vger.kernel.org,
	dccp@vger.kernel.org, linux-rdma@vger.kernel.org,
	kasan-dev@googlegroups.com, lvs-devel@vger.kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>, coreteam@netfilter.org,
	tipc-discussion@lists.sourceforge.net,
	linux-ext4@vger.kernel.org, linux-media@vger.kernel.org,
	linux-actions@lists.infradead.org, linux-nfs@vger.kernel.org,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-nvme@lists.infradead.org, SHA-cyfmac-dev-list@infineon.com,
	linux-hams@vger.kernel.org, ceph-devel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, cake@lists.bufferbloat.net,
	brcm80211-dev-list.pdl@broadcom.com, linux-raid@vger.kernel.org,
	netdev@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-xfs@vger.kernel.org, netfilter-devel@vger.kernel.org,
	linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [Drbd-dev] [PATCH v1 3/5] treewide: use get_random_u32() when
	possible
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <https://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <https://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Thu, Oct 06, 2022 at 07:05:48AM -0600, Jason A. Donenfeld wrote:
> On Thu, Oct 6, 2022 at 6:47 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > On Wed, Oct 05, 2022 at 11:48:42PM +0200, Jason A. Donenfeld wrote:

...

> > > -     u32 isn = (prandom_u32() & ~7UL) - 1;
> > > +     u32 isn = (get_random_u32() & ~7UL) - 1;
> >
> > Maybe this wants to be written as
> >
> > (prandom_max(U32_MAX >> 7) << 7) | 7

> > ?
> 
> Holy smokes. Yea I guess maybe? It doesn't exactly gain anything or
> make the code clearer though, and is a little bit more magical than
> I'd like on a first pass.

Shouldn't the two first 7s to be 3s?

...

> > > -     psn = prandom_u32() & 0xffffff;
> > > +     psn = get_random_u32() & 0xffffff;
> >
> >  prandom_max(0xffffff + 1)
> 
> That'd work, but again it's not more clear. Authors here are going for
> a 24-bit number, and masking seems like a clear way to express that.

We have some 24-bit APIs (and 48-bit) already in kernel, why not to have
get_random_u24() ?


-- 
With Best Regards,
Andy Shevchenko


