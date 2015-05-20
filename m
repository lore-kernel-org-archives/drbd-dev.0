Return-Path: <dietmar@proxmox.com>
Received: from proxmox.maurer-it.com (proxmox.maurer-it.com [94.136.31.133])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 3C7ED1050584
	for <drbd-dev@lists.linbit.com>; Wed, 20 May 2015 11:26:30 +0200 (CEST)
Received: from proxmox.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox.maurer-it.com (Proxmox) with ESMTP id E8CA4AD095A
	for <drbd-dev@lists.linbit.com>; Wed, 20 May 2015 11:26:29 +0200 (CEST)
Date: Wed, 20 May 2015 11:26:27 +0200 (CEST)
From: Dietmar Maurer <dietmar@proxmox.com>
To: drbd-dev <drbd-dev@lists.linbit.com>
Message-ID: <1182776473.27.1432113988008.JavaMail.open-xchange@ronja.mits.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Drbd-dev] cluster initialization with drbdmanage
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

Hi all,

The drbdmanage installation HowTo (README) contains the following instaructions:

>Cluster initialization (first drbdmanage cluster node only):
>    *  On the first node, issue the following command to initialize a new
>       drbdmanage cluster:
>         drbdmanage init <ipaddress>

This works. Now I want to add the second node:

>Adding nodes to a drbdmanage cluster:
>    *  On a node of the existing drbdmanage cluster, issue the following
>       command to prepare the cluster for integrating a new node:
>         drbdmanage new-node <nodename> <ipaddress>
>       ... where <nodename> is the node name of the node, and <ipaddress>
>           is the IP address of the node that will join the cluster
>       This command will also generate the command line that needs to be
>       entered on the new node to make it join the cluster

Now I run:

# drbdmanage new-node hatest2 192.168.3.202
Operation completed successfully
Operation completed successfully

Executing join command on hatest2 using ssh.
You are going to join an existing drbdmanage cluster.
CAUTION! Note that:
  * Any previous drbdmanage cluster information may be removed
  * Any remaining resources managed by a previous drbdmanage installation
    that still exist on this system will no longer be managed by drbdmanage

Confirm:

  yes/no: yes
  Logical volume ".drbdctrl" successfully removed
  Logical volume ".drbdctrl" created.
You want me to create a v09 style flexible-size internal meta data block.
There appears to be a v09 flexible-size internal meta data block
already in place on /dev/drbdpool/.drbdctrl at byte offset 4190208

Do you really want to overwrite the existing meta-data?
*** confirmation forced via --force option ***

Do you want to proceed?
*** confirmation forced via --force option ***
NOT initializing bitmap
md_offset 4190208
al_offset 4157440
bm_offset 4153344

Found some data

 ==> This might destroy existing data! <==
initializing activity log
Writing meta data...
New drbd meta data block successfully created.
Operation completed successfully
--------------------

I have two questions now:

1.) Where is the command line to join the node (mentioned in the README above)?

2.) Does this really destroy all existing resources? If so, how can I add 
nodes to a cluster which already have existing resources?

Or is there another way to initialize the cluster?

