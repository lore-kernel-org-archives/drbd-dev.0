Return-Path: <Lars.Ellenberg@linbit.com>
Received: from soda (unknown [86.59.100.100])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 742322D9DECC
	for <drbd-dev@lists.linbit.com>; Wed, 10 Jan 2007 14:48:02 +0100 (CET)
Date: Wed, 10 Jan 2007 14:48:04 +0100
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] drbd 2.6.19 crypto changes
Message-ID: <20070110134804.GI8061@soda.linbit>
References: <20070110123116.GX15730@kwaak.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070110123116.GX15730@kwaak.net>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

/ 2007-01-10 13:31:16 +0100
\ Ard van Breemen:
> This is a preliminary patch as in: as far as I can see it
> *should* work.
> Biggest change in the crypto api is that calls are more
> encapsulated.
> Instead of a hmac, we talk about hash only. We allocate and free
> hash structures, independent what kind of hash.
> To calculate the digest there are now 2 calls necessary: a call
> to setkey (if you want to use a key), and a call to generate the
> digest itself.
> This patch tries to keep the changes contained at a single point.
> This means we set the hash_key 2 times instead of being clever
> and setting it once in a more central point, and use that later
> on a few times.
> Anyway: it compiles without warning, it loads, what more do we
> want.

thank you very much...
and just in time!
we started working on that api change just now :)
this probably helps a lot.

-- 
: Lars Ellenberg                            Tel +43-1-8178292-55 :
: LINBIT Information Technologies GmbH      Fax +43-1-8178292-82 :
: Vivenotgasse 48, A-1120 Vienna/Europe    http://www.linbit.com :
