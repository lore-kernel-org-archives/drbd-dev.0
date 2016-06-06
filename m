Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id BD9F210564B2
	for <drbd-dev@lists.linbit.com>; Fri, 10 Jun 2016 13:47:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id B74F7420308
	for <drbd-dev@lists.linbit.com>; Fri, 10 Jun 2016 13:47:49 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 2Iw-3AS1113T for <drbd-dev@lists.linbit.com>;
	Fri, 10 Jun 2016 13:47:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 99EA2420313
	for <drbd-dev@lists.linbit.com>; Fri, 10 Jun 2016 13:47:49 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id OIPe0ow9CFP5 for <drbd-dev@lists.linbit.com>;
	Fri, 10 Jun 2016 13:47:49 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 6FA17420308
	for <drbd-dev@lists.linbit.com>; Fri, 10 Jun 2016 13:47:49 +0200 (CEST)
Resent-Message-ID: <20160610114749.GE3235@soda.linbit>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 94C28105644B
	for <drbd-dev@lists.linbit.com>; Mon,  6 Jun 2016 08:51:41 +0200 (CEST)
To: mchristi@redhat.com, linux-f2fs-devel@lists.sourceforge.net,
	linux-ext4@vger.kernel.org, konrad.wilk@oracle.com,
	drbd-dev@lists.linbit.com, philipp.reisner@linbit.com,
	lars.ellenberg@linbit.com, linux-raid@vger.kernel.org,
	dm-devel@redhat.com,
	linux-fsdevel@vger.kernel.org, linux-bcache@vger.kernel.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-mtd@lists.infradead.org,
	target-devel@vger.kernel.org, linux-btrfs@vger.kernel.org,
	osd-dev@open-osd.org, xfs@oss.sgi.com, ocfs2-devel@oss.oracle.com
References: <1465155145-10812-1-git-send-email-mchristi@redhat.com>
	<1465155145-10812-42-git-send-email-mchristi@redhat.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <57551D7C.8000004@suse.de>
Date: Mon, 6 Jun 2016 08:51:40 +0200
MIME-Version: 1.0
In-Reply-To: <1465155145-10812-42-git-send-email-mchristi@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Drbd-dev] [PATCH 41/45] block, drivers,
	fs: shrink bi_rw from long to int
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

On 06/05/2016 09:32 PM, mchristi@redhat.com wrote:
> From: Mike Christie <mchristi@redhat.com>
>=20
> We don't need bi_rw to be so large on 64 bit archs, so
> reduce it to unsigned int.
>=20
> Signed-off-by: Mike Christie <mchristi@redhat.com>
> ---
>  block/blk-core.c           | 2 +-
>  drivers/md/dm-flakey.c     | 2 +-
>  drivers/md/raid5.c         | 6 +++---
>  fs/btrfs/check-integrity.c | 4 ++--
>  fs/btrfs/inode.c           | 2 +-
>  include/linux/blk_types.h  | 2 +-
>  6 files changed, 9 insertions(+), 9 deletions(-)
>=20
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
--=20
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N=FCrnberg
GF: F. Imend=F6rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N=FCrnberg)
