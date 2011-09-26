Return-Path: <gld-drbd-dev@m.gmane.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id B451010556B9
	for <drbd-dev@lists.linbit.com>; Mon, 26 Sep 2011 14:45:43 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gld-drbd-dev@m.gmane.org>) id 1R8AZ2-0008SB-KM
	for drbd-dev@lists.linbit.com; Mon, 26 Sep 2011 14:45:40 +0200
Received: from barriere.frankfurter-softwarefabrik.de ([217.11.197.1])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <drbd-dev@lists.linbit.com>; Mon, 26 Sep 2011 14:45:40 +0200
Received: from lvml by barriere.frankfurter-softwarefabrik.de with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <drbd-dev@lists.linbit.com>; Mon, 26 Sep 2011 14:45:40 +0200
To: drbd-dev@lists.linbit.com
From: Lutz Vieweg <lvml@5t9.de>
Date: Mon, 26 Sep 2011 14:45:25 +0200
Message-ID: <j5ps55$u46$1@dough.gmane.org>
References: <201108241641.42676.philipp.reisner@linbit.com>
	<j5hkl1$o4o$1@dough.gmane.org>
	<20110923141820.GD11992@barkeeper1-xen.linbit>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
In-Reply-To: <20110923141820.GD11992@barkeeper1-xen.linbit>
Subject: Re: [Drbd-dev] [GIT PULL] drbd-8.4 for mainline
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On 09/23/2011 04:18 PM, Lars Ellenberg wrote:
> On Fri, Sep 23, 2011 at 11:48:17AM +0200, Lutz Vieweg wrote:
>> On 08/24/2011 04:41 PM, Philipp Reisner wrote:
>>>    This release brings a new meta-data format. Forward (8.3 ->   8.4)
>>>    conversion happens complete seamless.
>>
>> Well, it may happen seamless unless you reboot the machine before
>> it has completed the resyncing with the other (still 8.3 running)
>> machine.
>>
>> I happened to require yet some other kernel setting (unrelated to DRBD),
>> installed the changed kernel, while one DRBD resource was still syncing
>> (for the first time after upgrading to 8.4), and rebooted (clean shutdown/restart).
>>
>> After the reboot, DRBD complained about not finding valid meta data
>> on the device, and I had to write new metadata and perform a full sync
>> to rectify the situation.
>
> You probably had 8.4 userland already, but 8.3 module loaded still?

Sort of... the sequence was:
- installed CentOS 6 (which comes with some ancient standard kernel)
- installed drbd-8.4 user-land tools
- reboot 1
- installed linux-3.0.3 + drbd-kernel-module
- reboot 2
- re-installed linux-3.0.3 + drbd-kernel-module
- reboot 3 (while DRBD-sync still in progress)
=== at this point the drbd-meta data was said to be corrupt

> If you then unload the 8.3 module (no more /proc/drbd),
> then do "drbdadm apply-al all".  That should "fix" it.

Too late for that now :-)

> Otherwise, please tell us how to reproduce, and we will figure out what
> needs to be improved during the upgrade/downgrade paths.

Since this was happening just the one time during the upgrade,
I wouldn't dare to say this is highly reproducable.

But I wanted to warn those who might plan for upgrading both
machines of a DRBD-cluster at the same time... this could have
resulted in a loss of data, if the above happened on both sides.

Regards,

Lutz Vieweg

