Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Drbd-dev] too small timeout in drbdsetup
Date: Tue, 5 Aug 2008 08:54:08 -0400
Message-ID: <DA0E7D869C862D4095C265233CD1D41EC3080A@EXNA.corp.stratus.com>
In-Reply-To: 200808051335.15444.philipp.reisner@linbit.com
References: <87hcastmig.87fxqctmig@87ej5wtmig.message.id><87y73cochw.87wsiwochw@87vdygochw.message.id>
	200808051335.15444.philipp.reisner@linbit.com
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
> You have an issue with that 500ms in that function, right ?
>=20
> void ensure_drbd_driver_is_present(void)
>...
> We do not experience any issue with the 500ms in our setups, as are
> reports
> about such an issue rather rare. Could you give a more details
> description
> about the conditions you trigger can trigger this ?
>=20

FWIW, we see this occasionally in our environment too - usually when the
system is very busy; we're running DRBD in Dom0 of a Xen environment and
when the system is busy, the hypervisor can 'steal' time from Dom0 -
this translates to wall time moving forward with no chance to actually
execute code which can cause the 500ms timer to expire even when the
DRBD module is present.

We see this timeout once or twice a day (in about 2500hrs of total run
time) so it's not terribly prevalent but it's enough to cause issues.=20

I must admit (-blush-) that I simply commented out the call to
ensure_drbd_driver_is_present() in our version since I _know_ that the
module is always loaded. I think having a command line option to
drbdsetup that lengthens the timeout or disables the check altogether
would be good.

BTW: There is one other slightly annoying side effect of the check --
every time drbdsetup is run, you get an unexpected event reported if you
are running 'drbdsetup monitor' -- not terribly bad but it confuses
folks debugging issues...

Simon

