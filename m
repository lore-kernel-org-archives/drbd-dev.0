Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 28BA910564AC
	for <drbd-dev@lists.linbit.com>; Fri, 10 Jun 2016 13:47:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 2447F42031C
	for <drbd-dev@lists.linbit.com>; Fri, 10 Jun 2016 13:47:53 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id MpOVafQZb86Z for <drbd-dev@lists.linbit.com>;
	Fri, 10 Jun 2016 13:47:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 057FE42031E
	for <drbd-dev@lists.linbit.com>; Fri, 10 Jun 2016 13:47:53 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id egKcG_ZbPIMM for <drbd-dev@lists.linbit.com>;
	Fri, 10 Jun 2016 13:47:52 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id D279442031C
	for <drbd-dev@lists.linbit.com>; Fri, 10 Jun 2016 13:47:52 +0200 (CEST)
Resent-Message-ID: <20160610114752.GF3235@soda.linbit>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 0FADD1056447
	for <drbd-dev@lists.linbit.com>; Mon,  6 Jun 2016 08:53:05 +0200 (CEST)
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
	<1465155145-10812-43-git-send-email-mchristi@redhat.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <57551DD0.9090703@suse.de>
Date: Mon, 6 Jun 2016 08:53:04 +0200
MIME-Version: 1.0
In-Reply-To: <1465155145-10812-43-git-send-email-mchristi@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Drbd-dev] [PATCH 42/45] block, fs,
 drivers: remove REQ_OP compat defs and related code
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
> This patch drops the compat definition of req_op where it matches
> the rq_flag_bits definitions, and drops the related old and compat
> code that allowed users to set either the op or flags for the operation=
.
>=20
> We also then store the operation in the bi_rw/cmd_flags field similar
> to how we used to store the bio ioprio where it sat in the upper bits
> of the field.
>=20
> Signed-off-by: Mike Christie <mchristi@redhat.com>
> ---
>  drivers/scsi/sd.c           |  2 +-
>  include/linux/bio.h         |  3 ---
>  include/linux/blk_types.h   | 52 +++++++++++++++++--------------------=
--------
>  include/linux/blkdev.h      | 14 ++++++++----
>  include/linux/fs.h          | 37 +++++++++++++-------------------
>  include/trace/events/f2fs.h |  1 -
>  6 files changed, 46 insertions(+), 63 deletions(-)
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
