Return-Path: <axboe@suse.de>
Received: from virtualhost.dk (ns.virtualhost.dk [195.184.98.160])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id E67781431F
	for <drbd-dev@lists.linbit.com>; Mon, 24 Jan 2005 09:24:45 +0100 (CET)
Date: Mon, 24 Jan 2005 09:24:34 +0100
From: Jens Axboe <axboe@suse.de>
To: Lars Marowsky-Bree <lmb@suse.de>
Message-ID: <20050124082433.GB2820@suse.de>
References: <20050123161633.GH24350@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050123161633.GH24350@marowsky-bree.de>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] Re: drbd uses wrong API for struct bio
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Sun, Jan 23 2005, Lars Marowsky-Bree wrote:
> Hi all,
> 
> drbd is a quite bad offender for using bio's on stack or embedded in
> other internal structs instead of the pointer interface.
> 
> The attached patch shows the 'right' way as an example, which was
> pretty easy because I could use Jens' patch for md with minimal
> modifications ;-) However, the other offending code lines are within
> the transfer log and other places, and I'm not sure Philipp wants me
> to mess around with that.

Patch looks fine, I'm sad to say that if drdb was just in the kernel
source this would have been found in time...

> Jens, on chip.suse.de:/local/lmb/drbd-07/drbd/ you can find the most
> recent drbd kernel code. Could you look over drbd_compat_wrappers.h
> line 326ff in particular and give me a rough rundown of what's broken?
> We need to fix this by Tuesday latest :-(

Sure, will do so this morning.

-- 
Jens Axboe

