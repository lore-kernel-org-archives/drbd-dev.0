Return-Path: <Lars.Ellenberg@linbit.com>
Received: from minna.local (dialin-145-254-052-240.arcor-ip.net
	[145.254.52.240])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 1E7FA14314
	for <drbd-dev@lists.linbit.com>; Thu, 21 Oct 2004 01:25:14 +0200 (CEST)
Date: Thu, 21 Oct 2004 01:13:14 +0200
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] user interface test of drbd.conf
Message-ID: <PYb2hAVM47FNy9iVUnme8JY=lge@web.de>
References: <41768F97.60206@wollmersdorfer.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41768F97.60206@wollmersdorfer.at>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

/ 2004-10-20 18:17:27 +0200
\ Helmut Wollmersdorfer:
> Version 0.7.5
> Method: drbdadm -d up all
> 
> 1) Problem report
> -----------------
> docu quote:
> | minor-count count
> |   count may be a number from 1 to 255.
> 
> count 	expected-result	test-result
> 1 	valid   	passed
> 0 	invalid   	failed
> -1 	invalid   	passed
> 255 	valid   	passed
> 256 	invalid   	failed
> 260 	invalid   	failed
> 
> Problem description: Parser accepts invalid values.
> (assumed) generic requirement: Invalid values should be reported as 
> error as near as possible to the interface. Invalid values should not 
> enter a system and cause errors in later steps, or other components, or 
> in worst case crash the system.

will fix that in drbdadm soonish.
though, the module does not load with invalid minor_count:

,- drbd/drbd_main.c
|	if (1 > minor_count||minor_count > 255) {
|		printk(KERN_ERR DEVICE_NAME
|			": invalid minor_count (%d)\n",minor_count);
|#ifdef MODULE
|		return -EINVAL;
|#else
|		minor_count = 8;
|#endif
|	}
`-

> 2) Problem report
> -----------------
> docu quote:
> wfc-timeout
> The sign is important.
> Always use a negative value, positive will (try to) force
> primary status, which is not what you want, if it  has  outdated
> data.  Default is 0, which means unlimited. Unit is seconds.

the current svn docu looks like this:

  wfc-timeout time
  Wait for connection timeout.
  The init script drbd(8) blocks the boot process
  until the DRBD resources are connected.
  This is so when the cluster manager starts later,
  it does not see a resource with internal split-brain.
  In case you want to limit the wait time, do it here.
  Default is 0, which means unlimited. Unit is seconds.
  
> 100000 valid passed
> 
> Problem description: Very high, maybe senseless values are accepted.

should we limit it to three days?

I don't get the next sentence:

> From my experience as tester I will not expect, that _any_ values will 
> work correctly without "dry-run".

hm?

> Same is true for other values in drbd.conf.


> BTW: An appropriate problem tracking system like bugzilla would be nice.

well, we have had a bugzilla, but we did not use it.
and it would be very fast very heavily out of date.
do you want to keep it up-to-date,
and kick Phillip or me every now and then?

	Lars Ellenberg
