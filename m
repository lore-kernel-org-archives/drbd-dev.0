Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
	[209.85.221.66])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id BCDA8420418
	for <drbd-dev@lists.linbit.com>; Sat, 13 Jun 2020 11:58:08 +0200 (CEST)
Received: by mail-wr1-f66.google.com with SMTP id l10so12263196wrr.10
	for <drbd-dev@lists.linbit.com>; Sat, 13 Jun 2020 02:58:08 -0700 (PDT)
Received: from soda.linbit (62-99-137-214.static.upcbusiness.at.
	[62.99.137.214]) by smtp.gmail.com with ESMTPSA id
	t129sm13788726wmf.41.2020.06.13.02.58.07
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
	Sat, 13 Jun 2020 02:58:07 -0700 (PDT)
Resent-Message-ID: <20200613095805.GL4222@soda.linbit>
Received: from mail-qk1-f196.google.com (mail-qk1-f196.google.com
	[209.85.222.196])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 935A042041F
	for <drbd-dev@lists.linbit.com>; Thu, 21 May 2020 01:00:30 +0200 (CEST)
Received: by mail-qk1-f196.google.com with SMTP id n14so5414454qke.8
	for <drbd-dev@lists.linbit.com>; Wed, 20 May 2020 16:00:30 -0700 (PDT)
From: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Message-ID: <20200520230025.GT2491@localhost.localdomain>
References: <20200520195509.2215098-1-hch@lst.de>
	<20200520195509.2215098-33-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520195509.2215098-33-hch@lst.de>
Cc: Eric Dumazet <edumazet@google.com>, linux-nvme@lists.infradead.org,
	linux-sctp@vger.kernel.org, target-devel@vger.kernel.org,
	linux-afs@lists.infradead.org, drbd-dev@lists.linbit.com,
	linux-cifs@vger.kernel.org, rds-devel@oss.oracle.com,
	linux-rdma@vger.kernel.org, cluster-devel@redhat.com,
	Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
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
Date: Sat, 13 Jun 2020 10:13:47 -0000

