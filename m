Return-Path: <BATV+7a27817b7907a3189f11+2222+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [18.85.46.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id DA53910622A1
	for <drbd-dev@lists.linbit.com>; Wed, 23 Sep 2009 13:58:04 +0200 (CEST)
Date: Wed, 23 Sep 2009 07:57:51 -0400
From: Christoph Hellwig <hch@infradead.org>
To: Kyle Moffett <kyle@moffetthome.net>
Message-ID: <20090923115751.GA11820@infradead.org>
References: <20090921144308.GG8072@barkeeper1-xen.linbit>
	<20090921165252.04e335b1@infradead.org>
	<20090921165321.GJ8072@barkeeper1-xen.linbit>
	<20090922072617U.fujita.tomonori@lab.ntt.co.jp>
	<f73f7ab80909211751p4d797556lcce5e47c3241b5ef@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f73f7ab80909211751p4d797556lcce5e47c3241b5ef@mail.gmail.com>
Cc: hch@infradead.org, sam@ravnborg.org, bart.vanassche@gmail.com,
	neilb@suse.de, knikanth@suse.de, gregkh@suse.de,
	linux-kernel@vger.kernel.org, philipp.reisner@linbit.com,
	FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
	Mauelshagen@redhat.com, James.Bottomley@suse.de, lmb@suse.de,
	kosaki.motohiro@jp.fujitsu.com, jens.axboe@oracle.com,
	davej@redhat.com, lars.ellenberg@linbit.com,
	drbd-dev@lists.linbit.com, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, arjan@infradead.org
Subject: Re: [Drbd-dev] [GIT PULL] DRBD for 2.6.32
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Mon, Sep 21, 2009 at 08:51:32PM -0400, Kyle Moffett wrote:
> You have to realize that this project is NOT a new one, it's been
> around quite a decent number of years (since kernel 2.2-ish).  Yes,
> the ABI is unique and has its warts, but there are a lot of things
> that depend on it.

So?  That's never been an argument.  Quite contrary, we ignored upstream
for years and fucked up out of tree but please merge anyway is almost
a counter-argument.

