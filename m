Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Date: Tue, 18 May 2010 14:05:04 +0200
References: <cover.1274099535.git.iustin@google.com>
	<201005172344.40802.philipp.reisner@linbit.com>
	<20100518085207.GB19087@google.com>
In-Reply-To: <20100518085207.GB19087@google.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201005181405.04970.philipp.reisner@linbit.com>
Cc: Iustin Pop <iustin@google.com>
Subject: Re: [Drbd-dev]
 =?utf-8?q?=5BPATCH_0/3=5D_Implement_=7Bbegin=7Cafter?=
 =?utf-8?q?=7D-resync-source=09handlers?=
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

[..]
> > * Are you going to use them in your organisation?
>=20
> That too, but better said we're going to use them in Ganeti (opensource,
> cluster-based virtualization manager). Background: Ganeti uses only the
> low-level drbdsetup interface, and not the drbdadm one, since we manage
> the minor numbers assignments dynamically. This dynamic part hits us,
> because we cannot make easy 'resync-after' rules (especially as on
> bigger Ganeti clusters, like 20-40 nodes, you could get easily into
> circular dependencies if you're not careful.
>=20
> So the plan is to write a custom usermode_helper (right now Ganeti
> documentations says to use /bin/true :), so we're not losing any
> functionality by moving to a custom helper), that will simply restrict
> DRBD to a single sync (either incoming or outgoing) per machine, in
> order to not overload any machine's I/O resources. When a begin-sync
> request comes in, either source or target, the helper will look if any
> other minors are undergoing syncs, and if so will drbdsetup pause-sync
> the minor - I hope that this is safe to do from the callback, my few
> tests show it so. And when a after-resync-* requests comes, we look if
> there are any paused syncs (on our end), and if so then we'll unpause
> one.
>=20
> Now, if drbd (the kernel driver) would have a setting like 'max_syncs',
> then we wouldn't have to implement anything in Ganeti, but that is
> probably more work in the kernel - which is harder, compared with a
> simple userspace shell script.
>=20
> Hope my explanation makes sense=E2=80=A6

Hi Iustin,

Yes, makes sense. It will go in, after the 8.3.8 release dust settled.

Best,
 Phil
=2D-=20
: Dipl-Ing Philipp Reisner
: LINBIT | Your Way to High Availability
: Tel: +43-1-8178292-50, Fax: +43-1-8178292-82
: http://www.linbit.com

DRBD(R) and LINBIT(R) are registered trademarks of LINBIT, Austria.
