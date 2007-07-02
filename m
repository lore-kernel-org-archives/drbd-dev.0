Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] DRBD8: Receive_state() won't dec_local after a disk
	failure on peer.
Date: Mon, 2 Jul 2007 11:58:28 +0200
References: <BD7042533C2F8943A6A4257A9E31C454F47968@EXNA.corp.stratus.com>
In-Reply-To: <BD7042533C2F8943A6A4257A9E31C454F47968@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200707021158.29072.philipp.reisner@linbit.com>
Cc: "Montrose, Ernest" <Ernest.Montrose@stratus.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

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
> the first failure on X, receive_state() on Y failed to call dec_local().
> The pdisk received state is Diskless therefore we won't dec_local(). The
> included patch illustrates the problem and attempts to fix it.
>
> Thanks.
> EM--


Right.

I changed the patch to:

--- branches/drbd-8.0/drbd/drbd_receiver.c      2007-07-02 08:44:22 UTC (rev 2962)
+++ branches/drbd-8.0/drbd/drbd_receiver.c      2007-07-02 09:54:58 UTC (rev 2963)
@@ -2408,8 +2408,8 @@
        if (nconn == WFReportParams ) nconn = Connected;
 
        if (mdev->p_uuid && oconn <= Connected &&
-           inc_local_if_state(mdev,Negotiating) &&
-           peer_state.disk >= Negotiating) {
+           peer_state.disk >= Negotiating &&
+           inc_local_if_state(mdev,Negotiating) ) {
                nconn=drbd_sync_handshake(mdev,peer_state.role,peer_state.disk);
                dec_local(mdev);
 
since C guarantees us the evaluate the right argument of && only if
the left argument is true.

-Phil
-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Vivenotgasse 48, 1120 Vienna, Austria        http://www.linbit.com :
