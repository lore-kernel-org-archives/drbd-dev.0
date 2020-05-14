Return-Path: <hch@lst.de>
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 7519F4202B5
	for <drbd-dev@lists.linbit.com>; Thu, 14 May 2020 08:28:51 +0200 (CEST)
Date: Thu, 14 May 2020 08:28:20 +0200
From: Christoph Hellwig <hch@lst.de>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Message-ID: <20200514062820.GC8564@lst.de>
References: <20200513062649.2100053-1-hch@lst.de>
	<20200513062649.2100053-28-hch@lst.de>
	<20200513180058.GB2491@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513180058.GB2491@localhost.localdomain>
Cc: Eric Dumazet <edumazet@google.com>, linux-nvme@lists.infradead.org,
	linux-sctp@vger.kernel.org, target-devel@vger.kernel.org,
	linux-afs@lists.infradead.org, drbd-dev@lists.linbit.com,
	linux-cifs@vger.kernel.org, rds-devel@oss.oracle.com,
	linux-rdma@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	cluster-devel@redhat.com, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
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

On Wed, May 13, 2020 at 03:00:58PM -0300, Marcelo Ricardo Leitner wrote:
> On Wed, May 13, 2020 at 08:26:42AM +0200, Christoph Hellwig wrote:
> > And call it directly from dlm instead of going through kernel_setsockopt.
> 
> The advantage on using kernel_setsockopt here is that sctp module will
> only be loaded if dlm actually creates a SCTP socket.  With this
> change, sctp will be loaded on setups that may not be actually using
> it. It's a quite big module and might expose the system.

True.  Not that the intent is to kill kernel space callers of setsockopt,
as I plan to remove the set_fs address space override used for it.  So
if always pulling in sctp is not an option for the DLM maintainers we'd
have to do tricks using symbol_get() or similar.

The same would also apply for ipv6, although I'm not sure how common
modular ipv6 is in practice.
