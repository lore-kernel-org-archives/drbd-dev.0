Return-Path: <Lars.Ellenberg@linbit.com>
Received: from minna.local (c-134-76-134.b.dial.de.ignite.net [62.134.76.134])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id EAEEC14328
	for <drbd-dev@lists.linbit.com>; Tue, 19 Oct 2004 12:43:11 +0200 (CEST)
Date: Tue, 19 Oct 2004 12:43:17 +0200
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Re: [DRBD-cvs] r1598 - trunk/user
Message-ID: <2ZxDBCtFYpvIE7ZPNcUCb8Q=lge@web.de>
References: <20041019073224.518E93BE6D@garcon.linbit.com>
	<20041019091307.GD9603@marowsky-bree.de>
	<IHnGc0lqeCeXwtfkV1Xslp4=lge@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <IHnGc0lqeCeXwtfkV1Xslp4=lge@web.de>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

/ 2004-10-19 12:19:18 +0200
\ Lars Ellenberg:
> > In particular these headers
> > 
> > > +#include <asm/byteorder.h>	/* for the __cpu_to_le64 etc. functions  */
> > > +#include <linux/bitops.h>	/* for the hweight functions  */
> > > +#include <linux/types.h>	/* for the __u32/64 type defs */
> > 
> > _are known to break_ on ia64/ppc64/s390x. I'd be very grateful if you
> > could avoid this.
> 
> hm.
> 
> I just don't want to depend on glib-devel just for some endianness issues.
> rather copy waht is neccessary into our own headers.
> which is not too much, anyways.
> 
> #  linux/bitops.h
> we only care for the hweight functions, which are plain c.
> I don't see where they could break on any arch.
> 
> # linux/types.h
> we only care for the __u32 __u64 type defines.
> ok, we can drop that and just use sys/types.h,
> %s/__u\(.*\)/uint\1_t/
> 
> # asm/byteorder.h
> ok, we can drop that, and use utils.h instead.

nonsense.
that is a nonstandard header, too.
well, then I'd just copy_n_paste together our own endian header?

> konsensfähig?

	lge
