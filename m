Return-Path: <SRS0=6An1=25=goodmis.org=rostedt@kernel.org>
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 479FA4203BD
	for <drbd-dev@lists.linbit.com>;
	Fri, 28 Oct 2022 16:12:55 +0200 (CEST)
Date: Fri, 28 Oct 2022 10:06:56 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Jens Axboe <axboe@kernel.dk>
Message-ID: <20221028100656.00a4d537@gandalf.local.home>
In-Reply-To: <60b91c39-1e54-ac8b-5e9e-db7e46ca2d60@kernel.dk>
References: <20221027150525.753064657@goodmis.org>
	<20221027150925.819019339@goodmis.org>
	<20221027111944.39b3a80c@gandalf.local.home>
	<Y1uSG/7VXWLNlxlt@infradead.org>
	<20221028062414.7859f787@gandalf.local.home>
	<60b91c39-1e54-ac8b-5e9e-db7e46ca2d60@kernel.dk>
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

On Fri, 28 Oct 2022 07:56:50 -0600
Jens Axboe <axboe@kernel.dk> wrote:

> On 10/28/22 4:24 AM, Steven Rostedt wrote:
> > On Fri, 28 Oct 2022 01:26:03 -0700
> > Christoph Hellwig <hch@infradead.org> wrote:
> >   
> >> This is just a single patch out of apparently 31, which claims that
> >> something that doesn't even exist in mainline must be used without any
> >> explanation.  How do you expect anyone to be able to review it?  
> > 
> >   https://lore.kernel.org/all/20221027150525.753064657@goodmis.org/
> > 
> > Only the first patch is relevant to you. I guess the Cc list would have
> > been too big to Cc everyone that was Cc'd in the series.  
> 
> No it's not, because how on earth would anyone know what the change does
> if you only see the simple s/name/newname change? The patch is useless
> by itself.
> 

I meant this as the first patch:

  https://lore.kernel.org/all/20221027150925.248421571@goodmis.org/

Which was what the link above was suppose to point to.

It's the only patch relevant to the rest of the series, as the rest is just
converting over to the shutdown API, and the last patch changes
DEBUG_OBJECTS_TIMERS to catch if this was done properly.

That is, patch 01/31 and the patch you were Cc'd on is relevant, and for
those that want to look deeper, see patch 31 as well.

But if I included the Cc list for patch 01 for all those Cc'd in the
entire series, it would be a huge Cc list, so I avoided doing so.

Also, this is still RFC as the changes may still change. That is, this
patch set is a heads up to what is to come. Ideally, I'd like to get just
the API possibly in the kernel before the merge window without anyone using
it. Then I can ask all the sub systems to pull in these individual patches
as well.

-- Steve
