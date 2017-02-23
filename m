Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wr0-f174.google.com (mail-wr0-f174.google.com
	[209.85.128.174]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 95797105648E
	for <drbd-dev@lists.linbit.com>; Fri, 24 Feb 2017 15:59:48 +0100 (CET)
Received: by mail-wr0-f174.google.com with SMTP id 89so14720275wrr.3
	for <drbd-dev@lists.linbit.com>; Fri, 24 Feb 2017 06:59:48 -0800 (PST)
Received: from soda.linbit ([86.59.100.100]) by smtp.gmail.com with ESMTPSA id
	61sm10657436wrs.29.2017.02.24.06.59.47
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 24 Feb 2017 06:59:47 -0800 (PST)
Resent-Message-ID: <20170224145946.GV21236@soda.linbit>
Received: from smtprelay.hostedemail.com (smtprelay0118.hostedemail.com
	[216.40.44.118])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 0E63E1056473
	for <drbd-dev@lists.linbit.com>; Thu, 23 Feb 2017 18:18:40 +0100 (CET)
Message-ID: <1487870304.14159.29.camel@perches.com>
From: Joe Perches <joe@perches.com>
To: Rob Herring <robh@kernel.org>
Date: Thu, 23 Feb 2017 09:18:24 -0800
In-Reply-To: <CAL_JsqLTaq-QLTqfyDO8EVJYpgeUx1e4J0Fo2NvfFWqVoiVedQ@mail.gmail.com>
References: <cover.1487314666.git.joe@perches.com>
	<CAL_JsqLTaq-QLTqfyDO8EVJYpgeUx1e4J0Fo2NvfFWqVoiVedQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
	linux-ia64@vger.kernel.org, Richard, SH-Linux <linux-sh@vger.kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	nouveau@lists.freedesktop.org, Linux-ALSA <alsa-devel@alsa-project.org>,
	dri-devel <dri-devel@lists.freedesktop.org>,
	virtualization@lists.linux-foundation.org,
	"linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
	"linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
	sparclinux@vger.kernel.org, drbd-dev@lists.linbit.com,
	linux-scsi@vger.kernel.org, Weinberger <richard@nod.at>,
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

On Thu, 2017-02-23 at 09:28 -0600, Rob Herring wrote:
> On Fri, Feb 17, 2017 at 1:11 AM, Joe Perches <joe@perches.com> wrote:
> > There are ~4300 uses of pr_warn and ~250 uses of the older
> > pr_warning in the kernel source tree.
> > 
> > Make the use of pr_warn consistent across all kernel files.
> > 
> > This excludes all files in tools/ as there is a separate
> > define pr_warning for that directory tree and pr_warn is
> > not used in tools/.
> > 
> > Done with 'sed s/\bpr_warning\b/pr_warn/' and some emacsing.
[]
> Where's the removal of pr_warning so we don't have more sneak in?

After all of these actually get applied,
and maybe a cycle or two later, one would
get sent.

