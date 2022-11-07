Return-Path: <tglx@linutronix.de>
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 5FEB24201F6
	for <drbd-dev@lists.linbit.com>; Mon,  7 Nov 2022 11:54:53 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>, Linus Torvalds
	<torvalds@linux-foundation.org>
In-Reply-To: <20221106223256.4bbdb018@rorschach.local.home>
References: <20221106223256.4bbdb018@rorschach.local.home>
Date: Mon, 07 Nov 2022 11:47:04 +0100
Message-ID: <87pmdzvy6v.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Cc: alsa-devel@alsa-project.org, linux-staging@lists.linux.dev,
	linux-sh@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-afs@lists.infradead.org, linux-leds@vger.kernel.org,
	drbd-dev@lists.linbit.com, lvs-devel@vger.kernel.org,
	linux-nilfs@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-atm-general@lists.sourceforge.net,
	Julia Lawall <Julia.Lawall@inria.fr>, linux-acpi@vger.kernel.org,
	coreteam@netfilter.org, intel-wired-lan@lists.osuosl.org,
	linux-input@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
	linux-ext4@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
	linux-media@vger.kernel.org, bridge@lists.linux-foundation.org,
	intel-gfx@lists.freedesktop.org, linux-block@vger.kernel.org,
	cgroups@vger.kernel.org, Anna-Maria Gleixner <anna-maria@linutronix.de>,
	linux-nfs@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
	netdev@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org, netfilter-devel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Drbd-dev] [GIT PULL] treewide: timers: Use timer_shutdown*()
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

Linus,

On Sun, Nov 06 2022 at 22:32, Steven Rostedt wrote:
> As discussed here:
>
>   https://lore.kernel.org/all/20221106212427.739928660@goodmis.org/

Please hold off. It's only nits, but tip has documented rules and random
pull requests are not making them go away.

Thanks,

        tglx
