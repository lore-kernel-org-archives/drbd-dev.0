Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 0C325106275E
	for <drbd-dev@lists.linbit.com>; Wed, 16 Sep 2009 08:06:41 +0200 (CEST)
Resent-Message-ID: <20090916060640.GC13782@barkeeper1-xen.linbit>
Received: from fgwmail8.fujitsu.co.jp (fgwmail8.fujitsu.co.jp [192.51.44.38])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 5A5FD106273B
	for <drbd-dev@lists.linbit.com>;
	Wed, 16 Sep 2009 03:02:36 +0200 (CEST)
Received: from fgwmail7.fujitsu.co.jp (fgwmail7.fujitsu.co.jp [192.51.44.37])
	by fgwmail8.fujitsu.co.jp (Fujitsu Gateway) with ESMTP id
	n8G0keNj027320 for <drbd-dev@lists.linbit.com> (envelope-from
	kosaki.motohiro@jp.fujitsu.com); Wed, 16 Sep 2009 09:46:40 +0900
Received: from m4.gw.fujitsu.co.jp ([10.0.50.74])
	by fgwmail7.fujitsu.co.jp (Fujitsu Gateway) with ESMTP id
	n8G0kZac029978 for <drbd-dev@lists.linbit.com> (envelope-from
	kosaki.motohiro@jp.fujitsu.com); Wed, 16 Sep 2009 09:46:36 +0900
Received: from smail (m4 [127.0.0.1])
	by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id A1AB945DE70
	for <drbd-dev@lists.linbit.com>; Wed, 16 Sep 2009 09:46:35 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
	by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 6AFAA45DE60
	for <drbd-dev@lists.linbit.com>; Wed, 16 Sep 2009 09:46:35 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 546931DB8041
	for <drbd-dev@lists.linbit.com>; Wed, 16 Sep 2009 09:46:35 +0900 (JST)
Received: from m106.s.css.fujitsu.com (m106.s.css.fujitsu.com [10.249.87.106])
	by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id BF4791DB8043
	for <drbd-dev@lists.linbit.com>; Wed, 16 Sep 2009 09:46:34 +0900 (JST)
From: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
To: Philipp Reisner <philipp.reisner@linbit.com>
In-Reply-To: <200909151645.14256.philipp.reisner@linbit.com>
References: <200909151645.14256.philipp.reisner@linbit.com>
Message-Id: <20090916094421.DB8F.A69D9226@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Date: Wed, 16 Sep 2009 09:46:34 +0900 (JST)
Cc: linux-kernel@vger.kernel.org, kosaki.motohiro@jp.fujitsu.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Lars Ellenberg <lars.ellenberg@linbit.com>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [GIT PULL] DRBD for 2.6.32
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

> Hi Linus,
> 
> Please pull
> git://git.drbd.org/linux-2.6-drbd.git drbd
> 
> DRBD is a shared-nothing, replicated block device. It is designed to
> serve as a building block for high availability clusters and
> in this context, is a "drop-in" replacement for shared storage.
> 
> It has been discussed and reviewed on the list since March,
> and Andrew has asked us to send a pull request for 2.6.32-rc1.
> 
> Stephen added us to linux-next in July, and our most recent 
> build failure against Jens' 2.6.32-rc1 updates was ironed out this 
> morning. So it should be in fairly good shape.
> 

I'm sorry for my delayed pointing out.
if anyone add new feature, its Kconfig default parameter should be N.

but AFAIK, DRBD use M. I hope you change it. At least, typical desktop user don't use DRBD.

Thanks.

- kosaki

>  Documentation/blockdev/drbd/DRBD-8.3-data-packets.svg          |  588 +
>  Documentation/blockdev/drbd/DRBD-data-packets.svg              |  459 +
>  Documentation/blockdev/drbd/README.txt                         |   16
>  Documentation/blockdev/drbd/conn-states-8.dot                  |   18
>  Documentation/blockdev/drbd/disk-states-8.dot                  |   16
>  Documentation/blockdev/drbd/drbd-connection-state-overview.dot |   85
>  Documentation/blockdev/drbd/node-states-8.dot                  |   14
>  MAINTAINERS                                                    |   13
>  drivers/block/Kconfig                                          |    2
>  drivers/block/Makefile                                         |    1
>  drivers/block/drbd/Kconfig                                     |   82
>  drivers/block/drbd/Makefile                                    |    8
>  drivers/block/drbd/drbd_actlog.c                               | 1484 +++
>  drivers/block/drbd/drbd_bitmap.c                               | 1327 ++
>  drivers/block/drbd/drbd_int.h                                  | 2258 +++++
>  drivers/block/drbd/drbd_main.c                                 | 3735 ++++++++
>  drivers/block/drbd/drbd_nl.c                                   | 2365 +++++
>  drivers/block/drbd/drbd_proc.c                                 |  266
>  drivers/block/drbd/drbd_receiver.c                             | 4456 ++++++++++
>  drivers/block/drbd/drbd_req.c                                  | 1132 ++
>  drivers/block/drbd/drbd_req.h                                  |  327
>  drivers/block/drbd/drbd_strings.c                              |  113
>  drivers/block/drbd/drbd_tracing.c                              |  753 +
>  drivers/block/drbd/drbd_tracing.h                              |   87
>  drivers/block/drbd/drbd_vli.h                                  |  351
>  drivers/block/drbd/drbd_worker.c                               | 1529 +++
>  drivers/block/drbd/drbd_wrappers.h                             |   91
>  include/linux/drbd.h                                           |  349
>  include/linux/drbd_limits.h                                    |  137
>  include/linux/drbd_nl.h                                        |  137
>  include/linux/drbd_tag_magic.h                                 |   83
>  include/linux/lru_cache.h                                      |  294
>  lib/Kconfig                                                    |    3
>  lib/Makefile                                                   |    2
>  lib/lru_cache.c                                                |  560 +
>  35 files changed, 23141 insertions(+)
> 
> -phil
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/



