Return-Path: <kvalo@kernel.org>
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 0FD9942210F
	for <drbd-dev@lists.linbit.com>;
	Wed, 21 Dec 2022 19:48:00 +0100 (CET)
From: Kalle Valo <kvalo@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
References: <20221220134519.3dd1318b@gandalf.local.home>
In-Reply-To: <20221220134519.3dd1318b@gandalf.local.home> (Steven Rostedt's
	message of "Tue, 20 Dec 2022 13:45:19 -0500")
Message-ID: <87mt7gk2zt.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Cc: alsa-devel@alsa-project.org, linux-staging@lists.linux.dev,
	linux-sh@vger.kernel.org, dri-devel@lists.freedesktop.org,
	SHA-cyfmac-dev-list@infineon.com, linux-leds@vger.kernel.org,
	drbd-dev@lists.linbit.com, lvs-devel@vger.kernel.org,
	linux-nilfs@vger.kernel.org, linux-scsi@vger.kernel.org,
	Anna-Maria, linux-atm-general@lists.sourceforge.net,
	Julia Lawall <Julia.Lawall@inria.fr>, linux-acpi@vger.kernel.org,
	coreteam@netfilter.org, intel-wired-lan@lists.osuosl.org,
	linux-input@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
	linux-ext4@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
	linux-media@vger.kernel.org, bridge@lists.linux-foundation.org,
	intel-gfx@lists.freedesktop.org, linux-nfs@vger.kernel.org,
	linux-block@vger.kernel.org, cgroups@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>, Gleixner <anna-maria@linutronix.de>,
	brcm80211-dev-list.pdl@broadcom.com,
	Stephen Boyd <sboyd@kernel.org>, netdev@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	linux-bluetooth@vger.kernel.org, netfilter-devel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [Drbd-dev] [PATCH] treewide: Convert del_timer*() to
	timer_shutdown*()
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
Date: Wed, 21 Dec 2022 18:48:01 -0000

Steven Rostedt <rostedt@goodmis.org> writes:

> [
>   Linus,
>
>     I ran the script against your latest master branch:
>     commit b6bb9676f2165d518b35ba3bea5f1fcfc0d969bf
>
>     As the timer_shutdown*() code is now in your tree, I figured
>     we can start doing the conversions. At least add the trivial ones
>     now as Thomas suggested that this gets applied at the end of the
>     merge window, to avoid conflicts with linux-next during the
>     development cycle. I can wait to Friday to run it again, and
>     resubmit.
>
>     What is the best way to handle this?
> ]
>
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
>
> Due to several bugs caused by timers being re-armed after they are
> shutdown and just before they are freed, a new state of timers was added
> called "shutdown". After a timer is set to this state, then it can no
> longer be re-armed.
>
> The following script was run to find all the trivial locations where
> del_timer() or del_timer_sync() is called in the same function that the
> object holding the timer is freed. It also ignores any locations where the
> timer->function is modified between the del_timer*() and the free(), as
> that is not considered a "trivial" case.
>
> This was created by using a coccinelle script and the following commands:
>
>  $ cat timer.cocci
> @@
> expression ptr, slab;
> identifier timer, rfield;
> @@
> (
> -       del_timer(&ptr->timer);
> +       timer_shutdown(&ptr->timer);
> |
> -       del_timer_sync(&ptr->timer);
> +       timer_shutdown_sync(&ptr->timer);
> )
>   ... when strict
>       when != ptr->timer
> (
>         kfree_rcu(ptr, rfield);
> |
>         kmem_cache_free(slab, ptr);
> |
>         kfree(ptr);
> )
>
>  $ spatch timer.cocci . > /tmp/t.patch
>  $ patch -p1 < /tmp/t.patch
>
> Link: https://lore.kernel.org/lkml/20221123201306.823305113@linutronix.de/
>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

For wireless:

>  .../broadcom/brcm80211/brcmfmac/btcoex.c         |  2 +-
>  drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c |  2 +-
>  drivers/net/wireless/intel/iwlwifi/mvm/sta.c     |  2 +-
>  drivers/net/wireless/intersil/hostap/hostap_ap.c |  2 +-
>  drivers/net/wireless/marvell/mwifiex/main.c      |  2 +-
>  drivers/net/wireless/microchip/wilc1000/hif.c    |  6 +++---

Acked-by: Kalle Valo <kvalo@kernel.org>

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
