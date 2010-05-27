Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 7A1CF105EC9A
	for <drbd-dev@lists.linbit.com>; Thu, 27 May 2010 11:01:26 +0200 (CEST)
Date: Thu, 27 May 2010 11:01:25 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20100527090125.GC26213@soda.linbit>
References: <AANLkTim66dldWydThtZraIL6dqzVn0lxB1Q_chcOkkaa@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AANLkTim66dldWydThtZraIL6dqzVn0lxB1Q_chcOkkaa@mail.gmail.com>
Subject: Re: [Drbd-dev] DRBD + DM = EIO.
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Wed, May 26, 2010 at 12:21:27PM -0400, Ben Timby wrote:
> I posted a couple times to drbd-user, but I think this list is
> actually the correct forum for what I am experiencing. I will
> reiterate all the information have at this time below.
> 
> I have two matched machines. They have 15 SATA hard drives in a raid 5
> array. I am using LVM to split this array into two volumes. I am then
> using DRBD to replicate these two volumes. On top of DRBD, I have two
> more LVM volumes, on which I can create (replicated) snapshots. These
> volumes each contain a single file system which is ext4, the size is
> 10.84TB per volume.
> 
> The OS is CentOS 5.4, I am running DRBD 8.3.7, I built an RPM using
> the instructions provided in the DRBD users guide. I am using the
> 2.6.18-164.15.1.el5 kernel on an x86_64 processor.
> 
> I am intermittently receiving the following error in /var/log/messages:
> 
> -
> May 10 00:05:11 ragoon6 kernel: block drbd1: p read: error=-5
> -
> 
> I tracked this down to the function drbd_endio_pri, after this error
> occurs, DRBD goes into diskless mode, shovelling reads/writes to it's
> peer. Once in diskless mode, I no longer receive this error, but I
> can't run this way.
> 
> I removed DRBD from the mix, thus I have RAID -> LVM -> LVM -> EXT4,
> and I get no EIO errors.
> 
> I found that I can immediately trigger this error by starting a raid
> rebuild on the underlying array (while DRBD is in the stack). I do
> this by executing the weekly cron job that is part of the mdadm
> package on CentOS:
> 
> # /etc/cron.weekly/99-raid-check
> 
> I rebuilt the RPM and added a call to dump_stack() in the
> drbd_endio_pri function. Below is the stack trace.

> I just started walking the stack trace in my kernel sources to try to
> locate the issue. However, I am hopeful that a DRBD developer can help
> me to find the (I am assuming) bug in interaction between
> device-mapper and DRBD.

You most likely hit
http://git.drbd.org/?p=drbd-8.3.git;a=commitdiff;h=7fda00aacaf772253167d4ddb1eaa847862d6332;hp=3d36021c59c09e2bf37b82204b0df556de03ec0d

 :(

What is missing from that commit message is that a "failed"
(intentionally not served) READA will be considered
a real local IO error and cause DRBD to detach.

Hth,

-- 
: Lars Ellenberg
: LINBIT | Your Way to High Availability
: DRBD/HA support and consulting http://www.linbit.com

DRBD® and LINBIT® are registered trademarks of LINBIT, Austria.
