Return-Path: <dab21774@gmail.com>
Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com
	[209.85.210.66])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 32E9E101AC43
	for <drbd-dev@lists.linbit.com>; Sun, 11 Aug 2019 19:27:23 +0200 (CEST)
Received: by mail-ot1-f66.google.com with SMTP id f17so15700697otq.4
	for <drbd-dev@lists.linbit.com>; Sun, 11 Aug 2019 10:27:23 -0700 (PDT)
To: drbd-dev@lists.linbit.com, christoph.boehmwalder@linbit.com
From: David Butterfield <dab21774@gmail.com>
Message-ID: <1bc428a7-2cab-fba7-f521-d96ba1f6c7df@gmail.com>
Date: Sun, 11 Aug 2019 11:20:04 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: [Drbd-dev] using new cocci config on older kernels
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

In drbd-9.0/drbd, using the August 2 checkin "Prepare 10.0.0a1":
I tried building with a few different kernel versions, using commands of the form (e.g.):
    wget https://cdn.kernel.org/pub/linux/kernel/v3.x/linux-3.4.113.tar.gz
    ...
    make clean; make -i KDIR=linux-3.4.113

First question is whether I should be expecting that to work all the way back to the
expected DRBD limit of 2.6.32, or if the limit has (intentionally) been changed?

Builds with these KDIRs show no errors:
		   linux-4.20.17
		   linux-3.19.8

Back as far as linux-2.6.39.4, the first six errors below accumulate.  That jumps to
33 errors when reaching all the way to the 2.6.32 DRBD limit (though most of them are
concentrated in a few groups of functions).

The first two errors listed (check/update plugged) go away by adding braces to the
source code so that it matches one of the cocci patterns (detail at end of message).

The third one is that drbd_interval.c appears to unconditionally #include
linux/rbtree_augmented.h (and use rb_insert_augmented/rb_erase_augmented), whether or
not the selected KDIR has that file and those functions.  2.6.32 does not have them.

drbd_req.c:1809:31: error: implicit declaration of function ‘drbd_check_plugged’ (FIX BELOW)
drbd_req.c:1811:4: error: implicit declaration of function ‘drbd_update_plug’	 (FIX BELOW)
drbd_interval.c:2:10: fatal error: linux/rbtree_augmented.h: No such file or directory
drbd_receiver.c:1319:15: error: implicit declaration of function ‘bdev_discard_alignment’

		    linux-3.4.113	4 errors shown above appear in this build

drbd_debugfs.c:439:22: error: implicit declaration of function ‘kref_get_unless_zero’

		    linux-3.3.8		5 errors shown above appear in this build

drbd_nl.c:2027:3: error: implicit declaration of function ‘blk_set_stacking_limits’

		    1inux-3.0.1		6 errors shown above appear in this build
		    linux-2.6.39.4	6 errors shown above appear in this build

drbd_nl.c:1921:11: error: ‘struct queue_limits’ has no member named ‘discard_granularity’
drbd_receiver.c:1318:29: error: ‘struct queue_limits’ has no member named ‘discard_granularity’

drbd_bitmap.c:500:3: error: ‘kunmap_atomic’ undeclared (first use in this function)
drbd_main.c:1983:2: error: ‘kunmap_atomic’ undeclared (first use in this function)
drbd_sender.c:1345:5: error: ‘kunmap_atomic’ undeclared (first use in this function)
drbd_bitmap.c:500:21: error: macro "kunmap_atomic" requires 2 arguments, but only 1 given
drbd_main.c:1983:25: error: macro "kunmap_atomic" requires 2 arguments, but only 1 given
drbd_sender.c:1345:20: error: macro "kunmap_atomic" requires 2 arguments, but only 1 given
drbd_receiver.c:844:13: error: ‘struct task_struct’ has no member named ‘plug’
drbd_bitmap.c:492:10: error: too few arguments to function ‘kmap_atomic’
drbd_main.c:1981:14: error: too few arguments to function ‘kmap_atomic’
drbd_sender.c:1342:7: error: too few arguments to function ‘kmap_atomic’

drbd_debugfs.c:672:6: error: implicit declaration of function ‘IS_ERR_OR_NULL’
drbd_req.c:1912:6: error: implicit declaration of function ‘IS_ERR_OR_NULL’

drbd_main.c:123:7: error: implicit declaration of function ‘kstrtoull’

drbd_debugfs.c:1057:4: error: implicit declaration of function ‘ktime_to_ms’

drbd_main.c:1424:3: error: implicit declaration of function ‘lockdep_is_held’
drbd_nl.c:3444:9: error: implicit declaration of function ‘lockdep_is_held’
drbd_receiver.c:4335:5: error: implicit declaration of function ‘lockdep_is_held’

drbd_main.c:1423:8: error: implicit declaration of function ‘rcu_dereference_protected’
drbd_nl.c:3443:13: error: implicit declaration of function ‘rcu_dereference_protected’
drbd_receiver.c:4334:14: error: implicit declaration of function ‘rcu_dereference_protected’

drbd_bitmap.c:533:11: error: implicit declaration of function ‘__test_and_clear_bit_le’
drbd_bitmap.c:537:12: error: implicit declaration of function ‘__test_and_set_bit_le’
drbd_bitmap.c:541:11: error: implicit declaration of function ‘test_bit_le’
drbd_bitmap.c:559:13: error: implicit declaration of function ‘find_next_bit_le’
drbd_bitmap.c:565:13: error: implicit declaration of function ‘find_next_zero_bit_le’

		  linux-2.6.32.27       33 errors shown above appear in this build

=========================================
Add braces in drbd_req.c to match the cocci rule in blk_check_plugged__no_present.cocci, right?
Otherwise the references to drbd_check_plugged and drbd_update_plug don't get removed by the patch.

diff --git a/drbd/drbd_req.c b/drbd/drbd_req.c
@@ -1860,8 +1860,9 @@ static void drbd_send_and_submit(struct drbd_device *device, struct drbd_request
 
        if (no_remote == false) {
                struct drbd_plug_cb *plug = drbd_check_plugged(resource);
-               if (plug)
+               if (plug) {
                        drbd_update_plug(plug, req);
+               }
        }
 
        /* If it took the fast path in drbd_request_prepare, add it here.

=========================================
cocci/blk_check_plugged__no_present.cocci
@@
identifier pl;
@@
-if(...) {
-	struct drbd_plug_cb *pl = ...;
-	if(pl) {
-		...
-	}
-}
=========================================
