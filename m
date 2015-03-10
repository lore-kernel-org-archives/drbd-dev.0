Return-Path: <nwang@suse.com>
Received: from relay2.provo.novell.com (relay2.provo.novell.com
	[137.65.250.214])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 0FFB51050584
	for <drbd-dev@lists.linbit.com>; Tue, 10 Mar 2015 04:40:29 +0100 (CET)
Message-Id: <54FED842020000700004C399@relay2.provo.novell.com>
Date: Mon, 09 Mar 2015 21:40:50 -0600
From: "Nick Wang" <nwang@suse.com>
To: "Philipp Reisner" <philipp.reisner@linbit.com>
References: <54F893C4020000700004B720@relay2.provo.novell.com>
	<1487465.h977aYRqAU@fat-tyre>
	<54FDC6DF020000700004C043@relay2.provo.novell.com>
	<2835660.5HzbWRi9pB@fat-tyre>
In-Reply-To: <2835660.5HzbWRi9pB@fat-tyre>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
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

Hello Philipp,

Thanks for your information.
i was wrong.mkfs don't zero out the device, otherwise it won't 
perform that fast.

It is no harm for inconsistent date if don't touch it,  i still need to 
evaluate the benefit of implement the option to customer. It should 
faster than full sync (without checksum-based), but still need quite 
a long time for the large disk. 

Thanks & Best regards,
Nick

>>> 在 23:11 的 2015-3-9 上，在讯息 <2835660.5HzbWRi9pB@fat-tyre> 中，Philipp
Reisner <philipp.reisner@linbit.com> 写入：
> Hi Nick,
> 
> FYI: I do not know a mkfs that zeros out the block device.
> All mkfs.XXX I know only write a few blocks of a block device.
> The super block, block group descriptors, a journal...
> 
> ..onyl if the device supports discard (SSDs, thinly provisioned
> storage) e.g. mkfs.ext4 uses that to discard the block device.
> 
> The remaining question is if it is worth the trouble to do it
> in DRBD as well? -- BTW, you will not need to implement a
> flag in the meta-data, but you need to ship such a flag
> in the protocol...
> 
> best regards,
>  Phil 
