Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 5502C10556BB
	for <drbd-dev@lists.linbit.com>; Mon,  5 Sep 2011 10:51:26 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Date: Mon, 5 Sep 2011 10:51:17 +0200
References: <BAY165-W48FA9D87FF3A44D0B3D391CB250@phx.gbl>
In-Reply-To: <BAY165-W48FA9D87FF3A44D0B3D391CB250@phx.gbl>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201109051051.17465.philipp.reisner@linbit.com>
Subject: Re: [Drbd-dev] How DRBD uses active log to recovery from a crash in
	8.4.0
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Freitag, 12. August 2011, 08:12:32 schrieb ShenQiyu:
> Dear sir,
> 
> When learning and testing DRBD 8.4.0, I could not find where it applies
> active log to bitmap when up a resource after a crash.
> 
> While DRBD 8.3.9 do it in drbd_nl_disk_conf()  calls drbd_al_read_log(),
> then drbd_al_apply_to_bm().
> 
> So, is there anything I have not caught up? The code is download from
> http://oss.linbit.com/drbd/8.4/drbd-8.4.0.tar.gz
> 
> Any hints are very appreciated!
> 

That moved to user space. See the "apply-al" sub-command of drbdadm.

Best,
 Phil
-- 
: Dipl-Ing Philipp Reisner
: LINBIT | Your Way to High Availability
: Tel: +43-1-8178292-50, Fax: +43-1-8178292-82
: http://www.linbit.com

DRBD(R) and LINBIT(R) are registered trademarks of LINBIT, Austria.
