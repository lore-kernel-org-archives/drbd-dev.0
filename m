Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
	[209.85.221.66])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 0F0DA4203F1
	for <drbd-dev@lists.linbit.com>; Sat, 13 Jun 2020 11:56:49 +0200 (CEST)
Received: by mail-wr1-f66.google.com with SMTP id t18so12293716wru.6
	for <drbd-dev@lists.linbit.com>; Sat, 13 Jun 2020 02:56:49 -0700 (PDT)
Received: from soda.linbit (62-99-137-214.static.upcbusiness.at.
	[62.99.137.214]) by smtp.gmail.com with ESMTPSA id
	u3sm13082273wrw.89.2020.06.13.02.56.47
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
	Sat, 13 Jun 2020 02:56:47 -0700 (PDT)
Resent-Message-ID: <20200613095646.GN4222@soda.linbit>
Received: from mail-qt1-f193.google.com (mail-qt1-f193.google.com
	[209.85.160.193])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 679EA420317
	for <drbd-dev@lists.linbit.com>; Wed, 13 May 2020 20:02:03 +0200 (CEST)
Received: by mail-qt1-f193.google.com with SMTP id t25so602230qtc.0
	for <drbd-dev@lists.linbit.com>; Wed, 13 May 2020 11:02:03 -0700 (PDT)
From: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Message-ID: <20200513180058.GB2491@localhost.localdomain>
References: <20200513062649.2100053-1-hch@lst.de>
	<20200513062649.2100053-28-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513062649.2100053-28-hch@lst.de>
Cc: Eric Dumazet <edumazet@google.com>, linux-nvme@lists.infradead.org,
	linux-sctp@vger.kernel.org, target-devel@vger.kernel.org,
	linux-afs@lists.infradead.org, drbd-dev@lists.linbit.com,
	linux-cifs@vger.kernel.org, rds-devel@oss.oracle.com,
	linux-rdma@vger.kernel.org, cluster-devel@redhat.com,
	Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
	linux-block@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org,
	Neil Horman <nhorman@tuxdriver.com>,
	Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
	netdev@vger.kernel.org, Vlad Yasevich <vyasevich@gmail.com>,
	linux-kernel@vger.kernel.org, Jon Maloy <jmaloy@redhat.com>,
	Ying Xue <ying.xue@windriver.com>, "David S. Miller" <davem@davemloft.net>,
	ocfs2-devel@oss.oracle.com
Subject: Re: [Drbd-dev] [PATCH 27/33] sctp: export sctp_setsockopt_bindx
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
Date: Sat, 13 Jun 2020 10:01:45 -0000

On Wed, May 13, 2020 at 08:26:42AM +0200, Christoph Hellwig wrote:
> And call it directly from dlm instead of going through kernel_setsockopt.

The advantage on using kernel_setsockopt here is that sctp module will
only be loaded if dlm actually creates a SCTP socket.  With this
change, sctp will be loaded on setups that may not be actually using
it. It's a quite big module and might expose the system.

I'm okay with the SCTP changes, but I'll defer to DLM folks to whether
that's too bad or what for DLM.

> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/dlm/lowcomms.c       | 13 ++++++++-----
>  include/net/sctp/sctp.h |  3 +++
>  net/sctp/socket.c       |  5 +++--
>  3 files changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
> index b722a09a7ca05..e4939d770df53 100644
> --- a/fs/dlm/lowcomms.c
> +++ b/fs/dlm/lowcomms.c
> @@ -1005,14 +1005,17 @@ static int sctp_bind_addrs(struct connection *con, uint16_t port)
>  		memcpy(&localaddr, dlm_local_addr[i], sizeof(localaddr));
>  		make_sockaddr(&localaddr, port, &addr_len);
>  
> -		if (!i)
> +		if (!i) {
>  			result = kernel_bind(con->sock,
>  					     (struct sockaddr *)&localaddr,
>  					     addr_len);
> -		else
> -			result = kernel_setsockopt(con->sock, SOL_SCTP,
> -						   SCTP_SOCKOPT_BINDX_ADD,
> -						   (char *)&localaddr, addr_len);
> +		} else {
> +			lock_sock(con->sock->sk);
> +			result = sctp_setsockopt_bindx(con->sock->sk,
> +					(struct sockaddr *)&localaddr, addr_len,
> +					SCTP_BINDX_ADD_ADDR);
> +			release_sock(con->sock->sk);
> +		}
>  
>  		if (result < 0) {
>  			log_print("Can't bind to %d addr number %d, %d.\n",
> diff --git a/include/net/sctp/sctp.h b/include/net/sctp/sctp.h
> index 3ab5c6bbb90bd..f702b14d768ba 100644
> --- a/include/net/sctp/sctp.h
> +++ b/include/net/sctp/sctp.h
> @@ -615,4 +615,7 @@ static inline bool sctp_newsk_ready(const struct sock *sk)
>  	return sock_flag(sk, SOCK_DEAD) || sk->sk_socket;
>  }
>  
> +int sctp_setsockopt_bindx(struct sock *sk, struct sockaddr *kaddrs,
> +		int addrs_size, int op);
> +
>  #endif /* __net_sctp_h__ */
> diff --git a/net/sctp/socket.c b/net/sctp/socket.c
> index 1c96b52c4aa28..30c981d9f6158 100644
> --- a/net/sctp/socket.c
> +++ b/net/sctp/socket.c
> @@ -979,8 +979,8 @@ int sctp_asconf_mgmt(struct sctp_sock *sp, struct sctp_sockaddr_entry *addrw)
>   *
>   * Returns 0 if ok, <0 errno code on error.
>   */
> -static int sctp_setsockopt_bindx(struct sock *sk, struct sockaddr *kaddrs,
> -				 int addrs_size, int op)
> +int sctp_setsockopt_bindx(struct sock *sk, struct sockaddr *kaddrs,
> +		int addrs_size, int op)
>  {
>  	int err;
>  	int addrcnt = 0;
> @@ -1032,6 +1032,7 @@ static int sctp_setsockopt_bindx(struct sock *sk, struct sockaddr *kaddrs,
>  		return -EINVAL;
>  	}
>  }
> +EXPORT_SYMBOL(sctp_setsockopt_bindx);
>  
>  static int sctp_connect_new_asoc(struct sctp_endpoint *ep,
>  				 const union sctp_addr *daddr,
> -- 
> 2.26.2
> 
