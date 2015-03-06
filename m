Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 74DBB1011B9B
	for <drbd-dev@lists.linbit.com>; Fri,  6 Mar 2015 12:20:20 +0100 (CET)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Date: Fri, 06 Mar 2015 12:20:19 +0100
Message-ID: <1487465.h977aYRqAU@fat-tyre>
In-Reply-To: <54F9776D020000700004B9CC@relay2.provo.novell.com>
References: <54F893C4020000700004B720@relay2.provo.novell.com>
	<54F9776D020000700004B9CC@relay2.provo.novell.com>
	<54F9776D020000700004B9CC@relay2.provo.novell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Cc: Lars Marowsky-Bree <lmb@suse.com>
Subject: Re: [Drbd-dev] Querying the devel plan of speed up initial sync of
	new and empty devices
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

Please have a look at the new-current-uuid command of drbdsetup.
I guess it can be used for the described use case of skipping
the initial resync.

The only thing it does not do is a zero out of backing block
device. If that is a requirement the right way to do is to
implement the option --discard-backing-devices for the 
new-current-uuid command.
(Which tries to use discards, only if they are not available
 will do a zero out)


Here is the relevant excerpt from the drbdsetup man-page:
   new-current-uuid
       Generates a new current UUID and rotates all other UUID values. This
       has at least two use cases, namely to skip the initial sync, and to
       reduce network bandwidth when starting in a single node configuration
       and then later (re-)integrating a remote site.

       Available option:

       --clear-bitmap
           Clears the sync bitmap in addition to generating a new current
           UUID.

       This can be used to skip the initial sync, if you want to start from
       scratch. This use-case does only work on "Just Created" meta data.
       Necessary steps:

        1. On both nodes, initialize meta data and configure the device.

           drbdadm create-md --force res

        2. They need to do the initial handshake, so they know their sizes.

           drbdadm up res

        3. They are now Connected Secondary/Secondary
           Inconsistent/Inconsistent. Generate a new current-uuid and clear
           the dirty bitmap.

           drbdadm new-current-uuid --clear-bitmap res

        4. They are now Connected Secondary/Secondary UpToDate/UpToDate. Make
           one side primary and create a file system.

           drbdadm primary res

           mkfs -t fs-type $(drbdadm sh-dev res)

       One obvious side-effect is that the replica is full of old garbage
       (unless you made them identical using other means), so any
       online-verify is expected to find any number of out-of-sync blocks.

       You must not use this on pre-existing data!  Even though it may appear
       to work at first glance, once you switch to the other node, your data
       is toast, as it never got replicated. So do not leave out the mkfs (or
       equivalent).

best regards,
 Phil

> Hi,
> 
> DRBD is quite important and useful in SUSE HA product.
> With the feedback from customer, the initial sync will took some time
> even if no 'real' data has to be synced, especially with huge devices.
> Although the DRBD device can be fully operational with performance
> reduced before the initial synchronization has completed.
> 
> A method that can be used in SUSE HA 12 SP1 is under evaluation.
> One draft idea is to set a "a zeroed device" flag in metadata when
> using "drbdadm primary --force --<zeroed device flag> <res>",
> then the secondary device can skip the data sync but zeroing the
> device locally.
> 
> Comparing to the full sync, the data can be zerod without sync(only
> metadata synced). And compare to only sync the metadata, there
> is not necessary to the admin to guarantee all remote device are
> zerod/new already.
> 
> Before starting to do it. I want to ask is there any plan of the similar
> feature in upstream? And if not, can i work on it for both upstream
> and SUSE?
> 
> Since I am not an expert of DRBD yet like you, any suggestion or idea
> will be appreciate and helpful. Thanks in advanced.
> 
> # Since DRBD9 GM is not ready yet, the first target of
> development is drbd.8.4.x
> 
> Best regards,
> Nick
> 
> _______________________________________________
> drbd-dev mailing list
> drbd-dev@lists.linbit.com
> http://lists.linbit.com/mailman/listinfo/drbd-dev

