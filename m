Return-Path: <hch@lst.de>
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 378A24203BB
	for <drbd-dev@lists.linbit.com>; Thu, 21 May 2020 10:42:27 +0200 (CEST)
Date: Thu, 21 May 2020 10:42:24 +0200
From: Christoph Hellwig <hch@lst.de>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Message-ID: <20200521084224.GA7859@lst.de>
References: <20200520195509.2215098-1-hch@lst.de>
	<20200520195509.2215098-33-hch@lst.de>
	<20200520230025.GT2491@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520230025.GT2491@localhost.localdomain>
Cc: Eric Dumazet <edumazet@google.com>, linux-nvme@lists.infradead.org,
	linux-sctp@vger.kernel.org, target-devel@vger.kernel.org,
	linux-afs@lists.infradead.org, drbd-dev@lists.linbit.com,
	linux-cifs@vger.kernel.org, rds-devel@oss.oracle.com,
	linux-rdma@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	cluster-devel@redhat.com, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
	Jakub Kicinski <kuba@kernel.org>, ceph-devel@vger.kernel.org,
	linux-nfs@vger.kernel.org, Neil Horman <nhorman@tuxdriver.com>,
	Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
	netdev@vger.kernel.org, Vlad Yasevich <vyasevich@gmail.com>,
	linux-kernel@vger.kernel.org, Jon Maloy <jmaloy@redhat.com>,
	Ying Xue <ying.xue@windriver.com>, "David S. Miller" <davem@davemloft.net>,
	ocfs2-devel@oss.oracle.com
Subject: Re: [Drbd-dev] [PATCH 32/33] net: add a new bind_add method
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

On Wed, May 20, 2020 at 08:00:25PM -0300, Marcelo Ricardo Leitner wrote:
> > +	if (err)
> > +		return err;
> > +
> > +	lock_sock(sk);
> > +	err = sctp_do_bind(sk, (union sctp_addr *)addr, af->sockaddr_len);
> > +	if (!err)
> > +		err = sctp_send_asconf_add_ip(sk, addr, 1);
> 
> Some problems here.
> - addr may contain a list of addresses
> - the addresses, then, are not being validated
> - sctp_do_bind may fail, on which it requires some undoing
>   (like sctp_bindx_add does)
> - code duplication with sctp_setsockopt_bindx.

sctp_do_bind and thus this function only support a single address, as
that is the only thing that the DLM code requires.  I could move the
user copy out of sctp_setsockopt_bindx and reuse that, but it is a
rather rcane API.

> 
> This patch will conflict with David's one,
> [PATCH net-next] sctp: Pull the user copies out of the individual sockopt functions.

Do you have a link?  A quick google search just finds your mail that
I'm replying to.

> (I'll finish reviewing it in the sequence)
> 
> AFAICT, this patch could reuse/build on his work in there. The goal is
> pretty much the same and would avoid the issues above.
> 
> This patch could, then, point the new bind_add proto op to the updated
> sctp_setsockopt_bindx almost directly.
> 
> Question then is: dlm never removes an addr from the bind list. Do we
> want to add ops for both? Or one that handles both operations?
> Anyhow, having the add operation but not the del seems very weird to
> me.

We generally only add operations for things that we actually use.
bind_del is another logical op, but we can trivially add that when we
need it.
