Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id EBC6810518AC
	for <drbd-dev@lists.linbit.com>; Fri,  1 Mar 2013 13:34:16 +0100 (CET)
Date: Fri, 1 Mar 2013 13:34:16 +0100
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <20130301123416.GO2696@soda.linbit>
References: <20130225160038.d7f80aca93b62bd818c6b650@canb.auug.org.au>
	<512BBB43.8060309@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <512BBB43.8060309@infradead.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org,
	linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] linux-next: Tree for Feb 23 (drbd)
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Mon, Feb 25, 2013 at 11:28:03AM -0800, Randy Dunlap wrote:
> On 02/24/13 21:00, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Please do not add any work destined for v3.10 to your -next included
> > branches until after Linus has release v3.9-rc1.
> > 
> > Changes since 20130222:
> > 
> 
> 
> on i386:
> 
>   CC [M]  drivers/block/drbd/drbd_receiver.o
> drivers/block/drbd/drbd_receiver.c: In function 'drbd_do_auth':
> drivers/block/drbd/drbd_receiver.c:4662:10: error: 'mdev' undeclared (first use in this function)
> make[4]: *** [drivers/block/drbd/drbd_receiver.o] Error 1
> 
> 
> Full randconfig file is attached.

see: https://lkml.org/lkml/2013/2/5/375
and:
http://git.drbd.org/gitweb.cgi?p=linux-drbd.git;a=commitdiff;h=23c275cba16615ac8cd3815cb1a86fd64cf12aa6

> # CONFIG_CRYPTO_HMAC is not set

	Lars