On Wed, May 20, 2020 at 09:55:08PM +0200, Christoph Hellwig wrote:
> The SCTP protocol allows to bind multiple address to a socket.  That
> feature is currently only exposed as a socket option.  Add a bind_add
> method struct proto that allows to bind additional addresses, and
> switch the dlm code to use the method instead of going through the
> socket option from kernel space.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/dlm/lowcomms.c  |  9 +++------
>  include/net/sock.h |  6 +++++-
>  net/core/sock.c    |  8 ++++++++
>  net/sctp/socket.c  | 23 +++++++++++++++++++++++
>  4 files changed, 39 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
> index 9f1c3cdc9d653..3543a8fec9075 100644
> --- a/fs/dlm/lowcomms.c
> +++ b/fs/dlm/lowcomms.c
> @@ -882,6 +882,7 @@ static void writequeue_entry_complete(struct writequeue_entry *e, int completed)
>  static int sctp_bind_addrs(struct connection *con, uint16_t port)
>  {
>  	struct sockaddr_storage localaddr;
> +	struct sockaddr *addr = (struct sockaddr *)&localaddr;
>  	int i, addr_len, result = 0;
>  
>  	for (i = 0; i < dlm_local_count; i++) {
> @@ -889,13 +890,9 @@ static int sctp_bind_addrs(struct connection *con, uint16_t port)
>  		make_sockaddr(&localaddr, port, &addr_len);
>  
>  		if (!i)
> -			result = kernel_bind(con->sock,
> -					     (struct sockaddr *)&localaddr,
> -					     addr_len);
> +			result = kernel_bind(con->sock, addr, addr_len);
>  		else
> -			result = kernel_setsockopt(con->sock, SOL_SCTP,
> -						   SCTP_SOCKOPT_BINDX_ADD,
> -						   (char *)&localaddr, addr_len);
> +			result = sock_bind_add(con->sock->sk, addr, addr_len);
>  
>  		if (result < 0) {
>  			log_print("Can't bind to %d addr number %d, %d.\n",
> diff --git a/include/net/sock.h b/include/net/sock.h
> index d994daa418ec2..6e9f713a78607 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -1156,7 +1156,9 @@ struct proto {
>  	int			(*sendpage)(struct sock *sk, struct page *page,
>  					int offset, size_t size, int flags);
>  	int			(*bind)(struct sock *sk,
> -					struct sockaddr *uaddr, int addr_len);
> +					struct sockaddr *addr, int addr_len);
> +	int			(*bind_add)(struct sock *sk,
> +					struct sockaddr *addr, int addr_len);
>  
>  	int			(*backlog_rcv) (struct sock *sk,
>  						struct sk_buff *skb);
> @@ -2698,4 +2700,6 @@ void sock_set_reuseaddr(struct sock *sk);
>  void sock_set_reuseport(struct sock *sk);
>  void sock_set_sndtimeo(struct sock *sk, s64 secs);
>  
> +int sock_bind_add(struct sock *sk, struct sockaddr *addr, int addr_len);
> +
>  #endif	/* _SOCK_H */
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 2ca3425b519c0..61ec573221a60 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -3712,3 +3712,11 @@ bool sk_busy_loop_end(void *p, unsigned long start_time)
>  }
>  EXPORT_SYMBOL(sk_busy_loop_end);
>  #endif /* CONFIG_NET_RX_BUSY_POLL */
> +
> +int sock_bind_add(struct sock *sk, struct sockaddr *addr, int addr_len)
> +{
> +	if (!sk->sk_prot->bind_add)
> +		return -EOPNOTSUPP;
> +	return sk->sk_prot->bind_add(sk, addr, addr_len);
> +}
> +EXPORT_SYMBOL(sock_bind_add);
> diff --git a/net/sctp/socket.c b/net/sctp/socket.c
> index 827a9903ee288..8a0b9258f65c0 100644
> --- a/net/sctp/socket.c
> +++ b/net/sctp/socket.c
> @@ -1057,6 +1057,27 @@ static int sctp_setsockopt_bindx(struct sock *sk,
>  	return err;
>  }
>  
> +static int sctp_bind_add(struct sock *sk, struct sockaddr *addr,
> +		int addrlen)
> +{
> +	struct sctp_af *af = sctp_get_af_specific(addr->sa_family);
> +	int err;
> +
> +	if (!af || af->sockaddr_len > addrlen)
> +		return -EINVAL;
> +	err = security_sctp_bind_connect(sk, SCTP_SOCKOPT_BINDX_ADD, addr,
> +			addrlen);

The security_ call above is done today within the sock lock.
I couldn't find any issue through a code review, though, so I'm fine
with leaving it as is. Just highlighting it..

> +	if (err)
> +		return err;
> +
> +	lock_sock(sk);
> +	err = sctp_do_bind(sk, (union sctp_addr *)addr, af->sockaddr_len);
> +	if (!err)
> +		err = sctp_send_asconf_add_ip(sk, addr, 1);

Some problems here.
- addr may contain a list of addresses
- the addresses, then, are not being validated
- sctp_do_bind may fail, on which it requires some undoing
  (like sctp_bindx_add does)
- code duplication with sctp_setsockopt_bindx.

This patch will conflict with David's one,
[PATCH net-next] sctp: Pull the user copies out of the individual sockopt functions.
(I'll finish reviewing it in the sequence)

AFAICT, this patch could reuse/build on his work in there. The goal is
pretty much the same and would avoid the issues above.

This patch could, then, point the new bind_add proto op to the updated
sctp_setsockopt_bindx almost directly.

Question then is: dlm never removes an addr from the bind list. Do we
want to add ops for both? Or one that handles both operations?
Anyhow, having the add operation but not the del seems very weird to
me.

> +	release_sock(sk);
> +	return err;
> +}
> +
>  static int sctp_connect_new_asoc(struct sctp_endpoint *ep,
>  				 const union sctp_addr *daddr,
>  				 const struct sctp_initmsg *init,
> @@ -9625,6 +9646,7 @@ struct proto sctp_prot = {
>  	.sendmsg     =	sctp_sendmsg,
>  	.recvmsg     =	sctp_recvmsg,
>  	.bind        =	sctp_bind,
> +	.bind_add    =  sctp_bind_add,
>  	.backlog_rcv =	sctp_backlog_rcv,
>  	.hash        =	sctp_hash,
>  	.unhash      =	sctp_unhash,
> @@ -9667,6 +9689,7 @@ struct proto sctpv6_prot = {
>  	.sendmsg	= sctp_sendmsg,
>  	.recvmsg	= sctp_recvmsg,
>  	.bind		= sctp_bind,
> +	.bind_add	= sctp_bind_add,
>  	.backlog_rcv	= sctp_backlog_rcv,
>  	.hash		= sctp_hash,
>  	.unhash		= sctp_unhash,
> -- 
> 2.26.2
> 
