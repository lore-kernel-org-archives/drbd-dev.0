Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com
	[209.85.128.67])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 03BE042041A
	for <drbd-dev@lists.linbit.com>; Sat, 13 Jun 2020 11:58:13 +0200 (CEST)
Received: by mail-wm1-f67.google.com with SMTP id r15so10153722wmh.5
	for <drbd-dev@lists.linbit.com>; Sat, 13 Jun 2020 02:58:13 -0700 (PDT)
Received: from soda.linbit (62-99-137-214.static.upcbusiness.at.
	[62.99.137.214]) by smtp.gmail.com with ESMTPSA id
	l17sm14227459wrq.17.2020.06.13.02.58.12
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
	Sat, 13 Jun 2020 02:58:13 -0700 (PDT)
Resent-Message-ID: <20200613095811.GN4222@soda.linbit>
Received: from shards.monkeyblade.net (shards.monkeyblade.net [23.128.96.9])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 9CF3B420427
	for <drbd-dev@lists.linbit.com>; Thu, 21 May 2020 01:24:00 +0200 (CEST)
Message-Id: <20200520.162355.2212209708127373208.davem@davemloft.net>
To: marcelo.leitner@gmail.com
From: David Miller <davem@davemloft.net>
In-Reply-To: <20200520231001.GU2491@localhost.localdomain>
References: <20200520195509.2215098-1-hch@lst.de>
	<20200520195509.2215098-32-hch@lst.de>
	<20200520231001.GU2491@localhost.localdomain>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: edumazet@google.com, linux-nvme@lists.infradead.org,
	linux-sctp@vger.kernel.org, target-devel@vger.kernel.org,
	linux-afs@lists.infradead.org, drbd-dev@lists.linbit.com,
	linux-cifs@vger.kernel.org, rds-devel@oss.oracle.com,
	linux-rdma@vger.kernel.org, hch@lst.de, cluster-devel@redhat.com,
	kuznet@ms2.inr.ac.ru, kuba@kernel.org,
	ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org,
	nhorman@tuxdriver.com, yoshfuji@linux-ipv6.org,
	netdev@vger.kernel.org, vyasevich@gmail.com,
	linux-kernel@vger.kernel.org, jmaloy@redhat.com,
	ying.xue@windriver.com, ocfs2-devel@oss.oracle.com
Subject: Re: [Drbd-dev] [PATCH 31/33] sctp: add sctp_sock_set_nodelay
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <https://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <https://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>
Date: Sat, 13 Jun 2020 10:14:47 -0000

From: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Date: Wed, 20 May 2020 20:10:01 -0300

> The duplication with sctp_setsockopt_nodelay() is quite silly/bad.
> Also, why have the 'true' hardcoded? It's what dlm uses, yes, but the
> API could be a bit more complete than that.

The APIs are being designed based upon what in-tree users actually
make use of.  We can expand things later if necessary.
