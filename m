Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 8DE6B101707D
	for <drbd-dev@lists.linbit.com>; Thu,  7 Mar 2013 10:31:37 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id 800CF1B4372
	for <drbd-dev@lists.linbit.com>; Thu,  7 Mar 2013 10:31:37 +0100 (CET)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 71vfQL5UfdCa for <drbd-dev@lists.linbit.com>;
	Thu,  7 Mar 2013 10:31:37 +0100 (CET)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id 5F9B51B4369
	for <drbd-dev@lists.linbit.com>; Thu,  7 Mar 2013 10:31:37 +0100 (CET)
Date: Thu, 7 Mar 2013 10:31:37 +0100
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20130307093137.GA21005@soda.linbit>
References: <1963827.4HPAHhzfUk@itsj>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1963827.4HPAHhzfUk@itsj>
Subject: Re: [Drbd-dev] DRBD 8.4.3 : create-md possibly broken for fixed
 sized (shared) meta devices
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Wed, Mar 06, 2013 at 03:24:36PM +0100, Tijs Van Buggenhout wrote:
> Hi,
> 
> I recently installed drbd 8.4.3 packages and ran into problems when trying to 
> create a drbd resource using fixed size drbd meta device ided by an index. 
> Investigating further, it seems that when using a flexible meta disk, there is 
> no problem whatsoever.
> I also used the same configuration file/set of commands on the previous 
> version (8.4.2) for fixed size meta-disk, which worked without problems.
> 
> The following excerpt from the console log shows how I first create a drbd 
> resource (drbd0) with flexible meta disk (/dev/lv/drbd-meta-84). Afterwards I 
> undo the configuration, and try to do the same for fixed drbd meta disk, which 
> fails (every time). Then I roll back to the previous version of drbd 
> utils/module, and try the setup with fixed drbd meta disk again, which 
> succeeds.

> resource drbd0 {
>         on master.domain.com {
>                 device /dev/drbd0;
>                 disk /dev/lv/data;
>                 address 172.16.1.179:7788;
>                 meta-disk /dev/lv/drbd-meta-84 [0];

> (master.domain.com):~# dd if=/dev/zero of=/dev/lv/drbd-meta-84 bs=$[1024*1024] 
> (master.domain.com):~# modprobe drbd
> (master.domain.com):~# cat /proc/drbd 
> version: 8.4.3 (api:1/proto:86-101)
> GIT-hash: 89a294209144b68adb3ee85a73221f964d3ee515 build by root@build, 
> 2013-03-05 15:10:01
> (master.domain.com):~# drbdsetup new-resource drbd0
> (master.domain.com):~# drbdsetup new-minor drbd0 /dev/drbd0 0
> (master.domain.com):~# drbdadm create-md drbd0 -vvvvvvvvvv
> (master.domain.com):~# drbdadm attach drbd0
> 0: Failure: (119) No valid meta-data signature found.
> 
>         ==> Use 'drbdadm create-md res' to initialize meta-data area. <==

D'oh.
That is embarrassing.

I wonder why the regression tests using "old style indexed fixed size
external meta data" have not been exercised.

http://git.drbd.org/gitweb.cgi?p=drbd-8.4.git;a=commitdiff;h=82cf5feada2e4d0f536af5f6f377bd0f3fac1236

Thanks,

-- 
: Lars Ellenberg
: LINBIT | Your Way to High Availability
: DRBD/HA support and consulting http://www.linbit.com

DRBD® and LINBIT® are registered trademarks of LINBIT, Austria.
