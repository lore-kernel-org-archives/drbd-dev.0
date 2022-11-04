Return-Path: <groeck7@gmail.com>
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com
	[209.85.160.41])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id B8738420237
	for <drbd-dev@lists.linbit.com>; Fri,  4 Nov 2022 21:42:02 +0100 (CET)
Received: by mail-oa1-f41.google.com with SMTP id
	586e51a60fabf-13d9a3bb27aso5998210fac.11
	for <drbd-dev@lists.linbit.com>; Fri, 04 Nov 2022 13:42:02 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 4 Nov 2022 13:41:59 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Steven Rostedt <rostedt@goodmis.org>
Message-ID: <20221104204159.GA506794@roeck-us.net>
References: <20221104054053.431922658@goodmis.org>
	<20221104192232.GA2520396@roeck-us.net>
	<20221104154209.21b26782@rorschach.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221104154209.21b26782@rorschach.local.home>
Cc: alsa-devel@alsa-project.org, linux-staging@lists.linux.dev,
	linux-doc@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	Thomas Gleixner <tglx@linutronix.de>, linux-leds@vger.kernel.org,
	drbd-dev@lists.linbit.com, linux-s390@vger.kernel.org,
	linux-nilfs@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-sh@vger.kernel.org, linux-atm-general@lists.sourceforge.net,
	linux-afs@lists.infradead.org, lvs-devel@vger.kernel.org,
	linux-acpi@vger.kernel.org, coreteam@netfilter.org,
	intel-wired-lan@lists.osuosl.org, linux-input@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-ext4@vger.kernel.org, linux-media@vger.kernel.org,
	bridge@lists.linux-foundation.org, linux-pm@vger.kernel.org,
	intel-gfx@lists.freedesktop.org, rcu@vger.kernel.org,
	cgroups@vger.kernel.org, openipmi-developer@lists.sourceforge.net,
	Anna-Maria Gleixner <anna-maria@linutronix.de>,
	linux-edac@vger.kernel.org, linux-block@vger.kernel.org,
	linux-nfs@vger.kernel.org, linux-parisc@vger.kernel.org,
	Stephen Boyd <sboyd@kernel.org>, netdev@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	netfilter-devel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [Drbd-dev] [RFC][PATCH v3 00/33] timers: Use timer_shutdown*()
 before freeing timers
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

On Fri, Nov 04, 2022 at 03:42:09PM -0400, Steven Rostedt wrote:
> On Fri, 4 Nov 2022 12:22:32 -0700
> Guenter Roeck <linux@roeck-us.net> wrote:
> 
> > Unfortunately the renaming caused some symbol conflicts.
> > 
> > Global definition: timer_shutdown
> > 
> >   File             Line
> > 0 time.c            93 static inline void timer_shutdown(struct clock_event_device *evt)
> > 1 arm_arch_timer.c 690 static __always_inline int timer_shutdown(const int access,
> > 2 timer-fttmr010.c 105 int (*timer_shutdown)(struct clock_event_device *evt);
> > 3 timer-sp804.c    158 static inline void timer_shutdown(struct clock_event_device *evt)
> > 4 timer.h          239 static inline int timer_shutdown(struct timer_list *timer)
> 
> $ git grep '\btimer_shutdown'
> arch/arm/mach-spear/time.c:static inline void timer_shutdown(struct clock_event_device *evt)
> arch/arm/mach-spear/time.c:     timer_shutdown(evt);
> arch/arm/mach-spear/time.c:     timer_shutdown(evt);
> arch/arm/mach-spear/time.c:     timer_shutdown(evt);
> drivers/clocksource/arm_arch_timer.c:static __always_inline int timer_shutdown(const int access,
> drivers/clocksource/arm_arch_timer.c:   return timer_shutdown(ARCH_TIMER_VIRT_ACCESS, clk);
> drivers/clocksource/arm_arch_timer.c:   return timer_shutdown(ARCH_TIMER_PHYS_ACCESS, clk);
> drivers/clocksource/arm_arch_timer.c:   return timer_shutdown(ARCH_TIMER_MEM_VIRT_ACCESS, clk);
> drivers/clocksource/arm_arch_timer.c:   return timer_shutdown(ARCH_TIMER_MEM_PHYS_ACCESS, clk);
> drivers/clocksource/timer-fttmr010.c:   int (*timer_shutdown)(struct clock_event_device *evt);
> drivers/clocksource/timer-fttmr010.c:   fttmr010->timer_shutdown(evt);
> drivers/clocksource/timer-fttmr010.c:   fttmr010->timer_shutdown(evt);
> drivers/clocksource/timer-fttmr010.c:   fttmr010->timer_shutdown(evt);
> drivers/clocksource/timer-fttmr010.c:           fttmr010->timer_shutdown = ast2600_timer_shutdown;
> drivers/clocksource/timer-fttmr010.c:           fttmr010->timer_shutdown = fttmr010_timer_shutdown;
> drivers/clocksource/timer-fttmr010.c:   fttmr010->clkevt.set_state_shutdown = fttmr010->timer_shutdown;
> drivers/clocksource/timer-fttmr010.c:   fttmr010->clkevt.tick_resume = fttmr010->timer_shutdown;
> drivers/clocksource/timer-sp804.c:static inline void timer_shutdown(struct clock_event_device *evt)
> drivers/clocksource/timer-sp804.c:      timer_shutdown(evt);
> drivers/clocksource/timer-sp804.c:      timer_shutdown(evt);
> 
> Honestly, I think these need to be renamed, as "timer_shutdown()"
> should be specific to the timer code, and not individual timers.

Yes, that is what I did locally. I am repeating my test now with that
change made.

Guenter
