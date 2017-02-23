Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wr0-f172.google.com (mail-wr0-f172.google.com
	[209.85.128.172]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id B41EE1051881
	for <drbd-dev@lists.linbit.com>; Fri, 24 Feb 2017 15:59:27 +0100 (CET)
Received: by mail-wr0-f172.google.com with SMTP id 89so14713158wrr.3
	for <drbd-dev@lists.linbit.com>; Fri, 24 Feb 2017 06:59:27 -0800 (PST)
Received: from soda.linbit ([86.59.100.100])
	by smtp.gmail.com with ESMTPSA id g6sm2632466wmc.30.2017.02.24.06.59.25
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 24 Feb 2017 06:59:25 -0800 (PST)
Resent-Message-ID: <20170224145920.GU21236@soda.linbit>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id EE6361051881
	for <drbd-dev@lists.linbit.com>; Thu, 23 Feb 2017 16:36:13 +0100 (CET)
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 9187D20256
	for <drbd-dev@lists.linbit.com>; Thu, 23 Feb 2017 15:28:47 +0000 (UTC)
Received: from mail-yw0-f179.google.com (mail-yw0-f179.google.com
	[209.85.161.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id BF036201BB
	for <drbd-dev@lists.linbit.com>; Thu, 23 Feb 2017 15:28:44 +0000 (UTC)
Received: by mail-yw0-f179.google.com with SMTP id p77so18182979ywg.1
	for <drbd-dev@lists.linbit.com>; Thu, 23 Feb 2017 07:28:44 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <cover.1487314666.git.joe@perches.com>
References: <cover.1487314666.git.joe@perches.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 23 Feb 2017 09:28:23 -0600
Message-ID: <CAL_JsqLTaq-QLTqfyDO8EVJYpgeUx1e4J0Fo2NvfFWqVoiVedQ@mail.gmail.com>
To: Joe Perches <joe@perches.com>
Content-Type: text/plain; charset=UTF-8
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
	linux-ia64@vger.kernel.org, SH-Linux <linux-sh@vger.kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	nouveau@lists.freedesktop.org, Linux-ALSA <alsa-devel@alsa-project.org>,
	dri-devel <dri-devel@lists.freedesktop.org>,
	virtualization@lists.linux-foundation.org,
	"linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
	"linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
	sparclinux@vger.kernel.org, drbd-dev@lists.linbit.com,
	linux-scsi@vger.kernel.org, Richard Weinberger <richard@nod.at>,
	sfi-devel@simplefirmware.org, amd-gfx@lists.freedesktop.org,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	tboot-devel@lists.sourceforge.net, oprofile-list@lists.sf.net,
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
	xen-devel@lists.xenproject.org,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	platform-driver-x86@vger.kernel.org,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	gigaset307x-common@lists.sourceforge.net,
	acpi4asus-user@lists.sourceforge.net,
	adi-buildroot-devel@lists.sourceforge.net,
	Pekka Paalanen <ppaalanen@gmail.com>,
	linux-omap <linux-omap@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, netdev <netdev@vger.kernel.org>,
	Karol Herbst <karolherbst@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-crypto@vger.kernel.org, linux-alpha@vger.kernel.org,
	Fabio Estevam <fabio.estevam@nxp.com>,
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

On Fri, Feb 17, 2017 at 1:11 AM, Joe Perches <joe@perches.com> wrote:
> There are ~4300 uses of pr_warn and ~250 uses of the older
> pr_warning in the kernel source tree.
>
> Make the use of pr_warn consistent across all kernel files.
>
> This excludes all files in tools/ as there is a separate
> define pr_warning for that directory tree and pr_warn is
> not used in tools/.
>
> Done with 'sed s/\bpr_warning\b/pr_warn/' and some emacsing.
>
> Miscellanea:
>
> o Coalesce formats and realign arguments
>
> Some files not compiled - no cross-compilers
>
> Joe Perches (35):
>   alpha: Convert remaining uses of pr_warning to pr_warn
>   ARM: ep93xx: Convert remaining uses of pr_warning to pr_warn
>   arm64: Convert remaining uses of pr_warning to pr_warn
>   arch/blackfin: Convert remaining uses of pr_warning to pr_warn
>   ia64: Convert remaining use of pr_warning to pr_warn
>   powerpc: Convert remaining uses of pr_warning to pr_warn
>   sh: Convert remaining uses of pr_warning to pr_warn
>   sparc: Convert remaining use of pr_warning to pr_warn
>   x86: Convert remaining uses of pr_warning to pr_warn
>   drivers/acpi: Convert remaining uses of pr_warning to pr_warn
>   block/drbd: Convert remaining uses of pr_warning to pr_warn
>   gdrom: Convert remaining uses of pr_warning to pr_warn
>   drivers/char: Convert remaining use of pr_warning to pr_warn
>   clocksource: Convert remaining use of pr_warning to pr_warn
>   drivers/crypto: Convert remaining uses of pr_warning to pr_warn
>   fmc: Convert remaining use of pr_warning to pr_warn
>   drivers/gpu: Convert remaining uses of pr_warning to pr_warn
>   drivers/ide: Convert remaining uses of pr_warning to pr_warn
>   drivers/input: Convert remaining uses of pr_warning to pr_warn
>   drivers/isdn: Convert remaining uses of pr_warning to pr_warn
>   drivers/macintosh: Convert remaining uses of pr_warning to pr_warn
>   drivers/media: Convert remaining use of pr_warning to pr_warn
>   drivers/mfd: Convert remaining uses of pr_warning to pr_warn
>   drivers/mtd: Convert remaining uses of pr_warning to pr_warn
>   drivers/of: Convert remaining uses of pr_warning to pr_warn
>   drivers/oprofile: Convert remaining uses of pr_warning to pr_warn
>   drivers/platform: Convert remaining uses of pr_warning to pr_warn
>   drivers/rapidio: Convert remaining use of pr_warning to pr_warn
>   drivers/scsi: Convert remaining use of pr_warning to pr_warn
>   drivers/sh: Convert remaining use of pr_warning to pr_warn
>   drivers/tty: Convert remaining uses of pr_warning to pr_warn
>   drivers/video: Convert remaining uses of pr_warning to pr_warn
>   kernel/trace: Convert remaining uses of pr_warning to pr_warn
>   lib: Convert remaining uses of pr_warning to pr_warn
>   sound/soc: Convert remaining uses of pr_warning to pr_warn

Where's the removal of pr_warning so we don't have more sneak in?

Rob
