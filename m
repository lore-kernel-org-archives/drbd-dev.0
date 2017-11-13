Return-Path: <roland.kammerer@linbit.com>
Received: from mail-wr0-f195.google.com (mail-wr0-f195.google.com
	[209.85.128.195])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 66A641057580
	for <drbd-dev@lists.linbit.com>; Mon, 13 Nov 2017 13:47:07 +0100 (CET)
Received: by mail-wr0-f195.google.com with SMTP id j23so14304726wra.9
	for <drbd-dev@lists.linbit.com>; Mon, 13 Nov 2017 04:47:07 -0800 (PST)
Date: Mon, 13 Nov 2017 13:47:05 +0100
From: Roland Kammerer <roland.kammerer@linbit.com>
To: Nick Wang <nwang@suse.com>
Message-ID: <20171113124705.wykhbfe5ogczdkrv@rck.sh>
References: <20171107084305.22757-1-nwang@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171107084305.22757-1-nwang@suse.com>
Cc: Lars Ellenberg <lars.ellenberg@linbit.com>,
	Roland Kammerer <roland.kammerer@linbit.com>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] drbd-utils: Remove the hardcoded local5 of
	logfacility
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

On Tue, Nov 07, 2017 at 04:43:05PM +0800, Nick Wang wrote:
> It is able to override the loglevel with --logfacility 
> in crm-fence-peer.sh. However, in other scripts still 
> hardcoded to "local5.info". It is confusing only redirect 
> part of scripts.
> 
> Support --logfacility in notify.sh and snapshot-resync-target-lvm.sh

Hi Nick,

sorry for the long response time. I merged this in the hope it was
mainly copy/paste from existing scripts and does not break the existing
scripts as the are.

Thanks, rck
