Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Drbd-dev] Running Protocol C with disk cache enabled
Date: Fri, 22 Jun 2007 16:03:22 -0400
Message-ID: <342BAC0A5467384983B586A6B0B3767105DEBB07@EXNA.corp.stratus.com>
In-Reply-To: 200706222041.34776.philipp.reisner@linbit.com
References: <342BAC0A5467384983B586A6B0B3767105DEB765@EXNA.corp.stratus.com><20070621132606.GB22863@ogo.aicooma.com>
	200706222041.34776.philipp.reisner@linbit.com
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

> Just a comment to this:
>=20
> > Well, I look at this slightly differently; use of the on-disk cache
> is
> > really the only way to get decent (i.e. competitive) performance out
> of
> > rotating rust, so what we have to do is find ways to allow this and
> > still be correct.
>=20
> A disk drive or a controller is really fine to take over thousands of
> IO operations. -- And in fact Linux (2.6) (and DRBD) takes advantage
> of this. I have seen an HP raid5 controller that accepted up 10000
> write requests at without blocking acceptance of further write
> requests.

Perhaps I'm missing something (and I definitely need to go look at the
barrier stuff you mentioned previously) but it's really not the number
of outstanding requests I am concerned about but the time to complete
any specific request -- if you don't use the disk cache in write behind
mode, then you end up at a competitive disadvantage and it does no good
to explain how you are really better because data can't be lost.=20

Obviously if you are streaming data to the disk then the cache doesn't
really help - once it's full, you have to wait anyway. However, a lot of
real world cases are either very bursty or they tend to modify the same
blocks over and over and using the write behind cache can provide
significant improvements (if you don't care about availability).

The trick is providing both perf and reliability!

So - my homework for the w/e is to read up on the barrier support you
mentioned before and see whether or not this provides what we need and
can work in all cases - I'm particularly interested in two cases:
1. Using DRBD volumes with no filesystem (e.g. Oracle or some other DB)
2. Using DRBD volumes from virtual machines (again, there is no
filesystem in the host
   environment - I need to see whether or not the virtual disk drivers
that sit between DRBD
   and the filesystem in the guest implement the barriers properly).

Simon
