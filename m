Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wr0-f195.google.com (mail-wr0-f195.google.com
	[209.85.128.195])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 121471057329
	for <drbd-dev@lists.linbit.com>; Wed,  2 May 2018 17:38:31 +0200 (CEST)
Received: by mail-wr0-f195.google.com with SMTP id y15-v6so2789759wrg.11
	for <drbd-dev@lists.linbit.com>; Wed, 02 May 2018 08:38:31 -0700 (PDT)
Received: from soda.linbit ([86.59.100.100])
	by smtp.gmail.com with ESMTPSA id r3sm12795467wmg.5.2018.05.02.08.38.30
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 02 May 2018 08:38:30 -0700 (PDT)
Resent-Message-ID: <20180502153830.GT10032@soda.linbit>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 9BABC105732C
	for <drbd-dev@lists.linbit.com>; Mon, 30 Apr 2018 15:19:30 +0200 (CEST)
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20180425154827.32251-5-hch@lst.de>
References: <20180425154827.32251-5-hch@lst.de>
	<20180425154827.32251-1-hch@lst.de>
To: Christoph Hellwig <hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <26539.1525094365.1@warthog.procyon.org.uk>
Date: Mon, 30 Apr 2018 14:19:25 +0100
Message-ID: <26540.1525094365@warthog.procyon.org.uk>
Cc: linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	devel@driverdev.osuosl.org, linux-scsi@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jslaby@suse.com>, megaraidlinux.pdl@broadcom.com,
	linux-kernel@vger.kernel.org,
	Alexey Dobriyan <adobriyan@gmail.com>, dhowells@redhat.com,
	linux-ide@vger.kernel.org, netfilter-devel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>, netdev@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-ext4@vger.kernel.org, linux-afs@lists.infradead.org,
	jfs-discussion@lists.sourceforge.net, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 04/40] proc: introduce proc_create_seq{,
	_data}
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

> +
> +struct proc_dir_entry *proc_create_seq_data(const char *name, umode_t mode,
> +		struct proc_dir_entry *parent, const struct seq_operations *ops,
> +		void *data)
> +{
> ...
> +EXPORT_SYMBOL(proc_create_seq_data);

Please add documentation comments to exported functions when you add them.

David
