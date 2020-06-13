Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
	[209.85.221.67])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 2BDE0420406
	for <drbd-dev@lists.linbit.com>; Sat, 13 Jun 2020 11:57:27 +0200 (CEST)
Received: by mail-wr1-f67.google.com with SMTP id l10so12262088wrr.10
	for <drbd-dev@lists.linbit.com>; Sat, 13 Jun 2020 02:57:27 -0700 (PDT)
Received: from soda.linbit (62-99-137-214.static.upcbusiness.at.
	[62.99.137.214]) by smtp.gmail.com with ESMTPSA id
	v6sm14728948wrf.61.2020.06.13.02.57.25
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
	Sat, 13 Jun 2020 02:57:26 -0700 (PDT)
Resent-Message-ID: <20200613095724.GZ4222@soda.linbit>
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
	[207.211.31.120])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id B6EE14203C1
	for <drbd-dev@lists.linbit.com>; Thu, 14 May 2020 16:30:28 +0200 (CEST)
From: David Teigland <teigland@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Message-ID: <20200514142403.GA1447@redhat.com>
References: <20200513062649.2100053-1-hch@lst.de>
	<20200513062649.2100053-28-hch@lst.de>
	<20200513180058.GB2491@localhost.localdomain>
	<20200514104040.GA12979@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200514104040.GA12979@lst.de>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	linux-nvme@lists.infradead.org,
	Eric Dumazet <edumazet@google.com>, target-devel@vger.kernel.org,
	linux-afs@lists.infradead.org, drbd-dev@lists.linbit.com,
	linux-cifs@vger.kernel.org, rds-devel@oss.oracle.com,
	linux-rdma@vger.kernel.org, cluster-devel@redhat.com,
	Christine Caulfield <ccaulfie@redhat.com>,
	Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
	linux-block@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org,
	Neil Horman <nhorman@tuxdriver.com>,
	Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
	netdev@vger.kernel.org, Vlad Yasevich <vyasevich@gmail.com>,
	linux-kernel@vger.kernel.org, Jon Maloy <jmaloy@redhat.com>,
	linux-sctp@vger.kernel.org, Ying Xue <ying.xue@windriver.com>,
	"David S. Miller" <davem@davemloft.net>, ocfs2-devel@oss.oracle.com
Subject: Re: [Drbd-dev] is it ok to always pull in sctp for dlm,
 was: Re: [PATCH 27/33] sctp: export sctp_setsockopt_bindx
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
Date: Sat, 13 Jun 2020 10:07:45 -0000

On Thu, May 14, 2020 at 12:40:40PM +0200, Christoph Hellwig wrote:
> On Wed, May 13, 2020 at 03:00:58PM -0300, Marcelo Ricardo Leitner wrote:
> > On Wed, May 13, 2020 at 08:26:42AM +0200, Christoph Hellwig wrote:
> > > And call it directly from dlm instead of going through kernel_setsockopt.
> > 
> > The advantage on using kernel_setsockopt here is that sctp module will
> > only be loaded if dlm actually creates a SCTP socket.  With this
> > change, sctp will be loaded on setups that may not be actually using
> > it. It's a quite big module and might expose the system.
> > 
> > I'm okay with the SCTP changes, but I'll defer to DLM folks to whether
> > that's too bad or what for DLM.
> 
> So for ipv6 I could just move the helpers inline as they were trivial
> and avoid that issue.  But some of the sctp stuff really is way too
> big for that, so the only other option would be to use symbol_get.

Let's try symbol_get, having the sctp module always loaded caused problems
last time it happened (almost nobody uses dlm with it.)
Dave 

