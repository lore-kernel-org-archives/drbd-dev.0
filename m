Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 47EAA101AC71
	for <drbd-dev@lists.linbit.com>; Tue,  4 Mar 2014 15:19:15 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 39FB33257AB
	for <drbd-dev@lists.linbit.com>; Tue,  4 Mar 2014 15:19:15 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id fIedgm9P5uvn for <drbd-dev@lists.linbit.com>;
	Tue,  4 Mar 2014 15:19:15 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 13FED3257A5
	for <drbd-dev@lists.linbit.com>; Tue,  4 Mar 2014 15:19:15 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id eomFBlQeZN-V for <drbd-dev@lists.linbit.com>;
	Tue,  4 Mar 2014 15:19:14 +0100 (CET)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 042BB3254AD
	for <drbd-dev@lists.linbit.com>; Tue,  4 Mar 2014 15:19:13 +0100 (CET)
Resent-Message-ID: <20140304141912.GC11016@soda.linbit>
Received: from out3.rolmail.net (out3.rolmail.net [195.254.252.203])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 999581057D21
	for <drbd-dev@lists.linbit.com>; Fri, 26 Jul 2013 17:51:34 +0200 (CEST)
Message-ID: <51F29992.2000305@enas.net>
From: Urban Loesch <bind@enas.net>
MIME-Version: 1.0
To: Frank Steinborn <steinex@nognu.de>
References: <CANhLx2MO6aDsiTMmt-O4Fx8mmaF8QvNpC8WOBAT9-kfKEaQmVQ@mail.gmail.com>
In-Reply-To: <CANhLx2MO6aDsiTMmt-O4Fx8mmaF8QvNpC8WOBAT9-kfKEaQmVQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: drbd-dev@lists.linbit.com, 659762@bugs.debian.org
Subject: Re: [Drbd-dev] Bug#659762: lvm2: LVM commands freeze after snapshot
	delete fails
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
Date: Tue, 04 Mar 2014 14:19:15 -0000

Hi,

we had the same problems with Debian Wheezy, LVM2 and DRBD.
But this seems not DRBD related. It seems to be some problem between lvm and udevd.

See:
http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=549691

Stopping udevd before taking the snapshot and starting after removing the
snapshot solved the problem for us. It's only a workaround, but it works for us.

Regards
Urban


Am 26.07.2013 17:14, schrieb Frank Steinborn:
> Hi,
>
> we are a bit further in debugging this. We installed a DELL PowerEdge r620 (same hardware as used in our DRBD-cluster where this problem happens). As
> noone in this thread brought DRBD into play, I didn't expect any interaction with it related to this bug. However, we were not able to reproduce with
> just LVM2 (eg. configure LV, do IO in LV, remove LV, hang.)
>
> So we installed a second machine and put DRBD on top of the LVs. And voila, as soon as we create a snapshot of the LV where DRBD is on top and remove
> this snapshot it fails ca. 1/3 of the time.
>
> Some facts:
>
> root@drbd-primary:~# lvremove --force /dev/vg0/lv0-snap
>    Unable to deactivate open vg0-lv0--snap-cow (254:3)
>    Failed to resume lv0-snap.
>    libdevmapper exiting with 1 device(s) still suspended.
>
> After this, "dmsetup info" gives the following output:
>
> <<< snip >>>
>
> Name:              vg0-lv0--snap
> State:             ACTIVE
> Read Ahead:        256
> Tables present:    LIVE
> Open count:        0
> Event number:      0
> Major, minor:      254, 1
> Number of targets: 1
> UUID: LVM-M0Z897O16CAiYbSivOzgSn0M9Ae9TdoYy4WFhwy43CZA1g7zKFGF915pLAOIPvFZ
>
> Name:              vg0-lv0-real
> State:             ACTIVE
> Read Ahead:        0
> Tables present:    LIVE
> Open count:        1
> Event number:      0
> Major, minor:      254, 2
> Number of targets: 1
> UUID: LVM-M0Z897O16CAiYbSivOzgSn0M9Ae9TdoYC3ppjt1CZ3AcZR2hNz1VT5CHdM4RR32j-real
>
> Name:              vg0-lv0
> State:             SUSPENDED
> Read Ahead:        256
> Tables present:    LIVE & INACTIVE
> Open count:        2
> Event number:      0
> Major, minor:      254, 0
> Number of targets: 1
> UUID: LVM-M0Z897O16CAiYbSivOzgSn0M9Ae9TdoYC3ppjt1CZ3AcZR2hNz1VT5CHdM4RR32j
>
> Name:              vg0-lv0--snap-cow
> State:             ACTIVE
> Read Ahead:        0
> Tables present:    LIVE
> Open count:        0
> Event number:      0
> Major, minor:      254, 3
> Number of targets: 1
> UUID: LVM-M0Z897O16CAiYbSivOzgSn0M9Ae9TdoYy4WFhwy43CZA1g7zKFGF915pLAOIPvFZ-cow
>
> <<< snap >>>
>
> As you can see, the real LV with DRBD on top is now in state SUSPENDED - which causes the cluster to be non-functional as IO operations stall on both
> the primary and secondary node until one does "dmsetup resume /dev/vg0/lv0".
>
> Another interesting issue we've seen: after doing "dmsetup resume /dev/vg0/lv0", lv0-snap doesn't appear to be a snapshot anymore, given the output of
> lvs (lv0-snap has no origin anymore):
>
>    LV       VG   Attr     LSize   Pool Origin Data%  Move Log Copy%  Convert
>    lv0      vg0  -wi-ao-- 200.00g
>    lv0-snap vg0  -wi-a---  40.00g
>
>
> Some miscellaneous notes:
> * It _feels_ to only happen when the snapshot is filled at least something around 50-60%.
> * We can trigger something like this even without DRBD. When triggered however, the LV will never end up in SUSPENDED state and a second try of
> lvremove will always succeed.
>
> Thats all we have so far. I already had a private conversation with waldi@debian.org <mailto:waldi@debian.org> on this and we will (probably) provide
> him remote access on this system as soon as we have the setup reachable from the outside.
>
> Please let me know if I can provide any more information to get this fixed. I put drbd-dev in cc, maybe someone over there has an idea on this?
>
> @drbd-dev: system is debian wheezy, w/ drbd 8.3.11, lvm2 2.02.95.
>
> Thanks,
> Frank

