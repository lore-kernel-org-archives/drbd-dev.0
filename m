Return-Path: <axboe@kernel.dk>
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com
	[209.85.166.174])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 855FD420671
	for <drbd-dev@lists.linbit.com>; Fri, 28 Oct 2022 15:56:53 +0200 (CEST)
Received: by mail-il1-f174.google.com with SMTP id z9so2969465ilu.10
	for <drbd-dev@lists.linbit.com>; Fri, 28 Oct 2022 06:56:53 -0700 (PDT)
Message-ID: <60b91c39-1e54-ac8b-5e9e-db7e46ca2d60@kernel.dk>
Date: Fri, 28 Oct 2022 07:56:50 -0600
MIME-Version: 1.0
Content-Language: en-US
To: Steven Rostedt <rostedt@goodmis.org>, Christoph Hellwig <hch@infradead.org>
References: <20221027150525.753064657@goodmis.org>
	<20221027150925.819019339@goodmis.org>
	<20221027111944.39b3a80c@gandalf.local.home>
	<Y1uSG/7VXWLNlxlt@infradead.org>
	<20221028062414.7859f787@gandalf.local.home>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20221028062414.7859f787@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-block@vger.kernel.org, Tejun Heo <tj@kernel.org>,
	cgroups@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
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

On 10/28/22 4:24 AM, Steven Rostedt wrote:
> On Fri, 28 Oct 2022 01:26:03 -0700
> Christoph Hellwig <hch@infradead.org> wrote:
> 
>> This is just a single patch out of apparently 31, which claims that
>> something that doesn't even exist in mainline must be used without any
>> explanation.  How do you expect anyone to be able to review it?
> 
>   https://lore.kernel.org/all/20221027150525.753064657@goodmis.org/
> 
> Only the first patch is relevant to you. I guess the Cc list would have
> been too big to Cc everyone that was Cc'd in the series.

No it's not, because how on earth would anyone know what the change does
if you only see the simple s/name/newname change? The patch is useless
by itself.

-- 
Jens Axboe


