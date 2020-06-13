Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
	[209.85.221.53])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id BB400420411
	for <drbd-dev@lists.linbit.com>; Sat, 13 Jun 2020 11:58:21 +0200 (CEST)
Received: by mail-wr1-f53.google.com with SMTP id x6so12244601wrm.13
	for <drbd-dev@lists.linbit.com>; Sat, 13 Jun 2020 02:58:21 -0700 (PDT)
Received: from soda.linbit (62-99-137-214.static.upcbusiness.at.
	[62.99.137.214]) by smtp.gmail.com with ESMTPSA id
	k21sm14605169wrd.24.2020.06.13.02.58.20
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
	Sat, 13 Jun 2020 02:58:20 -0700 (PDT)
Resent-Message-ID: <20200613095818.GQ4222@soda.linbit>
Received: from eu-smtp-delivery-151.mimecast.com
	(eu-smtp-delivery-151.mimecast.com [207.82.80.151])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 0E7884203BB
	for <drbd-dev@lists.linbit.com>; Thu, 21 May 2020 10:01:36 +0200 (CEST)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Christoph Hellwig' <hch@lst.de>, "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>
Message-ID: <138a17dfff244c089b95f129e4ea2f66@AcuMS.aculab.com>
References: <20200520195509.2215098-1-hch@lst.de>
In-Reply-To: <20200520195509.2215098-1-hch@lst.de>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
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
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	Neil Horman <nhorman@tuxdriver.com>,
	Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Vlad
	Yasevich <vyasevich@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Jon Maloy <jmaloy@redhat.com>, Ying Xue <ying.xue@windriver.com>,
	"ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>
Subject: Re: [Drbd-dev] remove kernel_setsockopt and kernel_getsockopt v2
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
Date: Sat, 13 Jun 2020 10:16:17 -0000

From: Christoph Hellwig
> Sent: 20 May 2020 20:55
>=20
> this series removes the kernel_setsockopt and kernel_getsockopt
> functions, and instead switches their users to small functions that
> implement setting (or in one case getting) a sockopt directly using
> a normal kernel function call with type safety and all the other
> benefits of not having a function call.
>=20
> In some cases these functions seem pretty heavy handed as they do
> a lock_sock even for just setting a single variable, but this mirrors
> the real setsockopt implementation unlike a few drivers that just set
> set the fields directly.

How much does this increase the kernel code by?

You are also replicating a lot of code making it more
difficult to maintain.

I don't think the performance of an socket option code
really matters - it is usually done once when a socket
is initialised and the other costs of establishing a
connection will dominate.

Pulling the user copies outside the [gs]etsocksopt switch
statement not only reduces the code size (source and object)
and trivially allows kernel_[sg]sockopt() to me added to
the list of socket calls.

It probably isn't possible to pull the usercopies right
out into the syscall wrapper because of some broken
requests.

I worried about whether getsockopt() should read the entire
user buffer first. SCTP needs the some of it often (including a
sockaddr_storage in one case), TCP needs it once.
However the cost of reading a few words is small, and a big
buffer probably needs setting to avoid leaking kernel
memory if the structure has holes or fields that don't get set.
Reading from userspace solves both issues.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)

