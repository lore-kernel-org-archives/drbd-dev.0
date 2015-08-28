Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 22AEB1055F49
	for <drbd-dev@lists.linbit.com>; Fri, 11 Sep 2015 15:20:24 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 182352BEE36
	for <drbd-dev@lists.linbit.com>; Fri, 11 Sep 2015 15:20:24 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id zt84kn3S-S8K for <drbd-dev@lists.linbit.com>;
	Fri, 11 Sep 2015 15:20:24 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id E20CF2BEE40
	for <drbd-dev@lists.linbit.com>; Fri, 11 Sep 2015 15:20:23 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id y_BHyunEJZl0 for <drbd-dev@lists.linbit.com>;
	Fri, 11 Sep 2015 15:20:23 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 98DA22BEE36
	for <drbd-dev@lists.linbit.com>; Fri, 11 Sep 2015 15:20:23 +0200 (CEST)
Resent-Message-ID: <20150911132023.GY3436@soda.linbit>
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.9])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 97D2E10518BC
	for <drbd-dev@lists.linbit.com>; Fri, 28 Aug 2015 20:54:21 +0200 (CEST)
Date: Fri, 28 Aug 2015 11:19:28 -0700
From: Darren Hart <dvhart@infradead.org>
To: Christoph Hellwig <hch@lst.de>
Message-ID: <20150828181928.GD33809@vmdeb7>
References: <1440746842-19029-1-git-send-email-hch@lst.de>
	<1440746842-19029-2-git-send-email-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1440746842-19029-2-git-send-email-hch@lst.de>
Cc: linux-arch@vger.kernel.org, mitake@dcl.info.waseda.ac.jp, arnd@arndb.de,
	linux-kernel@vger.kernel.org, oded.gabbay@amd.com,
	dhowells@redhat.com, linux-gpio@vger.kernel.org,
	eli@mellanox.com, james_p_freyensee@linux.intel.com,
	drbd-dev@lists.linbit.com, herbert@gondor.apana.org.au
Subject: Re: [Drbd-dev] [PATCH 1/9] move io-64-nonatomic*.h out of
	asm-generic
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

On Fri, Aug 28, 2015 at 09:27:14AM +0200, Christoph Hellwig wrote:
> These are not implementations of default architecture code but helpers
> for drivers. Move them to the place they belong to.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

...

>  drivers/platform/x86/ibm_rtl.c                 |  2 +-
>  drivers/platform/x86/intel_ips.c               |  2 +-

No objection for platform/drivers/x86

Acked-by: Darren Hart <dvhart@linux.intel.com>

-- 
Darren Hart
Intel Open Source Technology Center
