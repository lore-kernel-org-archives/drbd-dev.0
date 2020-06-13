Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
	[209.85.128.65])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 3EE23420403
	for <drbd-dev@lists.linbit.com>; Sat, 13 Jun 2020 11:57:05 +0200 (CEST)
Received: by mail-wm1-f65.google.com with SMTP id r9so10049770wmh.2
	for <drbd-dev@lists.linbit.com>; Sat, 13 Jun 2020 02:57:05 -0700 (PDT)
Received: from soda.linbit (62-99-137-214.static.upcbusiness.at.
	[62.99.137.214]) by smtp.gmail.com with ESMTPSA id
	p16sm15309111wru.27.2020.06.13.02.57.04
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
	Sat, 13 Jun 2020 02:57:04 -0700 (PDT)
Resent-Message-ID: <20200613095703.GT4222@soda.linbit>
Received: from eu-smtp-delivery-151.mimecast.com
	(eu-smtp-delivery-151.mimecast.com [146.101.78.151])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id BF3CF4202B5
	for <drbd-dev@lists.linbit.com>; Thu, 14 May 2020 10:31:00 +0200 (CEST)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Joe Perches' <joe@perches.com>, Christoph Hellwig <hch@lst.de>, "David S.
	Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Message-ID: <756758e8f0e34e2e97db470609f5fbba@AcuMS.aculab.com>
References: <20200513062649.2100053-1-hch@lst.de>
	<ecc165c33962d964d518c80de605af632eee0474.camel@perches.com>
In-Reply-To: <ecc165c33962d964d518c80de605af632eee0474.camel@perches.com>
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
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	Neil Horman <nhorman@tuxdriver.com>,
	Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Vlad
	Yasevich <vyasevich@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Jon Maloy <jmaloy@redhat.com>, Ying Xue <ying.xue@windriver.com>,
	"ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>
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
Date: Sat, 13 Jun 2020 10:04:45 -0000

From: Joe Perches
> Sent: 13 May 2020 18:39
> On Wed, 2020-05-13 at 08:26 +0200, Christoph Hellwig wrote:
> > this series removes the kernel_setsockopt and kernel_getsockopt
> > functions, and instead switches their users to small functions that
> > implement setting (or in one case getting) a sockopt directly using
> > a normal kernel function call with type safety and all the other
> > benefits of not having a function call.
> >
> > In some cases these functions seem pretty heavy handed as they do
> > a lock_sock even for just setting a single variable, but this mirrors
> > the real setsockopt implementation - counter to that a few kernel
> > drivers just set the fields directly already.
> >
> > Nevertheless the diffstat looks quite promising:
> >
> >  42 files changed, 721 insertions(+), 799 deletions(-)

I missed this patch going through.
Massive NACK.

You need to export functions that do most of the socket options
for all protocols.
As well as REUSADDR and NODELAY SCTP has loads because a lot
of stuff that should have been extra system calls got piled
into setsockopt.

An alternate solution would be to move the copy_to/from_user()
into a wrapper function so that the kernel_[sg]etsockopt()
functions would bypass them completely.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)

