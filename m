Return-Path: <jlayton@kernel.org>
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id F132442066E
	for <drbd-dev@lists.linbit.com>; Tue, 29 Nov 2022 18:51:02 +0100 (CET)
Message-ID: <d0a8f7a5e307e201926ae8e80d629da10c706a91.camel@kernel.org>
From: Jeff Layton <jlayton@kernel.org>
To: Christoph Hellwig <hch@lst.de>, Benjamin Coddington <bcodding@redhat.com>
Date: Tue, 29 Nov 2022 12:42:33 -0500
In-Reply-To: <20221129140242.GA15747@lst.de>
References: <cover.1669036433.git.bcodding@redhat.com>
	<c2ec184226acd21a191ccc1aa46a1d7e43ca7104.1669036433.git.bcodding@redhat.com>
	<20221129140242.GA15747@lst.de>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Cc: Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Valentina Manea <valentina.manea.m@gmail.com>,
	linux-nvme@lists.infradead.org,
	Philipp Reisner <philipp.reisner@linbit.com>,
	David Howells <dhowells@redhat.com>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Eric Dumazet <edumazet@google.com>, linux-nfs@vger.kernel.org,
	Marc Dionne <marc.dionne@auristor.com>,
	Shuah Khan <shuah@kernel.org>, linux-afs@lists.infradead.org,
	Mike Christie <michael.christie@oracle.com>,
	drbd-dev@lists.linbit.com, linux-cifs@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>, linux-scsi@vger.kernel.org,
	Mark Fasheh <mark@fasheh.com>, cluster-devel@redhat.com,
	Christine Caulfield <ccaulfie@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>, Ilya Dryomov <idryomov@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Keith,
	Anna Schumaker <anna@kernel.org>, Hensbergen <ericvh@gmail.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	Josef Bacik <josef@toxicpanda.com>, David,
	linux-block@vger.kernel.org, nbd@other.debian.org, Greg,
	Teigland <teigland@redhat.com>, Joel Becker <jlbec@evilplan.org>,
	Chuck, v9fs-developer@lists.sourceforge.net,
	Busch <kbusch@kernel.org>, ceph-devel@vger.kernel.org,
	Xiubo Li <xiubli@redhat.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Jens Axboe <axboe@kernel.dk>, Chris Leech <cleech@redhat.com>,
	open-iscsi@googlegroups.com,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	netdev@vger.kernel.org, linux-usb@vger.kernel.org,
	samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Steve French <sfrench@samba.org>, Lever <chuck.lever@oracle.com>,
	Lee Duncan <lduncan@suse.com>, Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lars Ellenberg <lars.ellenberg@linbit.com>, Eric,
	ocfs2-devel@oss.oracle.com
Subject: Re: [Drbd-dev] [PATCH v1 2/3] Treewide: Stop corrupting socket's
	task_frag
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

On Tue, 2022-11-29 at 15:02 +0100, Christoph Hellwig wrote:
> Hmm.  Having to set a flag to not accidentally corrupt per-task
> state seems a bit fragile.  Wouldn't it make sense to find a way to opt
> into the feature only for sockets created from the syscall layer?

I agree that that would be cleaner. task_frag should have been an opt-in
thing all along. That change regressed all of the in-kernel users of
sockets.

Where would be the right place to set that flag for only userland
sockets? A lot of the in-kernel socket users hook into the socket API at
a fairly high-level. 9P and CIFS, for instance, call __sock_create.

We could set it in the syscall handlers (and maybe in iouring) I
suppose, but that seems like the wrong thing to do too.

In the absence of a clean place to do this, I think we're going to be
stuck doing it the way Ben has proposed...
--=20
Jeff Layton <jlayton@kernel.org>
