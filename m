Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
	[209.85.128.66])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 6018E420404
	for <drbd-dev@lists.linbit.com>; Sat, 13 Jun 2020 11:57:14 +0200 (CEST)
Received: by mail-wm1-f66.google.com with SMTP id y20so10153747wmi.2
	for <drbd-dev@lists.linbit.com>; Sat, 13 Jun 2020 02:57:14 -0700 (PDT)
Received: from soda.linbit (62-99-137-214.static.upcbusiness.at.
	[62.99.137.214]) by smtp.gmail.com with ESMTPSA id
	p16sm15309761wru.27.2020.06.13.02.57.13
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
	Sat, 13 Jun 2020 02:57:13 -0700 (PDT)
Resent-Message-ID: <20200613095711.GU4222@soda.linbit>
Received: from eu-smtp-delivery-151.mimecast.com
	(eu-smtp-delivery-151.mimecast.com [207.82.80.151])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 3DB0F420229
	for <drbd-dev@lists.linbit.com>; Thu, 14 May 2020 11:51:03 +0200 (CEST)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Marcelo Ricardo Leitner' <marcelo.leitner@gmail.com>, Christoph Hellwig
	<hch@lst.de>
Message-ID: <d112e18bfbdd40dfb219ed2c1f2082d4@AcuMS.aculab.com>
References: <20200513062649.2100053-1-hch@lst.de>
	<20200513062649.2100053-33-hch@lst.de>
	<20200513180302.GC2491@localhost.localdomain>
In-Reply-To: <20200513180302.GC2491@localhost.localdomain>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: Eric Dumazet <edumazet@google.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>,
	"target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
	"linux-afs@lists.infradead.org" <linux-afs@lists.infradead.org>,
	"drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>,
	"linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
	"rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"cluster-devel@redhat.com" <cluster-devel@redhat.com>,
	Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	Neil Horman <nhorman@tuxdriver.com>,
	Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Vlad Yasevich <vyasevich@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Jon Maloy <jmaloy@redhat.com>, Ying Xue <ying.xue@windriver.com>,
	"David S. Miller" <davem@davemloft.net>,
	"ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>
Subject: Re: [Drbd-dev] [PATCH 32/33] sctp: add sctp_sock_get_primary_addr
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
Date: Sat, 13 Jun 2020 10:05:15 -0000

From: Marcelo Ricardo Leitner
> Sent: 13 May 2020 19:03
>=20
> On Wed, May 13, 2020 at 08:26:47AM +0200, Christoph Hellwig wrote:
> > Add a helper to directly get the SCTP_PRIMARY_ADDR sockopt from kernel
> > space without going through a fake uaccess.
>=20
> Same comment as on the other dlm/sctp patch.

Wouldn't it be best to write sctp_[gs]etsockotp() that
use a kernel buffer and then implement the user-space
calls using a wrapper that does the copies to an on-stack
(or malloced if big) buffer.

That will also simplify the code be removing all the copies
and -EFAULT returns.
Only the size checks will be needed and the code can assume
the buffer is at least the size of the on-stack buffer.

Our SCTP code uses SO_REUSADDR, SCTP_EVENTS, SCTP_NODELAY,
SCTP_STATUS, SCTP_INITMSG, IPV6_ONLY, SCTP_SOCKOPT_BINDX_ADD
and SO_LINGER.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)

