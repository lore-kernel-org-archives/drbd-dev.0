Return-Path: <dietmar@proxmox.com>
Received: from proxmox.maurer-it.com (proxmox.maurer-it.com [94.136.31.133])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 008D11028A59
	for <drbd-dev@lists.linbit.com>; Mon, 11 May 2015 08:54:22 +0200 (CEST)
Received: from proxmox.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox.maurer-it.com (Proxmox) with ESMTP id 4D8EEAD09E2
	for <drbd-dev@lists.linbit.com>; Mon, 11 May 2015 08:44:25 +0200 (CEST)
Date: Mon, 11 May 2015 08:44:20 +0200 (CEST)
From: Dietmar Maurer <dietmar@proxmox.com>
To: drbd-dev <drbd-dev@lists.linbit.com>
Message-ID: <1676265523.49.1431326660324.JavaMail.open-xchange@ronja.mits.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Drbd-dev] drbdmanage package name
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

I just saw that you name the package 'python-drbdmanage'.

> Package: python-drbdmanage

Why don't you simply call it 'drbdmanage'?

IMHO, adding 'python' would be OK for a python library, but not 
for a binary package?

