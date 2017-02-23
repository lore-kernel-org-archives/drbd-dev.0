Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wr0-f170.google.com (mail-wr0-f170.google.com
	[209.85.128.170]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id A194D1051881
	for <drbd-dev@lists.linbit.com>; Fri, 24 Feb 2017 16:00:22 +0100 (CET)
Received: by mail-wr0-f170.google.com with SMTP id o22so9223388wro.1
	for <drbd-dev@lists.linbit.com>; Fri, 24 Feb 2017 07:00:22 -0800 (PST)
Received: from soda.linbit ([86.59.100.100]) by smtp.gmail.com with ESMTPSA id
	40sm10676133wry.22.2017.02.24.07.00.20
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 24 Feb 2017 07:00:20 -0800 (PST)
Resent-Message-ID: <20170224150019.GX21236@soda.linbit>
Received: from smtprelay.hostedemail.com (smtprelay0134.hostedemail.com
	[216.40.44.134])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 61CEB105630C
	for <drbd-dev@lists.linbit.com>; Thu, 23 Feb 2017 18:53:50 +0100 (CET)
Message-ID: <1487872421.14159.38.camel@perches.com>
From: Joe Perches <joe@perches.com>
To: Emil Velikov <emil.l.velikov@gmail.com>
Date: Thu, 23 Feb 2017 09:53:41 -0800
In-Reply-To: <CACvgo50LUm5VSn_F=Dh8kL5zCPpCQDoCyUEL=Z+=1+6hJpfTaw@mail.gmail.com>
References: <cover.1487314666.git.joe@perches.com>
	<CAL_JsqLTaq-QLTqfyDO8EVJYpgeUx1e4J0Fo2NvfFWqVoiVedQ@mail.gmail.com>
	<1487870304.14159.29.camel@perches.com>
	<CACvgo50LUm5VSn_F=Dh8kL5zCPpCQDoCyUEL=Z+=1+6hJpfTaw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
	linux-ia64@vger.kernel.org, SH-Linux <linux-sh@vger.kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	ML nouveau <nouveau@lists.freedesktop.org>,
	Linux-ALSA <alsa-devel@alsa-project.org>,
	dri-devel <dri-devel@lists.freedesktop.org>, "open list:VIRTIO GPU DRIVER"
	<virtualization@lists.linux-foundation.org>,
	"linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
	"linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
	sparclinux@vger.kernel.org, drbd-dev@lists.linbit.com,
	Rob Herring <robh@kernel.org>, linux-omap <linux-omap@vger.kernel.org>,
	linux-scsi@vger.kernel.org, Richard Weinberger <richard@nod.at>,
	tboot-devel@lists.sourceforge.net,
	amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	sfi-devel@simplefirmware.org, oprofile-list@lists.sf.net,
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
	xen-devel@lists.xenproject.org,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	gigaset307x-common@lists.sourceforge.net,
	acpi4asus-user@lists.sourceforge.net,
	adi-buildroot-devel@lists.sourceforge.net,
	Pekka Paalanen <ppaalanen@gmail.com>, platform-driver-x86@vger.kernel.org,
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

On Thu, 2017-02-23 at 17:41 +0000, Emil Velikov wrote:
> On 23 February 2017 at 17:18, Joe Perches <joe@perches.com> wrote:
> > On Thu, 2017-02-23 at 09:28 -0600, Rob Herring wrote:
> > > On Fri, Feb 17, 2017 at 1:11 AM, Joe Perches <joe@perches.com> wrote:
> > > > There are ~4300 uses of pr_warn and ~250 uses of the older
> > > > pr_warning in the kernel source tree.
> > > > 
> > > > Make the use of pr_warn consistent across all kernel files.
> > > > 
> > > > This excludes all files in tools/ as there is a separate
> > > > define pr_warning for that directory tree and pr_warn is
> > > > not used in tools/.
> > > > 
> > > > Done with 'sed s/\bpr_warning\b/pr_warn/' and some emacsing.
> > 
> > []
> > > Where's the removal of pr_warning so we don't have more sneak in?
> > 
> > After all of these actually get applied,
> > and maybe a cycle or two later, one would
> > get sent.
> > 
> 
> By which point you'll get a few reincarnation of it. So you'll have to
> do the same exercise again :-(

Maybe to one or two files.  Not a big deal.

> I guess the question is - are you expecting to get the series merged
> all together/via one tree ?

No.  The only person that could do that effectively is Linus.

> If not, your plan is perfectly reasonable.

