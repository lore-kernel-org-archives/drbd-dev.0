Return-Path: <helmut@wollmersdorfer.at>
Received: from viefep12-int.chello.at (viefep12-int.chello.at [213.46.255.25])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id A152C15162
	for <drbd-dev@lists.linbit.com>; Wed,  9 Mar 2005 12:48:11 +0100 (CET)
Received: from [192.168.0.21] (really [212.186.65.148])
	by viefep12-int.chello.at
	(InterMail vM.6.01.03.05 201-2131-111-107-20040910) with ESMTP
	id <20050309114811.NWJV20617.viefep12-int.chello.at@[192.168.0.21]>
	for <drbd-dev@lists.linbit.com>; Wed, 9 Mar 2005 12:48:11 +0100
Message-ID: <422EE27B.5040209@wollmersdorfer.at>
Date: Wed, 09 Mar 2005 12:48:11 +0100
From: Helmut Wollmersdorfer <helmut@wollmersdorfer.at>
MIME-Version: 1.0
To: drbd-dev@lists.linbit.com
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Drbd-dev] Wishlist: warning message in case of different disk size
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Something like

   drbdx: WARNING disk sizes more than 10% different

would be nice at (initial) full sync.

The funny story about blaming myself:
I deleted a 2 GB partition on node1 and created a new one 10 GB with the 
same name. But it seems, that I have forgotten to do the same on node2, 
_before_ mkfs and resync. A week later I wondered about df reporting 
only 2 GB and had one funny hour of research;-)

Helmut Wollmersdorfer
