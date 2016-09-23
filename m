Return-Path: <drbd-dev@lists.ewheeler.net>
Received: from mail.ewheeler.net (mx.ewheeler.net [66.155.3.69])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 41ADD1051881
	for <drbd-dev@lists.linbit.com>; Sat, 24 Sep 2016 00:01:14 +0200 (CEST)
Date: Fri, 23 Sep 2016 15:01:11 -0700 (PDT)
From: Eric Wheeler <drbd-dev@lists.ewheeler.net>
To: Lars Ellenberg <lars.ellenberg@linbit.com>
In-Reply-To: <20160920075709.GL3302@soda.linbit>
Message-ID: <alpine.LRH.2.11.1609231457310.29933@mail.ewheeler.net>
References: <alpine.LRH.2.11.1609191155210.21602@mail.ewheeler.net>
	<20160920075709.GL3302@soda.linbit>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="1641074820-2026619825-1474667856=:29933"
Cc: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] ASSERT( drbd_md_ss(device->ldev) ==
 device->ldev->md.md_offset )
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1641074820-2026619825-1474667856=:29933
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Tue, 20 Sep 2016, Lars Ellenberg wrote:

> On Mon, Sep 19, 2016 at 12:09:12PM -0700, Eric Wheeler wrote:
> > Hello all,
> > 
> > We noticed after resizing one backing device and not the other, that the 
> > side with the larger device issued the following assertion:
> > 
> > ASSERT( drbd_md_ss(device->ldev) == device->ldev->md.md_offset ) in drbd/obj/default/drbd_main.c:3257
> >
> > We were issuing a drbdadm resize --assume-clean, but for "reasons", the 
> > far-end did not resize. Below you can see the trace of the side issuing 
> > assertions. Is this a bug that should be hanadled intelligent way?
> > 
> > What does the failed assertion indicate? It appears to assert shortly 
> > after role change to-or-from Primary-or-Secondary.
> 
> DRBD is configured for "internal" meta data,
> for some reason does some meta data IO, and realizes that someone
> resized the backing device under it, without telling it to.
> 
> Should not do further harm.

"Further" ?  Was there any harm (corruption) in the first place?

> On the box that is logging these asserts,
> do a "drbdadm check-resize".
> 
> Preferably, you should follow a backend resize immediately
> with a drbdadm check-resize (or resize).

Is `drbdadm check-resize` a node-local operation?  Does it move metadata 
to the end on both sides, or only on the side invoking check-resize?

Thanks for your help!

--
Eric Wheeler


> 
> > We are using DRBD 8.4.7-2 from git.
> > 
> > [576057.341024] block drbd8033: logical block size of local backend does not match (drbd:512, backend:4096); was this a late attach?
> > [576057.343299] block drbd8033: drbd_bm_resize called with capacity == 21854808
> > [576057.344366] block drbd8033: resync bitmap: bits=2731851 words=42686 pages=84
> > [576057.345395] block drbd8033: size = 10 GB (10927404 KB)
> > [576057.381838] block drbd8033: Writing the whole bitmap, size changed
> > [576057.382865] block drbd8033: 0 KB (0 bits) marked out-of-sync by on disk bit-map.
> > [576057.384064] block drbd8033: Resync of new storage suppressed with --assume-clean
> > [576061.509044] block drbd8033: logical block size of local backend does not match (drbd:512, backend:4096); was this a late attach?
> > [576911.559399] block drbd8033: role( Primary -> Secondary ) 
> > [576911.560677] block drbd8033: 0 KB (0 bits) marked out-of-sync by on disk bit-map.
> > [662435.411830] block drbd8033: role( Secondary -> Primary ) 
> > [663204.542351] block drbd8033: role( Primary -> Secondary ) 
> > [663204.543515] block drbd8033: 0 KB (0 bits) marked out-of-sync by on disk bit-map.
> > [748834.185982] block drbd8033: role( Secondary -> Primary ) 
> > [750155.916752] block drbd8033: role( Primary -> Secondary ) 
> > [750155.918007] block drbd8033: 0 KB (0 bits) marked out-of-sync by on disk bit-map.
> > [750155.918768] block drbd8033: ASSERT( drbd_md_ss(device->ldev) == device->ldev->md.md_offset ) in /root/rpmbuild/BUILD/drbd-8.4.7-2-e4242d818e66301920ef28733f533053e924717f/obj/default/drbd_main.c:3257
> > [835228.859747] block drbd8033: role( Secondary -> Primary ) 
> > [835228.860996] block drbd8033: ASSERT( drbd_md_ss(device->ldev) == device->ldev->md.md_offset ) in /root/rpmbuild/BUILD/drbd-8.4.7-2-e4242d818e66301920ef28733f533053e924717f/obj/default/drbd_main.c:3257
> 
> -- 
> : Lars Ellenberg
> : LINBIT | Keeping the Digital World Running
> : DRBD -- Heartbeat -- Corosync -- Pacemaker
> : R&D, Integration, Ops, Consulting, Support
> 
> DRBD® and LINBIT® are registered trademarks of LINBIT
> _______________________________________________
> drbd-dev mailing list
> drbd-dev@lists.linbit.com
> http://lists.linbit.com/mailman/listinfo/drbd-dev
> 
--1641074820-2026619825-1474667856=:29933--
