Return-Path: <t.lamprecht@proxmox.com>
Received: from proxmox.maurer-it.com (proxmox.maurer-it.com [94.136.31.133])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 319FB1056318
	for <drbd-dev@lists.linbit.com>; Wed, 27 Jan 2016 07:44:17 +0100 (CET)
Received: from proxmox.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox.maurer-it.com (Proxmox) with ESMTP id AA901AD09FB
	for <drbd-dev@lists.linbit.com>; Wed, 27 Jan 2016 07:36:41 +0100 (CET)
To: drbd-dev@lists.linbit.com
From: Thomas Lamprecht <t.lamprecht@proxmox.com>
Message-ID: <56A86573.2000702@proxmox.com>
Date: Wed, 27 Jan 2016 07:36:35 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Drbd-dev] DRBD for linux 4.4
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

Hi all,

I'm currently experimenting with the 4.4 Kernel (used minor patched 
ubuntu/unstable) for PVE
and saw that I couldn't build drbd-9 as there were minor API changes in 
the Kernel and thus
it's not compatible at the moment.
But to be honest as a matter of time I didn't looked into what all 
changed and what is to change in drbd.

Are there any plans at the moment to fix that?


cheers,
Thomas

