Return-Path: <philipp.reisner@linbit.com>
Received: from mescal.linbit (office.linbit [213.229.1.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id CEA462CF836E
	for <drbd-dev@lists.linbit.com>; Fri, 15 Sep 2006 12:18:55 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] DRBD-8: attach seems to be broken
Date: Fri, 15 Sep 2006 12:18:56 +0200
References: <342BAC0A5467384983B586A6B0B37671038B06E2@EXNA.corp.stratus.com>
In-Reply-To: <342BAC0A5467384983B586A6B0B37671038B06E2@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200609151218.56673.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Donnerstag, 14. September 2006 17:24 schrieb Graham, Simon:
> I'm not running the absolute latest but some change in the past day
> seems to have broken attach after detach - the state goes to Attaching
> and never transitions to UpToDate. I haven't been able to figure out how
> the side doing the attach is actually supposed to transition - it's
> somewhere in receive_state() I think but it eludes me for the moment. I
> can see that on the other side, receipt of ReportState when the peer
> says it's disk state is Attaching causes it to send ReportState in reply
> which the comments says causes the peer to promote from
> Attaching->UpToDate but I cant see how that actually happens...
>
> At the moment, I'm using revision 2423 which is just one back from the
> tip and looking at the diffs for that, I don't see anything that would
> fix this issue.
>
> Any suggestions?

Hi Simon,

Thanks for pointing this out!

I fixed it with this commit:
http://lists.linbit.com/pipermail/drbd-cvs/2006-September/001238.html

=2DPhilipp
=2D-=20
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Sch=F6nbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :
