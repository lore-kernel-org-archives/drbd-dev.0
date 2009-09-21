Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 5563F10622A9
	for <drbd-dev@lists.linbit.com>; Mon, 21 Sep 2009 18:53:50 +0200 (CEST)
Resent-Message-ID: <20090921165350.GK8072@barkeeper1-xen.linbit>
Received: from casper.infradead.org (casper.infradead.org [85.118.1.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 91D3210622A8
	for <drbd-dev@lists.linbit.com>; Mon, 21 Sep 2009 17:52:03 +0200 (CEST)
Date: Mon, 21 Sep 2009 16:52:52 +0200
From: Arjan van de Ven <arjan@infradead.org>
To: Lars Ellenberg <lars.ellenberg@linbit.com>
Message-ID: <20090921165252.04e335b1@infradead.org>
In-Reply-To: <20090921144308.GG8072@barkeeper1-xen.linbit>
References: <20090918200803.GM23126@kernel.dk>
	<20090919141334N.fujita.tomonori@lab.ntt.co.jp>
	<20090919220232.GB31849@suse.de>
	<20090921223815U.fujita.tomonori@lab.ntt.co.jp>
	<20090921144308.GG8072@barkeeper1-xen.linbit>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: hch@infradead.org, kyle@moffetthome.net, sam@ravnborg.org,
	bart.vanassche@gmail.com, neilb@suse.de, knikanth@suse.de,
	gregkh@suse.de, linux-kernel@vger.kernel.org, philipp.reisner@linbit.com,
	FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
	Mauelshagen@RedHat.com, James.Bottomley@suse.de, lmb@suse.de,
	kosaki.motohiro@jp.fujitsu.com, jens.axboe@oracle.com,
	davej@redhat.com, akpm@linux-foundation.org,
	torvalds@linux-foundation.org, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [GIT PULL] DRBD for 2.6.32
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Mon, 21 Sep 2009 16:43:08 +0200
Lars Ellenberg <lars.ellenberg@linbit.com> wrote:
> We can choose whatever user-kernel interface you like,
> and change it with every dot release --
> we'd just need to add additional compat code into
> the drbdsetup userland binary.

uh no.

the kernel<->userspace ABI is stable.
we don't go about randomly changing it
(extending it is fine obviously)


-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
