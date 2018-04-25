Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wm0-f66.google.com (mail-wm0-f66.google.com [74.125.82.66])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 9E0091057327
	for <drbd-dev@lists.linbit.com>; Wed,  2 May 2018 17:38:13 +0200 (CEST)
Received: by mail-wm0-f66.google.com with SMTP id f8so14693148wmc.4
	for <drbd-dev@lists.linbit.com>; Wed, 02 May 2018 08:38:13 -0700 (PDT)
Received: from soda.linbit ([86.59.100.100]) by smtp.gmail.com with ESMTPSA id
	k3-v6sm20362046wri.28.2018.05.02.08.38.12
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 02 May 2018 08:38:12 -0700 (PDT)
Resent-Message-ID: <20180502153811.GR10032@soda.linbit>
Received: from mail-wr0-f195.google.com (mail-wr0-f195.google.com
	[209.85.128.195])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 75B271057321
	for <drbd-dev@lists.linbit.com>; Wed, 25 Apr 2018 23:24:15 +0200 (CEST)
Received: by mail-wr0-f195.google.com with SMTP id v5-v6so3923798wrf.9
	for <drbd-dev@lists.linbit.com>; Wed, 25 Apr 2018 14:24:15 -0700 (PDT)
Date: Thu, 26 Apr 2018 00:24:11 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Message-ID: <20180425212411.GB9020@avx2>
References: <20180419124140.9309-1-hch@lst.de> <20180419185750.GD2066@avx2>
	<20180424142304.GE26136@lst.de>
	<20180424081916.e94ca8463fb3c39ebc082bdd@linux-foundation.org>
	<20180424160652.GA28483@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180424160652.GA28483@lst.de>
Cc: linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	devel@driverdev.osuosl.org, linux-scsi@vger.kernel.org,
	Corey Minyard <minyard@acm.org>, linux-ide@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	jfs-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jiri Slaby <jslaby@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-ext4@vger.kernel.org, linux-afs@lists.infradead.org,
	megaraidlinux.pdl@broadcom.com, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] simplify procfs code for seq_file instances
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

On Tue, Apr 24, 2018 at 06:06:53PM +0200, Christoph Hellwig wrote:
> On Tue, Apr 24, 2018 at 08:19:16AM -0700, Andrew Morton wrote:
> > > > I want to ask if it is time to start using poorman function overloading
> > > > with _b_c_e(). There are millions of allocation functions for example,
> > > > all slightly difference, and people will add more. Seeing /proc interfaces
> > > > doubled like this is painful.
> > > 
> > > Function overloading is totally unacceptable.
> > > 
> > > And I very much disagree with a tradeoff that keeps 5000 lines of 
> > > code vs a few new helpers.
> > 
> > OK, the curiosity and suspense are killing me.  What the heck is
> > "function overloading with _b_c_e()"?
> 
> The way I understood Alexey was to use have a proc_create macro
> that can take different ops types.  Although the short cut for
> __builtin_types_compatible_p would be _b_t_c or similar, so maybe
> I misunderstood him.

That's correct.

I also think that several dozens kmalloc signatures are a problem.

And there will be more with pmalloc* stuff and more 2D/3D array
checked allocations and who knows what.
And I want to add typed kmalloc!
