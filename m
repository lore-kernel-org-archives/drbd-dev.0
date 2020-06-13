Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
	[209.85.221.67])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 88B3042040A
	for <drbd-dev@lists.linbit.com>; Sat, 13 Jun 2020 11:57:39 +0200 (CEST)
Received: by mail-wr1-f67.google.com with SMTP id x14so12295581wrp.2
	for <drbd-dev@lists.linbit.com>; Sat, 13 Jun 2020 02:57:39 -0700 (PDT)
Received: from soda.linbit (62-99-137-214.static.upcbusiness.at.
	[62.99.137.214])
	by smtp.gmail.com with ESMTPSA id r5sm14061980wrq.0.2020.06.13.02.57.38
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
	Sat, 13 Jun 2020 02:57:38 -0700 (PDT)
Resent-Message-ID: <20200613095736.GA4222@soda.linbit>
Received: from shards.monkeyblade.net (shards.monkeyblade.net [23.128.96.9])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 4169A4202B5
	for <drbd-dev@lists.linbit.com>; Thu, 14 May 2020 21:58:28 +0200 (CEST)
Message-Id: <20200514.125751.2175402701800030395.davem@davemloft.net>
To: David.Laight@ACULAB.COM
From: David Miller <davem@davemloft.net>
In-Reply-To: <756758e8f0e34e2e97db470609f5fbba@AcuMS.aculab.com>
References: <20200513062649.2100053-1-hch@lst.de>
	<ecc165c33962d964d518c80de605af632eee0474.camel@perches.com>
	<756758e8f0e34e2e97db470609f5fbba@AcuMS.aculab.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: marcelo.leitner@gmail.com, linux-nvme@lists.infradead.org,
	edumazet@google.com, target-devel@vger.kernel.org,
	linux-afs@lists.infradead.org, drbd-dev@lists.linbit.com,
	linux-cifs@vger.kernel.org, rds-devel@oss.oracle.com,
	linux-rdma@vger.kernel.org, hch@lst.de, cluster-devel@redhat.com,
	kuznet@ms2.inr.ac.ru, linux-block@vger.kernel.org,
	joe@perches.com, kuba@kernel.org, ceph-devel@vger.kernel.org,
	linux-nfs@vger.kernel.org, nhorman@tuxdriver.com,
	yoshfuji@linux-ipv6.org, netdev@vger.kernel.org,
	vyasevich@gmail.com, linux-kernel@vger.kernel.org,
	jmaloy@redhat.com, linux-sctp@vger.kernel.org,
	ying.xue@windriver.com, ocfs2-devel@oss.oracle.com
Subject: Re: [Drbd-dev] remove kernel_setsockopt and kernel_getsockopt
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
Date: Sat, 13 Jun 2020 10:08:15 -0000

From: David Laight <David.Laight@ACULAB.COM>
Date: Thu, 14 May 2020 08:29:30 +0000

> You need to export functions that do most of the socket options
> for all protocols.

If all in-tree users of this stuff are converted, there is no argument
for keeping these routines.

You seemed to be concerned about out of tree stuff.  If so, that's not
of our concern.
