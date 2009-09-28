Return-Path: <lars.ellenberg@linbit.com>
Date: Mon, 28 Sep 2009 10:50:37 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Message-ID: <20090928085037.GA8048@barkeeper1-xen.linbit>
References: <20090926152800.a6568e53.sfr@canb.auug.org.au>
	<20090926173143.GA5041@linux.vnet.ibm.com>
	<20090926200839.GA5220@merkur.ravnborg.org>
	<20090927125331.5367db08.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20090927125331.5367db08.sfr@canb.auug.org.au>
Cc: linux-kbuild@vger.kernel.org, Greg KH <greg@kroah.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
	linux-next@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
	LKML <linux-kernel@vger.kernel.org>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] linux-next: 20090926 - drop autoconf.h
	from	DRBD driver
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Sun, Sep 27, 2009 at 12:53:31PM +1000, Stephen Rothwell wrote:
> Hi Greg, Philipp,
> 
> On Sat, 26 Sep 2009 22:08:39 +0200 Sam Ravnborg <sam@ravnborg.org> wrote:
> >
> > On Sat, Sep 26, 2009 at 11:01:43PM +0530, Kamalesh Babulal wrote:
> > > 
> > > 	next-20090926 allyesconfig build breaks on powerpc,
> > > 
> > > drivers/block/drbd/drbd_proc.c:26:28: error: linux/autoconf.h: No such file or directory
> > > make[3]: *** [drivers/block/drbd/drbd_proc.o] Error 1
> > > 
> > > dropping autoconf.h from drbd_proc.c helps. The cleanup patch drops the
> > > unneeded include autoconf.h.
> > > 
> > > Signed-off-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
> > 
> > I only checked upstream - so this is no big suprise.
> > As there is no need to explicitly include autoconf.h this
> > change should be included by the drdb folks even if the
> > stuff I have does not hit upstream.
> 
> Maybe we should let them know (cc'd).


Thanks ;)
owed to our out-of-tree "backwards" compatibility for all 2.6 kernels
back to 2.6.5 (I think...).

includes have been dropped.

-- 
: Lars Ellenberg
: LINBIT | Your Way to High Availability
: DRBD/HA support and consulting http://www.linbit.com

DRBD® and LINBIT® are registered trademarks of LINBIT, Austria.
