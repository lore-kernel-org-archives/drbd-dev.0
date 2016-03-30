Return-Path: <roland.kammerer@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id C2C281056421
	for <drbd-dev@lists.linbit.com>; Wed, 30 Mar 2016 14:15:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id B0D13361705
	for <drbd-dev@lists.linbit.com>; Wed, 30 Mar 2016 14:15:20 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id I8IAvCywDq6j for <drbd-dev@lists.linbit.com>;
	Wed, 30 Mar 2016 14:15:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 8CF40361765
	for <drbd-dev@lists.linbit.com>; Wed, 30 Mar 2016 14:15:20 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id wZ_-c1-RlJEX for <drbd-dev@lists.linbit.com>;
	Wed, 30 Mar 2016 14:15:20 +0200 (CEST)
Received: from localhost (chello213047144126.1.15.vie.surfer.at
	[213.47.144.126])
	by zimbra13.linbit.com (Postfix) with ESMTPSA id 47648361705
	for <drbd-dev@lists.linbit.com>; Wed, 30 Mar 2016 14:15:20 +0200 (CEST)
Date: Wed, 30 Mar 2016 14:15:19 +0200
From: Roland Kammerer <roland.kammerer@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20160330121519.GG15462@rck.sh>
References: <CAF6H8oGE3dsx89dD_z7gM=h4HuOeHQbSt9ET-6BpV5Hvows7RQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF6H8oGE3dsx89dD_z7gM=h4HuOeHQbSt9ET-6BpV5Hvows7RQ@mail.gmail.com>
Subject: Re: [Drbd-dev] [CASE-38] self uuid may be crashed beacuse of
 garbage bitmap_index value.
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

On Wed, Mar 30, 2016 at 06:18:50PM +0900, Jaeheon Kim wrote:
> Hi,
> 
> There is some suspicious code.
> Please check following code in drbd_uuid_compare.
> 
>  --- code snip start ---
> *rule_nr = 70;
> self = drbd_bitmap_uuid(peer_device) & ~UUID_PRIMARY;
> peer = peer_device->current_uuid & ~UUID_PRIMARY;
> if (self == peer)
> return 2;
> 
> *rule_nr = 72;
> for (i = 0; i < DRBD_NODE_ID_MAX; i++) {
>     if (i == peer_device->node_id)
>           continue;
>     if (i == device->ldev->md.node_id)
>           continue;
> 
> #ifdef
> _WIN32_V9_INSERT!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
> /* Skip bitmap indexes which are not assigned to a peer. */
>       if (device->ldev->md.peers[i].bitmap_index == -1)
>            continue;
> #endif //
> !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
> 
>      self = device->ldev->md.peers[i].bitmap_uuid & ~UUID_PRIMARY;
>      if (self == peer) {
>           *peer_node_id = i;
>            return 4;
>       }
> }
> ------ code done --------
> 
> If you don't skip undefnded bitmap_index, self uuid will get crashed data.
> So, we insert this skip logic.
> What do you think about it?

on a first look this seems reasonable, but I have to further think about
it and discuss it with my colleagues.

Would be great if you could provide the steps how to trigger that
specific scenario.

Regards, rck
