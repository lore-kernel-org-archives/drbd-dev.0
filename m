Return-Path: <philipp.reisner@linbit.com>
Received: from mescal.linbit (office.linbit [213.229.1.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id A6F222CF62A3
	for <drbd-dev@lists.linbit.com>; Mon,  4 Sep 2006 10:27:05 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Another drbdsetup issue...
Date: Mon, 4 Sep 2006 10:27:07 +0200
References: <342BAC0A5467384983B586A6B0B376710377B6ED@EXNA.corp.stratus.com>
In-Reply-To: <342BAC0A5467384983B586A6B0B376710377B6ED@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200609041027.07565.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Freitag, 1. September 2006 19:59 schrieb Graham, Simon:
> I notice that with the latest drbd 8 from trunk, I get errors printed
> out during system boot - these are caused by invalid drbdsetup commands
> being issued that cause drbdsetup to print it's usage information
> (leading to the segfault I reported earlier) - what I found is that the
> drbd startup script is issuing a "drbdadm wait_con_int" command which in
> turn generates 'drbdsetup wait_connect" commands which seem to have been
> removed from drbdsetup... did I miss something whilst I was on vacation?
>

Hi Simon,

I have to admit that the new netlink/connector based code is not finished
by now (regarding the missing wait_connect command) and of course by no
means fully debugged.=20

But the patch was already so big, that I wanted to have it under version
control, therefore I committed it to SVN.

I will continue to work on it, implement the last missing commands, and
fixing the bugs...

=2DPhilipp
=2D-=20
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Sch=F6nbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :
