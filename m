Return-Path: <philipp.reisner@linbit.com>
Received: from mescal.linbit (office.linbit [213.229.1.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 6C79E2DF653A
	for <drbd-dev@lists.linbit.com>; Tue, 31 Oct 2006 16:40:56 +0100 (CET)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] DRBD-8: add (basic) tracing to netlink commands
Date: Tue, 31 Oct 2006 16:40:56 +0100
References: <342BAC0A5467384983B586A6B0B3767103EB9ABC@EXNA.corp.stratus.com>
In-Reply-To: <342BAC0A5467384983B586A6B0B3767103EB9ABC@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200610311640.56670.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Samstag, 28. Oktober 2006 23:08 schrieb Graham, Simon:
> The attached patch adds some basic tracing to the netlink interface
> using the new TRACE() mechanism and a new trace type. I'd like to add
> more detailed tracing of the packets over time (probably based on
> generating code from drbd_nl.h).
>
> Simon

Hi Simon,

I will apply that patch, but I have one question before I do ...=20

Why did you did it ?
Are you looking for a problem in the area of the netlink stuff ?

=2DPhilipp
=2D-=20
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Sch=F6nbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :
