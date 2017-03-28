Return-Path: <Bart.VanAssche@sandisk.com>
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 4A8A4105633D
	for <drbd-dev@lists.linbit.com>; Tue, 28 Mar 2017 20:50:14 +0200 (CEST)
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "agk@redhat.com" <agk@redhat.com>, "lars.ellenberg@linbit.com"
	<lars.ellenberg@linbit.com>, "snitzer@redhat.com" <snitzer@redhat.com>,
	"hch@lst.de" <hch@lst.de>, "martin.petersen@oracle.com"
	<martin.petersen@oracle.com>, "philipp.reisner@linbit.com"
	<philipp.reisner@linbit.com>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"shli@kernel.org" <shli@kernel.org>
Date: Tue, 28 Mar 2017 18:50:01 +0000
Message-ID: <1490726988.2573.16.camel@sandisk.com>
References: <20170323143341.31549-1-hch@lst.de>
	<20170323143341.31549-4-hch@lst.de>
In-Reply-To: <20170323143341.31549-4-hch@lst.de>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <6E8D87EDE82597458EF1FAF3788FC111@sandisk.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
	"dm-devel@redhat.com" <dm-devel@redhat.com>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>
Subject: Re: [Drbd-dev] [PATCH 03/23] sd: implement REQ_OP_WRITE_ZEROES
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

On Thu, 2017-03-23 at 10:33 -0400, Christoph Hellwig wrote:
> diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
> index af632e350ab4..b6f70a09a301 100644
> --- a/drivers/scsi/sd.c
> +++ b/drivers/scsi/sd.c
> @@ -748,7 +748,7 @@ static int sd_setup_unmap_cmnd(struct scsi_cmnd *cmd)
>  	return scsi_init_io(cmd);
>  }
> =20
> -static int sd_setup_write_same16_cmnd(struct scsi_cmnd *cmd)
> +static int sd_setup_write_same16_cmnd(struct scsi_cmnd *cmd, bool unmap)
>  {
>  	struct scsi_device *sdp =3D cmd->device;
>  	struct request *rq =3D cmd->request;
> @@ -765,13 +765,14 @@ static int sd_setup_write_same16_cmnd(struct scsi_c=
mnd *cmd)
> =20
>  	cmd->cmd_len =3D 16;
>  	cmd->cmnd[0] =3D WRITE_SAME_16;
> -	cmd->cmnd[1] =3D 0x8; /* UNMAP */
> +	if (unmap)
> +		cmd->cmnd[1] =3D 0x8; /* UNMAP */
>  	put_unaligned_be64(sector, &cmd->cmnd[2]);
>  	put_unaligned_be32(nr_sectors, &cmd->cmnd[10]);

Hello Christoph,

A quote from SBC: "An OPTIMAL UNMAP GRANULARITY field set to a non-zero val=
ue
indicates the optimal granularity in logical blocks for unmap requests (e.g=
.,
an UNMAP command or a WRITE SAME (16) command with the UNMAP bit set to one=
).
An unmap request with a number of logical blocks that is not a multiple of
this value may result in unmap operations on fewer LBAs than requested."

This means that just like the start and end of a discard must be aligned on=
 a
discard_granularity boundary, WRITE SAME commands with the UNMAP bit set mu=
st
also respect that granularity. I think this means that either
__blkdev_issue_zeroout() has to be modified such that it rejects unaligned
REQ_OP_WRITE_ZEROES operations or that blk_bio_write_same_split() has to be
modified such that it generates REQ_OP_WRITEs for the unaligned start and t=
ail.

Bart.=
