Return-Path: <florian@hastexo.com>
Received: from mail-ey0-f182.google.com (mail-ey0-f182.google.com
	[209.85.215.182]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id F0DD1105570F
	for <drbd-dev@lists.linbit.com>; Tue, 29 Nov 2011 19:57:46 +0100 (CET)
Received: by eaai12 with SMTP id i12so6040387eaa.27
	for <drbd-dev@lists.linbit.com>; Tue, 29 Nov 2011 10:57:45 -0800 (PST)
From: Florian Haas <florian@hastexo.com>
To: drbd-dev@lists.linbit.com
Date: Tue, 29 Nov 2011 19:57:24 +0100
Message-Id: <1322593045-678-1-git-send-email-florian@hastexo.com>
Subject: [Drbd-dev] [PATCH] Modify udev rules file so non-block devices
	aren't renamed
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Phil/Lars/Andreas,

attached is a suggested patch for the udev rules file that DRBD ships.
Julian Seifert ("alamar" on freenode) made the interesting choice of
naming one of his network interfaces "drbdlink". This the drbd udev
rule apparently then promptly re-renamed "drbd0", which shouldn't
happen.

As always, feel free to improve the patch as you see fit. If you wish
to apply it unmodified, consider pulling it from the "drbd-8.3"
branch in my GitHub repo; git://github.com/fghaas/drbd-8.git.

Cheers,
Florian
