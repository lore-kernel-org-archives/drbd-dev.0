Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] DRBD8: drbd nodes deadlock in WFBitMapT
Date: Mon, 2 Apr 2007 21:59:32 +0200
References: <BD7042533C2F8943A6A4257A9E31C45439C944@EXNA.corp.stratus.com>
In-Reply-To: <BD7042533C2F8943A6A4257A9E31C45439C944@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200704022159.32913.philipp.reisner@linbit.com>
Cc: "Montrose, Ernest" <Ernest.Montrose@stratus.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hi Ernest,

I removed all the linebreaks:

Drbd2: Writing metadata to superblock now.
......
....... This nodes is powered of and came back with:

13:16:53 je rct = 0 in
13:16:54 je drbd_sync_handshake:
13:16:54 je self F71E503A8179BC5D:0000000000000000:3F430D4E1D59C3EA:6B0B1DA5CB20689C
13:16:54 je peer F71E503A8179BC5C:0000000000000000:3F430D4E1D59C3EA:6B0B1DA5CB20689C
13:16:55 je uuid_compare()=0 by rule 4    <<<<<<<<=========---------------
13:16:55 je No resync, but bits in bitmap!

......

13:17:00 je drbd_sync_handshake:
13:17:00 je self F71E503A8179BC5D:0000000000000000:3F430D4E1D59C3EA:6B0B1DA5CB20689C
13:17:00 je peer 0000000000000000:0000000000000000:F71E503A8179BC5C:3F430D4E1D59C3EA
13:17:00 je uuid_compare()=-2 by rule 6
13:17:00 je Writing meta data super block now.
13:17:01 je writing of bitmap took 11 jiffies
13:17:01 je 12 GB marked out-of-sync by on disk bit-map.
13:17:02 je 13336132 KB now marked out-of-sync by on disk bit-map.
13:17:02 je Writing meta data super block now.
13:17:02 je  uuid[History_start] now F71E503A8179BC5D
13:17:02 je  uuid[Current] now 0000000000000000
13:17:03 je conn( Connected -> WFBitMapT )
13:17:03 je Writing meta data super block now.

On theh other node=============================

13:16:48 be aftr_isp( 0 -> 1 )
13:16:48 be Handshake successful: DRBD Network Protocol version 86
13:16:48 be peer( Unknown -> Secondary ) conn( WFReportParams -> Connected ) pdsk( DUnknown -> UpToDate ) peer_isp( 0 -> 1 )
13:16:48 be Writing meta data super block now.

....

13:16:49 be rct = 2 in
13:16:49 be drbd_sync_handshake:
13:16:49 be self F71E503A8179BC5C:0000000000000000:3F430D4E1D59C3EA:6B0B1DA5CB20689C
13:16:49 be peer F71E503A8179BC5D:0000000000000000:3F430D4E1D59C3EA:6B0B1DA5CB20689C
13:16:49 be uuid_compare()=-1 by rule 4   <<<<<<<<=========---------------
13:16:49 be  uuid[History_start] now F71E503A8179BC5C
13:16:49 be  uuid[Current] now 0000000000000000
13:16:49 be conn( Connected -> WFBitMapT )
13:16:49 be Writing meta data super block now.


Unfortunately the clocks of the nodes seems to be not in sync (please
use NTP, this would make reading such logs much easiert!)

I assume that the line marked with the arrow ( <<==-- ) is 
where the troubles begin. Because the 'self' and 'peer' line
is matches here inverse. Then the suspicious decision is
the outcome of uuid_compare() with rule 4. 

While je (jerry) comes to the conclusion 0, gets ben -1. 

The rtc (a few lines before) suggests us that jerry thought
that neither node was a CRASHED_PRIMARY, while ben thought
that jerry was a CRASHED_PRIMARY. Out of you comment
that jerry was powered off, I guess that jerry was really
a CRASHED_PRIMARY, and therefore it sent this information
over to ben. But somehow that CRASHED_PRIMARY bit got
cleared before jerry came to its drbd_uuid_compare()
function. 

The question is: how did that happen ?

In the rest of the log entries on jerry we can see how he
tried to do a second sync handshake ... 

Back to the question of the lost CRASHED_PRIMARY bit. 

That bits can get cleared when:
1) We attach a disk.
2) Connection state goes to connected.
3) In the receive_bitmap.

I think that the clear_bit in receive_bitmap() is wrong, but
I currently can not think of a situation where this clear_bit
can get executed before the drbd_sync_handshake() function.

Ernest, could you provide a bit more context with a few more
lines of jerry's log before 13:16:53.

So far this my proposed patch. But there is still a missing
link in the reasoning:

--- drbd_receiver.c	(revision 2821)
+++ drbd_receiver.c	(working copy)
@@ -2509,7 +2509,6 @@
 		D_ASSERT(h->command == ReportBitMap);
 	}
 
-	clear_bit(CRASHED_PRIMARY, &mdev->flags); // md_write() is in drbd_start_resync.
 	if (mdev->state.conn == WFBitMapS) {
 		drbd_start_resync(mdev,SyncSource);
 	} else if (mdev->state.conn == WFBitMapT) {
