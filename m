Return-Path: <philipp.reisner@linbit.com>
Received: from mescal.linbit (office.linbit [213.229.1.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 05C032CF868B
	for <drbd-dev@lists.linbit.com>; Mon, 18 Sep 2006 14:01:17 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] DRBD-8: crash due to incorrect thread termination
Date: Mon, 18 Sep 2006 14:01:16 +0200
References: <342BAC0A5467384983B586A6B0B37671038B07C7@EXNA.corp.stratus.com>
In-Reply-To: <342BAC0A5467384983B586A6B0B37671038B07C7@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200609181401.16982.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Freitag, 15. September 2006 00:49 schrieb Graham, Simon:
> I reported the issue with threads being stopped synchronously from the
> wrong context a while ago but now I've found an actual case that causes
> a panic() - if BOTH sides are detached, and you attach one side, the
> other will crash apparently because the code attempts to synchronously
> stop the sender thread, fails, then discards all the network connection
> data as the sender thread is still attempting to use it...
>
> Just thought I'd pass on an easy test case (since I don't know how to
> fix this one ;-).
>

Hi Simon,

I think I could reporduce a similar case. They crashed in the process of=20
connecting two diskless nodes.=20
I fixed the issue with this commit:
http://lists.linbit.com/pipermail/drbd-cvs/2006-September/001241.html

Could you please verify that the crash you experienced is also gone.

Thanks,
 Philipp
=2D-=20
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Sch=F6nbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :
