Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wm0-f51.google.com (mail-wm0-f51.google.com [74.125.82.51])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id ACB6D105633D
	for <drbd-dev@lists.linbit.com>; Thu, 11 May 2017 14:05:17 +0200 (CEST)
Received: by mail-wm0-f51.google.com with SMTP id u65so37425599wmu.1
	for <drbd-dev@lists.linbit.com>; Thu, 11 May 2017 05:05:17 -0700 (PDT)
Received: from soda.linbit ([86.59.100.100]) by smtp.gmail.com with ESMTPSA id
	y16sm2307685wry.46.2017.05.11.05.05.14
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 11 May 2017 05:05:14 -0700 (PDT)
Resent-Message-ID: <20170511120510.GL28116@soda.linbit>
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id A9CAC1056320
	for <drbd-dev@lists.linbit.com>; Thu, 11 May 2017 11:05:33 +0200 (CEST)
Date: Thu, 11 May 2017 10:29:48 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Lars Ellenberg <lars.ellenberg@linbit.com>
Message-ID: <20170511082948.wfzuh5coviinyul3@hirez.programming.kicks-ass.net>
References: <1494490906-19582-1-git-send-email-lars.ellenberg@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1494490906-19582-1-git-send-email-lars.ellenberg@linbit.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, Philipp Reisner <philipp.reisner@linbit.com>,
	Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	"Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] drbd: fix request leak introduced by
 locking/atomic, kref: Kill kref_sub()
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

On Thu, May 11, 2017 at 10:21:46AM +0200, Lars Ellenberg wrote:
> Regression fix for 4.11, which totally broke DRBD
> 
> When killing kref_sub(), the unconditional additional kref_get()
> was not properly paired with the necessary kref_put(), causing
> a leak of struct drbd_requests (~ 224 Bytes) per submitted bio,
> and breaking DRBD in general, as the destructor of those "drbd_requests"
> does more than just the mempoll_free().
> 
> Fixes: bdfafc4ffdd2 ("locking/atomic, kref: Kill kref_sub()")
> Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>

Dang, sorry about that. Thanks for fixing it.
