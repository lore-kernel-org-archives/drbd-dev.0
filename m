Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
	[209.85.128.66])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 0A7AD420415
	for <drbd-dev@lists.linbit.com>; Sat, 13 Jun 2020 11:58:00 +0200 (CEST)
Received: by mail-wm1-f66.google.com with SMTP id f185so10150222wmf.3
	for <drbd-dev@lists.linbit.com>; Sat, 13 Jun 2020 02:58:00 -0700 (PDT)
Received: from soda.linbit (62-99-137-214.static.upcbusiness.at.
	[62.99.137.214]) by smtp.gmail.com with ESMTPSA id
	d16sm12639222wmd.42.2020.06.13.02.57.58
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
	Sat, 13 Jun 2020 02:57:59 -0700 (PDT)
Resent-Message-ID: <20200613095757.GI4222@soda.linbit>
Received: from eu-smtp-delivery-151.mimecast.com
	(eu-smtp-delivery-151.mimecast.com [207.82.80.151])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 87CED420105
	for <drbd-dev@lists.linbit.com>; Sat, 16 May 2020 17:21:18 +0200 (CEST)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Christoph Hellwig' <hch@lst.de>, David Howells <dhowells@redhat.com>
Message-ID: <c23030de384747ae83c6c0813bd4f1c0@AcuMS.aculab.com>
References: <20200514062820.GC8564@lst.de>
	<20200513062649.2100053-1-hch@lst.de>
	<20200513062649.2100053-28-hch@lst.de>
	<20200513180058.GB2491@localhost.localdomain>
	<129070.1589556002@warthog.procyon.org.uk>
	<20200515152459.GA28995@lst.de>
In-Reply-To: <20200515152459.GA28995@lst.de>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>,
	"target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
	"linux-afs@lists.infradead.org" <linux-afs@lists.infradead.org>,
	"drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>,
	"linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
	"rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"cluster-devel@redhat.com" <cluster-devel@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	Neil Horman <nhorman@tuxdriver.com>,
	Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Vlad Yasevich <vyasevich@gmail.com>, Eric Dumazet <edumazet@google.com>,
	Jon Maloy <jmaloy@redhat.com>, Ying Xue <ying.xue@windriver.com>,
	"David S. Miller" <davem@davemloft.net>,
	"ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>
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
Date: Sat, 13 Jun 2020 10:12:17 -0000

From: Christoph Hellwig
> Sent: 15 May 2020 16:25
> On Fri, May 15, 2020 at 04:20:02PM +0100, David Howells wrote:
> > Christoph Hellwig <hch@lst.de> wrote:
> >
> > > > The advantage on using kernel_setsockopt here is that sctp module w=
ill
> > > > only be loaded if dlm actually creates a SCTP socket.  With this
> > > > change, sctp will be loaded on setups that may not be actually usin=
g
> > > > it. It's a quite big module and might expose the system.
> > >
> > > True.  Not that the intent is to kill kernel space callers of setsock=
opt,
> > > as I plan to remove the set_fs address space override used for it.
> >
> > For getsockopt, does it make sense to have the core kernel load optval/=
optlen
> > into a buffer before calling the protocol driver?  Then the driver need=
 not
> > see the userspace pointer at all.
> >
> > Similar could be done for setsockopt - allocate a buffer of the size re=
quested
> > by the user inside the kernel and pass it into the driver, then copy th=
e data
> > back afterwards.
>=20
> I did look into that initially.  The problem is that tons of sockopts
> entirely ignore optlen and just use a fixed size.  So I fear that there
> could be tons of breakage if we suddently respect it.  Otherwise that
> would be a pretty nice way to handle the situation.

I'd guess that most application use the correct size for setsockopt().
(Well, apart from using 4 instead of 1.)

It is certainly possible to always try to read in 64 bytes
regardless of the supplied length, but handle the EFAULT case
by shortening the buffer.

Historically getsockopt() only wrote the length back.
Treating 0 and garbage as (say) 4k and letting the protocol
code set a shorten the copy to user might work.
All short transfers would want to use an on-stack buffer,
so slight oversizes could also be allowed for.

OTOH if i did a getsockopt() with too short a length I wouldn't
want the kernel to trash my program memory.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)

