Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
	[209.85.128.65])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id A2BA4420409
	for <drbd-dev@lists.linbit.com>; Sat, 13 Jun 2020 11:57:52 +0200 (CEST)
Received: by mail-wm1-f65.google.com with SMTP id j198so10588304wmj.0
	for <drbd-dev@lists.linbit.com>; Sat, 13 Jun 2020 02:57:52 -0700 (PDT)
Received: from soda.linbit (62-99-137-214.static.upcbusiness.at.
	[62.99.137.214]) by smtp.gmail.com with ESMTPSA id
	j18sm14892937wrn.59.2020.06.13.02.57.51
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
	Sat, 13 Jun 2020 02:57:51 -0700 (PDT)
Resent-Message-ID: <20200613095749.GF4222@soda.linbit>
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
	[207.211.31.120])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 70725420105
	for <drbd-dev@lists.linbit.com>; Fri, 15 May 2020 17:15:40 +0200 (CEST)
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20200514062622.GA8564@lst.de>
References: <20200514062622.GA8564@lst.de>
	<20200513062649.2100053-22-hch@lst.de>
	<20200513062649.2100053-1-hch@lst.de>
	<3123898.1589375861@warthog.procyon.org.uk>
To: Christoph Hellwig <hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <128699.1589555724.1@warthog.procyon.org.uk>
Message-ID: <128700.1589555724@warthog.procyon.org.uk>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	dhowells@redhat.com, linux-sctp@vger.kernel.org,
	target-devel@vger.kernel.org, linux-afs@lists.infradead.org,
	drbd-dev@lists.linbit.com, linux-cifs@vger.kernel.org,
	rds-devel@oss.oracle.com, linux-rdma@vger.kernel.org,
	cluster-devel@redhat.com, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
	linux-block@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org,
	Neil Horman <nhorman@tuxdriver.com>,
	Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
	netdev@vger.kernel.org, Vlad Yasevich <vyasevich@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jon Maloy <jmaloy@redhat.com>, Ying Xue <ying.xue@windriver.com>,
	"David S. Miller" <davem@davemloft.net>, ocfs2-devel@oss.oracle.com
Subject: Re: [Drbd-dev] [PATCH 21/33] ipv4: add ip_sock_set_mtu_discover
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
Date: Sat, 13 Jun 2020 10:10:45 -0000

Christoph Hellwig <hch@lst.de> wrote:

> > > +		ip_sock_set_mtu_discover(conn->params.local->socket->sk,
> > > +				IP_PMTUDISC_DONT);
> > 
> > Um... The socket in question could be an AF_INET6 socket, not an AF_INET4
> > socket - I presume it will work in that case.  If so:
> 
> Yes, the implementation of that sockopt, including the inet_sock
> structure where these options are set is shared between ipv4 and ipv6.

Great!  Could you note that either in the patch description or in the
kerneldoc attached to the function?

Thanks,
David

