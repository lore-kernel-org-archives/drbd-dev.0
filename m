Return-Path: <lars.ellenberg@linbit.com>
Received: from racke.linbit (chello080108047253.34.11.vie.surfer.at
	[80.108.47.253])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 6C2642E05E95
	for <drbd-dev@lists.linbit.com>; Tue, 30 Sep 2008 22:10:16 +0200 (CEST)
Date: Tue, 30 Sep 2008 22:10:16 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Behaviour of verify: false positives -> true positives
Message-ID: <20080930201016.GB30030@racke>
References: <200809091602.31104.thomas.schoebel-theuer@1und1.de>
	<20080911092512.GC9756@soda.linbit>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20080911092512.GC9756@soda.linbit>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Thu, Sep 11, 2008 at 11:25:12AM +0200, Lars Ellenberg wrote:
> On Tue, Sep 09, 2008 at 04:02:30PM +0200, schoebel wrote:

...

> > Now I am reasoning on different solutions. Please comment.
> > 
> > Here are just some brainstorming ideas, without judging on their quality (this 
> > will come later):

...

> how about holding a ring buffer of pinned pages,
> say "drbd max-buffer" pages plus some,
> and in drbd_make_request,
> memcpy(ring buffer, submitted data)
> then checksum that,
> and submit it to localdisk as well as to tcp stack.
> as these are now "private" data buffers,
> the "application" cannot possibly modify them in-flight.

have you made any progress on that matter?

shall we further discuss whether or not it should be "fixed" (in drbd),
and if so, how?

or have you decided to just move a long?

-- 
: Lars Ellenberg                
: LINBIT | Your Way to High Availability
: DRBD/HA support and consulting http://www.linbit.com

DRBD® and LINBIT® are registered trademarks of LINBIT, Austria.
__
please don't Cc me, but send to list   --   I'm subscribed
