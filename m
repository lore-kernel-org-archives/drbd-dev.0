Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Drbd-dev] DRBD-8: crash due to incorrect thread termination
Date: Mon, 18 Sep 2006 09:51:44 -0400
Message-ID: <342BAC0A5467384983B586A6B0B37671039D3E4E@EXNA.corp.stratus.com>
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

Just run a quick test and yes the problem is fixed - thanks!
Simon

> -----Original Message-----
> From: drbd-dev-bounces@linbit.com [mailto:drbd-dev-bounces@linbit.com]
> On Behalf Of Philipp Reisner
> Sent: Monday, September 18, 2006 8:01 AM
> To: drbd-dev@linbit.com
> Subject: Re: [Drbd-dev] DRBD-8: crash due to incorrect thread
> termination
>=20
> Am Freitag, 15. September 2006 00:49 schrieb Graham, Simon:
> > I reported the issue with threads being stopped synchronously from
> the
> > wrong context a while ago but now I've found an actual case that
> causes
> > a panic() - if BOTH sides are detached, and you attach one side, the
> > other will crash apparently because the code attempts to
> synchronously
> > stop the sender thread, fails, then discards all the network
> connection
> > data as the sender thread is still attempting to use it...
> >
> > Just thought I'd pass on an easy test case (since I don't know how =
to
> > fix this one ;-).
> >
>=20
> Hi Simon,
>=20
> I think I could reporduce a similar case. They crashed in the process
> of
> connecting two diskless nodes.
> I fixed the issue with this commit:
> http://lists.linbit.com/pipermail/drbd-cvs/2006-September/001241.html
>=20
> Could you please verify that the crash you experienced is also gone.
>=20
> Thanks,
>  Philipp
> --
> : Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
> : LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
> : Sch=F6nbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com =
:
> _______________________________________________
> drbd-dev mailing list
> drbd-dev@lists.linbit.com
> http://lists.linbit.com/mailman/listinfo/drbd-dev
