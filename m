Return-Path: <Lars.Ellenberg@linbit.com>
Received: from soda (unknown [86.59.100.100])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 6C9402D9D6C9
	for <drbd-dev@lists.linbit.com>; Mon, 15 Jan 2007 09:01:55 +0100 (CET)
Resent-Message-ID: <20070115080152.GE8577@soda.linbit>
Received: from squawk.glines.org (squawk.glines.org [72.36.206.66])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 896FF2D9E0D8
	for <drbd-dev@lists.linbit.com>; Mon, 15 Jan 2007 08:52:06 +0100 (CET)
Received: from [10.1.0.9] (adsl-75-28-77-94.dsl.scrm01.sbcglobal.net
	[75.28.77.94])
	by squawk.glines.org (Postfix) with ESMTP id C09EE10371F
	for <drbd-dev@lists.linbit.com>; Sun, 14 Jan 2007 23:52:04 -0800 (PST)
Message-ID: <45AB32A1.5080804@glines.org>
Date: Sun, 14 Jan 2007 23:52:01 -0800
From: Mark Glines <mark@glines.org>
MIME-Version: 1.0
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] drbd-svn can't handle modular hmac,	and crashes if
	hash can't be found
References: <45AA65F4.90709@glines.org> <20070115074512.GD8577@soda.linbit>
In-Reply-To: <20070115074512.GD8577@soda.linbit>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Lars Ellenberg wrote:
>> 2.  If the hash algorithm itself isn't available (like sha1.ko wasn't loaded yet), crypto_alloc_hash() returns 
>> -ENOENT.  It does not return NULL, which is what the drbd code currently checks for.  This leads to crashes later.
> 
> right... we know 't was unfinished code,
> but checked in anyways, to get it going.

FYI, it's working here on 2.6.20-rc4 (PPC) with CONFIG_CRYPTO_HMAC and 
CONFIG_CRYPTO_SHA1 both configured as modules.  So now I'm watching my 
new cluster sync up for the first time:

drbd0: Writing meta data super block now.
drbd0: conn( WFConnection -> WFReportParams )
drbd0: Handshake successful: DRBD Network Protocol version 85
drbd0: Peer authenticated usind 20 bytes of 'sha1' HMAC
drbd0: peer( Unknown -> Secondary ) conn( WFReportParams -> WFBitMapS ) 
pdsk( DUnknown -> Inconsistent )
drbd0: Writing meta data super block now.
drbd0: conn( WFBitMapS -> SyncSource )
drbd0: Began resync as SyncSource (will sync 9775216 KB [2443804 bits set]).


>> P.S.  Since drbd no longer requires any exported symbols from the hmac/hash module, is there any reason to check 
>> CONFIG_CRYPTO_HMAC at all?  A simpler check on CONFIG_CRYPTO to make sure the basic API exists should be all you 
>> need...
> 
> we build against older kernels as well,
> and as long as debian, suse, redhat & co have their
> vendor kernels the way they are, this probably needs to stay this way.
> we should be able to relax it for builds against newer kernels, though.

Makes sense.  Thanks again!

Mark

