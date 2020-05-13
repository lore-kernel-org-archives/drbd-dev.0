Return-Path: <joe@perches.com>
Received: from smtprelay.hostedemail.com (smtprelay0142.hostedemail.com
	[216.40.44.142])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id A92694202F0
	for <drbd-dev@lists.linbit.com>; Wed, 13 May 2020 19:49:03 +0200 (CEST)
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com
	[10.5.19.251])
	by smtpgrave05.hostedemail.com (Postfix) with ESMTP id A6295180220CF
	for <drbd-dev@lists.linbit.com>; Wed, 13 May 2020 17:39:36 +0000 (UTC)
Message-ID: <ecc165c33962d964d518c80de605af632eee0474.camel@perches.com>
From: Joe Perches <joe@perches.com>
To: Christoph Hellwig <hch@lst.de>, "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>
Date: Wed, 13 May 2020 10:38:59 -0700
In-Reply-To: <20200513062649.2100053-1-hch@lst.de>
References: <20200513062649.2100053-1-hch@lst.de>
Content-Type: text/plain; charset="ISO-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	linux-nvme@lists.infradead.org, linux-sctp@vger.kernel.org,
	target-devel@vger.kernel.org, linux-afs@lists.infradead.org,
	drbd-dev@lists.linbit.com, Vlad, rds-devel@oss.oracle.com,
	linux-rdma@vger.kernel.org, cluster-devel@redhat.com,
	Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
	linux-cifs@vger.kernel.org, linux-block@vger.kernel.org,
	ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org,
	Neil Horman <nhorman@tuxdriver.com>,
	Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
	netdev@vger.kernel.org, Yasevich <vyasevich@gmail.com>,
	linux-kernel@vger.kernel.org, Jon Maloy <jmaloy@redhat.com>,
	Ying Xue <ying.xue@windriver.com>, ocfs2-devel@oss.oracle.com
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

On Wed, 2020-05-13 at 08:26 +0200, Christoph Hellwig wrote:
> this series removes the kernel_setsockopt and kernel_getsockopt
> functions, and instead switches their users to small functions that
> implement setting (or in one case getting) a sockopt directly using
> a normal kernel function call with type safety and all the other
> benefits of not having a function call.
> 
> In some cases these functions seem pretty heavy handed as they do
> a lock_sock even for just setting a single variable, but this mirrors
> the real setsockopt implementation - counter to that a few kernel
> drivers just set the fields directly already.
> 
> Nevertheless the diffstat looks quite promising:
> 
>  42 files changed, 721 insertions(+), 799 deletions(-)

trivia:

It might be useful to show overall object size change.

More EXPORT_SYMBOL uses increase object size a little.

And not sure it matters much except it reduces overall object
size, but these patches remove (unnecessary) logging on error
and that could be mentioned in the cover letter too.

e.g.:

-       ret = kernel_setsockopt(queue->sock, SOL_SOCKET, SO_LINGER,
-                       (char *)&sol, sizeof(sol));
-       if (ret) {
-               dev_err(nctrl->device,
-                       "failed to set SO_LINGER sock opt %d\n", ret);
-               goto err_sock;
-       }
+       sock_set_linger(queue->sock->sk, true, 0);



