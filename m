Return-Path: <zamf@dcs.gla.ac.uk>
Received: from mr1.dcs.gla.ac.uk (mr1.dcs.gla.ac.uk [130.209.249.184])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id DCD712D9D6F9
	for <drbd-dev@lists.linbit.com>; Wed,  6 Dec 2006 18:22:40 +0100 (CET)
Received: from paraoa.dcs.gla.ac.uk ([130.209.253.109]:42445)
	by mr1.dcs.gla.ac.uk with esmtpa (Exim 4.42) id 1Gs0Tf-0002mW-V4
	for drbd-dev@lists.linbit.com; Wed, 06 Dec 2006 17:22:40 +0000
Message-ID: <4576FC63.704@dcs.gla.ac.uk>
Date: Wed, 06 Dec 2006 17:22:43 +0000
From: Cristian Zamfir <zamf@dcs.gla.ac.uk>
MIME-Version: 1.0
To: drbd-dev@lists.linbit.com
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Drbd-dev] lock for reading device state
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>



Hi,

I am using drbd to implement xen block device migration.  Right now I am 
parsing /proc/drbd to find out if the drives are synchronized and I can 
migrate them. Is there a way to obtain a lock while reading and 
processing this information and prevent other writes to the primary 
device? I need to be able to prevent writes while reading the state of 
the device from a script external to drbd.

In case there is no existing solution, can you please give me a few tips 
on how to start developing such a locking mechanism?

Thank you very much.


Cristian
