Return-Path: <joe@perches.com>
Received: from smtprelay.hostedemail.com (smtprelay0200.hostedemail.com
	[216.40.44.200])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id C3561420229
	for <drbd-dev@lists.linbit.com>; Thu, 14 May 2020 13:52:02 +0200 (CEST)
Message-ID: <9992a1fe768a0b1e9bb9470d2728ba25dbe042db.camel@perches.com>
From: Joe Perches <joe@perches.com>
To: Christoph Hellwig <hch@lst.de>
Date: Thu, 14 May 2020 04:51:26 -0700
In-Reply-To: <20200514103025.GB12680@lst.de>
References: <20200513062649.2100053-1-hch@lst.de>
	<20200513062649.2100053-21-hch@lst.de>
	<0ee5acfaca4cf32d4efad162046b858981a4dae3.camel@perches.com>
	<20200514103025.GB12680@lst.de>
Content-Type: text/plain; charset="ISO-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	linux-nvme@lists.infradead.org,
	Eric Dumazet <edumazet@google.com>, target-devel@vger.kernel.org,
	linux-afs@lists.infradead.org, drbd-dev@lists.linbit.com, Vlad,
	rds-devel@oss.oracle.com, linux-rdma@vger.kernel.org,
	cluster-devel@redhat.com, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
	linux-cifs@vger.kernel.org, linux-block@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>, ceph-devel@vger.kernel.org,
	linux-nfs@vger.kernel.org, Neil Horman <nhorman@tuxdriver.com>,
	Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
	netdev@vger.kernel.org, Yasevich <vyasevich@gmail.com>,
	linux-kernel@vger.kernel.org, Jon Maloy <jmaloy@redhat.com>,
	linux-sctp@vger.kernel.org, Ying Xue <ying.xue@windriver.com>,
	"David S. Miller" <davem@davemloft.net>, ocfs2-devel@oss.oracle.com
Subject: Re: [Drbd-dev] [PATCH 20/33] ipv4: add ip_sock_set_recverr
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

On Thu, 2020-05-14 at 12:30 +0200, Christoph Hellwig wrote:
> On Wed, May 13, 2020 at 02:00:43PM -0700, Joe Perches wrote:
> > On Wed, 2020-05-13 at 08:26 +0200, Christoph Hellwig wrote:
> > > Add a helper to directly set the IP_RECVERR sockopt from kernel space
> > > without going through a fake uaccess.
> > 
> > This seems used only with true as the second arg.
> > Is there reason to have that argument at all?
> 
> Mostly to keep it symmetric with the sockopt.  I could probably remove
> a few arguments in the series if we want to be strict.

My preference would use strict and add
arguments only when necessary.


