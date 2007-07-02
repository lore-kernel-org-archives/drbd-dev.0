Return-Path: <Ernest.Montrose@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Drbd-dev] DRBD8: Receive_state() won't dec_local after a disk
	failure on peer.
Date: Mon, 2 Jul 2007 08:18:51 -0400
Message-ID: <BD7042533C2F8943A6A4257A9E31C454F4796C@EXNA.corp.stratus.com>
In-Reply-To: 200707021158.29072.philipp.reisner@linbit.com
From: "Montrose, Ernest" <Ernest.Montrose@stratus.com>
To: "Philipp Reisner" <philipp.reisner@linbit.com>, <drbd-dev@lists.linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Phil,
Though this approach is really cute, it is error prone though.
Actually, the next guy that adds to the conditional might break us
again.  Maybe add a comment to say that the inc_local() must be last.
Hopefully the next guy will read it :)

Thanks!
EM--
-----Original Message-----
From: Philipp Reisner [mailto:philipp.reisner@linbit.com]=20
Sent: Monday, July 02, 2007 5:58 AM
To: drbd-dev@linbit.com
Cc: Montrose, Ernest
Subject: Re: [Drbd-dev] DRBD8: Receive_state() won't dec_local after a
disk failure on peer.

On Friday 29 June 2007 23:40:45 Montrose, Ernest wrote:
> Hi all,
> We have been seeing a problem where a cluster of two systems, X and Y.
> X is Primary and gets a disk fault.  X goes Diskless.
> Y now is forced to be Primary.
> X recovers from the fault.
> But now Y gets a disk fault and goes Diskless but Stay Primary.
> At this point I/O from r0 hangs on Y!
>
> A check on /proc/<ip>/wchan for the worker thread reveals that we are
> waiting forever for local_cnt to become 0 in after_state_ch(). So the
> worker thread will process the Net_read.  What happened is that after
> the first failure on X, receive_state() on Y failed to call
dec_local().
> The pdisk received state is Diskless therefore we won't dec_local().
The
> included patch illustrates the problem and attempts to fix it.
>
> Thanks.
> EM--


Right.

I changed the patch to:

--- branches/drbd-8.0/drbd/drbd_receiver.c      2007-07-02 08:44:22 UTC
(rev 2962)
+++ branches/drbd-8.0/drbd/drbd_receiver.c      2007-07-02 09:54:58 UTC
(rev 2963)
@@ -2408,8 +2408,8 @@
        if (nconn =3D=3D WFReportParams ) nconn =3D Connected;
=20
        if (mdev->p_uuid && oconn <=3D Connected &&
-           inc_local_if_state(mdev,Negotiating) &&
-           peer_state.disk >=3D Negotiating) {
+           peer_state.disk >=3D Negotiating &&
+           inc_local_if_state(mdev,Negotiating) ) {
=20
nconn=3Ddrbd_sync_handshake(mdev,peer_state.role,peer_state.disk);
                dec_local(mdev);
=20
since C guarantees us the evaluate the right argument of && only if
the left argument is true.

-Phil
--=20
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Vivenotgasse 48, 1120 Vienna, Austria        http://www.linbit.com :
