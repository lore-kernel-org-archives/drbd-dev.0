Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wr0-f172.google.com (mail-wr0-f172.google.com
	[209.85.128.172])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id F3F381057315
	for <drbd-dev@lists.linbit.com>; Wed,  4 Apr 2018 12:42:29 +0200 (CEST)
Received: by mail-wr0-f172.google.com with SMTP id y55so21835244wry.3
	for <drbd-dev@lists.linbit.com>; Wed, 04 Apr 2018 03:42:29 -0700 (PDT)
Received: from soda.linbit ([86.59.100.100]) by smtp.gmail.com with ESMTPSA id
	p14sm10801597wrc.30.2018.04.04.03.37.26
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 04 Apr 2018 03:37:26 -0700 (PDT)
Date: Wed, 4 Apr 2018 12:37:26 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20180404103726.GD16420@soda.linbit>
References: <aaa4fb1a-2659-9b88-3304-08660d012818@pscome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aaa4fb1a-2659-9b88-3304-08660d012818@pscome.com>
Subject: Re: [Drbd-dev] DRBD Bug Report : DRBD 9.0 after-resync-target not
 being called after resync / reconnect
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

On Wed, Apr 04, 2018 at 10:04:49AM +0300, Farhan Khan wrote:
> Hello, I would like to report a bug:
> 
> Scenario:
> - 2 nodes running as primary and secondary on CentOS 7.4 with pacemaker and
> corosync with dedicated link Gigabit link between nodes
> 
> Bug description and replication:
> - Disconnect the link between nodes
>      --> fence-peer is called and secondary node is correctly fenced
> - Do not write any new data to primary while the link is broken
> -Reconnect the link
>      --> nodes reconnect and re-sync correctly
>      --> after-resync-target is NOT called and location constraint remains

Becaquse it likely did not sync anything, because there was nothing to
sync, it did not become sync target, so there was nothing to do for an
"after" resync target handler?

You should use the "unfence-peer" handler to unfence.

-- 
: Lars Ellenberg
: LINBIT | Keeping the Digital World Running
: DRBD -- Heartbeat -- Corosync -- Pacemaker
: R&D, Integration, Ops, Consulting, Support

DRBD® and LINBIT® are registered trademarks of LINBIT
