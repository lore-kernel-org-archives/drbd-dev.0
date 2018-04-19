Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wr0-f194.google.com (mail-wr0-f194.google.com
	[209.85.128.194])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 460F41057318
	for <drbd-dev@lists.linbit.com>; Fri, 20 Apr 2018 00:37:59 +0200 (CEST)
Received: by mail-wr0-f194.google.com with SMTP id s18-v6so18003056wrg.9
	for <drbd-dev@lists.linbit.com>; Thu, 19 Apr 2018 15:37:59 -0700 (PDT)
Received: from soda.linbit ([86.59.100.100])
	by smtp.gmail.com with ESMTPSA id k126sm441155wmg.6.2018.04.19.15.37.58
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 19 Apr 2018 15:37:58 -0700 (PDT)
Resent-Message-ID: <20180419223758.GC3821@soda.linbit>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 82E481057311
	for <drbd-dev@lists.linbit.com>; Thu, 19 Apr 2018 15:00:28 +0200 (CEST)
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20180419124140.9309-21-hch@lst.de>
References: <20180419124140.9309-21-hch@lst.de>
	<20180419124140.9309-1-hch@lst.de>
To: Christoph Hellwig <hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <22410.1524142823.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Apr 2018 14:00:23 +0100
Message-ID: <22411.1524142823@warthog.procyon.org.uk>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	jfs-discussion@lists.sourceforge.net, dhowells@redhat.com,
	linux-ide@vger.kernel.org, linux-afs@lists.infradead.org,
	drbd-dev@lists.linbit.com, linux-rtc@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-acpi@vger.kernel.org,
	Jiri Slaby <jslaby@suse.com>, linux-ext4@vger.kernel.org,
	Alexey Dobriyan <adobriyan@gmail.com>,
	devel@driverdev.osuosl.org, Corey Minyard <minyard@acm.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, megaraidlinux.pdl@broadcom.com,
	Alessandro Zummo <a.zummo@towertech.it>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
	netdev@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Drbd-dev] [PATCH 20/39] afs: simplify procfs code
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

Christoph Hellwig <hch@lst.de> wrote:

> Use remove_proc_subtree to remove the whole subtree on cleanup, and
> unwind the registration loop into individual calls.  Switch to use
> proc_create_seq where applicable.

Note that this is likely going to clash with my patch to net-namespace all=
 of
the afs proc files:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/com=
mit/?h=3Dmount-context&id=3Df60c26c827c073583107ebf19d87bc5c0e71c3d2

If it helps, I should be able to disentangle this from the mount-api chang=
es
since the subsequent patch connects the dots to propagate the network
namespace over automount using the new fs_context to do it.

David
