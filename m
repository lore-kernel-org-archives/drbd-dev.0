Return-Path: <Simon.Graham@stratus.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-class: urn:content-classes:message
Subject: RE: [Drbd-dev] DRBD-8: BUG when disk write errors occur during
	heavyI/O
Date: Thu, 11 Jan 2007 15:39:10 -0500
Message-ID: <342BAC0A5467384983B586A6B0B3767104614900@EXNA.corp.stratus.com>
From: "Graham, Simon" <Simon.Graham@stratus.com>
To: "Philipp Reisner" <philipp.reisner@linbit.com>, <drbd-dev@lists.linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

>=20
> Simon, this is an excellent description of what is going on. I also
> have gone
> through it as well, and think that moving dec_local() is the correct
> solution.
>=20
> Just have just committed it
> http://lists.linbit.com/pipermail/drbd-cvs/2007-January/001421.html
>=20

Phil,

It turns out that this fix, whilst necessary I think, is not sufficient
-- specifically, it does not cover the case where the local request
fails and then later on the network request is ACK'd...

. When the local request fails, we run through
req_mod(write_completed_with_error) and at the end
  do the dec_local().
. If some other thread was attempting to set the local disk Diskless, it
will now see local_cnt=3D=3D0
  and run, releasing the act_log and resync caches.
. Now the network request is acked and we run
req_mod(write_acked_by_peer) -- now that both local and
  remote are done, req_may_be_done does it's thing and ends up calling
drbd_al_complete_io which crashes
  because act_log is now NULL.

Now - one fix would be to check for act_log being NULL in
drbd_al_complete_io. However, I wonder if it might be more correct to
delay doing the dec_local() until we are definitely done with the
request?

This would mean moving it out of req_mod() completely and instead doing
it in req_may_be_done() when the request actually is complete on both
sides... (and if RQ_LOCAL_COMPLETED flag is set I think)

Simon
