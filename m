Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 1F6AE10518BE
	for <drbd-dev@lists.linbit.com>; Thu, 15 Oct 2015 15:38:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 114A44751A8
	for <drbd-dev@lists.linbit.com>; Thu, 15 Oct 2015 15:38:33 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id V792TJmvCMJP for <drbd-dev@lists.linbit.com>;
	Thu, 15 Oct 2015 15:38:32 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id E64DB4751F9
	for <drbd-dev@lists.linbit.com>; Thu, 15 Oct 2015 15:38:32 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id yhN_pakjz6Y3 for <drbd-dev@lists.linbit.com>;
	Thu, 15 Oct 2015 15:38:32 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id BB21F4751A8
	for <drbd-dev@lists.linbit.com>; Thu, 15 Oct 2015 15:38:32 +0200 (CEST)
Resent-Message-ID: <20151015133832.GQ32439@soda.linbit>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id EDE2A10556A0
	for <drbd-dev@lists.linbit.com>; Wed, 14 Oct 2015 16:47:34 +0200 (CEST)
From: Arnd Bergmann <arnd@arndb.de>
To: Christoph Hellwig <hch@lst.de>
Date: Wed, 14 Oct 2015 16:41:49 +0200
Message-ID: <5693903.Ud0gtefqqr@wuerfel>
In-Reply-To: <20150829134937.GA13103@lst.de>
References: <1440746842-19029-1-git-send-email-hch@lst.de>
	<22516156.tfGZvl13aG@wuerfel> <20150829134937.GA13103@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Cc: linux-arch@vger.kernel.org, mitake@dcl.info.waseda.ac.jp,
	linux-kernel@vger.kernel.org, oded.gabbay@amd.com,
	dhowells@redhat.com, linux-gpio@vger.kernel.org,
	eli@mellanox.com, james_p_freyensee@linux.intel.com,
	drbd-dev@lists.linbit.com, herbert@gondor.apana.org.au
Subject: Re: [Drbd-dev] fix various asm-generic abuses
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

On Saturday 29 August 2015 15:49:37 Christoph Hellwig wrote:
> On Fri, Aug 28, 2015 at 09:16:51PM +0200, Arnd Bergmann wrote:
> > On Friday 28 August 2015 09:27:13 Christoph Hellwig wrote:
> > > This fixes two trivial classes of asm-generic abuse.  First two headers
> > > that are intended for drivers are moved to include/linux, and second
> > > various drivers that incorrectly use asm-generic headers directly are
> > > switched over to use the proper public headers.  There are a few more
> > > asm-generic abuse, but they aren't quite as trivial so they will take
> > > a little more effort to fix.
> > 
> > Thanks a lot, these all look really useful. My normal way of dealing
> > with asm-generic patches is to have changes go through the tree of
> > whichever maintainer needs the changes for their own work with my
> > Ack, but I guess in this case you don't actually have other patches
> > depending on them, right?
> 
> No, there's nothing depending on it.
> 
> > If driver maintainers want to pick individual patches from this series,
> > please add my
> > 
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > 
> > otherwise let me know if I should put them into my asm-generic git
> > tree (which is currently empty, but part of linux-next).
> 
> Note that the first two are something you should probably pick up either
> way as they aren't really specific to a driver.

I've applied the remaining patches to my asm-generic tree now, with
the Acks from Herbert, Darren and Hitoshi.

	Arnd
