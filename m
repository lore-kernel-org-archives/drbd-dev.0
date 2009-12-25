Return-Path: <lars.ellenberg@linbit.com>
Received: from racke.rauchzart (p548C8E20.dip0.t-ipconnect.de [84.140.142.32])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPSA id 139C110620D6
	for <drbd-dev@lists.linbit.com>; Mon, 28 Dec 2009 13:53:01 +0100 (CET)
Resent-Message-ID: <20091228125300.GB11365@racke>
Message-ID: <26922845.post@talk.nabble.com>
Date: Fri, 25 Dec 2009 10:45:24 -0800 (PST)
From: logyati <logyati@gmail.com>
To: drbd-user@lists.linbit.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: [Drbd-dev] [DRBD-user] writing data to the physical device instead
 of /dev/drbd0
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>


Hi all :) im new to drbd
I have two nodes with the resouce opt and metadisk internal. I shrinked the
filesystem to use this kind of metadisk using resize2fs.
The primary node, opt is /dev/sda8
The secondary node, opt is /dev/sda6
what happens if i stop drbd on secondary, then on primary, and then i
dismount /dev/drbd0 on primary and then mount the real device (/dev/sda8)
and write data to it and then start drbd in both servers and mount the
/dev/drbd0 on primary? is there a chance to lose data?
I know i can restart everything from zero moving the data from primary
(/dev/sda8) to another machine and then start drbd, mount /dev/drbd0 /opt on
primary and move the files back again and let it sync, but it takes so long!
its 600 gb of data =/

ps: i dont have another disk to backup this 600GB... all i can do is to copy
over network to another machine!

please help!
-- 
View this message in context: http://old.nabble.com/writing-data-to-the-physical-device-instead-of--dev-drbd0-tp26922845p26922845.html
Sent from the DRBD - User mailing list archive at Nabble.com.

