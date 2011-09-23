Return-Path: <gld-drbd-dev@m.gmane.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 365E610556C5
	for <drbd-dev@lists.linbit.com>; Fri, 23 Sep 2011 12:20:18 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gld-drbd-dev@m.gmane.org>) id 1R72d1-0003Le-Ni
	for drbd-dev@lists.linbit.com; Fri, 23 Sep 2011 12:05:07 +0200
Received: from barriere.frankfurter-softwarefabrik.de ([217.11.197.1])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <drbd-dev@lists.linbit.com>; Fri, 23 Sep 2011 12:05:07 +0200
Received: from lvml by barriere.frankfurter-softwarefabrik.de with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <drbd-dev@lists.linbit.com>; Fri, 23 Sep 2011 12:05:07 +0200
To: drbd-dev@lists.linbit.com
From: Lutz Vieweg <lvml@5t9.de>
Date: Fri, 23 Sep 2011 11:48:17 +0200
Message-ID: <j5hkl1$o4o$1@dough.gmane.org>
References: <201108241641.42676.philipp.reisner@linbit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
In-Reply-To: <201108241641.42676.philipp.reisner@linbit.com>
Subject: Re: [Drbd-dev] [GIT PULL] drbd-8.4 for mainline
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On 08/24/2011 04:41 PM, Philipp Reisner wrote:
>    This release brings a new meta-data format. Forward (8.3 ->  8.4)
>    conversion happens complete seamless.

Well, it may happen seamless unless you reboot the machine before
it has completed the resyncing with the other (still 8.3 running)
machine.

I happened to require yet some other kernel setting (unrelated to DRBD),
installed the changed kernel, while one DRBD resource was still syncing
(for the first time after upgrading to 8.4), and rebooted (clean shutdown/restart).

After the reboot, DRBD complained about not finding valid meta data
on the device, and I had to write new metadata and perform a full sync
to rectify the situation.

(Luckily, since the other machine was still running, so no data was lost
in the process.)

Regards,

Lutz Vieweg

