Return-Path: <mmazur@kernel.pl>
Received: from srv.axeos.nl (srv.axeos.nl [83.98.196.54])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 3243B101AC76
	for <drbd-dev@lists.linbit.com>; Wed,  2 Jul 2014 16:00:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by localhost.srv.axeos.nl (Postfix) with ESMTP id 9852314100
	for <drbd-dev@lists.linbit.com>; Wed,  2 Jul 2014 15:52:35 +0200 (CEST)
Received: from srv.axeos.nl ([127.0.0.1])
	by localhost (srv.axeos.nl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hyW2KyjPJLI9 for <drbd-dev@lists.linbit.com>;
	Wed,  2 Jul 2014 15:52:32 +0200 (CEST)
Received: from mmaszyna.localnet (vpn.axeos.nl [83.98.196.63])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by srv.axeos.nl (Postfix) with ESMTPSA
	for <drbd-dev@lists.linbit.com>; Wed,  2 Jul 2014 15:52:32 +0200 (CEST)
From: Mariusz Mazur <mmazur@kernel.pl>
To: drbd-dev@lists.linbit.com
Date: Wed, 2 Jul 2014 15:49:51 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201407021549.52105.mmazur@kernel.pl>
Subject: [Drbd-dev] ocf resource invoking non-existent 'syncer' command
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

drbdadm's 'syncer' command was removed in 8.4. Yet 
thecreate_device_udev_settle() function in scripts/drbd.ocf still (as of 
current git master branch) invokes it as have all the 8.4.x releases.

(I'm surprised nobody encountered this before, 8.4.0 is three years old.)

--mmazur

