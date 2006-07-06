Return-Path: <philipp.reisner@linbit.com>
Received: from mescal.linbit (office.linbit [213.229.1.138])
	(using TLSv1 with cipher EXP1024-RC4-SHA (56/128 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id C88A62CDC263
	for <drbd-dev@lists.linbit.com>; Thu,  6 Jul 2006 16:39:01 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Re: drbd_panic() in drbd_receiver.c
Date: Thu, 6 Jul 2006 15:38:59 +0100
References: <342BAC0A5467384983B586A6B0B37671031FB4D2@EXNA.corp.stratus.com>
In-Reply-To: <342BAC0A5467384983B586A6B0B37671031FB4D2@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200607061638.59672.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Mittwoch, 5. Juli 2006 19:49 schrieb Graham, Simon:
> Thanks again for the review; I understand and agree with your comments on
> doing this in 8 versus 7 - anything I do on 7 will just be for prototyping
> (because as I said it's much easier for me to test with 7 right now).
>
> I will take the approach of continuing with as much as possible of the
> resync (although as I suspected, it's MUCH easier to simply abort the
> resync as soon as any error is reported).

Ok.=20

> One question -- you said that DRBD disconnects from the disk on the first
> (local) error -- I think this is only true if you set on-io-error to
> "Detach" -- we actually run with the default value of PassOn in which case
> drbd_io_error does nothing; I think this is actually the best way to run
> since it keeps the disk accessible for those blocks that are OK and retur=
ns
> errors for those that are not.

Hmmm. The current semantic is:

on-io-error =3D passOn

If there is a local read error, DRBD will pass the IO error on to the=20
filesystem without retrying on the peer node.

Maybe we should have one more on-io-error hander. One that=20
retrtries on the peer node, if there is one, and if there is no peer
it returns the IO error, without detaching from the disk.

Good point.=20

I added that thought to my ROADMAP file...

=2DPhilipp
=2D-=20
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Sch=F6nbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :
