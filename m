Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] DRBD8: Split-brain if primary and syncTarget
Date: Mon, 12 Mar 2007 15:52:16 +0100
References: <BD7042533C2F8943A6A4257A9E31C45439C91C@EXNA.corp.stratus.com>
	<200703121528.20523.philipp.reisner@linbit.com>
In-Reply-To: <200703121528.20523.philipp.reisner@linbit.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_gkW9FmIOy5SWvr3"
Message-Id: <200703121552.16600.philipp.reisner@linbit.com>
Cc: "Montrose, Ernest" <Ernest.Montrose@stratus.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

--Boundary-00=_gkW9FmIOy5SWvr3
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Montag, 12. M=E4rz 2007 15:28 schrieb Philipp Reisner:
> Am Donnerstag, 8. M=E4rz 2007 23:21 schrieb Montrose, Ernest:
> > Hi all,
> >
> > We are seeing an issue with split brain if one node is syncing as
> > syncTarget while being Primary.
> > two node A and B.
> > * make B primary and the syncTarget
> > * Start a sync.
> > * ifdown eth1 to break communication
> > * ifup eth1.
> > * then on the node in standalone "drbdadm connect"
> > We get a split-brain.
> >
> > I think the  problem is that if we are primary and we lose contact from
> > the other side we generate a new current UUID which causes a Split-Brain
> > next time we connect.
> > This only happens if we are the sync target and we are primary. Perhaps
> > we should not generate a UUID if we were syncing when the disconnect
> > happen. Below is a possible patch for this in after_state_ch():
>
> Hi Ernest,
>
> I think the current behaviour is correct.
>
> * When a node is SyncTarget it actually exposes the data of the sync
>   source node to its applications. (And the applications can potentially
>   see the data when the SyncTarget node is primary.)
>
> * When you disconnect such a node, it has to fall back to its local
>   data set. =3D=3D suddenly the applications see a different data set,
>   and of course the apps might continue to modify this data set...
>
> * Wen you reconnect this, you have a split brain situation. But you
>   might let the automatic-split-brain resolving handler solve the
>   situation. Use some after-sb-?pri settings, and an rr-conflict of
>   "violently" E.g.:
>
>   after-sb-0pri discard-least-changes
>   after-sb-1pri violently-as0p
>   after-sb-2pri violently-as0p
>   rr-conflict   violently
>
>   Then the resync should continue. Since the "violently" allows DRBD
>   to change the data set again, that is seen on the Primary node.

Hmmm. I just had a look at the code in drbd_sync_handshake(), and came
to the conclusion that the handling of the inconsistent disk state was
a bit obscure.

With the attached patch the after-sb-?pri settings are of no impact
this such an situation any longer. Only the "rr-conflict" setting
should influence the outcome...

If it works for you with that patch, I will commit it...

=2Dphil
=2D-=20
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Vivenotgasse 48, 1120 Vienna, Austria        http://www.linbit.com :

--Boundary-00=_gkW9FmIOy5SWvr3
Content-Type: text/x-diff; charset="iso-8859-15";
	name="look_at_inconsistent_first.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="look_at_inconsistent_first.diff"

Index: drbd_receiver.c
===================================================================
--- drbd_receiver.c	(revision 2786)
+++ drbd_receiver.c	(working copy)
@@ -1932,20 +1932,24 @@
 STATIC drbd_conns_t drbd_sync_handshake(drbd_dev *mdev, drbd_role_t peer_role,
 					drbd_disks_t peer_disk)
 {
-	int hg,rule_nr;
+	int hg,rule_nr=0;
 	drbd_conns_t rv = conn_mask;
 	drbd_disks_t mydisk;
 
 	mydisk = mdev->state.disk;
 	if( mydisk == Negotiating ) mydisk = mdev->new_state_tmp.disk;
 
-	hg = drbd_uuid_compare(mdev,&rule_nr);
+	// Look if a disk is inconsistent. Only if this does not find 
+	// a decission look at the UUIDs.
+	if(mydisk==Inconsistent && peer_disk>Inconsistent) hg=-1;
+	else if(mydisk>Inconsistent && peer_disk==Inconsistent) hg= 1;
+	else hg = drbd_uuid_compare(mdev,&rule_nr);
 
 	MTRACE(TraceTypeUuid,TraceLvlSummary,
 	       INFO("drbd_sync_handshake:\n");
 	       drbd_uuid_dump(mdev,"self",mdev->bc->md.uuid);
 	       drbd_uuid_dump(mdev,"peer",mdev->p_uuid);
-	       INFO("uuid_compare()=%d by rule %d\n",hg,rule_nr);
+	       INFO("have_good=%d by rule %d\n",hg,rule_nr);
 	    );
 
 	if (hg == 100 || (hg == -100 && mdev->net_conf->always_asbp) ) {
@@ -1990,13 +1994,6 @@
 		}
 	}
 
-	if (abs(hg) < 100) {
-		// This is needed in case someone does an invalidate on an
-		// disconnected node. This has priority.
-		if(mydisk==Inconsistent && peer_disk>Inconsistent) hg=-1;
-		if(mydisk>Inconsistent && peer_disk==Inconsistent) hg= 1;
-	}
-
 	if (hg == -1000) {
 		ALERT("Unrelated data, dropping connection!\n");
 		drbd_force_state(mdev,NS(conn,Disconnecting));

--Boundary-00=_gkW9FmIOy5SWvr3--
