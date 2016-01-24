Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 7DFFE1056312
	for <drbd-dev@lists.linbit.com>; Sun, 24 Jan 2016 21:40:59 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 703C33788D3
	for <drbd-dev@lists.linbit.com>; Sun, 24 Jan 2016 21:40:59 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id pjQfYAbJugqb for <drbd-dev@lists.linbit.com>;
	Sun, 24 Jan 2016 21:40:59 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 39E4B378916
	for <drbd-dev@lists.linbit.com>; Sun, 24 Jan 2016 21:40:59 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id v0ehSisVZhKf for <drbd-dev@lists.linbit.com>;
	Sun, 24 Jan 2016 21:40:59 +0100 (CET)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 136FF3788D3
	for <drbd-dev@lists.linbit.com>; Sun, 24 Jan 2016 21:40:59 +0100 (CET)
Resent-Message-ID: <20160124204058.GQ26774@soda.linbit>
Received: from helcar.hengli.com.au (helcar.hengli.com.au [209.40.204.226])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 8F6E8105631C
	for <drbd-dev@lists.linbit.com>; Sun, 24 Jan 2016 14:21:23 +0100 (CET)
Date: Sun, 24 Jan 2016 21:10:21 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	netdev@vger.kernel.org, devel@driverdev.osuosl.org,
	dm-devel@redhat.com, linux-wireless@vger.kernel.org,
	linux-cifs@vger.kernel.org, ecryptfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-nfs@vger.kernel.org, keyrings@vger.kernel.org,
	linux-bluetooth@vger.kernel.org, ceph-devel@vger.kernel.org,
	linux-wpan@vger.kernel.org, linux-afs@lists.infradead.org,
	drbd-dev@lists.linbit.com, linux-nfc@lists.01.org,
	open-iscsi@googlegroups.com
Message-ID: <20160124131021.GA31153@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Drbd-dev] [PATCH 0/26] crypto: Use skcipher and ahash/shash where
	possible
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

Hi:

The crypto hash interface has been obsolete for many years and
this series converts all remaining users to shash and ahash as
appropriate.  Despite the name ahash can be used synchronously
and is the preferred interface for those dealing with SGs.

The blkcipher and ablkcipher interfaces are also being phased out
and is being replaced with the merged skcipher interface which
is essentially the same as ablkcipher but without the implicit
IV generators.  This series converts all users of blkcipher and
ablkcipher over to skcipher.

If you have any objections please shout.  Otherwise I would like
to take these patches through the cryptodev tree so we can proceed
with phasing out the obsolete interfaces.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
