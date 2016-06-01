Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id BB3D61056446
	for <drbd-dev@lists.linbit.com>; Fri, 10 Jun 2016 13:46:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id B3DAA4202FF
	for <drbd-dev@lists.linbit.com>; Fri, 10 Jun 2016 13:46:16 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 3vqzhLI210sU for <drbd-dev@lists.linbit.com>;
	Fri, 10 Jun 2016 13:46:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 8B1C1420305
	for <drbd-dev@lists.linbit.com>; Fri, 10 Jun 2016 13:46:16 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 8IBMwwfiH4OG for <drbd-dev@lists.linbit.com>;
	Fri, 10 Jun 2016 13:46:16 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 3A9A24202FF
	for <drbd-dev@lists.linbit.com>; Fri, 10 Jun 2016 13:46:16 +0200 (CEST)
Resent-Message-ID: <20160610114615.GQ3235@soda.linbit>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id E04731056445
	for <drbd-dev@lists.linbit.com>; Wed,  1 Jun 2016 16:13:44 +0200 (CEST)
To: Christoph Hellwig <hch@infradead.org>, Ming Lei <ming.lei@canonical.com>
References: <1464615294-9946-1-git-send-email-ming.lei@canonical.com>
	<20160601134300.GA15656@infradead.org>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <574EE8F7.4050509@suse.de>
Date: Wed, 1 Jun 2016 15:53:59 +0200
MIME-Version: 1.0
In-Reply-To: <20160601134300.GA15656@infradead.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Cc: linux-block@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
	Jan Kara <jack@suse.cz>, Mike Snitzer <snitzer@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Steven Whitehouse <swhiteho@redhat.com>,
	linux-kernel@vger.kernel.org, Sagi Grimberg <sagig@mellanox.com>,
	NeilBrown <neilb@suse.com>, Jens Axboe <axboe@fb.com>,
	Joe Thornber <ejt@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>,
	Shaohua Li <shli@fb.com>, Tejun Heo <tj@kernel.org>,
	Keith Busch <keith.busch@intel.com>,
	"open list:XFS FILESYSTEM" <xfs@oss.sgi.com>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	"open list:DRBD DRIVER" <drbd-dev@lists.linbit.com>
Subject: Re: [Drbd-dev] [PATCH v6 0/8] block: prepare for multipage bvecs
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On 06/01/2016 03:43 PM, Christoph Hellwig wrote:
> These patches look good on their own.  They might be an easier sell
> just as bio cleanups :)

Fully agree. I've seen (some) improvements with those patches, so
I'd prefer to have them.

You can add:

Tested-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
--=20
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N=FCrnberg
GF: F. Imend=F6rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N=FCrnberg)
