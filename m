Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
	[209.85.221.41])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id D1AAC420421
	for <drbd-dev@lists.linbit.com>; Sat, 13 Jun 2020 11:58:26 +0200 (CEST)
Received: by mail-wr1-f41.google.com with SMTP id l11so12301602wru.0
	for <drbd-dev@lists.linbit.com>; Sat, 13 Jun 2020 02:58:26 -0700 (PDT)
Received: from soda.linbit (62-99-137-214.static.upcbusiness.at.
	[62.99.137.214]) by smtp.gmail.com with ESMTPSA id
	p7sm14383155wro.26.2020.06.13.02.58.25
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
	Sat, 13 Jun 2020 02:58:25 -0700 (PDT)
Resent-Message-ID: <20200613095823.GS4222@soda.linbit>
Received: from eu-smtp-delivery-151.mimecast.com
	(eu-smtp-delivery-151.mimecast.com [146.101.78.151])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 87C674203D6
	for <drbd-dev@lists.linbit.com>; Thu, 21 May 2020 12:46:36 +0200 (CEST)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Christoph Hellwig' <hch@lst.de>
Message-ID: <b7c7cf98999f4167b821f4425896e4e8@AcuMS.aculab.com>
References: <20200520195509.2215098-1-hch@lst.de>
	<138a17dfff244c089b95f129e4ea2f66@AcuMS.aculab.com>
	<20200521091150.GA8401@lst.de>
In-Reply-To: <20200521091150.GA8401@lst.de>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: Marcelo Ricardo
	Leitner <marcelo.leitner@gmail.com>, Eric Dumazet <edumazet@google.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>,
	"target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
	"linux-afs@lists.infradead.org" <linux-afs@lists.infradead.org>,
	"drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>,
	"linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
	"rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"cluster-devel@redhat.com" <cluster-devel@redhat.com>,
	Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Jakub Kicinski <kuba@kernel.org>,
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
Date: Sat, 13 Jun 2020 10:17:17 -0000

From: 'Christoph Hellwig'
> Sent: 21 May 2020 10:12
...
> > I worried about whether getsockopt() should read the entire
> > user buffer first. SCTP needs the some of it often (including a
> > sockaddr_storage in one case), TCP needs it once.
> > However the cost of reading a few words is small, and a big
> > buffer probably needs setting to avoid leaking kernel
> > memory if the structure has holes or fields that don't get set.
> > Reading from userspace solves both issues.
>=20
> As mention in the thread on the last series:  That was my first idea, but
> we have way to many sockopts, especially in obscure protocols that just
> hard code the size.  The chance of breaking userspace in a way that can't
> be fixed without going back to passing user pointers to get/setsockopt
> is way to high to commit to such a change unfortunately.

Right the syscall stubs probably can't do it.
But the per-protocol ones can for the main protocols.

I posted a patch for SCTP yesterday that removes 800 lines
of source and 8k of object code.
Even that needs a horrid bodge for one request where the
length returned has to be less than the data copied!

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)

