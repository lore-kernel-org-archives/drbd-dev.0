Return-Path: <hch@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 78586105733B
	for <drbd-dev@lists.linbit.com>; Thu, 17 May 2018 08:37:46 +0200 (CEST)
Date: Thu, 17 May 2018 08:42:20 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Message-ID: <20180517064220.GA24300@lst.de>
References: <20180425154827.32251-1-hch@lst.de>
	<20180425154827.32251-12-hch@lst.de>
	<878t8y46sy.fsf@xmission.com> <20180515145643.GA661@lst.de>
	<871seakg0u.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871seakg0u.fsf@xmission.com>
Cc: linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	devel@driverdev.osuosl.org, linux-afs@lists.infradead.org,
	linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
	Christoph Hellwig <hch@lst.de>, linux-acpi@vger.kernel.org,
	netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jiri Slaby <jslaby@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>, linux-ext4@vger.kernel.org,
	Alexey Dobriyan <adobriyan@gmail.com>,
	megaraidlinux.pdl@broadcom.com, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 11/40] ipv6/flowlabel: simplify pid namespace
	lookup
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

On Thu, May 17, 2018 at 12:28:01AM -0500, Eric W. Biederman wrote:
> > struct pid_namespace *proc_pid_namespace(struct inode *inode)
> > {
> > 	// maybe warn on for s_magic not on procfs??
> > 	return inode->i_sb->s_fs_info;
> > }
> 
> That should work.  Ideally out of line for the proc_fs.h version.
> Basically it should be a cousin of PDE_DATA.

The version in Al's tree is inline and without the warning as
I didn't want to drag in the magic.h include.  Please look at it for
additional comments, I can send incremental fixups if needed.
