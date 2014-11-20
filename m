Return-Path: <htejun@gmail.com>
Received: from mail-qa0-f54.google.com (mail-qa0-f54.google.com
	[209.85.216.54]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id E34ED1028A4A
	for <drbd-dev@lists.linbit.com>; Thu, 20 Nov 2014 16:38:47 +0100 (CET)
Received: by mail-qa0-f54.google.com with SMTP id i13so2041999qae.41
	for <drbd-dev@lists.linbit.com>; Thu, 20 Nov 2014 07:38:44 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 20 Nov 2014 10:38:41 -0500
From: Tejun Heo <tj@kernel.org>
To: Jan Kara <jack@suse.cz>
Message-ID: <20141120153841.GF14877@htj.dyndns.org>
References: <1416299848-22112-1-git-send-email-tj@kernel.org>
	<1416299848-22112-2-git-send-email-tj@kernel.org>
	<20141120152702.GF2330@quack.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141120152702.GF2330@quack.suse.cz>
Cc: axboe@kernel.dk, Mike Snitzer <snitzer@redhat.com>,
	Neil Brown <neilb@suse.de>, linux-kernel@vger.kernel.org,
	Wu Fengguang <fengguang.wu@intel.com>,
	Alasdair Kergon <agk@redhat.com>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 01/10] writeback: move
 backing_dev_info->state into bdi_writeback
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

Hello, Jan.

On Thu, Nov 20, 2014 at 04:27:02PM +0100, Jan Kara wrote:
>   Hum, does it make sense to convert BDI_sync_congested and
> BDI_async_congested? It contains information whether the *device* is
> congested and cannot take more work. I understand that in a cgroup world

Yeah, I mean, with cgroup writeback, the device itself doesn't matter.
The only thing writeback sees is that cgroup's slice of the device
whose congestion status can be independent from other slices of the
device.

> you want to throttle IO from a cgroup to a device so when you take
> bdi_writeback to be a per-cgroup structure you want some indication there
> that a particular cgroup cannot push more to the device. But is it that
> e.g. mdraid cares about a cgroup and not about the device?

I didn't update mdraid to support cgroup writeback yet but it depends
on how it's implemented.  If it just transmits back the pressure from
individual underlying cgroup split devices, it's the same.  If we
wanna put blkcg splitting in front of mdraid and keep the backend side
clear of cgroup splitting, it'd just send down everything as belonging
to the root cgroup.

Thanks.

-- 
tejun
