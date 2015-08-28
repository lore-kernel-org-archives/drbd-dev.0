Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 07F0F1055F44
	for <drbd-dev@lists.linbit.com>; Fri, 11 Sep 2015 15:20:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 049A82BEE36
	for <drbd-dev@lists.linbit.com>; Fri, 11 Sep 2015 15:20:23 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id Jrt7hbh-Zfef for <drbd-dev@lists.linbit.com>;
	Fri, 11 Sep 2015 15:20:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id D41CF2BEE40
	for <drbd-dev@lists.linbit.com>; Fri, 11 Sep 2015 15:20:22 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Wq9GuuI5jJsY for <drbd-dev@lists.linbit.com>;
	Fri, 11 Sep 2015 15:20:22 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id B2E3C2BEE36
	for <drbd-dev@lists.linbit.com>; Fri, 11 Sep 2015 15:20:22 +0200 (CEST)
Resent-Message-ID: <20150911132022.GX3436@soda.linbit>
Received: from helcar.hengli.com.au (helcar.hengli.com.au [209.40.204.226])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 1DE5910518AB
	for <drbd-dev@lists.linbit.com>; Fri, 28 Aug 2015 15:51:13 +0200 (CEST)
Date: Fri, 28 Aug 2015 21:14:59 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Christoph Hellwig <hch@lst.de>
Message-ID: <20150828131459.GA11796@gondor.apana.org.au>
References: <1440746842-19029-1-git-send-email-hch@lst.de>
	<1440746842-19029-6-git-send-email-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1440746842-19029-6-git-send-email-hch@lst.de>
Cc: linux-arch@vger.kernel.org, mitake@dcl.info.waseda.ac.jp, arnd@arndb.de,
	linux-kernel@vger.kernel.org, oded.gabbay@amd.com,
	dhowells@redhat.com, linux-gpio@vger.kernel.org,
	eli@mellanox.com, james_p_freyensee@linux.intel.com,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 5/9] hifn_795x: stop including
	<asm-generic/kmap_types.h>
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

On Fri, Aug 28, 2015 at 09:27:18AM +0200, Christoph Hellwig wrote:
> <linux/highmem.h> is the placace the get the kmap type flags, asm-generic
> files are generic implementations only to be used by architecture code.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
