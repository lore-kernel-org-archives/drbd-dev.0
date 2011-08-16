Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id D451A1056294
	for <drbd-dev@lists.linbit.com>; Tue, 16 Aug 2011 15:08:33 +0200 (CEST)
Date: Tue, 16 Aug 2011 15:08:33 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20110816130833.GD3975@barkeeper1-xen.linbit>
References: <4E3BA638.9000601@ii.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4E3BA638.9000601@ii.nl>
Subject: Re: [Drbd-dev] [PATCH] expand section on throughput tuning to
 highlight prime usecase of external metadata, florians comments applied,
 added section replacing metadata
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Fri, Aug 05, 2011 at 10:13:44AM +0200, Mrten wrote:
> Git and I do not jive, yet. Sorry for duplicate mails, sent by hand this time.
> 
> Mrten.
> 
> ---
>  users-guide/throughput.txt |   66 ++++++++++++++++++++++++++++++++++++++++++--
>  1 files changed, 63 insertions(+), 3 deletions(-)
> 
> diff --git a/users-guide/throughput.txt b/users-guide/throughput.txt
> index 1cdf1b7..dd32d56 100644
> --- a/users-guide/throughput.txt
> +++ b/users-guide/throughput.txt
> @@ -48,11 +48,12 @@ important to consider the following natural limitations:
> 
>  * DRBD throughput is limited by that of the raw I/O subsystem.
>  * DRBD throughput is limited by the available network bandwidth.
> +* DRBD throughput can possibly be limited by head seeks with '+meta-disk internal+'
> 
> -The _minimum_ between the two establishes the theoretical throughput
> -_maximum_ available to DRBD. DRBD then reduces that throughput maximum
> +The _minimum_ of the first two establishes the _maximum_ theoretical throughput
> +available to DRBD. DRBD then reduces that throughput maximum
>  by its additional throughput overhead, which can be expected to be
> -less than 3 percent.
> +less than 3 percent.
> 
>  * Consider the example of two cluster nodes containing I/O subsystems
>    capable of 200 MB/s throughput, with a Gigabit Ethernet link
> @@ -64,6 +65,18 @@ less than 3 percent.
>  * By contrast, if the I/O subsystem is capable of only 100 MB/s for
>    sustained writes, then it constitutes the bottleneck, and you would
>    be able to expect only 97 MB/s maximum DRBD throughput.
> +
> +* In case of +meta-disk+ internal and without a hardware write cache, DRBD
> +metadata updates to the <<s-activity-log,activity log>> can slow down write

I suggest to point out that this is for _linear streaming writes_,
which, once they leave the covered area, need one activity log
transaction every 4 MiB.

Other, more localized, usage patterns need less AL-transactions per
amount of changes, and are less impacted, or virtually not at all,
depending on the change rate and size of the working set, and the
size of the activity log.

The impact heavily depends on the overall AL-transaction latency, which
is why write cache enabled controllers do much better. Even better than
a dedicated disk, usually, which may no longer suffer from seek time,
but still has access and processing time up to two orders of magnitude
higher than a decent write cache.

> +throughput significantly. If a raw software RAID-0 device with rotational disks
> +is normally capable of 250 MB/s linear write throughput it is not an anomaly to
> +see writes of 70 MB/s with DRBD. This is purely caused by head seeks; data
> +writes have to be followed by activity log updates and data writes can only
> +continue after the meta data update has _reached the platters_. With RAID-0,
> +activity log updates can get concentrated on one harddrive, which is then
> +seeking most of the time instead of writing, lowering throughput. External meta
> +data on a different device (which is not on a disk used by the RAID-0 device)
> +can be used to mitigate this.
> 
>  [[s-throughput-tuning]]
>  === Tuning recommendations
> @@ -204,3 +217,50 @@ resource <resource> {
>    ...
>  }
>  ----------------------------
> +
> +[[s-tune-external-metadata]]
> +==== Moving meta-disk to external device
> +
> +WARNING: The recommended configuration is running with internal +meta-disk+.
> +With external meta data, when underlying storage dies the meta data does not
> +die with it, so special care should be taken. See <<s-external-meta-data,external meta data>>.
> +
> +With a software raid (md) of rotational media it is often faster to create the meta data on a
> +dedicated device.
> +
> +[source,drbd]
> +----------------------------
> +resource <resource> {
> +  disk {
> +    disk /dev/md3;
> +    flexible-meta-disk /dev/md4;
> +    ...
> +  }
> +  ...
> +}
> +----------------------------
> +
> +
> +To move meta-data from one device to another:
> +
> +Make sure the device is stopped:
> +----------------------------
> +drbdadm down [resource]
> +----------------------------
> +
> +Save a textual representation of the current meta data to a temporary file:
> +----------------------------
> +drbdadm dump-md [resource] > savefile
> +----------------------------
> +
> +Wipe the current meta data so that DRBD isn't confronted with it in a later stage:
> +----------------------------
> +drbdadm wipe-md [resource]
> +----------------------------
> +
> +Write the meta data to another device:
> +----------------------------
> +drbdmeta /dev/[drbd-device] v08 [new metadevice] 0 restore-md savefile

This is to use "index 0" of fixed-size external meta data, where each
such index uses up to 128 MiB of meta data,
thus supporting only up to 4 TiB of data.

You may want to instead say:
drbdmeta /dev/[drbd-device] v08 [new metadevice] flexible-external restore-md savefile

> +----------------------------
> +
> +Adjust your config, and start the device again.

Thanks,

	Lars
