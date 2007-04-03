Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] DRBD8: drbd nodes deadlock in WFBitMapT
Date: Tue, 3 Apr 2007 11:34:54 +0200
References: <BD7042533C2F8943A6A4257A9E31C45439C948@EXNA.corp.stratus.com>
In-Reply-To: <BD7042533C2F8943A6A4257A9E31C45439C948@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_/+hEGhLFZ8BIrVu"
Message-Id: <200704031134.55269.philipp.reisner@linbit.com>
Cc: "Montrose, Ernest" <Ernest.Montrose@stratus.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

--Boundary-00=_/+hEGhLFZ8BIrVu
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Am Montag, 2. April 2007 23:44 schrieb Montrose, Ernest:
> Phil,
> OK...I have learned a tad more since that last email.  So before I even
> try the proposed patch here is a way I was able to duplicate the
> problem.
> Perhaps that will help a bit.  Here it is with two nodes 'a' and 'b' .
> Suppose
> They are in steady states with UUIDS:
> Xa:0:Ha:HH:1:1:0:1:0:0
> Xb:0:Hb:HH:1:1:0:1:0:0
> Role Secondary/Secondary
>
> 1) Disconnect/detach /dev/drbdX on nodea
> 2) Move Current UUID of nodea to history-UUID of nodea and set
> current_UUID of nodea to 00000000000 with drbdmeta..
> 0:0:Xa:HH:1:1:0:1:0:0
> 3) Now attach and connect /dev/drbdX and the problem will occur
>
> I have attached the logs for my "manufactured" version of the problem
>

Ernest,

You are right, that DRBD should get out of this situation. The attached
patch fixes this. (I will commit it when you confirm that it also fixes
the issue for your)

But I am still asking myself how the CRASHED_PRIMARY got lost. Ernest,
do you still have the log of jerry from Mar 23 13:16:54 ?

I would really like to see the last 30 lines before Mar 23 13:16:54.

Thanks!
-Phil
-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Vivenotgasse 48, 1120 Vienna, Austria        http://www.linbit.com :

--Boundary-00=_/+hEGhLFZ8BIrVu
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="fix_i2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="fix_i2.diff"

Index: drbd_receiver.c
===================================================================
--- drbd_receiver.c	(revision 2822)
+++ drbd_receiver.c	(working copy)
@@ -1890,7 +1890,7 @@
 
 	*rule_nr = 5;
 	peer = mdev->p_uuid[Bitmap] & ~((u64)1);
-	if (self == peer) return -1;
+	if (self == peer && self != ((u64)0)) return -1;
 
 	*rule_nr = 6;
 	for ( i=History_start ; i<=History_end ; i++ ) {
@@ -1901,7 +1901,7 @@
 	*rule_nr = 7;
 	self = mdev->bc->md.uuid[Bitmap] & ~((u64)1);
 	peer = mdev->p_uuid[Current] & ~((u64)1);
-	if (self == peer) return 1;
+	if (self == peer && self != ((u64)0)) return 1;
 
 	*rule_nr = 8;
 	for ( i=History_start ; i<=History_end ; i++ ) {

--Boundary-00=_/+hEGhLFZ8BIrVu--
