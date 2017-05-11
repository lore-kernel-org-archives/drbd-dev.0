Return-Path: <axboe@kernel.dk>
Received: from mail-io0-f172.google.com (mail-io0-f172.google.com
	[209.85.223.172])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 0FEA5105633D
	for <drbd-dev@lists.linbit.com>; Thu, 11 May 2017 18:09:16 +0200 (CEST)
Received: by mail-io0-f172.google.com with SMTP id o12so24491439iod.3
	for <drbd-dev@lists.linbit.com>; Thu, 11 May 2017 09:09:16 -0700 (PDT)
To: Lars Ellenberg <lars.ellenberg@linbit.com>, linux-kernel@vger.kernel.org
References: <1494490906-19582-1-git-send-email-lars.ellenberg@linbit.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <6f667fb4-f536-6b1f-fc7a-aa846830294c@kernel.dk>
Date: Thu, 11 May 2017 10:03:14 -0600
MIME-Version: 1.0
In-Reply-To: <1494490906-19582-1-git-send-email-lars.ellenberg@linbit.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Peter Zijlstra <peterz@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Philipp Reisner <philipp.reisner@linbit.com>,
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

On 05/11/2017 02:21 AM, Lars Ellenberg wrote:
> Regression fix for 4.11, which totally broke DRBD
> 
> When killing kref_sub(), the unconditional additional kref_get()
> was not properly paired with the necessary kref_put(), causing
> a leak of struct drbd_requests (~ 224 Bytes) per submitted bio,
> and breaking DRBD in general, as the destructor of those "drbd_requests"
> does more than just the mempoll_free().

Ugh... Applied for this series. I'll mark it stable for 4.11.

-- 
Jens Axboe

