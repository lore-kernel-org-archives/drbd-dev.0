Return-Path: <kuba@kernel.org>
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 1D3294252E8
	for <drbd-dev@lists.linbit.com>; Fri,  9 Dec 2022 17:11:06 +0100 (CET)
Date: Fri, 9 Dec 2022 08:11:01 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Message-ID: <20221209081101.7500478c@kernel.org>
In-Reply-To: <d220402a232e204676d9100d6fe4c2ae08f753ee.camel@redhat.com>
References: <cover.1669036433.git.bcodding@redhat.com>
	<c2ec184226acd21a191ccc1aa46a1d7e43ca7104.1669036433.git.bcodding@redhat.com>
	<d220402a232e204676d9100d6fe4c2ae08f753ee.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Latchesar Ionkov <lucho@ionkov.net>, samba-technical@lists.samba.org,
	Dominique Martinet <asmadeus@codewreck.org>,
	Valentina Manea <valentina.manea.m@gmail.com>,
	linux-nvme@lists.infradead.org,
	Philipp Reisner <philipp.reisner@linbit.com>,
	David Howells <dhowells@redhat.com>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Eric Dumazet <edumazet@google.com>, linux-nfs@vger.kernel.org,
	Marc Dionne <marc.dionne@auristor.com>,
	Shuah Khan <shuah@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Mike Christie <michael.christie@oracle.com>,
	drbd-dev@lists.linbit.com, linux-cifs@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>, linux-scsi@vger.kernel.org,
	Mark Fasheh <mark@fasheh.com>, linux-afs@lists.infradead.org,
	cluster-devel@redhat.com, Christine Caulfield <ccaulfie@redhat.com>,
	v9fs-developer@lists.sourceforge.net,
	Ilya Dryomov <idryomov@gmail.com>, open-iscsi@googlegroups.com,
	Anna Schumaker <anna@kernel.org>, Hensbergen <ericvh@gmail.com>, "James
	E.J. Bottomley" <jejb@linux.ibm.com>, Josef Bacik <josef@toxicpanda.com>,
	David, linux-block@vger.kernel.org, nbd@other.debian.org, Greg,
	Teigland <teigland@redhat.com>, Joel Becker <jlbec@evilplan.org>,
	Chuck, Keith Busch <kbusch@kernel.org>,
	ceph-devel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Jens Axboe <axboe@kernel.dk>, Chris Leech <cleech@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>, Christoph,
	netdev@vger.kernel.org, linux-usb@vger.kernel.org,
	Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>, Steve French <sfrench@samba.org>,
	Benjamin Coddington <bcodding@redhat.com>,
	Lever <chuck.lever@oracle.com>, Lee Duncan <lduncan@suse.com>,
	Kroah-Hartman <gregkh@linuxfoundation.org>,
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

On Fri, 09 Dec 2022 13:37:08 +0100 Paolo Abeni wrote:
> I think this is the most feasible way out of the existing issue, and I
> think this patchset should go via the networking tree, targeting the
> Linux 6.2.

FWIW some fields had been moved so this will not longer apply cleanly,
see b534dc46c8ae016. But I think we can apply it to net since the merge
window is upon us? Just a heads up.
