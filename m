Return-Path: <Lars.Ellenberg@linbit.com>
Received: from minna.local (dialin-145-254-052-187.arcor-ip.net
	[145.254.52.187])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 6610914347
	for <drbd-dev@lists.linbit.com>; Mon, 25 Oct 2004 23:01:46 +0200 (CEST)
Date: Mon, 25 Oct 2004 22:59:04 +0200
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <oQ8h+tLc53xtaV2FSuXHvMc=lge@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Drbd-dev] range checks in drbdadm and drbdsetup
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>


have a look at my most recent svn checkin.

added
  user/drbd_limits.h
to be able to give better diagnostics for nonsensical configuration.

please review my choice of ranges.

Helmut, please "stress"
  drbdadm -c some.conf dump 
a little :)

this patch makes drbdadm and drbdsetup a little bit noisy on stderr,
until this is settled; then we
  #define DEBUG_RANGE_CHECK 0
and are happy again.

	lge
