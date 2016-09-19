Return-Path: <drbd-dev@lists.ewheeler.net>
Received: from mail.ewheeler.net (mx.ewheeler.net [66.155.3.69])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 3D02810556DB
	for <drbd-dev@lists.linbit.com>; Mon, 19 Sep 2016 21:14:25 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mail.ewheeler.net (Postfix) with ESMTP id 52A6AA0C51
	for <drbd-dev@lists.linbit.com>; Mon, 19 Sep 2016 12:09:16 -0700 (PDT)
Received: from mail.ewheeler.net ([127.0.0.1])
	by localhost (mail.ewheeler.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id RcVIU5NYVvQm for <drbd-dev@lists.linbit.com>;
	Mon, 19 Sep 2016 12:09:15 -0700 (PDT)
Received: from mx.ewheeler.net (mx.ewheeler.net [66.155.3.69])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.ewheeler.net (Postfix) with ESMTPSA id A73BEA0C50
	for <drbd-dev@lists.linbit.com>; Mon, 19 Sep 2016 12:09:15 -0700 (PDT)
Date: Mon, 19 Sep 2016 12:09:12 -0700 (PDT)
From: Eric Wheeler <drbd-dev@lists.ewheeler.net>
To: drbd-dev@lists.linbit.com
Message-ID: <alpine.LRH.2.11.1609191155210.21602@mail.ewheeler.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [Drbd-dev] ASSERT( drbd_md_ss(device->ldev) ==
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

Hello all,

We noticed after resizing one backing device and not the other, that the 
side with the larger device issued the following assertion:

ASSERT( drbd_md_ss(device->ldev) == device->ldev->md.md_offset ) in drbd/obj/default/drbd_main.c:3257

We were issuing a drbdadm resize --assume-clean, but for "reasons", the 
far-end did not resize. Below you can see the trace of the side issuing 
assertions. Is this a bug that should be hanadled intelligent way?

What does the failed assertion indicate? It appears to assert shortly 
after role change to-or-from Primary-or-Secondary.

We are using DRBD 8.4.7-2 from git.

[576057.341024] block drbd8033: logical block size of local backend does not match (drbd:512, backend:4096); was this a late attach?
[576057.343299] block drbd8033: drbd_bm_resize called with capacity == 21854808
[576057.344366] block drbd8033: resync bitmap: bits=2731851 words=42686 pages=84
[576057.345395] block drbd8033: size = 10 GB (10927404 KB)
[576057.381838] block drbd8033: Writing the whole bitmap, size changed
[576057.382865] block drbd8033: 0 KB (0 bits) marked out-of-sync by on disk bit-map.
[576057.384064] block drbd8033: Resync of new storage suppressed with --assume-clean
[576061.509044] block drbd8033: logical block size of local backend does not match (drbd:512, backend:4096); was this a late attach?
[576911.559399] block drbd8033: role( Primary -> Secondary ) 
[576911.560677] block drbd8033: 0 KB (0 bits) marked out-of-sync by on disk bit-map.
[662435.411830] block drbd8033: role( Secondary -> Primary ) 
[663204.542351] block drbd8033: role( Primary -> Secondary ) 
[663204.543515] block drbd8033: 0 KB (0 bits) marked out-of-sync by on disk bit-map.
[748834.185982] block drbd8033: role( Secondary -> Primary ) 
[750155.916752] block drbd8033: role( Primary -> Secondary ) 
[750155.918007] block drbd8033: 0 KB (0 bits) marked out-of-sync by on disk bit-map.
[750155.918768] block drbd8033: ASSERT( drbd_md_ss(device->ldev) == device->ldev->md.md_offset ) in /root/rpmbuild/BUILD/drbd-8.4.7-2-e4242d818e66301920ef28733f533053e924717f/obj/default/drbd_main.c:3257
[835228.859747] block drbd8033: role( Secondary -> Primary ) 
[835228.860996] block drbd8033: ASSERT( drbd_md_ss(device->ldev) == device->ldev->md.md_offset ) in /root/rpmbuild/BUILD/drbd-8.4.7-2-e4242d818e66301920ef28733f533053e924717f/obj/default/drbd_main.c:3257
[836287.928694] block drbd8033: role( Primary -> Secondary ) 
[836287.929886] block drbd8033: 0 KB (0 bits) marked out-of-sync by on disk bit-map.
[836287.930695] block drbd8033: ASSERT( drbd_md_ss(device->ldev) == device->ldev->md.md_offset ) in /root/rpmbuild/BUILD/drbd-8.4.7-2-e4242d818e66301920ef28733f533053e924717f/obj/default/drbd_main.c:3257
[921626.879416] block drbd8033: role( Secondary -> Primary ) 
[921626.880644] block drbd8033: ASSERT( drbd_md_ss(device->ldev) == device->ldev->md.md_offset ) in /root/rpmbuild/BUILD/drbd-8.4.7-2-e4242d818e66301920ef28733f533053e924717f/obj/default/drbd_main.c:3257
[922755.643770] block drbd8033: role( Primary -> Secondary ) 
[922755.645472] block drbd8033: 0 KB (0 bits) marked out-of-sync by on disk bit-map.
[922755.646186] block drbd8033: ASSERT( drbd_md_ss(device->ldev) == device->ldev->md.md_offset ) in /root/rpmbuild/BUILD/drbd-8.4.7-2-e4242d818e66301920ef28733f533053e924717f/obj/default/drbd_main.c:3257
[1008022.668036] block drbd8033: role( Secondary -> Primary ) 
[1008022.669397] block drbd8033: ASSERT( drbd_md_ss(device->ldev) == device->ldev->md.md_offset ) in /root/rpmbuild/BUILD/drbd-8.4.7-2-e4242d818e66301920ef28733f533053e924717f/obj/default/drbd_main.c:3257
[1009802.518711] block drbd8033: role( Primary -> Secondary ) 
[1009802.519884] block drbd8033: 0 KB (0 bits) marked out-of-sync by on disk bit-map.
[1009802.520536] block drbd8033: ASSERT( drbd_md_ss(device->ldev) == device->ldev->md.md_offset ) in /root/rpmbuild/BUILD/drbd-8.4.7-2-e4242d818e66301920ef28733f533053e924717f/obj/default/drbd_main.c:3257
[1024556.860980] block drbd8033: role( Secondary -> Primary ) 
[1024556.863208] block drbd8033: ASSERT( drbd_md_ss(device->ldev) == device->ldev->md.md_offset ) in /root/rpmbuild/BUILD/drbd-8.4.7-2-e4242d818e66301920ef28733f533053e924717f/obj/default/drbd_main.c:3257
[1024614.269377] block drbd8033: role( Primary -> Secondary ) 
[1024614.271469] block drbd8033: 0 KB (0 bits) marked out-of-sync by on disk bit-map.
[1024614.272483] block drbd8033: ASSERT( drbd_md_ss(device->ldev) == device->ldev->md.md_offset ) in /root/rpmbuild/BUILD/drbd-8.4.7-2-e4242d818e66301920ef28733f533053e924717f/obj/default/drbd_main.c:3257


--
Eric Wheeler
