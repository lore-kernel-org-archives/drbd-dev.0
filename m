Return-Path: <Ernest.Montrose@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Drbd-dev] DRBD8: disconnecting while already disconnecting can
	hang the receiver
Date: Tue, 27 Nov 2007 10:06:25 -0500
Message-ID: <BD7042533C2F8943A6A4257A9E31C454F47A40@EXNA.corp.stratus.com>
In-Reply-To: 200711271552.33461.philipp.reisner@linbit.com
References: <BD7042533C2F8943A6A4257A9E31C4543D15E5@EXNA.corp.stratus.com>
	<BD7042533C2F8943A6A4257A9E31C454F47A3F@EXNA.corp.stratus.com>
	200711271552.33461.philipp.reisner@linbit.com
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
Interesting...With a delay at the end of drbd_disconnect() it happens
every time for me.  What I did is that I delay for 30 seconds and
quickly issue the disconnect in that window.
I added this at the very end of drbd_disconnect:
 if(os.conn =3D=3D TearDown && ns.conn =3D=3D Unconnected && mdev->minor =
=3D=3D11)
{
 INFO("drbd_disconnect: ##5# EM-- Done but waiting 30 seconds######\n");
 set_current_state(TASK_INTERRUPTIBLE);
 schedule_timeout(HZ * 30);
 INFO("drbd_disconnect: ##5# EM-- Done ##### waiting 30
seconds######\n");
}

Notice mdev->minor =3D=3D 11..you can change the 11 to some other device
that you are doing the disconnect on.  Once you see the message "done
waiting" then you'd issue the local disconnect.  Put the instrumented
driver on one side (The side that will do the last disconnect)

BTW, I agree that your spin on the patch is less intrusive.  I will test
that and let you know.

EM--

-----Original Message-----
From: Philipp Reisner [mailto:philipp.reisner@linbit.com]=20
Sent: Tuesday, November 27, 2007 9:53 AM
To: drbd-dev@linbit.com
Cc: Montrose, Ernest
Subject: Re: [Drbd-dev] DRBD8: disconnecting while already disconnecting
can hang the receiver

On Tuesday 27 November 2007 14:06:46 Montrose, Ernest wrote:
> Phil,
> I looked at my notes...To reproduce this you can fake the condition
this
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

Yes. This is what I tested. I had a delay in drbd_disconenct().=20
I did not managed to get it into troubles.

BTW, while looking at the patch, I would have done it like this:

@@ -589,7 +589,8 @@ STATIC int is_valid_state_transition(drbd_dev*=20
mdev,drbd_state_t ns,drbd_state_t
        if( (ns.conn =3D=3D StartingSyncT || ns.conn =3D=3D =
StartingSyncS ) &&
            os.conn > Connected) rv=3DSS_ResyncRunning;

-       if( ns.conn =3D=3D Disconnecting && os.conn =3D=3D StandAlone)
+       if ( ns.conn =3D=3D Disconnecting &&
+            ( os.conn =3D=3D StandAlone || os.conn =3D=3D TearDown ) )
                rv=3DSS_AlreadyStandAlone;

        if( ns.disk > Attaching && os.disk =3D=3D Diskless)

-Phil
--=20
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Vivenotgasse 48, 1120 Vienna, Austria        http://www.linbit.com :
