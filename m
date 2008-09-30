Return-Path: <lars.ellenberg@linbit.com>
Received: from racke.linbit (chello080108047253.34.11.vie.surfer.at
	[80.108.47.253])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 1EFEF2E05437
	for <drbd-dev@lists.linbit.com>; Tue, 30 Sep 2008 22:02:49 +0200 (CEST)
Date: Tue, 30 Sep 2008 22:02:48 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] New Features: write-back cache mode
Message-ID: <20080930200248.GA30030@racke>
References: <48D3378E.3020201@gmail.com> <20080919155343.GD9779@soda.linbit>
	<91a37e890809190919g5a746367g54e76d36e1a825f6@mail.gmail.com>
	<20080919221339.GB15916@soda.linbit>
	<48D42783.1050403@gmail.com> <20080920131821.GB16149@racke>
	<20080920134827.GD16149@racke> <48D5818C.1030703@gmail.com>
	<20080920231938.GA16320@racke>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080920231938.GA16320@racke>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Sun, Sep 21, 2008 at 01:19:38AM +0200, Lars Ellenberg wrote:
> On Sat, Sep 20, 2008 at 05:04:44PM -0600, Morey Roof wrote:
> > This is pretty much what I was thinking.  For the btree, generations,  
> > and ref-count a good example to look at is how btrfs (This is the other  
> > project I have started to mess with) works.  The design is very  
> > efficient and I think we could use a very close match for our setup.  I  
> > haven't read the paper you sent yet but will get to that today.
> >
> > Let me know how you would like to start and I can start working a proof  
> > of concept and we can see how to go from there.
> 
> I still think that should be implemented as a
> generic device-mapper write-back target,
> not as part of drbd.

> http://www.acis.ufl.edu/~ming/dmcache/

> maybe you can use that as a starting point,
> and point it to a ram disk as cache?

any news on that?

	Lars
