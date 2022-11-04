Return-Path: <torvalds@linuxfoundation.org>
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com
	[209.85.160.174])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id C3EC7420237
	for <drbd-dev@lists.linbit.com>; Fri,  4 Nov 2022 20:51:01 +0100 (CET)
Received: by mail-qt1-f174.google.com with SMTP id a27so3652057qtw.10
	for <drbd-dev@lists.linbit.com>; Fri, 04 Nov 2022 12:51:01 -0700 (PDT)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com.
	[209.85.128.170]) by smtp.gmail.com with ESMTPSA id
	m13-20020a05620a290d00b006fa43e139b5sm55633qkp.59.2022.11.04.12.50.59
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
	Fri, 04 Nov 2022 12:50:59 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id
	00721157ae682-333a4a5d495so52882607b3.10
	for <drbd-dev@lists.linbit.com>; Fri, 04 Nov 2022 12:50:59 -0700 (PDT)
MIME-Version: 1.0
References: <20221104054053.431922658@goodmis.org>
	<20221104192232.GA2520396@roeck-us.net>
	<20221104154209.21b26782@rorschach.local.home>
In-Reply-To: <20221104154209.21b26782@rorschach.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 4 Nov 2022 12:50:42 -0700
Message-ID: <CAHk-=wge9uWV2i9PR6x7va4ZbPdX5+rg7Ep1UNH_nYdd9rD-uw@mail.gmail.com>
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

On Fri, Nov 4, 2022 at 12:42 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Linus, should I also add any patches that has already been acked by the
> respective maintainer?

No, I'd prefer to keep only the ones that are 100% unambiguously not
changing any semantics.

              Linus
