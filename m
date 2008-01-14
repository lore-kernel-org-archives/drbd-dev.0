Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Drbd-dev] [DRBD-8.0 PATCH] Revert some changes that cause
	resyncto stall
Date: Mon, 14 Jan 2008 08:57:05 -0500
Message-ID: <342BAC0A5467384983B586A6B0B3767107C5B14B@EXNA.corp.stratus.com>
In-Reply-To: 20080114090418.GG5715@barkeeper1.linbit
References: <342BAC0A5467384983B586A6B0B3767107C5AF60@EXNA.corp.stratus.com>
	20080114090418.GG5715@barkeeper1.linbit
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

> On Fri, Jan 11, 2008 at 10:23:37AM -0500, Graham, Simon wrote:
> > The attached patches revert a couple of changes made in DRBD-8.0
that
> can cause
> > resync to stall if it is pasued/resumed quickly (as can happen if
you
> have a
> > lot of devices all releated with sync-after settings).
>=20
> I don't think these should be reverted,
> I believe these changes are "correct".
> If they cause resync to be stalled, then there is an other problem
> which should be tracked down and fixed.
>=20

Perhaps but they definitely cause sync stalls (because there are race
conditions setting and clearing the stop-sync-timer flag because it's
set in one thread and cleared in another). I think all the
checking/asserting should just be removed -- if you want it to stop, set
the flag, if you want sync to run, clear it and that's it...

For the moment, in 8.0 at least, I think it's simply better to revert
these changes because they cause problems.

Simon
