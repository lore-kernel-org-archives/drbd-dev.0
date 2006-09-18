Return-Path: <philipp.reisner@linbit.com>
Received: from mescal.linbit (office.linbit [213.229.1.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 3BAE42CF83EB
	for <drbd-dev@lists.linbit.com>; Mon, 18 Sep 2006 14:10:25 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] DRBD-8: Fix to Negotiating state handling
Date: Mon, 18 Sep 2006 14:10:26 +0200
References: <342BAC0A5467384983B586A6B0B37671039D3DAA@EXNA.corp.stratus.com>
In-Reply-To: <342BAC0A5467384983B586A6B0B37671039D3DAA@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200609181410.26858.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Sonntag, 17. September 2006 18:10 schrieb Graham, Simon:
> Ignore previous email... I've figured out what I did wrong (test was in
> the wrong place) -- I also left out the code to have the receiver of a
> negotiating state update it's peer state to UpToDate instead of
> Negotiating...
>
> Final, really working but possibly not entirely correct, patch
> attached...
> Simon

Hi Simon,

Thanks!

I think the patch is right. It seems I have tested all cases where
a resync start after attach, but I missed to test the case where
no resync happens after the attach command.

=2Dphil
=2D-=20
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Sch=F6nbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :
