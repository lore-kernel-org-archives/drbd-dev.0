Return-Path: <oren@forescout.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Drbd-dev] DRBD8: Deadlock in PausedSyncS
Date: Thu, 2 Aug 2007 15:07:33 +0300
Message-ID: <07E688A4439C9C4ABF81C84EFBB342F366FC02@TA-SAT.fsd.forescout.com>
In-Reply-To: <200708021144.49764.philipp.reisner@linbit.com>
References: <BD7042533C2F8943A6A4257A9E31C454F4799A@EXNA.corp.stratus.com>
	<200708021144.49764.philipp.reisner@linbit.com>
From: "Oren Nechushtan" <oren@forescout.com>
To: "Philipp Reisner" <philipp.reisner@linbit.com>, <drbd-dev@lists.linbit.com>
Cc: "Montrose, Ernest" <Ernest.Montrose@stratus.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hi,
I believe we have a similar problem, possibly a variant.
We are using 2.4.x kernel with drbd 0.7.22.
It seems that sometimes drbdadm state stalls, for 20sec or much longer
(possibly indefinitely.)
Can it be that the same problem exists in the older drbd branch?

More info..
We have a two node HA cluster with drbd. Usually drbdadm state works
great within less than a second.
However, sometime it stalls. It seems that in these cases drbdadm
returns code 20.
The output of the command varies between Primary/Secondary to
Primary/Unknown.
drbd.conf special flags
 wfc-timeout 30;
 degr-wfc-timeout 60;
For example, during one of the times drbdadm stalled for 20 sec,=20
/var/log/messages did not show any activity on this node (me) during and
immediately before this happened.
A second node (him) , attached to the same drbd device, shows the next
output around 2 minutes before this happened.=20
There were no messages during the drbdadm state check on the second
node.

him kernel: drbd0: drbdsetup [17327]: cstate StandAlone --> Unconnected
him kernel: drbd0: drbdsetup [17327]: cstate Unconnected --> StandAlone
him kernel: drbd0: drbdsetup [17327]: cstate StandAlone --> Unconfigured
him kernel: drbd0: worker terminated
him kernel: drbd: module cleanup done.
him kernel: drbd: initialized. Version: 0.7.22 (api:79/proto:74)
him kernel: drbd: SVN Revision: 2554 build by root@Build, 2007-02-21
09:49:13
him kernel: drbd: registered as block device major 147
him kernel: drbd0: resync bitmap: bits=3D15360148 words=3D480006
him kernel: drbd0: size =3D 58 GB (61440592 KB)
him kernel: klogd 1.4.1, ---------- state change ----------
him kernel: Loaded 551 symbols from 19 modules.
him kernel: drbd0: 8 KB marked out-of-sync by on disk bit-map.
him kernel: drbd0: Found 6 transactions (324 active extents) in activity
log.
him kernel: drbd0: drbdsetup [17349]: cstate Unconfigured --> StandAlone
him kernel: drbd0: drbdsetup [17353]: cstate StandAlone --> Unconnected
him kernel: drbd0: drbd0_receiver [17354]: cstate Unconnected -->
WFConnection
him kernel: drbd0: Unable to bind source sock (-99)
him kernel: drbd0: Unable to bind sock2 (-99)
him kernel: drbd0: drbd0_receiver [17354]: cstate WFConnection -->
Unconnected
him kernel: drbd0: worker terminated
him kernel: drbd0: drbd0_receiver [17354]: cstate Unconnected -->
Unconnected
him kernel: drbd0: Connection lost.
him kernel: drbd0: Discarding network configuration.
him kernel: drbd0: drbd0_receiver [17354]: cstate Unconnected -->
StandAlone
him kernel: drbd0: receiver terminated
him kernel: drbd0: drbdsetup [17534]: cstate StandAlone --> Unconnected
him kernel: drbd0: drbd0_receiver [17535]: cstate Unconnected -->
WFConnection
him kernel: drbd0: Unable to bind source sock (-99)
him kernel: drbd0: Unable to bind sock2 (-99)
him kernel: drbd0: drbd0_receiver [17535]: cstate WFConnection -->
Unconnected
him kernel: drbd0: worker terminated
him kernel: drbd0: drbd0_receiver [17535]: cstate Unconnected -->
Unconnected
him kernel: drbd0: Connection lost.
him kernel: drbd0: Discarding network configuration.
him kernel: drbd0: drbd0_receiver [17535]: cstate Unconnected -->
StandAlone
him kernel: drbd0: receiver terminated

In case the state was Primary/Unknown, a drbdadm connect results with
the next output, everything within a short time interval:

