Return-Path: <philipp.reisner@linbit.com>
Received: from mescal.linbit (213-229-1-138.sdsl-line.inode.at [213.229.1.138])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id EFD81142F3
	for <drbd-dev@lists.linbit.com>; Wed, 25 Aug 2004 17:13:45 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Date: Wed, 25 Aug 2004 17:13:45 +0200
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Message-Id: <200408251713.45325.philipp.reisner@linbit.com>
Subject: [Drbd-dev] Summary (3rd try)
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hi,

I tried to incooperate the comments of LMB and LGE. Please review:

after-pri-pri-now-sec-sec = 
 disconnect     No automatic resynchronisation gets performed. One
                node should drop its net-conf (preferable the
                node that would become sync-target)
                DEFAULT.
 ass-older      Auto sync source is the oder primary (curr.behaviour i.t.s.)
 ass-younger    Auto sync source is the younger primary
 ass-furthest   Auto sync source is the node that did more modifications
 ass-NODENAME   Auto sync source is the named node 


pri-sees-sec-with-higher-gc =
 disconnect	(current behaviour)
 ass-primary	Auto sync source is the current primary
 panic		The current primary panics. The node with the
		higher gc should take over.


Notes:
1) The disconnect actions cause the sync-target or the secondary
   node to go into StandAllone state.
2) If two nodes in primary state try to connect one of them goes
   into StandAllone state (=curr. behaviour)
3) As soon as the decission is takes the sync-target addopts the
   GC of the sync source. 
   [ The whole algorith would also work if both would reset their 
     GCs to <0,0,0...> after the decission, but since we also
     use the GC to tag the bitmap it is better the current way ]

Is this better than try2 ?
Should we improve the naming ? "ass" might not be the best choice.
Do you think that the naming is constent ?
Is it still ambiguous ?

-Philipp
-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Schönbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :
