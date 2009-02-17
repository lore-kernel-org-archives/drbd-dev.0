Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [86.59.100.100])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 86FCF10126A0
	for <drbd-dev@lists.linbit.com>; Tue, 17 Feb 2009 10:45:31 +0100 (CET)
Resent-Message-ID: <20090217094531.GC9673@barkeeper1-xen.linbit>
Received: from mail-fx0-f10.google.com (mail-fx0-f10.google.com
	[209.85.220.10])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 0DC4A1011BA6
	for <drbd-dev@lists.linbit.com>; Tue, 17 Feb 2009 10:06:25 +0100 (CET)
Received: by fxm3 with SMTP id 3so4825288fxm.3
	for <drbd-dev@lists.linbit.com>; Tue, 17 Feb 2009 01:06:24 -0800 (PST)
MIME-Version: 1.0
Date: Tue, 17 Feb 2009 09:58:40 +0100
Message-ID: <9bb5e33f0902170058l41474beeydc0970bcdcc67d3e@mail.gmail.com>
From: Mario Wolff <wolfshoehle@googlemail.com>
To: drbd-dev@lists.linbit.com
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Drbd-dev] DRBD MC help-progs/drbd-gui-helper
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hi all,
you should set $ENV{'LANG'} to 'c' or '' to get a usable output from
commands like ifconfig.
Regards,
Mario Wolff
