Return-Path: <SRS0=6An1=25=goodmis.org=rostedt@kernel.org>
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 8FCA14203BD
	for <drbd-dev@lists.linbit.com>; Fri, 28 Oct 2022 16:30:15 +0200 (CEST)
Date: Fri, 28 Oct 2022 10:30:28 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Jens Axboe <axboe@kernel.dk>
Message-ID: <20221028103028.636072e3@gandalf.local.home>
In-Reply-To: <9bb423f8-5910-494d-2522-2fcf8e41c2e4@kernel.dk>
References: <20221027150525.753064657@goodmis.org>
	<20221027150925.819019339@goodmis.org>
	<20221027111944.39b3a80c@gandalf.local.home>
	<Y1uSG/7VXWLNlxlt@infradead.org>
	<20221028062414.7859f787@gandalf.local.home>
	<60b91c39-1e54-ac8b-5e9e-db7e46ca2d60@kernel.dk>
	<20221028100656.00a4d537@gandalf.local.home>
	<9bb423f8-5910-494d-2522-2fcf8e41c2e4@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Lars, linux-block@vger.kernel.org, Christoph,
	Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Christoph Hellwig <hch@infradead.org>, Tejun Heo <tj@kernel.org>,
	cgroups@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Ellenberg <lars.ellenberg@linbit.com>,
	Guenter Roeck <linux@roeck-us.net>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [RFC][PATCH v2 04/31] timers: block: Use
 del_timer_shutdown() before freeing timer
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <https://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <https://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Fri, 28 Oct 2022 08:11:27 -0600
Jens Axboe <axboe@kernel.dk> wrote:

> This is pretty common for tree wide changes. The relevant lists need
> to see the full context, patch 4/31 by itself is useless and may as well
> not be sent at this point then.

Ah, I didn't think about just including the mailing lists. The Cc lists
were auto-generated, and I didn't think about just taking out the lists.

Will do that for v2.

Thanks,

-- Steve
