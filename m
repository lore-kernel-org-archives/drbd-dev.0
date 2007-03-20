Return-Path: <philipp.reisner@linbit.com>
Received: from mescal.linbit (unknown [86.59.100.100])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 245842DEAC65
	for <drbd-dev@lists.linbit.com>; Tue, 20 Mar 2007 13:25:40 +0100 (CET)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] DRBD8: Resync speed reporting not accurate
Date: Tue, 20 Mar 2007 13:25:40 +0100
References: <BD7042533C2F8943A6A4257A9E31C45439C92B@EXNA.corp.stratus.com>
In-Reply-To: <BD7042533C2F8943A6A4257A9E31C45439C92B@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200703201325.41353.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Freitag, 16. M=E4rz 2007 20:24 schrieb Montrose, Ernest:
> Hi all,
> We are seeing a problem where  resyncing multiple drbd volumes
> say r0,r1,r2 reports the wrong sync speed stats.  It seems to get worst
> and worst.  So r0 would report 30meg/S, r1 19Meg/sec and r2 9Meg/sec.
> These rates are not the true rates except for the first one. In reality,
> all the volumes took the same time to resync and they have the same
> size.
>
> The problem I think is that while one volume is Syncing the next volume
> in
> PauseSyncX get some activity and ends up calling __drbd_set_in_sync()
> from the asender thread.  When this happens rs_mark_time gets reset as
> well
> as rs_mark_left.  To illustrate this the change below would force the
> problem
> to go away.  I am not sure this is the correct patch though:
>

Hi Ernest,

Right, I have comited the patch.=20

=2DPhil
=2D-=20
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Vivenotgasse 48, 1120 Vienna, Austria        http://www.linbit.com :
