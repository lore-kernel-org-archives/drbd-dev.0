Return-Path: <philipp.reisner@linbit.com>
Received: from mescal.linbit (office.linbit [213.229.1.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 301A02CE79B1
	for <drbd-dev@lists.linbit.com>; Thu, 17 Aug 2006 16:47:35 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] DRBD-8: handling of concurrent writes with two
	primaries
Date: Thu, 17 Aug 2006 16:47:32 +0200
References: <342BAC0A5467384983B586A6B0B37671036255F9@EXNA.corp.stratus.com>
In-Reply-To: <342BAC0A5467384983B586A6B0B37671036255F9@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200608171647.32293.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Donnerstag, 17. August 2006 16:17 schrieb Graham, Simon:
> > hmmm.
> > did you read
> >  http://www.drbd.org/fileadmin/drbd/publications/drbd8_wpnr.pdf
> > can you point out what we were missing there?
>
> --blush-- no I had not (but I HAVE now!)
>
> That's a great explanation and answers all of my questions I think... I
> certainly cant see any holes in your approach.
>

We are pretty confident about the approach, but there are for sure=20
tons^H^H^H^H some bugs hidden in the implementation ;)

=2DPhil
=2D-=20
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Sch=F6nbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :
