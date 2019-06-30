Return-Path: <dab21774@gmail.com>
Received: from mail-io1-f66.google.com (mail-io1-f66.google.com
	[209.85.166.66])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id B99681028A76
	for <drbd-dev@lists.linbit.com>; Mon,  1 Jul 2019 00:46:54 +0200 (CEST)
Received: by mail-io1-f66.google.com with SMTP id e5so24463987iok.4
	for <drbd-dev@lists.linbit.com>; Sun, 30 Jun 2019 15:46:54 -0700 (PDT)
Received: from [192.168.1.20] (c-73-78-150-191.hsd1.co.comcast.net.
	[73.78.150.191]) by smtp.gmail.com with ESMTPSA id
	z17sm13910808iol.73.2019.06.30.15.46.52
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 30 Jun 2019 15:46:52 -0700 (PDT)
To: drbd-dev@lists.linbit.com
From: David Butterfield <dab21774@gmail.com>
Message-ID: <44599673-cf74-7e79-3672-af9feea537d2@gmail.com>
Date: Sun, 30 Jun 2019 16:46:51 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Drbd-dev] How to leak a peer_devices idr instance
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

I've been valgrinding the SCST/DRBD usermode server to look for bugs in my kernel function
emulation.  Once in a while it points me at a problem in DRBD.  I mentioned in a message last
week about the "resync_fifo" leak (which appears consistently in the valgrind output).

Ideally I could get a clean valgrind run, with all allocations having been freed before exit.
After deleting objects using drbdsetup and then running the server's exit handlers, it is very
close, with a couple of "usual suspects", plus whatever I discover from time to time as I try 
different operations.

Today's discovery is the ability to leak a peer_devices idr instance by a sequence of six
drbdsetup create and delete steps.  Whether or not it leaks depends on the order of the delete
steps.  After a fresh restart of the server the first sequence below leaks, but not the second.

If I delete the peer before the minor it leaks the peer_devices idr.
    sudo drbdsetup new-resource r0 0
    sudo drbdsetup new-minor r0 1 0 
    sudo drbdsetup new-peer r0 1 --_name=vagrant
    sudo drbdsetup del-peer r0 1                # delete peer first leaks peer_devices idr 
    sudo drbdsetup del-minor 1
    sudo drbdsetup del-resource r0

If I delete the minor before the peer it doesn't leak.
    sudo drbdsetup new-resource r0 0
    sudo drbdsetup new-minor r0 1 0 
    sudo drbdsetup new-peer r0 1 --_name=vagrant
    sudo drbdsetup del-minor 1                  # delete minor first doesn't leak
    sudo drbdsetup del-peer r0 1
    sudo drbdsetup del-resource r0

What appears to be happening:

    During del-minor, the peer_devices idr gets removed in drbd_unregister_device(), for each
    connection it finds.  That appears to be the only place that idr gets removed after use.

    But in the leaking sequence, the connection has already been removed by the del-peer command
    before the later del-minor command runs.  So the connection loop in drbd_unregister_device()
    (line 3935 below) iterates zero times and does not free any peer_devices idr.

    3928 void drbd_unregister_device(struct drbd_device *device)
    ... 
    3934         spin_lock_irq(&resource->req_lock);
    3935         for_each_connection(connection, resource) {
    3936                 idr_remove(&connection->peer_devices, device->vnr);
    3937         }
    3938         idr_remove(&resource->devices, device->vnr);
    3939         idr_remove(&drbd_devices, device_to_minor(device));
    3940         spin_unlock_irq(&resource->req_lock);

Regards,
David Butterfield
