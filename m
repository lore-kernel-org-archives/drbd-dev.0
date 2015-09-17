Return-Path: <cru.lists@zodia.de>
Received: from nucleo.bm.de.wahlich.com (nucleo.bm.de.wahlich.com
	[195.149.81.115])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 4F35B10518AC
	for <drbd-dev@lists.linbit.com>; Thu, 17 Sep 2015 12:58:08 +0200 (CEST)
Received: from vaduz.fondsnet.de ([192.168.1.40]:42750)
	by nucleo.bm.de.wahlich.com with esmtpsa (TLSv1:AES256-SHA:256)
	id 1ZcWkt-00037t-Ai
	for drbd-dev@lists.linbit.com; Thu, 17 Sep 2015 12:49:31 +0200
Message-ID: <1442486932.25039.41.camel@vaduz.fondsnet.de>
From: Veit Wahlich <cru.lists@zodia.de>
To: drbd-dev@lists.linbit.com
Date: Thu, 17 Sep 2015 12:48:52 +0200
Content-Type: multipart/mixed; boundary="=-ig74T8bOTrD2ig/5vy2O"
Mime-Version: 1.0
Subject: [Drbd-dev] Bug in DRBD 8.4 potentially leading to data loss
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


--=-ig74T8bOTrD2ig/5vy2O
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hi devs,

I discovered a bug in drbd 8.4.6 and earlier versions that I regard as
being harmful as it might lead to data loss in certain situations.

The command line parameter the kernel module uses to communicate the
device minor to userland helper is flawed in a way that the device
indentifier "minor-%d" is being truncated to minors with a maximum of 5
digits.
But as according to your documentation[1], DRBD 8.4 allows 2^20 ==
1048576 minors, thus a minimum of 7 digits must be supported.

Here an example of what happens:

[ 1713.695861] block drbd100000: conn( Connected -> WFBitMapS ) 
[ 1713.695900] block drbd100000: send bitmap stats [Bytes(packets)]: plain 0(0), RLE 21(1), total 21; compression: 99.7%
[ 1713.697376] block drbd100000: receive bitmap stats [Bytes(packets)]: plain 0(0), RLE 21(1), total 21; compression: 99.7%
[ 1713.697397] block drbd100000: helper command: /sbin/drbdadm before-resync-source minor-10000
[ 1713.703018] block drbd100000: helper command: /sbin/drbdadm before-resync-source minor-10000 exit code 1 (0x100)
[ 1713.703029] block drbd100000: before-resync-source handler returned 1, dropping connection.
[ 1713.703039] block drbd100000: conn( WFBitMapS -> Disconnecting ) 

Trying to sync minor 100000 causes drbdadm being called for minor 10000
instead. In this case, minor 10000 is not configured, causing drbdadm to
exit with code 1, resulting in DRBD to only drop the connection to the
peer for minor 100000.

But I suspect (as I did not test so far) that in cases where minor 10000
DOES exist while minor 100000 should be handled, the userland helper
would actually execute operations on the wrong minor, resulting in
undefined states on that minor, and, depending on the operation, stop of
replication, split-brain scenarios or maybe even loss of data.

The problematic code resides in drbd/drbd_nl.c in int drbd_khelper().

I created a patch against 8.4.6[2] that allows userland helpers to be
called with any minor up to the allowed maximum of 2^20 or 7 digits.
Find it attached as "drbd84-8.4.6-khelper-minor.patch".

I hope this helps and thank you for a great software product!

Best regards,
// Veit Wahlich

[1]: https://drbd.linbit.com/users-guide/s-recent-changes-defaults.html
[2]: http://oss.linbit.com/drbd/8.4/drbd-8.4.6.tar.gz

--=-ig74T8bOTrD2ig/5vy2O
Content-Disposition: attachment; filename="drbd84-8.4.6-khelper-minor.patch"
Content-Type: text/x-patch; name="drbd84-8.4.6-khelper-minor.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

diff -N -r '--unified=5' drbd-8.4.6.orig/drbd/drbd_nl.c drbd-8.4.6/drbd/drbd_nl.c
--- drbd-8.4.6.orig/drbd/drbd_nl.c	2015-04-03 17:33:22.000000000 +0200
+++ drbd-8.4.6/drbd/drbd_nl.c	2015-09-17 10:48:58.234824005 +0200
@@ -377,20 +377,20 @@
 			"TERM=linux",
 			"PATH=/sbin:/usr/sbin:/bin:/usr/bin",
 			 (char[20]) { }, /* address family */
 			 (char[60]) { }, /* address */
 			NULL };
-	char mb[12];
+	char mb[14];
 	char *argv[] = {usermode_helper, cmd, mb, NULL };
 	struct drbd_connection *connection = first_peer_device(device)->connection;
 	struct sib_info sib;
 	int ret;
 
 	if (current == connection->worker.task)
 		set_bit(CALLBACK_PENDING, &connection->flags);
 
-	snprintf(mb, 12, "minor-%d", device_to_minor(device));
+	snprintf(mb, 14, "minor-%d", device_to_minor(device));
 	setup_khelper_env(connection, envp);
 
 	/* The helper may take some time.
 	 * write out any unsynced meta data changes now */
 	drbd_md_sync(device);

--=-ig74T8bOTrD2ig/5vy2O--

