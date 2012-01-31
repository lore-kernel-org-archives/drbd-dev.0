Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 437F5105570F
	for <drbd-dev@lists.linbit.com>; Tue, 31 Jan 2012 11:02:18 +0100 (CET)
Date: Tue, 31 Jan 2012 11:02:15 +0100
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20120131100215.GI31519@barkeeper1-xen.linbit>
References: <CAPkhwwRYNwmv7B--Whaz8Nrpfc9XDMxqVw8J5V8qObfroVF2qw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPkhwwRYNwmv7B--Whaz8Nrpfc9XDMxqVw8J5V8qObfroVF2qw@mail.gmail.com>
Subject: Re: [Drbd-dev] Why does resync-cache uses LRU, rather than a queue,
 as its mechanism.
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Sun, Jan 29, 2012 at 09:23:12AM +0800, carlos_wang wrote:
> Hi all:
>         I got a problem in understanding why resync-cache uses LRU as its
> mechanism. I think that a queue is enough to realize the LRU functions. Why
> does it use LRU anyway?

Blocks may be "resynced" by new application writes as well.


-- 
: Lars Ellenberg
: LINBIT | Your Way to High Availability
: DRBD/HA support and consulting http://www.linbit.com
