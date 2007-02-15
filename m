Return-Path: <brederlo@informatik.uni-tuebingen.de>
Received: from mx1.informatik.uni-tuebingen.de
	(mx1.Informatik.Uni-Tuebingen.De [134.2.12.5])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id B08012E05E88
	for <drbd-dev@lists.linbit.com>; Thu, 15 Feb 2007 11:13:04 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mx1.informatik.uni-tuebingen.de (Postfix) with ESMTP id 25D563499
	for <drbd-dev@lists.linbit.com>; Thu, 15 Feb 2007 11:13:04 +0100 (MET)
Received: from mx1.informatik.uni-tuebingen.de ([127.0.0.1])
	by localhost (mx1.informatik.uni-tuebingen.de [127.0.0.1]) (amavisd-new,
	port 10024)
	with ESMTP id oJG3yd4otgg5 for <drbd-dev@lists.linbit.com>;
	Thu, 15 Feb 2007 11:13:04 +0100 (MET)
Received: from localhost.localdomain (ssh1 [134.2.13.191])
	by mx1.informatik.uni-tuebingen.de (Postfix) with ESMTP id B98F63470
	for <drbd-dev@lists.linbit.com>; Thu, 15 Feb 2007 11:13:02 +0100 (MET)
Received: from mrvn by localhost.localdomain with local (Exim 4.63)
	(envelope-from <brederlo@informatik.uni-tuebingen.de>)
	id 1HHdbR-0007WM-0w
	for drbd-dev@lists.linbit.com; Thu, 15 Feb 2007 11:12:37 +0100
From: Goswin von Brederlow <brederlo@informatik.uni-tuebingen.de>
To: drbd-dev@lists.linbit.com
Date: Thu, 15 Feb 2007 11:12:36 +0100
Message-ID: <874ppnhgq3.fsf@informatik.uni-tuebingen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Drbd-dev] drbd 8.0.0 over IP over infiniband crashes
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hi,

I have problems running drbd over IP over infiniband where I don't
quite know what is to blame for the problem. I am wondering
if anyone has a similar setup that works.

Hardware too nearly identical systems:

4 Intel(R) Xeon(TM) CPU 3.73GHz cores
4 GB ram
Infiniband cross link
2x SATA disks in software raid1 for the system
6x 300G SAS/SATA disks for 6x drbd

Software:

2.6.19.2 xen kernel
drbd 8.0.0

Configuration:

IP-over-infiniband setup as 10.0.0.{1,2}
6 drbd devices, one for each of the 6 disks in each host
active-active setup


The drbd comes up and starts to sync the 6 devices and then after a
short while I get a kernel oops.

Does anyone have anything similar running, e.g. drbd under xen or drbd
over ip over infiniband?

MfG
        Goswin
