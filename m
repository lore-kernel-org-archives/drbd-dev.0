Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [86.59.100.100])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id E47BB10690D0
	for <drbd-dev@lists.linbit.com>; Wed, 11 Mar 2009 19:25:10 +0100 (CET)
Resent-Message-ID: <20090311182510.GF8646@soda.linbit>
Received: from lists.balabit.hu (support.balabit.hu [195.70.41.86])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 9C9271068F94
	for <drbd-dev@lists.linbit.com>; Wed, 11 Mar 2009 18:59:48 +0100 (CET)
Received: from balabit.hu (unknown [10.80.0.254])
	by lists.balabit.hu (Postfix) with ESMTP id E342939D3DC
	for <drbd-dev@lists.linbit.com>; Wed, 11 Mar 2009 18:30:22 +0100 (CET)
From: "ILLES, Marton" <illes.marton@balabit.hu>
To: drbd-dev@lists.linbit.com
Content-Type: text/plain
Date: Wed, 11 Mar 2009 18:30:21 +0100
Message-Id: <1236792621.7981.25.camel@octane>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Drbd-dev] invalidate broken in 8.3.0 regression from 8.2.6
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hi,

First of all thanks for drbd, it is such a nice piece of code, we love
to use it.

In my current setup I use drbd 8.3.0 with linux 2.6.27 and some ubuntu
patches (but it does not really matter), while I discovered that
"drbdsetup /dev/drbd0 invalidate" does not do anything. No error code,
nothing. In 8.2.6 it worked well, so some regression is here.

After some debugging and git digging I realized that invalidate logic
was changed in this patch:

commit 1ad8484c83eb1ae28a8471d998c7b060ed045493
Author: Philipp Reisner <philipp.reisner@linbit.com>
Date:   Fri May 9 10:33:35 2008 +0200

    Mande the invalidate and invalidate-remote to fit with the
"before-resync-target" handler
    
    Changed the code so that with the invalidate and invalidate-remote
    commands the disk state is only set to invalidate _after_ the
    before-resync-target handler returned success.


However it is way before 8.2.6, so it should not cause problem. After
some more careful code watching, I realized that after 8.2.6 release
during a tree merge the fix it is partially reverted, cause currently we
have:

 861     /* Early state sanitising. */
 862 
 863     /* Dissalow the invalidate command to connect  */
 864     if ((ns.conn == StartingSyncS || ns.conn == StartingSyncT) &&
 865         os.conn < Connected) {
 866         ns.conn = os.conn;
 867         ns.pdsk = os.pdsk;
 868     }

While the 1ad8484c83eb1ae28a8471d998c7b060ed045493 patch was:
--- a/drbd/drbd_main.c
+++ b/drbd/drbd_main.c
@@ -707,6 +707,10 @@ int is_valid_state_transition(struct drbd_conf *mdev,
            ns.conn != os.conn && os.conn > Connected)
                rv = SS_ResyncRunning;
 
+       if ((ns.conn == StartingSyncS || ns.conn == StartingSyncT) &&
+           os.conn < Connected)
+               rv = SS_NeedConnection;
+
        return rv;
 }
 
@@ -730,12 +734,7 @@ int _drbd_set_state(struct drbd_conf *mdev,
                dec_local(mdev);
        }
 
-       /* Early state sanitising. Dissalow the invalidate ioctl to connect  */
-       if ( (ns.conn == StartingSyncS || ns.conn == StartingSyncT) &&
-               os.conn < Connected ) {
-               ns.conn = os.conn;
-               ns.pdsk = os.pdsk;
-       }
+       /* Early state sanitising. */
 
        /* Dissalow Network errors to configure a device's network part */
        if ( (ns.conn >= Timeout && ns.conn <= TearDown ) &&

So IMHO some lines come back accidentally, which is bad. Checking the
patch it looks like that is the only affected part that "returned".
After removing the lines, invalidate works like a charm.

So here is the "magic" patch to fix it:

diff --git a/drbd/drbd_main.c b/drbd/drbd_main.c
index 1a66e52..d73e247 100644
--- a/drbd/drbd_main.c
+++ b/drbd/drbd_main.c
@@ -860,13 +860,6 @@ int _drbd_set_state(struct drbd_conf *mdev,
 
        /* Early state sanitising. */
 
-       /* Dissalow the invalidate command to connect  */
-       if ((ns.conn == StartingSyncS || ns.conn == StartingSyncT) &&
-               os.conn < Connected) {
-               ns.conn = os.conn;
-               ns.pdsk = os.pdsk;
-       }
-
        /* Dissalow Network errors to configure a device's network part */
        if ((ns.conn >= Timeout && ns.conn <= TearDown) &&
            os.conn <= Disconnecting)

Please correct me if I am wrong, or please apply the patch. :)

Maybe it would make sense to check how it could happen and check other
parts of the code as well...

thanks

Marton

PS: I am off list, so please CC-me.
-- 
Key fingerprint = F78C 25CA 5F88 6FAF EA21 779D 3279 9F9E 1155 670D

