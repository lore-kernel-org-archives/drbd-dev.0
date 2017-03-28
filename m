Return-Path: <Bart.VanAssche@sandisk.com>
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 8B774105630C
	for <drbd-dev@lists.linbit.com>; Tue, 28 Mar 2017 18:49:08 +0200 (CEST)
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "agk@redhat.com" <agk@redhat.com>, "lars.ellenberg@linbit.com"
	<lars.ellenberg@linbit.com>, "snitzer@redhat.com" <snitzer@redhat.com>,
	"hch@lst.de" <hch@lst.de>, "martin.petersen@oracle.com"
	<martin.petersen@oracle.com>, "philipp.reisner@linbit.com"
	<philipp.reisner@linbit.com>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"shli@kernel.org" <shli@kernel.org>
Date: Tue, 28 Mar 2017 16:48:55 +0000
Message-ID: <1490719722.2573.8.camel@sandisk.com>
References: <20170323143341.31549-1-hch@lst.de>
	<20170323143341.31549-13-hch@lst.de>
In-Reply-To: <20170323143341.31549-13-hch@lst.de>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <67C38495A74E4545A8ECDA6712B7DBC1@sandisk.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
	"dm-devel@redhat.com" <dm-devel@redhat.com>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>
Subject: Re: [Drbd-dev] [PATCH 12/23] sd: handle REQ_UNMAP
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
> Try to use a write same with unmap bit variant if the device supports it
> and the caller asks for it.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/scsi/sd.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
> index b6f70a09a301..ca96bb33471b 100644
> --- a/drivers/scsi/sd.c
> +++ b/drivers/scsi/sd.c
> @@ -871,6 +871,16 @@ static int sd_setup_write_zeroes_cmnd(struct scsi_cm=
nd *cmd)
>  			return BLKPREP_INVALID;
>  		return sd_setup_ata_trim_cmnd(cmd);
>  	}
> +
> +	if (rq->cmd_flags & REQ_UNMAP) {
> +		switch (sdkp->provisioning_mode) {
> +		case SD_LBP_WS16:
> +			return sd_setup_write_same16_cmnd(cmd, true);
> +		case SD_LBP_WS10:
> +			return sd_setup_write_same10_cmnd(cmd, true);
> +		}
> +	}
> +
>  	if (sdp->no_write_same)
>  		return BLKPREP_INVALID;
>  	if (sdkp->ws16 || sector > 0xffffffff || nr_sectors > 0xffff)

Users can change the provisioning mode from user space from=A0SD_LBP_WS16 i=
nto
SD_LBP_WS10 so I'm not sure it's safe to skip the (sdkp->ws16 || sector >
0xffffffff || nr_sectors > 0xffff) check if REQ_UNMAP is set.

Bart.=
