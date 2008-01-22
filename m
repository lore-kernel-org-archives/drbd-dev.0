Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Drbd-dev] Barrier assert failures with latest 8.0 sources
Date: Mon, 21 Jan 2008 21:29:02 -0500
Message-ID: <342BAC0A5467384983B586A6B0B3767107E89D34@EXNA.corp.stratus.com>
In-Reply-To: 20080121163638.GC7594@barkeeper1.linbit
References: <342BAC0A5467384983B586A6B0B3767107E89B46@EXNA.corp.stratus.com>
	20080121163638.GC7594@barkeeper1.linbit
From: "Graham, Simon" <Simon.Graham@stratus.com>
To: "Lars Ellenberg" <lars.ellenberg@linbit.com>, <drbd-dev@lists.linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

> > I'm not sure why tl_clear leaves this pseudo-barrier in the list...
> > shouldn't it simply leave the list completely empty just like
tl_init
> > does?
>=20
> probably.
> we have seen these ASSERTS, too, btw, also without this latest change
> in
> the barrier code, so aparently it has been there all along.
> unfortunately we are all sort of distracted right now.
> but coding will resume shortly :)

Well, I realize now that I completely misunderstood again;
newest_barrier represents thenext barrier that will be sent, so of
course there has to be one in the list at all times (and tl_init also
sets up barrier 4711).

I think the problem is that tl_clear does NOT clear the CREATE_BARRIER
bit from mdev->flags - so if we disconnect in the small window between
setting this bit and creating the new barrier, then when we reconnect
and send the first request, we'll end up creating a new barrier before
sending the BarrierRq(4711) (processing the first request that has to go
remote) and I think this gets us into the cycle of always being one
barrier behind the remote system... this would also explain why the
assert is intermittent since you have to disconnect in a small window...

Seem reasonable?
/simgr
