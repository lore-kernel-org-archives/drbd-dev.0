Return-Path: <dietmar@proxmox.com>
Received: from proxmox.maurer-it.com (proxmox.maurer-it.com [94.136.31.133])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id B5E1410003FC
	for <drbd-dev@lists.linbit.com>; Wed, 20 May 2015 12:41:10 +0200 (CEST)
Received: from proxmox.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox.maurer-it.com (Proxmox) with ESMTP id 17467AD0952
	for <drbd-dev@lists.linbit.com>; Wed, 20 May 2015 12:41:10 +0200 (CEST)
Date: Wed, 20 May 2015 12:41:08 +0200 (CEST)
From: Dietmar Maurer <dietmar@proxmox.com>
To: drbd-dev <drbd-dev@lists.linbit.com>
Message-ID: <1335158101.57.1432118468143.JavaMail.open-xchange@ronja.mits.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Drbd-dev] howto enable auto-promote
Reply-To: Dietmar Maurer <dietmar@proxmox.com>
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

I am trying to live migrate a kvm based VM which uses a 
drbd9 image created with drbdmanage. But I get the 
following error:

[ 7268.069023] drbd vm-100-disk-1: Auto-promote failed: Multiple primaries not
allowed by config

So how can I enable the auto-promote feature?

