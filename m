Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Drbd-dev] DRBD-8 - after_state_ch() can attempt to
	terminateworker thread with wait==true
Date: Mon, 7 Aug 2006 10:24:29 -0400
Message-ID: <342BAC0A5467384983B586A6B0B376710347120F@EXNA.corp.stratus.com>
From: "Graham, Simon" <Simon.Graham@stratus.com>
To: "Graham, Simon" <Simon.Graham@stratus.com>,
	<drbd-dev@lists.linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Found one more place where this occurs -- drbd_sync_handshake which runs
in the context of the receiver thread can call drbd_force_state() in
error cases which will eventually call after_state_ch() since the
ScheduleAfter flag is not set.

/simgr


> -----Original Message-----
> From: drbd-dev-bounces@linbit.com [mailto:drbd-dev-bounces@linbit.com]
> On Behalf Of Graham, Simon
> Sent: Monday, August 07, 2006 9:33 AM
> To: drbd-dev@linbit.com
> Subject: [Drbd-dev] DRBD-8 - after_state_ch() can attempt to
> terminateworker thread with wait=3D=3Dtrue
>=20
> Near the end of after_state_ch() there are several clauses that stop
> (and restart) receiver and worker threads synchronously - since this
> function is called from both the worker and receiver thread context,
> these calls cannot be made synchronously (and an ASSERT in
> _drbd_thread_stop will fire).
>=20
> There seem to be a couple of issues here:
>=20
> 1. Is it the intention that after_state_ch is always called from the
> worker thread? If so, then the calls in drbd_receiver and
>    drbd_fs need to change to submit work items
>=20
> 2. No matter what, it should not issue synchronous calls to
> drbd_thread_stop for non-current threads.
>=20
> 3. In receive_state() -- should after_state_ch() be called at all if
> the
> preceding call to _drbd_set_state fails? It seems a
>    bit wrong to me to pass in the new state to after_state_ch when you
> know this does not represent the actual new state...
>=20
> 4. Ditto receive_outdate().
>=20
> Simon
> _______________________________________________
> drbd-dev mailing list
> drbd-dev@lists.linbit.com
> http://lists.linbit.com/mailman/listinfo/drbd-dev
