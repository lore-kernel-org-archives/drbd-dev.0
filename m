Return-Path: <hch@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 38ACC1057315
	for <drbd-dev@lists.linbit.com>; Tue, 15 May 2018 16:38:24 +0200 (CEST)
Date: Tue, 15 May 2018 16:42:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: David Howells <dhowells@redhat.com>
Message-ID: <20180515144244.GA32583@lst.de>
References: <20180425154827.32251-5-hch@lst.de>
	<20180425154827.32251-1-hch@lst.de>
	<26540.1525094365@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26540.1525094365@warthog.procyon.org.uk>
Cc: linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	devel@driverdev.osuosl.org, linux-scsi@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jslaby@suse.com>, megaraidlinux.pdl@broadcom.com,
	linux-kernel@vger.kernel.org, linux-afs@lists.infradead.org,
	linux-ide@vger.kernel.org, netfilter-devel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>, netdev@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-ext4@vger.kernel.org, drbd-dev@lists.linbit.com,
	Christoph Hellwig <hch@lst.de>, jfs-discussion@lists.sourceforge.net,
	Alexey Dobriyan <adobriyan@gmail.com>
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

On Mon, Apr 30, 2018 at 02:19:25PM +0100, David Howells wrote:
> Christoph Hellwig <hch@lst.de> wrote:
> 
> > +
> > +struct proc_dir_entry *proc_create_seq_data(const char *name, umode_t mode,
> > +		struct proc_dir_entry *parent, const struct seq_operations *ops,
> > +		void *data)
> > +{
> > ...
> > +EXPORT_SYMBOL(proc_create_seq_data);
> 
> Please add documentation comments to exported functions when you add them.

None of the base functions are document, and we really want people to not
use procfs for new code anyway.  But if I get some consensus from the
maintainers and the list I can throw in another patch to document
all proc_create* variants.
