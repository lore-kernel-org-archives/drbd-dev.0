Return-Path: <hch@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 0FE1A1057315
	for <drbd-dev@lists.linbit.com>; Tue, 15 May 2018 16:52:23 +0200 (CEST)
Date: Tue, 15 May 2018 16:56:43 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Message-ID: <20180515145643.GA661@lst.de>
References: <20180425154827.32251-1-hch@lst.de>
	<20180425154827.32251-12-hch@lst.de> <878t8y46sy.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878t8y46sy.fsf@xmission.com>
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

On Sat, May 05, 2018 at 07:37:33AM -0500, Eric W. Biederman wrote:
> Christoph Hellwig <hch@lst.de> writes:
> 
> > The shole seq_file sequence already operates under a single RCU lock pair,
> > so move the pid namespace lookup into it, and stop grabbing a reference
> > and remove all kinds of boilerplate code.
> 
> This is wrong.
> 
> Move task_active_pid_ns(current) from open to seq_start actually means
> that the results if you pass this proc file between callers the results
> will change.  So this breaks file descriptor passing.
> 
> Open is a bad place to access current.  In the middle of read/write is
> broken.
> 
> 
> In this particular instance looking up the pid namespace with
> task_active_pid_ns was a personal brain fart.  What the code should be
> doing (with an appropriate helper) is:
> 
> struct pid_namespace *pid_ns = inode->i_sb->s_fs_info;
> 
> Because each mount of proc is bound to a pid namespace.  Looking up the
> pid namespace from the super_block is a much better way to go.

What do you have in mind for the helper?  For now I've thrown it in
opencoded into my working tree, but I'd be glad to add a helper.

struct pid_namespace *proc_pid_namespace(struct inode *inode)
{
	// maybe warn on for s_magic not on procfs??
	return inode->i_sb->s_fs_info;
}

?
