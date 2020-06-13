Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
	[209.85.128.68])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 1DC13420423
	for <drbd-dev@lists.linbit.com>; Sat, 13 Jun 2020 11:58:29 +0200 (CEST)
Received: by mail-wm1-f68.google.com with SMTP id y20so10155419wmi.2
	for <drbd-dev@lists.linbit.com>; Sat, 13 Jun 2020 02:58:29 -0700 (PDT)
Received: from soda.linbit (62-99-137-214.static.upcbusiness.at.
	[62.99.137.214]) by smtp.gmail.com with ESMTPSA id
	h12sm14232427wro.80.2020.06.13.02.58.27
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
	Sat, 13 Jun 2020 02:58:28 -0700 (PDT)
Resent-Message-ID: <20200613095826.GT4222@soda.linbit>
Received: from mail-qt1-f196.google.com (mail-qt1-f196.google.com
	[209.85.160.196])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id A2F1A4203BB
	for <drbd-dev@lists.linbit.com>; Thu, 21 May 2020 15:33:52 +0200 (CEST)
Received: by mail-qt1-f196.google.com with SMTP id v4so5458903qte.3
	for <drbd-dev@lists.linbit.com>; Thu, 21 May 2020 06:33:52 -0700 (PDT)
From: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Message-ID: <20200521133348.GX2491@localhost.localdomain>
References: <20200520195509.2215098-1-hch@lst.de>
	<20200520195509.2215098-32-hch@lst.de>
	<20200520231001.GU2491@localhost.localdomain>
	<20200520.162355.2212209708127373208.davem@davemloft.net>
	<20200520233913.GV2491@localhost.localdomain>
	<20200521083442.GA7771@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521083442.GA7771@lst.de>
Cc: edumazet@google.com, linux-nvme@lists.infradead.org,
	linux-sctp@vger.kernel.org, target-devel@vger.kernel.org,
	linux-afs@lists.infradead.org, drbd-dev@lists.linbit.com,
	linux-cifs@vger.kernel.org, rds-devel@oss.oracle.com,
	linux-rdma@vger.kernel.org, cluster-devel@redhat.com,
	kuznet@ms2.inr.ac.ru, kuba@kernel.org,
	ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org,
	nhorman@tuxdriver.com, yoshfuji@linux-ipv6.org,
	netdev@vger.kernel.org, vyasevich@gmail.com,
	linux-kernel@vger.kernel.org, jmaloy@redhat.com,
	ying.xue@windriver.com, David Miller <davem@davemloft.net>,
	ocfs2-devel@oss.oracle.com
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
Date: Sat, 13 Jun 2020 10:17:47 -0000

On Thu, May 21, 2020 at 10:34:42AM +0200, Christoph Hellwig wrote:
> On Wed, May 20, 2020 at 08:39:13PM -0300, Marcelo Ricardo Leitner wrote:
> > On Wed, May 20, 2020 at 04:23:55PM -0700, David Miller wrote:
> > > From: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
> > > Date: Wed, 20 May 2020 20:10:01 -0300
> > > 
> > > > The duplication with sctp_setsockopt_nodelay() is quite silly/bad.
> > > > Also, why have the 'true' hardcoded? It's what dlm uses, yes, but the
> > > > API could be a bit more complete than that.
> > > 
> > > The APIs are being designed based upon what in-tree users actually
> > > make use of.  We can expand things later if necessary.
> > 
> > Sometimes expanding things later can be though, thus why the worry.
> > But ok, I get it. Thanks.
> > 
> > The comment still applies, though. (re the duplication)
> 
> Where do you see duplication?
> 
> sctp_setsockopt_nodelay does the following things:
> 
>  - verifies optlen, returns -EINVAL if it doesn't match
>  - calls get_user, returns -EFAULT on error
>  - converts the value from get_user to a boolean and assigns it
>    to sctp_sk(sk)->nodelay
>  - returns 0.
> 
> sctp_sock_set_nodelay does:
> 
>  - call lock_sock
>  - assign true to sctp_sk(sk)->nodelay
>  - call release_sock
>  - does not return an error code

With the patch there are now two ways of enabling nodelay. It may be
just a boolean set today, but if one wants to probe on it or if we
want to extend it with anything, say a debug msg, we have to do it in
two (very different) places.
