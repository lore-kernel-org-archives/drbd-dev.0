Return-Path: <zamf@dcs.gla.ac.uk>
Received: from mr1.dcs.gla.ac.uk (mr1.dcs.gla.ac.uk [130.209.249.184])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 07F262D9D710
	for <drbd-dev@lists.linbit.com>; Wed, 13 Dec 2006 20:40:46 +0100 (CET)
Received: from paraoa.dcs.gla.ac.uk ([130.209.253.109]:37830)
	by mr1.dcs.gla.ac.uk with esmtpa (Exim 4.42) id 1GuZy6-0001n3-UZ
	for drbd-dev@lists.linbit.com; Wed, 13 Dec 2006 19:40:42 +0000
Message-ID: <45805753.1060005@dcs.gla.ac.uk>
Date: Wed, 13 Dec 2006 19:41:07 +0000
From: Cristian Zamfir <zamf@dcs.gla.ac.uk>
MIME-Version: 1.0
To: drbd-dev@lists.linbit.com
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Drbd-dev] resync end in drbd8
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>


Hi,

I am using the svn version of drbd8 and the -m option to allow both 
peers to be primary. The states are Connected and UpToDate/UpTodate.
I am going bursts of writes to one of the disks and I am interested in 
finding out when there are no outstanding writes that need to be 
mirrored to the other disk, basically when the resync ends.
What can I use to achieve this? Is there a flag that I can read from 
userspace when the drives are in sync? Or maybe it is already somewhere 
in /proc/drbd and I don't see it.

Thank you.

Cristian




