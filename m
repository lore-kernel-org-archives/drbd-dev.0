Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wr0-f179.google.com (mail-wr0-f179.google.com
	[209.85.128.179])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id F33501058015
	for <drbd-dev@lists.linbit.com>; Tue, 18 Jul 2017 10:22:36 +0200 (CEST)
Received: by mail-wr0-f179.google.com with SMTP id w4so17681702wrb.2
	for <drbd-dev@lists.linbit.com>; Tue, 18 Jul 2017 01:22:36 -0700 (PDT)
Received: from soda.linbit ([86.59.100.100])
	by smtp.gmail.com with ESMTPSA id i32sm4056949wra.5.2017.07.18.01.22.35
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 18 Jul 2017 01:22:35 -0700 (PDT)
Date: Tue, 18 Jul 2017 10:22:34 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20170718082217.GD4122@soda.linbit>
References: <20170718031615.18985-1-nwang@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170718031615.18985-1-nwang@suse.com>
Subject: Re: [Drbd-dev] [PATCH] drbdadm: Fix handler called from kernel
 always invalid for stacking resource
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

On Tue, Jul 18, 2017 at 11:16:15AM +0800, Nick Wang wrote:
>Handler like "before-resync-target" called from kernel
>space does not have "-S" option for stacking resource, it
>always return as invalid usage for stacking resource in
>normal mode, then the connection will be dropped. Add "-S"
>option for stacking resource automatically if the handler
>is called from kernel.

I think the intention was to no longer have stacked with 9,
stacked was a kludge anyways, because that was the only way
to add additional nodes with a two-node only replication.

That we did not patch it out was probably just being lazy.


-- 
: Lars Ellenberg
: LINBIT | Keeping the Digital World Running
: DRBD -- Heartbeat -- Corosync -- Pacemaker
: R&D, Integration, Ops, Consulting, Support

DRBD® and LINBIT® are registered trademarks of LINBIT
