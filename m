Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] DRBD8: disconnecting while already disconnecting can
	hang the receiver
Date: Tue, 27 Nov 2007 15:52:33 +0100
References: <BD7042533C2F8943A6A4257A9E31C4543D15E5@EXNA.corp.stratus.com>
	<BD7042533C2F8943A6A4257A9E31C454F47A3F@EXNA.corp.stratus.com>
In-Reply-To: <BD7042533C2F8943A6A4257A9E31C454F47A3F@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200711271552.33461.philipp.reisner@linbit.com>
Cc: "Montrose, Ernest" <Ernest.Montrose@stratus.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Tuesday 27 November 2007 14:06:46 Montrose, Ernest wrote:
> Phil,
> I looked at my notes...To reproduce this you can fake the condition this
> way:
> * Issue a disconnect on node0 for r5.
> * Locally on node1 we will get into drbd_receiver.c:drbd_disconnect()
> and while there in drbd_disconnect() (Put a small delay there or
> something); issue a "drbdsetup /dev/drbd5 disconnect".
>
> This last drbdsetup will time out with " No response from the DRBD
> driver! Is the module loaded?"
> But the driver will be waiting forever in
> drbd_nl.c:drbd_nl_disconnect().
>

Yes. This is what I tested. I had a delay in drbd_disconenct(). 
I did not managed to get it into troubles.

BTW, while looking at the patch, I would have done it like this:

@@ -589,7 +589,8 @@ STATIC int is_valid_state_transition(drbd_dev* 
mdev,drbd_state_t ns,drbd_state_t
        if( (ns.conn == StartingSyncT || ns.conn == StartingSyncS ) &&
            os.conn > Connected) rv=SS_ResyncRunning;

-       if( ns.conn == Disconnecting && os.conn == StandAlone)
+       if ( ns.conn == Disconnecting &&
+            ( os.conn == StandAlone || os.conn == TearDown ) )
                rv=SS_AlreadyStandAlone;

        if( ns.disk > Attaching && os.disk == Diskless)

-Phil
-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Vivenotgasse 48, 1120 Vienna, Austria        http://www.linbit.com :
