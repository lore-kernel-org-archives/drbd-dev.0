Return-Path: <fujita.tomonori@lab.ntt.co.jp>
Received: from sh.osrg.net (sh.osrg.net [192.16.179.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id C2AF31045C2D
	for <drbd-dev@lists.linbit.com>; Thu, 24 Sep 2009 01:22:50 +0200 (CEST)
Date: Thu, 24 Sep 2009 08:21:51 +0900
To: kyle@moffetthome.net
From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
In-Reply-To: <f73f7ab80909230701k438be273y1e363a9ef5579e4d@mail.gmail.com>
References: <f73f7ab80909211751p4d797556lcce5e47c3241b5ef@mail.gmail.com>
	<20090923115751.GA11820@infradead.org>
	<f73f7ab80909230701k438be273y1e363a9ef5579e4d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20090924082042G.fujita.tomonori@lab.ntt.co.jp>
Cc: fujita.tomonori@lab.ntt.co.jp, sam@ravnborg.org, bart.vanassche@gmail.com,
	neilb@suse.de, knikanth@suse.de, gregkh@suse.de,
	linux-kernel@vger.kernel.org, philipp.reisner@linbit.com,
	hch@infradead.org, Mauelshagen@redhat.com,
	James.Bottomley@suse.de, lmb@suse.de,
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

On Wed, 23 Sep 2009 10:01:09 -0400
Kyle Moffett <kyle@moffetthome.net> wrote:

> The only thing missing is a list of exactly what still needs to be
> fixed.  I see a lot of handwaving about "We want a new API", but
> nobody defining what the requirements for that are.  If nobody can

Seems that you missed Christoph's requirements:

http://marc.info/?l=drbd-dev&m=125326222414549&w=2
