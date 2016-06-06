Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 7CCA910564B5
	for <drbd-dev@lists.linbit.com>; Fri, 10 Jun 2016 13:47:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 76F2E420313
	for <drbd-dev@lists.linbit.com>; Fri, 10 Jun 2016 13:47:48 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id In1ilZNhdfiP for <drbd-dev@lists.linbit.com>;
	Fri, 10 Jun 2016 13:47:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 5723A420311
	for <drbd-dev@lists.linbit.com>; Fri, 10 Jun 2016 13:47:48 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id m3rn_Cvk2maa for <drbd-dev@lists.linbit.com>;
	Fri, 10 Jun 2016 13:47:48 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 2FFED420313
	for <drbd-dev@lists.linbit.com>; Fri, 10 Jun 2016 13:47:48 +0200 (CEST)
Resent-Message-ID: <20160610114747.GC3235@soda.linbit>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 23BCF1056447
	for <drbd-dev@lists.linbit.com>; Mon,  6 Jun 2016 08:50:20 +0200 (CEST)
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
	<1465155145-10812-38-git-send-email-mchristi@redhat.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <57551D2B.1090707@suse.de>
Date: Mon, 6 Jun 2016 08:50:19 +0200
MIME-Version: 1.0
In-Reply-To: <1465155145-10812-38-git-send-email-mchristi@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Drbd-dev] [PATCH 37/45] drivers: use req op accessor
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
> The req operation REQ_OP is separated from the rq_flag_bits
> definition. This converts the block layer drivers to
> use req_op to get the op from the request struct.
>=20
> Signed-off-by: Mike Christie <mchristi@redhat.com>
> ---
>  drivers/block/loop.c              |  6 +++---
>  drivers/block/mtip32xx/mtip32xx.c |  2 +-
>  drivers/block/nbd.c               |  2 +-
>  drivers/block/rbd.c               |  4 ++--
>  drivers/block/xen-blkfront.c      |  8 +++++---
>  drivers/ide/ide-floppy.c          |  2 +-
>  drivers/md/dm.c                   |  2 +-
>  drivers/mmc/card/block.c          |  7 +++----
>  drivers/mmc/card/queue.c          |  6 ++----
>  drivers/mmc/card/queue.h          |  5 ++++-
>  drivers/mtd/mtd_blkdevs.c         |  2 +-
>  drivers/nvme/host/core.c          |  2 +-
>  drivers/nvme/host/nvme.h          |  4 ++--
>  drivers/scsi/sd.c                 | 25 ++++++++++++++++---------
>  14 files changed, 43 insertions(+), 34 deletions(-)
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
