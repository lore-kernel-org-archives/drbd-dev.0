Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
	[209.85.221.67])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 5992742041F
	for <drbd-dev@lists.linbit.com>; Sat, 13 Jun 2020 11:58:16 +0200 (CEST)
Received: by mail-wr1-f67.google.com with SMTP id l10so12263371wrr.10
	for <drbd-dev@lists.linbit.com>; Sat, 13 Jun 2020 02:58:16 -0700 (PDT)
Received: from soda.linbit (62-99-137-214.static.upcbusiness.at.
	[62.99.137.214]) by smtp.gmail.com with ESMTPSA id
	b132sm12742537wmh.3.2020.06.13.02.58.15
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
	Sat, 13 Jun 2020 02:58:15 -0700 (PDT)
Resent-Message-ID: <20200613095813.GO4222@soda.linbit>
Received: from mail-qt1-f194.google.com (mail-qt1-f194.google.com
	[209.85.160.194])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 8714D420309
	for <drbd-dev@lists.linbit.com>; Thu, 21 May 2020 01:39:17 +0200 (CEST)
Received: by mail-qt1-f194.google.com with SMTP id v4so4126621qte.3
	for <drbd-dev@lists.linbit.com>; Wed, 20 May 2020 16:39:17 -0700 (PDT)
From: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To: David Miller <davem@davemloft.net>
Message-ID: <20200520233913.GV2491@localhost.localdomain>
References: <20200520195509.2215098-1-hch@lst.de>
	<20200520195509.2215098-32-hch@lst.de>
	<20200520231001.GU2491@localhost.localdomain>
	<20200520.162355.2212209708127373208.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520.162355.2212209708127373208.davem@davemloft.net>
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
Date: Sat, 13 Jun 2020 10:15:17 -0000

On Wed, May 20, 2020 at 04:23:55PM -0700, David Miller wrote:
> From: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
> Date: Wed, 20 May 2020 20:10:01 -0300
> 
> > The duplication with sctp_setsockopt_nodelay() is quite silly/bad.
> > Also, why have the 'true' hardcoded? It's what dlm uses, yes, but the
> > API could be a bit more complete than that.
> 
> The APIs are being designed based upon what in-tree users actually
> make use of.  We can expand things later if necessary.

Sometimes expanding things later can be though, thus why the worry.
But ok, I get it. Thanks.

The comment still applies, though. (re the duplication)
