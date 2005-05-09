Return-Path: <hug@abanet.ch>
Received: from shopwall.abacus.ch (shopwall.abacus.ch [193.246.120.14])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 0B08525753
	for <drbd-dev@lists.linbit.com>; Mon,  9 May 2005 10:57:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by postman.abacus.ch (Postfix) with ESMTP id 64F4712F891
	for <drbd-dev@lists.linbit.com>; Mon,  9 May 2005 10:57:20 +0200 (CEST)
Received: from postman.abacus.ch ([127.0.0.1])
	by localhost (postman [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 04210-02-81 for <drbd-dev@lists.linbit.com>;
	Mon, 9 May 2005 10:57:19 +0200 (CEST)
Received: from hug64.int.abacus.ch.int.abacus.ch (unknown [172.16.34.85])
	by postman.abacus.ch (Postfix) with ESMTP id E964512F6BE
	for <drbd-dev@lists.linbit.com>; Mon,  9 May 2005 10:57:18 +0200 (CEST)
From: Philipp Hug <hug@abanet.ch>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] 0.7.11 soon
Date: Mon, 9 May 2005 10:58:42 +0200
References: <200505091030.00455.philipp.reisner@linbit.com>
In-Reply-To: <200505091030.00455.philipp.reisner@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505091058.42759.hug@abanet.ch>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

philipp,

if you release a new version it won't make it into sarge...
0.7.10 will be in sarge and has to be supported for about 2 years ;-)

philipp
On Monday 09 May 2005 10.30, Philipp Reisner wrote:
> Hi,
>
> The last DRBD release happened on the 31st Jan of 2005, this
> is more than 3 month by now. I guess we need to give our
> users the feeling that DRBD is still alive :)
>
> 0.7.11 (api:77/proto:74)
> -----
>  * The upper limit of the runtime tuning parameter max_buffers
>    was ways too low for today's IBM storage controllers.
>    Was 32 - 10000 ; Now it is 32 - 131072 ( Now one could
>    allow DRBD to allocate up to half a gigabyte of memory as
>    receive buffers)
>  * A fix to the Makefiles to make building of RPMs work on RAHS4.
>  * A workaround to have DBRD running on PPC64 with Linux-2.4.x kernels,
>    on Linux-2.6.x everything was fine already.
>  * Removal of dead code (busy_blocks).
>
> I will tag, create the tar-ball and announce it on wednesday,
> as long as nobody objects.
>
> -phil
