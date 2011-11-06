Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 2220110556B6
	for <drbd-dev@lists.linbit.com>; Mon,  7 Nov 2011 10:23:52 +0100 (CET)
Resent-Message-ID: <20111107092351.GB15431@barkeeper1-xen.linbit>
Received: from mail-fx0-f54.google.com (mail-fx0-f54.google.com
	[209.85.161.54]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 3B8C710556D2
	for <drbd-dev@lists.linbit.com>; Sun,  6 Nov 2011 17:10:23 +0100 (CET)
Received: by faar19 with SMTP id r19so8390582faa.27
	for <drbd-dev@lists.linbit.com>; Sun, 06 Nov 2011 08:10:21 -0800 (PST)
From: Florian Haas <florian@hastexo.com>
To: drbd-dev@lists.linbit.com
Date: Sun,  6 Nov 2011 17:09:55 +0100
Message-Id: <1320595796-5181-1-git-send-email-florian@hastexo.com>
Subject: [Drbd-dev] fix missing directory creation in "make install"
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Lars/Phil,

please consider the following patch, which ensures that "make install"
creates DRBD_RUN_DIR. Issue highlighted by Eric Robinson, see:

http://lists.linux-ha.org/pipermail/linux-ha/2011-November/044198.html

The fix to DRBD_LIB_DIR is merely cosmetic I guess; I strongly doubt
anyone ever overrides the PACKAGE_TARNAME. But it doesn't hurt not
to hard-code "drbd" here.

The patch is in my repo at git://github.com/fghaas/drbd-8.4.git --
feel free to pull from there.

Thanks,
Florian

