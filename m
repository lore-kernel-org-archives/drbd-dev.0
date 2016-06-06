Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id E00C410564B0
	for <drbd-dev@lists.linbit.com>; Fri, 10 Jun 2016 13:47:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id DA9C6420308
	for <drbd-dev@lists.linbit.com>; Fri, 10 Jun 2016 13:47:47 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id aF0kakhjBL1G for <drbd-dev@lists.linbit.com>;
	Fri, 10 Jun 2016 13:47:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id B5DDB420311
	for <drbd-dev@lists.linbit.com>; Fri, 10 Jun 2016 13:47:47 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id QOw0XlfYXc0B for <drbd-dev@lists.linbit.com>;
	Fri, 10 Jun 2016 13:47:47 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 8F223420308
	for <drbd-dev@lists.linbit.com>; Fri, 10 Jun 2016 13:47:47 +0200 (CEST)
Resent-Message-ID: <20160610114747.GB3235@soda.linbit>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 7DBB81056445
	for <drbd-dev@lists.linbit.com>; Mon,  6 Jun 2016 08:46:48 +0200 (CEST)
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
	<1465155145-10812-29-git-send-email-mchristi@redhat.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <57551C57.5090507@suse.de>
Date: Mon, 6 Jun 2016 08:46:47 +0200
MIME-Version: 1.0
In-Reply-To: <1465155145-10812-29-git-send-email-mchristi@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Drbd-dev] [PATCH 28/45] target: use bio op accessors
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
> Separate the op from the rq_flag_bits and have the target layer
> set/get the bio using bio_set_op_attrs/bio_op.
>=20
> Signed-off-by: Mike Christie <mchristi@redhat.com>
> ---
>  drivers/target/target_core_iblock.c | 29 ++++++++++++++---------------
>  drivers/target/target_core_pscsi.c  |  2 +-
>  2 files changed, 15 insertions(+), 16 deletions(-)
>=20
> diff --git a/drivers/target/target_core_iblock.c b/drivers/target/targe=
t_core_iblock.c
> index c25109c..22af12f 100644
> --- a/drivers/target/target_core_iblock.c
> +++ b/drivers/target/target_core_iblock.c
[ .. ]
> @@ -689,18 +690,15 @@ iblock_execute_rw(struct se_cmd *cmd, struct scat=
terlist *sgl, u32 sgl_nents,
>  		 * Force writethrough using WRITE_FUA if a volatile write cache
>  		 * is not enabled, or if initiator set the Force Unit Access bit.
>  		 */
> +		op =3D REQ_OP_WRITE;
>  		if (test_bit(QUEUE_FLAG_FUA, &q->queue_flags)) {
>  			if (cmd->se_cmd_flags & SCF_FUA)
> -				rw =3D WRITE_FUA;
> +				op_flags =3D WRITE_FUA;
>  			else if (!test_bit(QUEUE_FLAG_WC, &q->queue_flags))
> -				rw =3D WRITE_FUA;
> -			else
> -				rw =3D WRITE;
> -		} else {
> -			rw =3D WRITE;
> +				op_flags =3D WRITE_FUA;
>  		}
Wrong intendation.

>  	} else {
> -		rw =3D READ;
> +		op =3D REQ_OP_READ;
>  	}
> =20
>  	ibr =3D kzalloc(sizeof(struct iblock_req), GFP_KERNEL);
> @@ -714,7 +712,7 @@ iblock_execute_rw(struct se_cmd *cmd, struct scatte=
rlist *sgl, u32 sgl_nents,
>  		return 0;
>  	}
> =20
> -	bio =3D iblock_get_bio(cmd, block_lba, sgl_nents, rw);
> +	bio =3D iblock_get_bio(cmd, block_lba, sgl_nents, op, op_flags);
>  	if (!bio)
>  		goto fail_free_ibr;
> =20
> @@ -738,7 +736,8 @@ iblock_execute_rw(struct se_cmd *cmd, struct scatte=
rlist *sgl, u32 sgl_nents,
>  				bio_cnt =3D 0;
>  			}
> =20
> -			bio =3D iblock_get_bio(cmd, block_lba, sg_num, rw);
> +			bio =3D iblock_get_bio(cmd, block_lba, sg_num, op,
> +					     op_flags);
>  			if (!bio)
>  				goto fail_put_bios;
> =20
> diff --git a/drivers/target/target_core_pscsi.c b/drivers/target/target=
_core_pscsi.c
> index de18790..81564c8 100644
> --- a/drivers/target/target_core_pscsi.c
> +++ b/drivers/target/target_core_pscsi.c
> @@ -922,7 +922,7 @@ pscsi_map_sg(struct se_cmd *cmd, struct scatterlist=
 *sgl, u32 sgl_nents,
>  					goto fail;
> =20
>  				if (rw)
> -					bio->bi_rw |=3D REQ_WRITE;
> +					bio_set_op_attrs(bio, REQ_OP_WRITE, 0);
> =20
>  				pr_debug("PSCSI: Allocated bio: %p,"
>  					" dir: %s nr_vecs: %d\n", bio,
>=20
Cheers,

Hannes
--=20
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N=FCrnberg
GF: F. Imend=F6rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N=FCrnberg)
