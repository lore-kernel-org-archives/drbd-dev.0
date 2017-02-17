Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wm0-f51.google.com (mail-wm0-f51.google.com [74.125.82.51])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 7D1D0105631C
	for <drbd-dev@lists.linbit.com>; Fri, 17 Feb 2017 14:00:05 +0100 (CET)
Received: by mail-wm0-f51.google.com with SMTP id v186so14355902wmd.0
	for <drbd-dev@lists.linbit.com>; Fri, 17 Feb 2017 05:00:05 -0800 (PST)
Received: from soda.linbit ([86.59.100.100]) by smtp.gmail.com with ESMTPSA id
	18sm12840481wrb.14.2017.02.17.05.00.04
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 17 Feb 2017 05:00:04 -0800 (PST)
Resent-Message-ID: <20170217125958.GE21236@soda.linbit>
Received: from mail-oi0-f67.google.com (mail-oi0-f67.google.com
	[209.85.218.67]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id DDAF11051881
	for <drbd-dev@lists.linbit.com>; Fri, 17 Feb 2017 13:34:20 +0100 (CET)
Received: by mail-oi0-f67.google.com with SMTP id s131so1590705oie.0
	for <drbd-dev@lists.linbit.com>; Fri, 17 Feb 2017 04:34:20 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <cover.1487314666.git.joe@perches.com>
References: <cover.1487314666.git.joe@perches.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 17 Feb 2017 13:27:00 +0100
Message-ID: <CAJZ5v0gNcGtnXpE1n6LSq7ey+UDKx+oQfmTg0_PgFwzB0Dd_5A@mail.gmail.com>
To: Joe Perches <joe@perches.com>
Content-Type: text/plain; charset=UTF-8
Cc: "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
	"linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
	Linux-sh list <linux-sh@vger.kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	nouveau@lists.freedesktop.org,
	"moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
	<alsa-devel@alsa-project.org>, dri-devel <dri-devel@lists.freedesktop.org>,
	virtualization@lists.linux-foundation.org,
	linux-ide@vger.kernel.org, linux-mtd@lists.infradead.org,
	sparclinux@vger.kernel.org, drbd-dev@lists.linbit.com,
	"open list:TARGET SUBSYSTEM" <linux-scsi@vger.kernel.org>,
	Richard Weinberger <richard@nod.at>,
	sfi-devel@simplefirmware.org, amd-gfx@lists.freedesktop.org,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	tboot-devel@lists.sourceforge.net, oprofile-list@lists.sf.net,
	linux-input@vger.kernel.org, xen-devel@lists.xenproject.org,
	linux-media@vger.kernel.org, platform-driver-x86@vger.kernel.org,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	gigaset307x-common@lists.sourceforge.net,
	acpi4asus-user@lists.sourceforge.net,
	adi-buildroot-devel@lists.sourceforge.net,
	Pekka Paalanen <ppaalanen@gmail.com>,
	Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, netdev@vger.kernel.org,
	Karol Herbst <karolherbst@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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

On Fri, Feb 17, 2017 at 8:11 AM, Joe Perches <joe@perches.com> wrote:
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

Sorry about asking if that has been asked already.

Wouldn't it be slightly less intrusive to simply redefined
pr_warning() as a synonym for pr_warn()?

Thanks,
Rafael
