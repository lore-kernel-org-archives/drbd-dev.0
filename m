Return-Path: <Lars.Ellenberg@linbit.com>
Received: from minna.local (dialin-145-254-065-089.arcor-ip.net
	[145.254.65.89])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 2C39B14360
	for <drbd-dev@lists.linbit.com>; Tue, 19 Oct 2004 12:29:02 +0200 (CEST)
Date: Tue, 19 Oct 2004 12:19:18 +0200
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Re: [DRBD-cvs] r1598 - trunk/user
Message-ID: <IHnGc0lqeCeXwtfkV1Xslp4=lge@web.de>
References: <20041019073224.518E93BE6D@garcon.linbit.com>
	<20041019091307.GD9603@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20041019091307.GD9603@marowsky-bree.de>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

/ 2004-10-19 11:13:07 +0200
\ Lars Marowsky-Bree:
> On 2004-10-19T09:32:24, svn@svn.drbd.org wrote:
> 
> > Author: phil
> > Date: 2004-10-19 09:32:21 +0200 (Tue, 19 Oct 2004)
> > New Revision: 1598
> > 
> > Modified:
> >    trunk/user/Makefile
> >    trunk/user/drbdmeta.c
> > Log:
> > [patch by LGE] 
> >  * removed the dependency on glib, and use the kernel's
> >    includes instead. 
> 
> Do not do that. Please. Including kernel-headers from user-space is an
> absolute nightmare, it keeps breaking sporadically and in particular on
> non-i386 archs. The kernel headers just aren't meant to be used in
> user-space (and are documented to not be supported for this), and all
> the build issues I've had with OCFS, Lustre, ... have been caused by
> this.
> 
> In particular these headers
> 
> > +#include <asm/byteorder.h>	/* for the __cpu_to_le64 etc. functions  */
> > +#include <linux/bitops.h>	/* for the hweight functions  */
> > +#include <linux/types.h>	/* for the __u32/64 type defs */
> 
> _are known to break_ on ia64/ppc64/s390x. I'd be very grateful if you
> could avoid this.

hm.

I just don't want to depend on glib-devel just for some endianness issues.
rather copy waht is neccessary into our own headers.
which is not too much, anyways.

#  linux/bitops.h
we only care for the hweight functions, which are plain c.
I don't see where they could break on any arch.

# linux/types.h
we only care for the __u32 __u64 type defines.
ok, we can drop that and just use sys/types.h,
%s/__u\(.*\)/uint\1_t/

# asm/byteorder.h
ok, we can drop that, and use utils.h instead.
we'd need to define *64 variants of swap and *_to_* functions, though.

konsensfähig?

	lge
