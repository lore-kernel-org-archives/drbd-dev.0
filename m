Return-Path: <lumiere2002@free.fr>
Received: from postfix3-2.free.fr (postfix3-2.free.fr [213.228.0.169])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 8B1CD14DF3
	for <drbd-dev@lists.linbit.com>; Wed, 27 Jul 2005 21:12:27 +0200 (CEST)
Received: from [192.168.1.50] (ras75-1-81-57-234-114.fbx.proxad.net
	[81.57.234.114])
	by postfix3-2.free.fr (Postfix) with ESMTP id B48B8C121
	for <drbd-dev@lists.linbit.com>; Wed, 27 Jul 2005 21:12:26 +0200 (CEST)
Message-ID: <42E7DC38.2020009@free.fr>
Date: Wed, 27 Jul 2005 21:10:48 +0200
From: lumiere2002 <lumiere2002@free.fr>
MIME-Version: 1.0
To: drbd-dev@lists.linbit.com
Subject: [drbd-dev] Trunk version incompatible with SATA
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hello,


I have tested the Trunk version of the CVS on 2 machines (one AMD and 
one Intel) with differents disks (sata and ide)

drbd refuse to create meta data on SATA device

error is

[root@amd ~]# /sbin/drbdmeta /dev/drbd0 v08 /dev/sda4 -1 create-md
ioctl(,BLKFLSBUF,) failed: Operation not supported

The same command on an IDE disk works.

My 2 configurations are:

[root@amd ~]# uname -a
Linux amd 2.6.9-1.667 #1 Tue Nov 2 14:41:25 EST 2004 i686 athlon i386 
GNU/Linux

This is Fedora Core 3

[root@intel ~]# uname -a
Linux intel 2.6.9-1.667 #1 Tue Nov 2 14:41:25 EST 2004 i686 i686 i386 
GNU/Linux

This is fedora core 3


drbd version is :
drbd: initialised. Version: 0.8-pre1 (api:80/proto:80)
drbd: SVN Revision: 1904M build by antoine@intel, 2005-07-27 19:31:43
drbd: registered as block device major 147

Thanks
              Patrick





