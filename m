Return-Path: <syrius.ml@no-log.org>
Received: from postfix1-g20.free.fr (postfix1-g20.free.fr [212.27.60.42])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 320552CC092B
	for <drbd-dev@lists.linbit.com>; Mon, 14 Jul 2008 19:46:15 +0200 (CEST)
Received: from smtp3-g19.free.fr (smtp3-g19.free.fr [212.27.42.29])
	by postfix1-g20.free.fr (Postfix) with ESMTP id 547832845E46
	for <drbd-dev@lists.linbit.com>; Mon, 14 Jul 2008 19:24:44 +0200 (CEST)
Received: from smtp3-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 2E4DA17B59D
	for <drbd-dev@lists.linbit.com>; Mon, 14 Jul 2008 19:24:31 +0200 (CEST)
Received: from f.smtp.localhost (amm80-1-82-246-72-218.fbx.proxad.net
	[82.246.72.218])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 1BE5317B59B
	for <drbd-dev@lists.linbit.com>; Mon, 14 Jul 2008 19:24:31 +0200 (CEST)
To: drbd-dev@lists.linbit.com
From: syrius.ml@no-log.org
Message-ID: <87hcastmig.87fxqctmig@87ej5wtmig.message.id>
Date: Mon, 14 Jul 2008 19:24:30 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Drbd-dev] too small timeout in drbdsetup
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>


Hi,

as previously reported here
http://thread.gmane.org/gmane.linux.kernel.drbd.devel/330 I also get
the error message.

looking at
http://git.drbd.org/?p=drbd-8.0.git;a=blob;f=user/drbdsetup.c;h=0bca7c1c773bcbd1c2ed6781062396ed15e77e9c;hb=HEAD#l1919
and
http://git.drbd.org/?p=drbd-8.2.git;a=blob;f=user/drbdsetup.c;h=3868f1a18f4cda80cad5b0b05aa6f2348755dedd;hb=HEAD

it seems the timeout is still too low (at least for me)

I've fixed my problem by increasing the timeout to 5s.

to reproduce the bug i was doing several drbdsetup disk one after the other
in a script.

(in fact the bug was first triggered by heartbeat drbd ocf script)

Was do you thing would be the best change to make ?
increase the timeout ?
why not using NL_TIME (12000) as other drbd_calls ?

Thanks

-- 
