Return-Path: <BATV+a231b325d53909937e6f+6122+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id A1E7D42011A
	for <drbd-dev@lists.linbit.com>; Thu, 28 May 2020 07:13:11 +0200 (CEST)
From: Christoph Hellwig <hch@lst.de>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Date: Thu, 28 May 2020 07:12:08 +0200
Message-Id: <20200528051236.620353-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-cifs@vger.kernel.org, rds-devel@oss.oracle.com,
	cluster-devel@redhat.com, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, Jon Maloy <jmaloy@redhat.com>,
	linux-rdma@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	target-devel@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net, linux-nfs@vger.kernel.org,
	Ying Xue <ying.xue@windriver.com>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
	ceph-devel@vger.kernel.org, linux-afs@lists.infradead.org,
	ocfs2-devel@oss.oracle.com, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] remove most callers of kernel_setsockopt v3
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

Hi Dave,

this series removes most callers of the kernel_setsockopt functions, and
instead switches their users to small functions that implement setting a
sockopt directly using a normal kernel function call with type safety and
all the other benefits of not having a function call.

In some cases these functions seem pretty heavy handed as they do
a lock_sock even for just setting a single variable, but this mirrors
the real setsockopt implementation unlike a few drivers that just set
set the fields directly.


Changes since v2:
 - drop the separately merged kernel_getopt_removal
 - drop the sctp patches, as there is conflicting cleanup going on
 - add an additional ACK for the rxrpc changes

Changes since v1:
 - use ->getname for sctp sockets in dlm
 - add a new ->bind_add struct proto method for dlm/sctp
 - switch the ipv6 and remaining sctp helpers to inline function so that
   the ipv6 and sctp modules are not pulled in by any module that could
   potentially use ipv6 or sctp connections
 - remove arguments to various sock_* helpers that are always used with
   the same constant arguments
