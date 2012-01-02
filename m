Return-Path: <xrobau@gmail.com>
Received: from mail-qy0-f182.google.com (mail-qy0-f182.google.com
	[209.85.216.182]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 6CFCC10556A0
	for <drbd-dev@lists.linbit.com>; Mon,  2 Jan 2012 01:26:29 +0100 (CET)
Received: by qcse13 with SMTP id e13so12719536qcs.27
	for <drbd-dev@lists.linbit.com>; Sun, 01 Jan 2012 16:26:28 -0800 (PST)
MIME-Version: 1.0
Date: Mon, 2 Jan 2012 10:19:44 +1000
Message-ID: <CAC5zRjMCKiyKRi4jcRpfJw44LCkJ1gnatVXm_wtXPbO_dvSyNg@mail.gmail.com>
From: Rob Thomas <xrobau@gmail.com>
To: drbd-dev@lists.linbit.com
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Drbd-dev] Documentation bug.
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

http://www.drbd.org/users-guide-emb/s-configure-sync-rate.html

Has the parameter as 'sync-rate', when it's actually 'resync-rate'. I
ended up having to dive through the source to figure out WTF was going
on, after which point I immediately found the CORRECT parameter here:

http://www.drbd.org/users-guide/re-drbdconf.html

Sigh.

--Rob
