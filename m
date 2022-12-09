Return-Path: <pabeni@redhat.com>
Received: from us-smtp-delivery-124.mimecast.com
	(us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id BBAE2420372
	for <drbd-dev@lists.linbit.com>; Fri,  9 Dec 2022 13:44:01 +0100 (CET)
Received: by mail-wm1-f71.google.com with SMTP id
	ay19-20020a05600c1e1300b003cf758f1617so3885986wmb.5
	for <drbd-dev@lists.linbit.com>; Fri, 09 Dec 2022 04:37:13 -0800 (PST)
Message-ID: <d220402a232e204676d9100d6fe4c2ae08f753ee.camel@redhat.com>
From: Paolo Abeni <pabeni@redhat.com>
To: Benjamin Coddington <bcodding@redhat.com>, netdev@vger.kernel.org
Date: Fri, 09 Dec 2022 13:37:08 +0100
In-Reply-To: <c2ec184226acd21a191ccc1aa46a1d7e43ca7104.1669036433.git.bcodding@redhat.com>
References: <cover.1669036433.git.bcodding@redhat.com>
	<c2ec184226acd21a191ccc1aa46a1d7e43ca7104.1669036433.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
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
	Jakub Kicinski <kuba@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>, open-iscsi@googlegroups.com,
	Keith, Anna Schumaker <anna@kernel.org>,
	Hensbergen <ericvh@gmail.com>, "James
	E.J. Bottomley" <jejb@linux.ibm.com>, Josef Bacik <josef@toxicpanda.com>,
	David, linux-block@vger.kernel.org, nbd@other.debian.org, Greg,
	Teigland <teigland@redhat.com>, Joel Becker <jlbec@evilplan.org>,
	v9fs-developer@lists.sourceforge.net, Busch <kbusch@kernel.org>,
	ceph-devel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Jens Axboe <axboe@kernel.dk>, Chris Leech <cleech@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
	linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Steve French <sfrench@samba.org>, Chuck Lever <chuck.lever@oracle.com>,
	Lee Duncan <lduncan@suse.com>,
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

On Mon, 2022-11-21 at 08:35 -0500, Benjamin Coddington wrote:
> Since moving to memalloc_nofs_save/restore, SUNRPC has stopped setting the
> GFP_NOIO flag on sk_allocation which the networking system uses to decide
> when it is safe to use current->task_frag.  The results of this are
> unexpected corruption in task_frag when SUNRPC is involved in memory
> reclaim.
> 
> The corruption can be seen in crashes, but the root cause is often
> difficult to ascertain as a crashing machine's stack trace will have no
> evidence of being near NFS or SUNRPC code.  I believe this problem to
> be much more pervasive than reports to the community may indicate.
> 
> Fix this by having kernel users of sockets that may corrupt task_frag due
> to reclaim set sk_use_task_frag = false.  Preemptively correcting this
> situation for users that still set sk_allocation allows them to convert to
> memalloc_nofs_save/restore without the same unexpected corruptions that are
> sure to follow, unlikely to show up in testing, and difficult to bisect.
> 
> CC: Philipp Reisner <philipp.reisner@linbit.com>
> CC: Lars Ellenberg <lars.ellenberg@linbit.com>
> CC: "Christoph Böhmwalder" <christoph.boehmwalder@linbit.com>
> CC: Jens Axboe <axboe@kernel.dk>
> CC: Josef Bacik <josef@toxicpanda.com>
> CC: Keith Busch <kbusch@kernel.org>
> CC: Christoph Hellwig <hch@lst.de>
> CC: Sagi Grimberg <sagi@grimberg.me>
> CC: Lee Duncan <lduncan@suse.com>
> CC: Chris Leech <cleech@redhat.com>
> CC: Mike Christie <michael.christie@oracle.com>
> CC: "James E.J. Bottomley" <jejb@linux.ibm.com>
> CC: "Martin K. Petersen" <martin.petersen@oracle.com>
> CC: Valentina Manea <valentina.manea.m@gmail.com>
> CC: Shuah Khan <shuah@kernel.org>
> CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> CC: David Howells <dhowells@redhat.com>
> CC: Marc Dionne <marc.dionne@auristor.com>
> CC: Steve French <sfrench@samba.org>
> CC: Christine Caulfield <ccaulfie@redhat.com>
> CC: David Teigland <teigland@redhat.com>
> CC: Mark Fasheh <mark@fasheh.com>
> CC: Joel Becker <jlbec@evilplan.org>
> CC: Joseph Qi <joseph.qi@linux.alibaba.com>
> CC: Eric Van Hensbergen <ericvh@gmail.com>
> CC: Latchesar Ionkov <lucho@ionkov.net>
> CC: Dominique Martinet <asmadeus@codewreck.org>
> CC: "David S. Miller" <davem@davemloft.net>
> CC: Eric Dumazet <edumazet@google.com>
> CC: Jakub Kicinski <kuba@kernel.org>
> CC: Paolo Abeni <pabeni@redhat.com>
> CC: Ilya Dryomov <idryomov@gmail.com>
> CC: Xiubo Li <xiubli@redhat.com>
> CC: Chuck Lever <chuck.lever@oracle.com>
> CC: Jeff Layton <jlayton@kernel.org>
> CC: Trond Myklebust <trond.myklebust@hammerspace.com>
> CC: Anna Schumaker <anna@kernel.org>
> CC: drbd-dev@lists.linbit.com
> CC: linux-block@vger.kernel.org
> CC: linux-kernel@vger.kernel.org
> CC: nbd@other.debian.org
> CC: linux-nvme@lists.infradead.org
> CC: open-iscsi@googlegroups.com
> CC: linux-scsi@vger.kernel.org
> CC: linux-usb@vger.kernel.org
> CC: linux-afs@lists.infradead.org
> CC: linux-cifs@vger.kernel.org
> CC: samba-technical@lists.samba.org
> CC: cluster-devel@redhat.com
> CC: ocfs2-devel@oss.oracle.com
> CC: v9fs-developer@lists.sourceforge.net
> CC: netdev@vger.kernel.org
> CC: ceph-devel@vger.kernel.org
> CC: linux-nfs@vger.kernel.org
> 
> Suggested-by: Guillaume Nault <gnault@redhat.com>
> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>

I think this is the most feasible way out of the existing issue, and I
think this patchset should go via the networking tree, targeting the
Linux 6.2.

If someone has disagreement with the above, please speak! 

Thanks,

Paolo

