Return-Path: <philipp.reisner@linbit.com>
Received: from mescal.linbit (unknown [86.59.100.100])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id B25BE2D9E033
	for <drbd-dev@lists.linbit.com>; Mon, 15 Jan 2007 18:06:19 +0100 (CET)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] oopses in 2.6.19.1
Date: Mon, 15 Jan 2007 18:06:20 +0100
References: <20070110123116.GX15730@kwaak.net>
	<20070111171205.GC15730@kwaak.net>
	<20070111180322.GD15730@kwaak.net>
In-Reply-To: <20070111180322.GD15730@kwaak.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701151806.20526.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

> Kernel BUG at ...ed/kernel/tyan-s2891/modules/drbd/drbd/lru_cache.c:312
> invalid opcode: 0000 [1] SMP
> CPU 1
> Modules linked in: drbd sha1 cn ipv6 tg3
>
[...]

Hi Ard,

Although I can not reproduce this crash here, I was able to trigger
"LOGIC BUG" Messages, by finishing the resync by by application-IO...

This bug fixes (at least parts of) the problem.

http://lists.linbit.com/pipermail/drbd-cvs/2007-January/001434.html

Could you verify if this patch changes the situation for you ?

-Phil
-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Vivenotgasse 48, 1120 Vienna, Austria        http://www.linbit.com :
