Return-Path: <philipp.reisner@linbit.com>
Received: from mescal.linbit (office.linbit [213.229.1.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 1C8512D99862
	for <drbd-dev@lists.linbit.com>; Mon, 25 Sep 2006 15:41:56 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] DRBD-8: failure to complete resync when connection
	lost and resyncing to primary
Date: Mon, 25 Sep 2006 15:41:55 +0200
References: <342BAC0A5467384983B586A6B0B37671039D46DB@EXNA.corp.stratus.com>
In-Reply-To: <342BAC0A5467384983B586A6B0B37671039D46DB@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200609251541.55922.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hi Simon,

Thanks, for this.


> 3. Forcibly disconnect the network (you can actually do 'drbdadm
> disconnect' on the secondary side!)

Ok, I fixed this.
http://lists.linbit.com/pipermail/drbd-cvs/2006-September/001262.html

> 4. Reconnect the network - at this point, the resync is rejected.

> I'm thinking that this should be allowed IF the primary side disk is
> inconsistent or diskless or otherwise bad; this means that the test in
> drbd_sync_handshake:

Yes, right. This is necessary for the work you have in your pipeline,
I see.

I will commit that.

=2DPhil
=2D-=20
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Sch=F6nbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :
