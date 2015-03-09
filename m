Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 779561011B9B
	for <drbd-dev@lists.linbit.com>; Mon,  9 Mar 2015 16:11:17 +0100 (CET)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Nick Wang <nwang@suse.com>
Date: Mon, 09 Mar 2015 16:11:16 +0100
Message-ID: <2835660.5HzbWRi9pB@fat-tyre>
In-Reply-To: <54FDC6DF020000700004C043@relay2.provo.novell.com>
References: <54F893C4020000700004B720@relay2.provo.novell.com>
	<1487465.h977aYRqAU@fat-tyre>
	<54FDC6DF020000700004C043@relay2.provo.novell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Cc: Lars Marowsky-Bree <lmb@suse.com>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev]
	=?utf-8?b?562U5aSN77yaIFJlOiAgUXVlcnlpbmcgdGhlIGRldmVs?=
	=?utf-8?q?_plan_of_speed_up_initial_sync_of_new_and_empty_devices?=
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

Hi Nick,

FYI: I do not know a mkfs that zeros out the block device.
All mkfs.XXX I know only write a few blocks of a block device.
The super block, block group descriptors, a journal...

..onyl if the device supports discard (SSDs, thinly provisioned
storage) e.g. mkfs.ext4 uses that to discard the block device.

The remaining question is if it is worth the trouble to do it
in DRBD as well? -- BTW, you will not need to implement a
flag in the meta-data, but you need to ship such a flag
in the protocol...

best regards,
 Phil

> Hello Philipp,
> 
> Thanks for your hint about "new-current-uuid --clear-bitmap"
> to skip the sync.
> 
> However the inconsistent date before a mkfs make the world
> not perfect. I will check whether zeroing out the peer devices
> before one goes to primary (and mkfs) is worth to implement,
> since zeroing a device also take some time and will do again
> during mkfs. If plan to do it, add "--discard-backing-devices"
> to "new-current-uuid" and need a flag to write in metadata,
> since it only run on one node, it my understanding right?
> 
> One question about new-current-uuid. With two fresh devices
> (no current-uuid on both node), will new-current-uuid without the
> option --clear-bitmap do a full sync as well?
> 
> Best regards,
> Nick
> 
