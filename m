Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
	[209.85.221.67])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id D8305420407
	for <drbd-dev@lists.linbit.com>; Sat, 13 Jun 2020 11:57:49 +0200 (CEST)
Received: by mail-wr1-f67.google.com with SMTP id p5so12263328wrw.9
	for <drbd-dev@lists.linbit.com>; Sat, 13 Jun 2020 02:57:49 -0700 (PDT)
Received: from soda.linbit (62-99-137-214.static.upcbusiness.at.
	[62.99.137.214]) by smtp.gmail.com with ESMTPSA id
	h18sm14073486wru.7.2020.06.13.02.57.48
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
	Sat, 13 Jun 2020 02:57:48 -0700 (PDT)
Resent-Message-ID: <20200613095747.GE4222@soda.linbit>
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
	[205.139.110.120])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id EAE3D420105
	for <drbd-dev@lists.linbit.com>; Fri, 15 May 2020 17:14:20 +0200 (CEST)
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20200514102919.GA12680@lst.de>
References: <20200514102919.GA12680@lst.de>
	<20200513062649.2100053-30-hch@lst.de>
	<20200513062649.2100053-1-hch@lst.de>
	<3123534.1589375587@warthog.procyon.org.uk>
To: Christoph Hellwig <hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <128581.1589555639.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Message-ID: <128582.1589555639@warthog.procyon.org.uk>
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
Subject: Re: [Drbd-dev] [PATCH 29/33] rxrpc_sock_set_min_security_level
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
Date: Sat, 13 Jun 2020 10:10:15 -0000

Christoph Hellwig <hch@lst.de> wrote:

> > Looks good - but you do need to add this to Documentation/networking/r=
xrpc.txt
> > also, thanks.
> =

> That file doesn't exist, instead we now have a
> cumentation/networking/rxrpc.rst in weird markup.

Yeah - that's only in net/next thus far.

> Where do you want this to be added, and with what text?  Remember I don'=
t
> really know what this thing does, I just provide a shortcut.

The document itself describes what each rxrpc sockopt does.  Just look for
RXRPC_MIN_SECURITY_LEVEL in there;-)

Anyway, see the attached.  This also fixes a couple of errors in the doc t=
hat
I noticed.

David
---
diff --git a/Documentation/networking/rxrpc.rst b/Documentation/networking=
/rxrpc.rst
index 5ad35113d0f4..68552b92dc44 100644
--- a/Documentation/networking/rxrpc.rst
+++ b/Documentation/networking/rxrpc.rst
@@ -477,7 +477,7 @@ AF_RXRPC sockets support a few socket options at the S=
OL_RXRPC level:
 	 Encrypted checksum plus packet padded and first eight bytes of packet
 	 encrypted - which includes the actual packet length.
 =

-     (c) RXRPC_SECURITY_ENCRYPTED
+     (c) RXRPC_SECURITY_ENCRYPT
 =

 	 Encrypted checksum plus entire packet padded and encrypted, including
 	 actual packet length.
@@ -578,7 +578,7 @@ A client would issue an operation by:
      This issues a request_key() to get the key representing the security
      context.  The minimum security level can be set::
 =

-	unsigned int sec =3D RXRPC_SECURITY_ENCRYPTED;
+	unsigned int sec =3D RXRPC_SECURITY_ENCRYPT;
 	setsockopt(client, SOL_RXRPC, RXRPC_MIN_SECURITY_LEVEL,
 		   &sec, sizeof(sec));
 =

@@ -1090,6 +1090,15 @@ The kernel interface functions are as follows:
      jiffies).  In the event of the timeout occurring, the call will be
      aborted and -ETIME or -ETIMEDOUT will be returned.
 =

+ (#) Apply the RXRPC_MIN_SECURITY_LEVEL sockopt to a socket from within i=
n the
+     kernel::
+
+       int rxrpc_sock_set_min_security_level(struct sock *sk,
+					     unsigned int val);
+
+     This specifies the minimum security level required for calls on this
+     socket.
+
 =

 Configurable Parameters
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
index 7dfcbd58da85..e313dae01674 100644
--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -57,7 +57,7 @@ int afs_open_socket(struct afs_net *net)
 	srx.transport.sin6.sin6_port	=3D htons(AFS_CM_PORT);
 =

 	ret =3D rxrpc_sock_set_min_security_level(socket->sk,
-			RXRPC_SECURITY_ENCRYPT);
+						RXRPC_SECURITY_ENCRYPT);
 	if (ret < 0)
 		goto error_2;
 =

