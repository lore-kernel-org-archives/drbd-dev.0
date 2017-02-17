Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wr0-f179.google.com (mail-wr0-f179.google.com
	[209.85.128.179]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 8056D105646A
	for <drbd-dev@lists.linbit.com>; Fri, 17 Feb 2017 14:18:41 +0100 (CET)
Received: by mail-wr0-f179.google.com with SMTP id i10so29793617wrb.0
	for <drbd-dev@lists.linbit.com>; Fri, 17 Feb 2017 05:18:41 -0800 (PST)
Received: from soda.linbit ([86.59.100.100])
	by smtp.gmail.com with ESMTPSA id 32sm6782518wrr.20.2017.02.17.05.18.39
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 17 Feb 2017 05:18:39 -0800 (PST)
Resent-Message-ID: <20170217131839.GI21236@soda.linbit>
Received: from mail-oi0-f67.google.com (mail-oi0-f67.google.com
	[209.85.218.67]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 8EEAC1056483
	for <drbd-dev@lists.linbit.com>; Fri, 17 Feb 2017 14:07:18 +0100 (CET)
Received: by mail-oi0-f67.google.com with SMTP id x84so3765511oix.2
	for <drbd-dev@lists.linbit.com>; Fri, 17 Feb 2017 05:07:18 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0gNcGtnXpE1n6LSq7ey+UDKx+oQfmTg0_PgFwzB0Dd_5A@mail.gmail.com>
References: <cover.1487314666.git.joe@perches.com>
	<CAJZ5v0gNcGtnXpE1n6LSq7ey+UDKx+oQfmTg0_PgFwzB0Dd_5A@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 17 Feb 2017 13:37:33 +0100
Message-ID: <CAMuHMdWsG0DboaLqXag53Vejwvc5PPY2k2gy9PSdHWbNEx6nRQ@mail.gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset=UTF-8
Cc: "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
	"linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
	Linux-sh list <linux-sh@vger.kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	nouveau@lists.freedesktop.org,
	"moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
	<alsa-devel@alsa-project.org>, dri-devel <dri-devel@lists.freedesktop.org>,
	virtualization@lists.linux-foundation.org,
	"linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
	MTD Maling List <linux-mtd@lists.infradead.org>,
	sparclinux <sparclinux@vger.kernel.org>,
	Lars Ellenberg <drbd-dev@lists.linbit.com>,
	"open list:TARGET SUBSYSTEM" <linux-scsi@vger.kernel.org>,
	Richard Weinberger <richard@nod.at>,
	sfi-devel@simplefirmware.org, amd-gfx@lists.freedesktop.org,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	tboot-devel@lists.sourceforge.net, oprofile-list@lists.sf.net,
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
	xen-devel@lists.xenproject.org,
	Linux Media Mailing List <linux-media@vger.kernel.org>,
	platform-driver-x86@vger.kernel.org,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	gigaset307x-common@lists.sourceforge.net,
	acpi4asus-user@lists.sourceforge.net,
	"adi-buildroot-devel@lists.sourceforge.net"
	<adi-buildroot-devel@lists.sourceforge.net>, Joe Perches <joe@perches.com>,
	Pekka Paalanen <ppaalanen@gmail.com>,
	Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Karol Herbst <karolherbst@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
	alpha <linux-alpha@vger.kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [Drbd-dev] [PATCH 00/35] treewide trivial patches converting
	pr_warning to pr_warn
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

Hi Rafael,

On Fri, Feb 17, 2017 at 1:27 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Fri, Feb 17, 2017 at 8:11 AM, Joe Perches <joe@perches.com> wrote:
>> There are ~4300 uses of pr_warn and ~250 uses of the older
>> pr_warning in the kernel source tree.
>>
>> Make the use of pr_warn consistent across all kernel files.
>>
>> This excludes all files in tools/ as there is a separate
>> define pr_warning for that directory tree and pr_warn is
>> not used in tools/.
>>
>> Done with 'sed s/\bpr_warning\b/pr_warn/' and some emacsing.
>
> Sorry about asking if that has been asked already.
>
> Wouldn't it be slightly less intrusive to simply redefined
> pr_warning() as a synonym for pr_warn()?

That's already the case.

This series cleans up the cruft, so we can catch all users with
"git grep -w pr_warn".

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
