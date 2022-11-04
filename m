Return-Path: <torvalds@linuxfoundation.org>
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com
	[209.85.219.45])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id F00334210DE
	for <drbd-dev@lists.linbit.com>; Fri,  4 Nov 2022 18:00:23 +0100 (CET)
Received: by mail-qv1-f45.google.com with SMTP id w10so3600405qvr.3
	for <drbd-dev@lists.linbit.com>; Fri, 04 Nov 2022 10:00:23 -0700 (PDT)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com.
	[209.85.128.170]) by smtp.gmail.com with ESMTPSA id
	s8-20020a05620a16a800b006ed30a8fb21sm3145770qkj.76.2022.11.04.10.00.20
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
	Fri, 04 Nov 2022 10:00:20 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id
	00721157ae682-3701a0681daso49162977b3.4
	for <drbd-dev@lists.linbit.com>; Fri, 04 Nov 2022 10:00:20 -0700 (PDT)
MIME-Version: 1.0
References: <20221104054053.431922658@goodmis.org>
In-Reply-To: <20221104054053.431922658@goodmis.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 4 Nov 2022 10:00:03 -0700
Message-ID: <CAHk-=whKE5UL+AuCC2wK8oq8D_ueSO_T7-9Acx4POouqVi8ZHg@mail.gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Cc: alsa-devel@alsa-project.org, linux-staging@lists.linux.dev,
	linux-doc@vger.kernel.org, dri-devel@lists.freedesktop.org,
	Thomas Gleixner <tglx@linutronix.de>, linux-leds@vger.kernel.org,
	drbd-dev@lists.linbit.com, linux-s390@vger.kernel.org,
	linux-nilfs@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-sh@vger.kernel.org, linux-atm-general@lists.sourceforge.net,
	linux-afs@lists.infradead.org, lvs-devel@vger.kernel.org,
	linux-acpi@vger.kernel.org, coreteam@netfilter.org,
	intel-wired-lan@lists.osuosl.org, linux-input@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-ext4@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
	linux-media@vger.kernel.org, bridge@lists.linux-foundation.org,
	linux-pm@vger.kernel.org, intel-gfx@lists.freedesktop.org,
	rcu@vger.kernel.org, cgroups@vger.kernel.org,
	openipmi-developer@lists.sourceforge.net,
	Anna-Maria Gleixner <anna-maria@linutronix.de>,
	linux-edac@vger.kernel.org, linux-block@vger.kernel.org,
	linux-nfs@vger.kernel.org, linux-parisc@vger.kernel.org,
	Stephen Boyd <sboyd@kernel.org>, netdev@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	netfilter-devel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	linaro-mm-sig@lists.linaro.org
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

On Thu, Nov 3, 2022 at 10:48 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Ideally, I would have the first patch go into this rc cycle, which is mostly
> non functional as it will allow the other patches to come in via the respective
> subsystems in the next merge window.

Ack.

I also wonder if we could do the completely trivially correct
conversions immediately.

I'm talking about the scripted ones where it's currently a
"del_timer_sync()", and the very next action is freeing whatever data
structure the timer is in (possibly with something like free_irq() in
between - my point is that there's an unconditional free that is very
clear and unambiguous), so that there is absolutely no question about
whether they should use "timer_shutdown_sync()" or not.

IOW, things like patches 03, 17 and 31, and at least parts others in
this series.

This series clearly has several much more complex cases that need
actual real code review, and I think it would help to have the
completely unambiguous cases out of the way, just to get rid of noise.

So I'd take that first patch, and a scripted set of "this cannot
change any semantics" patches early.

                Linus
