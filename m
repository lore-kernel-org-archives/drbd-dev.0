Return-Path: <nwang@suse.com>
Received: from relay2.provo.novell.com (relay2.provo.novell.com
	[137.65.250.214])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 9B441104B1D2
	for <drbd-dev@lists.linbit.com>; Mon,  9 Mar 2015 09:14:19 +0100 (CET)
Message-Id: <54FDC6DF020000700004C043@relay2.provo.novell.com>
Date: Mon, 09 Mar 2015 02:14:22 -0600
From: "Nick Wang" <nwang@suse.com>
To: "Philipp Reisner" <philipp.reisner@linbit.com>, <drbd-dev@lists.linbit.com>
References: <54F893C4020000700004B720@relay2.provo.novell.com>
	<54F9776D020000700004B9CC@relay2.provo.novell.com>
	<54F9776D020000700004B9CC@relay2.provo.novell.com>
	<1487465.h977aYRqAU@fat-tyre>
In-Reply-To: <1487465.h977aYRqAU@fat-tyre>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Cc: Lars Marowsky-Bree <lmb@suse.com>
Subject: [Drbd-dev] =?utf-8?b?562U5aSN77yaIFJlOiAgUXVlcnlpbmcgdGhlIGRldmVs?=
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

Thanks for your hint about "new-current-uuid --clear-bitmap" 
to skip the sync. 

However the inconsistent date before a mkfs make the world 
not perfect. I will check whether zeroing out the peer devices 
before one goes to primary (and mkfs) is worth to implement, 
since zeroing a device also take some time and will do again 
during mkfs. If plan to do it, add "--discard-backing-devices"
to "new-current-uuid" and need a flag to write in metadata, 
since it only run on one node, it my understanding right?

One question about new-current-uuid. With two fresh devices 
(no current-uuid on both node), will new-current-uuid without the 
option --clear-bitmap do a full sync as well? 

Best regards,
Nick

>>> 在  7:20 下午 的 3/6/2015 上，在讯息 <1487465.h977aYRqAU@fat-tyre> 中，Philipp
Reisner <philipp.reisner@linbit.com> 写入：
> Hi Nick,
> 
> Please have a look at the new-current-uuid command of drbdsetup.
> I guess it can be used for the described use case of skipping
> the initial resync.
> 
> The only thing it does not do is a zero out of backing block
> device. If that is a requirement the right way to do is to
> implement the option --discard-backing-devices for the 
> new-current-uuid command.
> (Which tries to use discards, only if they are not available
>  will do a zero out)
> 
> 
> Here is the relevant excerpt from the drbdsetup man-page:
>    new-current-uuid
>        Generates a new current UUID and rotates all other UUID values. This
>        has at least two use cases, namely to skip the initial sync, and to
>        reduce network bandwidth when starting in a single node configuration
>        and then later (re-)integrating a remote site.
> 
>        Available option:
> 
>        --clear-bitmap
>            Clears the sync bitmap in addition to generating a new current
>            UUID.
> 
>        This can be used to skip the initial sync, if you want to start from
>        scratch. This use-case does only work on "Just Created" meta data.
>        Necessary steps:
> 
>         1. On both nodes, initialize meta data and configure the device.
> 
>            drbdadm create-md --force res
> 
>         2. They need to do the initial handshake, so they know their sizes.
> 
>            drbdadm up res
> 
>         3. They are now Connected Secondary/Secondary
>            Inconsistent/Inconsistent. Generate a new current-uuid and clear
>            the dirty bitmap.
> 
>            drbdadm new-current-uuid --clear-bitmap res
> 
>         4. They are now Connected Secondary/Secondary UpToDate/UpToDate. 
> Make
>            one side primary and create a file system.
> 
>            drbdadm primary res
> 
>            mkfs -t fs-type $(drbdadm sh-dev res)
> 
>        One obvious side-effect is that the replica is full of old garbage
>        (unless you made them identical using other means), so any
>        online-verify is expected to find any number of out-of-sync blocks.
> 
>        You must not use this on pre-existing data!  Even though it may appear
>        to work at first glance, once you switch to the other node, your data
>        is toast, as it never got replicated. So do not leave out the mkfs 
> (or
>        equivalent).
> 
> best regards,
>  Phil
> 
> > Hi,
> > 
> > DRBD is quite important and useful in SUSE HA product.
> > With the feedback from customer, the initial sync will took some time
> > even if no 'real' data has to be synced, especially with huge devices.
> > Although the DRBD device can be fully operational with performance
> > reduced before the initial synchronization has completed.
> > 
> > A method that can be used in SUSE HA 12 SP1 is under evaluation.
> > One draft idea is to set a "a zeroed device" flag in metadata when
> > using "drbdadm primary --force --<zeroed device flag> <res>",
> > then the secondary device can skip the data sync but zeroing the
> > device locally.
> > 
> > Comparing to the full sync, the data can be zerod without sync(only
> > metadata synced). And compare to only sync the metadata, there
> > is not necessary to the admin to guarantee all remote device are
> > zerod/new already.
> > 
> > Before starting to do it. I want to ask is there any plan of the similar
> > feature in upstream? And if not, can i work on it for both upstream
> > and SUSE?
> > 
> > Since I am not an expert of DRBD yet like you, any suggestion or idea
> > will be appreciate and helpful. Thanks in advanced.
> > 
> > # Since DRBD9 GM is not ready yet, the first target of
> > development is drbd.8.4.x
> > 
> > Best regards,
> > Nick
> > 
> > _______________________________________________
> > drbd-dev mailing list
> > drbd-dev@lists.linbit.com 
> > http://lists.linbit.com/mailman/listinfo/drbd-dev 
