Return-Path: <philipp@hug.cx>
Received: from dandelion.nextdomain.net (62-2-150-10.business.cablecom.ch
	[62.2.150.10])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 146BE142FF
	for <drbd-dev@lists.linbit.com>; Thu, 10 Feb 2005 20:50:58 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dandelion.nextdomain.net (Postfix) with ESMTP id 425316F6A
	for <drbd-dev@lists.linbit.com>; Thu, 10 Feb 2005 20:50:57 +0100 (CET)
Received: from dandelion.nextdomain.net ([127.0.0.1])
	by localhost (devnull [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 09150-05 for <drbd-dev@lists.linbit.com>;
	Thu, 10 Feb 2005 20:50:53 +0100 (CET)
Received: from [172.18.8.254] (unknown [172.18.8.254])
	by dandelion.nextdomain.net (Postfix) with ESMTP id 36CF7143
	for <drbd-dev@lists.linbit.com>; Thu, 10 Feb 2005 20:50:53 +0100 (CET)
Message-ID: <420BBB44.4030007@hug.cx>
Date: Thu, 10 Feb 2005 20:51:32 +0100
From: Philipp Hug <philipp@hug.cx>
MIME-Version: 1.0
To: "drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Drbd-dev] Documentation for DRBD under Debian
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

I think it would make sense to update the wiki for installation on debian:

default installation (compilation and installation is just one step):
m-a a-i drbd0.7-module-source

this builds drbd against the current running kernel (if it doesn't find 
an already built module on debian.org) and installs it automatically. ;-)

in case you want to build against a custom kernel have a look at the m-a 
man page. (e.g. --kernel-dir might be of interest or --kvers-list if you 
want to build against another "official" debian kernel)

philipp
