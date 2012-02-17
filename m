Return-Path: <florian@hastexo.com>
Received: from mail-ey0-f182.google.com (mail-ey0-f182.google.com
	[209.85.215.182]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 33CF1105CA37
	for <drbd-dev@lists.linbit.com>; Fri, 17 Feb 2012 16:11:29 +0100 (CET)
Received: by eaan10 with SMTP id n10so1658865eaa.27
	for <drbd-dev@lists.linbit.com>; Fri, 17 Feb 2012 07:11:29 -0800 (PST)
MIME-Version: 1.0
From: Florian Haas <florian@hastexo.com>
To: drbd-dev@lists.linbit.com
Date: Fri, 17 Feb 2012 16:10:03 +0100
Message-Id: <1329491404-15769-1-git-send-email-florian@hastexo.com>
Subject: [Drbd-dev] [8.3 PATCH 0/1]: peer fencing via stonith_admin
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Lars,

here's a trivial peer fencing handler that kicks out a peer via
Pacemaker's stonith_ng client utility, stonith_admin.

Likely to be useful only in dual-Primary configurations, where
it will of course lead to the inevitable cluster shootout on
replication network failure -- but since stonith_admin -F is
synchronous that shouldn't be a problem.

This is certainly far from perfect, so please feed free to add
your own shell wizardry to this.

Cheers,
Florian