him kernel: drbd0: drbdsetup [18288]: cstate StandAlone --> Unconnected
him kernel: drbd0: drbd0_receiver [18289]: cstate Unconnected -->
WFConnection
me kernel: drbd0: drbd0_receiver [1915]: cstate WFConnection -->
WFReportParams
me kernel: drbd0: Handshake successful: DRBD Network Protocol version 74
him kernel: drbd0: drbd0_receiver [18289]: cstate WFConnection -->
WFReportParams
me kernel: drbd0: Connection established.
him kernel: drbd0: Handshake successful: DRBD Network Protocol version
74
me kernel: drbd0: I am(P): 1:00000002:00000001:0000008a:00000028:10
him kernel: drbd0: Connection established.
me kernel: drbd0: Peer(S): 1:00000002:00000001:0000008c:00000027:00
him kernel: drbd0: I am(S): 1:00000002:00000001:0000008c:00000027:00
me kernel: drbd0: Current Primary shall become sync TARGET! Aborting to
prevent data corruption.
him kernel: drbd0: Peer(P): 1:00000002:00000001:0000008a:00000028:10
me kernel: drbd0: drbd0_receiver [1915]: cstate WFReportParams -->
StandAlone
him kernel: drbd0: drbd0_receiver [18289]: cstate WFReportParams -->
WFBitMapS
me kernel: drbd0: error receiving ReportParams, l: 72!
him kernel: drbd0: meta connection shut down by peer.
me kernel: drbd0: worker terminated
him kernel: drbd0: drbd0_asender [18290]: cstate WFBitMapS -->
NetworkFailure
me kernel: drbd0: asender terminated
him kernel: drbd0: asender terminated
me kernel: drbd0: drbd0_receiver [1915]: cstate StandAlone -->
StandAlone
him kernel: drbd0: short sent ReportBitMap size=3D4096 sent=3D-1001
me kernel: drbd0: Connection lost.
him kernel: drbd0: Secondary/Unknown --> Secondary/Primary
me kernel: drbd0: receiver terminated
him kernel: drbd0: sock was shut down by peer
him kernel: drbd0: drbd0_receiver [18289]: cstate NetworkFailure -->
BrokenPipe
him kernel: drbd0: short read expecting header on sock: r=3D0
him kernel: drbd0: worker terminated
him kernel: drbd0: drbd0_receiver [18289]: cstate BrokenPipe -->
Unconnected
him kernel: drbd0: Connection lost.
him kernel: drbd0: drbd0_receiver [18289]: cstate Unconnected -->
WFConnection

Thanks in advance,
Oren.

> -----Original Message-----
> From: drbd-dev-bounces@lists.linbit.com=20
> [mailto:drbd-dev-bounces@lists.linbit.com] On Behalf Of=20
> Philipp Reisner
> Sent: Thursday, August 02, 2007 12:45 PM
> To: drbd-dev@lists.linbit.com
> Cc: Montrose, Ernest
> Subject: Re: [Drbd-dev] DRBD8: Deadlock in PausedSyncS
>=20
> On Tuesday 31 July 2007 00:31:19 Montrose, Ernest wrote:
> > Hi all,
> > We are seeing a problem where we deadlock if a pause sync request=20
> > happens while attaching.  Below is an explaination of what=20
> I think is
> > occurring:
> >
> > Consider two nodes X primary and Y Secondary.
> > 1. X becomes Secondary/Diskless
> > 2. Y becomes Primary
> > 3. X tries to Attach and sends its states/uuids to Y 4.=20
> While Y is in=20
> > receive_state() doing a drbd_sync_handshake(), it receives a Paused=20
> > Sync request.
> >   This is where the trouble starts.
> > 5. aftr_isp is changed from 0->1 on Y and after_state_ch() called. =20
> > This triggers
> >   a drbd_send_state() from Y.
> > 6.  X receives States from Y but no uuids and runs a
> > drbd_sync_handshake() with the old uuids and
> >     we deadlocked with PausedSyncS on both sides.
> >
> > I am not sure how to best fix this.  Perhaps we should not call
> > drbd_send_state()
> > in after_state_ch() for a sync request from the peer if the peer's=20
> > disk is diskless.
> > Or we do send states, sends the uuids as well.  The attached patch=20
> > will at least serve as an illustration of the issue if not=20
> the correct fix.
> >
>=20
>=20
> Hi Ernest,
>=20
> Your patch was correct I think. But in reality we have not=20
> only this one case of the problem it is a whole class of such=20
> problems.=20
>=20
> While the node that gets the new disk is in disk=3DNegotiating,=20
> it will run drbd_sync_handshake() on each state packet that comes in.
>=20
> We need to avoid this. Calling pause-sync is just one=20
> possible way to cause the transmittion of a state packets,=20
> this is a whole class of such problems.
>=20
> Instead of fixing every place where we send a state packet,=20
> to not send it if the peer has no disk, I decided to fix the=20
> receiving side.
>=20
> http://lists.linbit.com/pipermail/drbd-cvs/2007-August/001613.html
>=20
> -Phil
> --=20
> : Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
> : LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
> : Vivenotgasse 48, 1120 Vienna, Austria        http://www.linbit.com :
> _______________________________________________
> drbd-dev mailing list
> drbd-dev@lists.linbit.com
> http://lists.linbit.com/mailman/listinfo/drbd-dev
>=20
