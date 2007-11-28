Return-Path: <lars.ellenberg@linbit.com>
Received: from racke.linbit (chello080108047253.34.11.vie.surfer.at
	[80.108.47.253])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id D72AD2E0BD9F
	for <drbd-dev@lists.linbit.com>; Wed, 28 Nov 2007 01:26:29 +0100 (CET)
Date: Wed, 28 Nov 2007 01:26:21 +0100
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] DRBD8: disconnecting while already disconnecting can
	hang the receiver
Message-ID: <20071128002621.GA6588@racke.local>
References: <BD7042533C2F8943A6A4257A9E31C4543D15E5@EXNA.corp.stratus.com>
	<BD7042533C2F8943A6A4257A9E31C454F47A3F@EXNA.corp.stratus.com>
	<BD7042533C2F8943A6A4257A9E31C454F47A42@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BD7042533C2F8943A6A4257A9E31C454F47A42@EXNA.corp.stratus.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Tue, Nov 27, 2007 at 04:51:21PM -0500, Montrose, Ernest wrote:
> Phil,
> Your modification to the original patch will break it actually.  The
> reason is that we can get into "disconnecting" anywhere.

and that should not be the case.
unfortunately it is, because it is forced everywhere.

grep -n force_state *[ch] | tr -s '\t ' '  ' | grep ': ' 

drbd_actlog.c:852: drbd_force_state(mdev,NS(conn,Disconnecting));
drbd_main.c:1883: drbd_force_state(mdev, NS(conn,BrokenPipe));
drbd_main.c:1885: drbd_force_state(mdev, NS(conn,Timeout));
drbd_nl.c:1025: drbd_force_state(mdev,NS(disk,Diskless));
drbd_receiver.c:589: if(rv != size)
drbd_force_state(mdev,NS(conn,BrokenPipe));
drbd_receiver.c:672: drbd_force_state(mdev,NS(conn,Disconnecting));
drbd_receiver.c:1957: drbd_force_state(mdev,NS(conn,Disconnecting));
drbd_receiver.c:2016: drbd_force_state(mdev,NS(conn,Disconnecting));
drbd_receiver.c:2023: drbd_force_state(mdev,NS(conn,Disconnecting));
drbd_receiver.c:2035: drbd_force_state(mdev,NS(conn,Disconnecting));
drbd_receiver.c:2143: drbd_force_state(mdev,NS(conn,Disconnecting));
drbd_receiver.c:2225: drbd_force_state(mdev,NS(conn,Disconnecting));
drbd_receiver.c:2259: drbd_force_state(mdev,NS(conn,Disconnecting));
drbd_receiver.c:2294: drbd_force_state(mdev,NS(conn,Disconnecting));
drbd_receiver.c:2447: drbd_force_state(mdev,NS(conn,Disconnecting));
drbd_receiver.c:2648: drbd_force_state(mdev,NS(conn,ProtocolError));
drbd_receiver.c:2654: drbd_force_state(mdev,NS(conn,ProtocolError));
drbd_receiver.c:3099: drbd_force_state(mdev,NS(conn,Disconnecting));
drbd_receiver.c:3430: drbd_force_state(mdev,NS(conn,NetworkFailure));
drbd_worker.c:738: drbd_force_state(mdev,NS(conn,NetworkFailure));
drbd_worker.c:1008: drbd_force_state(mdev,NS(conn,NetworkFailure));

I don't think "Disconnecting" should ever be forced.
NetworkFailure and the like are possible "forced" transitions.
"state engine" should then do "the right thing".

most locations above where there is "force -> Disconnecting",
in fact there should be either no "force", or force -> ProtocolError.

-- 
: Lars Ellenberg                            Tel +43-1-8178292-55 :
: LINBIT Information Technologies GmbH      Fax +43-1-8178292-82 :
: Vivenotgasse 48, A-1120 Vienna/Europe    http://www.linbit.com :
