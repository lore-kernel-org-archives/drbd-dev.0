Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 2AA6910564B1
	for <drbd-dev@lists.linbit.com>; Fri, 10 Jun 2016 13:47:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 24B98420308
	for <drbd-dev@lists.linbit.com>; Fri, 10 Jun 2016 13:47:49 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id iC5A2vfzfZLb for <drbd-dev@lists.linbit.com>;
	Fri, 10 Jun 2016 13:47:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 079F442031A
	for <drbd-dev@lists.linbit.com>; Fri, 10 Jun 2016 13:47:49 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 2mETigW342YU for <drbd-dev@lists.linbit.com>;
	Fri, 10 Jun 2016 13:47:48 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id CE0AF420308
	for <drbd-dev@lists.linbit.com>; Fri, 10 Jun 2016 13:47:48 +0200 (CEST)
Resent-Message-ID: <20160610114748.GD3235@soda.linbit>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id BF2081056447
	for <drbd-dev@lists.linbit.com>; Mon,  6 Jun 2016 08:51:02 +0200 (CEST)
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
	<1465155145-10812-41-git-send-email-mchristi@redhat.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <57551D55.8070200@suse.de>
Date: Mon, 6 Jun 2016 08:51:01 +0200
MIME-Version: 1.0
In-Reply-To: <1465155145-10812-41-git-send-email-mchristi@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Drbd-dev] [PATCH 40/45] block: move bio io prio to a new field
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
> In the next patch, we move drop the compat code and make
> the op a separate value that is hidden in bi_rw. To give
> the op and rq bits flags room to grow this moves prio to
> its own field.
>=20
> Signed-off-by: Mike Christie <mchristi@redhat.com>
> ---
>  include/linux/bio.h       | 14 ++------------
>  include/linux/blk_types.h |  5 ++---
>  2 files changed, 4 insertions(+), 15 deletions(-)
>=20
> diff --git a/include/linux/bio.h b/include/linux/bio.h
> index 4568647..35108c2 100644
> --- a/include/linux/bio.h
> +++ b/include/linux/bio.h
> @@ -47,18 +47,8 @@
>  #define bio_op(bio)				(op_from_rq_bits((bio)->bi_rw))
>  #define bio_set_op_attrs(bio, op, flags)	((bio)->bi_rw |=3D (op | flag=
s))
> =20
> -/*
> - * upper 16 bits of bi_rw define the io priority of this bio
> - */
> -#define BIO_PRIO_SHIFT	(8 * sizeof(unsigned long) - IOPRIO_BITS)
> -#define bio_prio(bio)	((bio)->bi_rw >> BIO_PRIO_SHIFT)
> -#define bio_prio_valid(bio)	ioprio_valid(bio_prio(bio))
> -
> -#define bio_set_prio(bio, prio)		do {			\
> -	WARN_ON(prio >=3D (1 << IOPRIO_BITS));			\
> -	(bio)->bi_rw &=3D ((1UL << BIO_PRIO_SHIFT) - 1);		\
> -	(bio)->bi_rw |=3D ((unsigned long) (prio) << BIO_PRIO_SHIFT);	\
> -} while (0)
> +#define bio_prio(bio)			(bio)->bi_ioprio
> +#define bio_set_prio(bio, prio)		((bio)->bi_ioprio =3D prio)
> =20
>  /*
>   * various member access, note that bio_data should of course not be u=
sed
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index 6e60baa..2738413 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -48,9 +48,8 @@ struct bio {
>  	struct block_device	*bi_bdev;
>  	unsigned int		bi_flags;	/* status, command, etc */
>  	int			bi_error;
> -	unsigned long		bi_rw;		/* bottom bits READ/WRITE,
> -						 * top bits priority
> -						 */
> +	unsigned long		bi_rw;		/* READ/WRITE */
> +	unsigned short		bi_ioprio;
> =20
>  	struct bvec_iter	bi_iter;
> =20
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
