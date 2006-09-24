Return-Path: <Simon.Graham@stratus.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-class: urn:content-classes:message
Date: Sun, 24 Sep 2006 08:35:42 -0400
Message-ID: <342BAC0A5467384983B586A6B0B37671039D46DB@EXNA.corp.stratus.com>
From: "Graham, Simon" <Simon.Graham@stratus.com>
To: <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] DRBD-8: failure to complete resync when connection lost
	and resyncing to primary
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

In testing the panic removal code, I have come across a failure to
complete a resync process when the primary side is the target of the
resync; right now, if the disk state is not Negotiating then the code
will reject any attempt to perform a resync with the primary side disk
as the target even if the primary's disk is inconsistent. I came across
this with the following test case:

1. Set one side primary
2. do detach/attach on the primary side - this starts a full resync with
the secondary side as the source
3. Forcibly disconnect the network (you can actually do 'drbdadm
disconnect' on the secondary side!)
4. Reconnect the network - at this point, the resync is rejected.

Attached is some sample trace output showing the failure on the primary
side.

I'm thinking that this should be allowed IF the primary side disk is
inconsistent or diskless or otherwise bad; this means that the test in
drbd_sync_handshake:

	if (hg < 0 &&=20
	    mdev->state.role =3D=3D Primary && mdev->state.disk !=3D
Negotiating ) {
		ERR("I shall become SyncTarget, but I am primary!\n");
		drbd_force_state(mdev,NS(conn,StandAlone));
		drbd_thread_stop_nowait(&mdev->receiver);
		return conn_mask;
	}

should instead be:

	if (hg < 0 &&=20
	    mdev->state.role =3D=3D Primary && mdev->state.disk >=3D
Consistent ) {
		ERR("I shall become SyncTarget, but I am primary!\n");
		drbd_force_state(mdev,NS(conn,StandAlone));
		drbd_thread_stop_nowait(&mdev->receiver);
		return conn_mask;
	}

Does that make sense?
Simon

---extract of messages from Primary---

Sep 24 08:17:03 snoopy kernel: drbd0: Forcing state change from bad
state. Error would be: 'Refusing to be Primary without at least one
UpToDate disk'
Sep 24 08:17:03 snoopy kernel: drbd0:  old =3D { cs:WFConnection
st:Primary/Unknown ds:Inconsistent/DUnknown r--- }
Sep 24 08:17:03 snoopy kernel: drbd0:  new =3D { cs:WFReportParams
st:Primary/Unknown ds:Inconsistent/DUnknown r--- }
Sep 24 08:17:03 snoopy kernel: drbd0: conn( WFConnection ->
WFReportParams )=20
Sep 24 08:17:03 snoopy kernel: drbd0: data >>> HandShake (protocol 82)
Sep 24 08:17:03 snoopy kernel: drbd0: data <<< HandShake (protocol 82)
Sep 24 08:17:03 snoopy kernel: drbd0: Handshake successful: DRBD Network
Protocol version 82
Sep 24 08:17:03 snoopy kernel: drbd0: data >>> ReportProtocol (11)
Sep 24 08:17:03 snoopy kernel: drbd0: data >>> SyncParam (10)
Sep 24 08:17:03 snoopy kernel: drbd0: data >>> ReportSizes (d 15007MiB,
u 0MiB, c 15007MiB, max bio 1000, q order 0)
Sep 24 08:17:03 snoopy kernel: drbd0: data >>> ReportUUIDs
Curr:ABFA2C5E8469C059, Bitmap:0000000000000001, HisSt:980DF0A708466D72,
HisEnd:882E2BDEC183E244
Sep 24 08:17:03 snoopy kernel: drbd0: data >>> ReportState (s c861 {
role( Primary ) peer( Unknown ) conn( WFReportParams ) disk(
Inconsistent ) pdsk( DUnknown )})
Sep 24 08:17:03 snoopy kernel: drbd0: data <<< ReportProtocol (11)
Sep 24 08:17:03 snoopy kernel: drbd0: data <<< SyncParam (10)
Sep 24 08:17:03 snoopy kernel: drbd0: data <<< ReportSizes (d 15007MiB,
u 0MiB, c 15007MiB, max bio 1000, q order 0)
Sep 24 08:17:03 snoopy kernel: drbd0: data <<< ReportUUIDs
Curr:DC3A3BB9EB892584, Bitmap:ABFA2C5E8469C058, HisSt:980DF0A708466D72,
HisEnd:882E2BDEC183E244
Sep 24 08:17:03 snoopy kernel: drbd0: drbd_sync_handshake:
Sep 24 08:17:03 snoopy kernel: drbd0: self
ABFA2C5E8469C059:0000000000000001:980DF0A708466D72:882E2BDEC183E244
Sep 24 08:17:03 snoopy kernel: drbd0: peer
DC3A3BB9EB892584:ABFA2C5E8469C058:980DF0A708466D72:882E2BDEC183E244
Sep 24 08:17:03 snoopy kernel: drbd0: uuid_compare()=3D-1
Sep 24 08:17:03 snoopy kernel: drbd0: I shall become SyncTarget, but I
am primary!
Sep 24 08:17:03 snoopy kernel: drbd0: conn( WFReportParams -> StandAlone
)=20
Sep 24 08:17:03 snoopy kernel: drbd0: error receiving ReportState, l: 4!
Sep 24 08:17:03 snoopy kernel: drbd0: asender starting cleanup


