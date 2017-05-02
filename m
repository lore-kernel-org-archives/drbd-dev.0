Return-Path: <nab@linux-iscsi.org>
Received: from linux-iscsi.org (mail.linux-iscsi.org [67.23.28.174])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id ACAD01056446
	for <drbd-dev@lists.linbit.com>; Tue,  2 May 2017 08:43:49 +0200 (CEST)
Message-ID: <1493707425.23202.77.camel@haakon3.risingtidesystems.com>
From: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
To: Bart Van Assche <Bart.VanAssche@sandisk.com>
Date: Mon, 01 May 2017 23:43:45 -0700
In-Reply-To: <1493671519.2665.15.camel@sandisk.com>
References: <20170405172125.22600-1-hch@lst.de>
	<20170405172125.22600-26-hch@lst.de>
	<1493671519.2665.15.camel@sandisk.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Cc: "axboe@kernel.dk" <axboe@kernel.dk>,
	"linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
	"snitzer@redhat.com" <snitzer@redhat.com>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>,
	"philipp.reisner@linbit.com" <philipp.reisner@linbit.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"dm-devel@redhat.com" <dm-devel@redhat.com>,
	"target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"lars.ellenberg@linbit.com" <lars.ellenberg@linbit.com>,
	"shli@kernel.org" <shli@kernel.org>, "hch@lst.de" <hch@lst.de>,
	"agk@redhat.com" <agk@redhat.com>,
	"drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>
Subject: Re: [Drbd-dev] [PATCH 25/27] block: remove the discard_zeroes_data
	flag
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

On Mon, 2017-05-01 at 20:45 +0000, Bart Van Assche wrote:
> On Wed, 2017-04-05 at 19:21 +0200, Christoph Hellwig wrote:
> > Now that we use the proper REQ_OP_WRITE_ZEROES operation everywhere we can
> > kill this hack.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
> > Reviewed-by: Hannes Reinecke <hare@suse.com>
> > [ ... ]
> > diff --git a/drivers/target/target_core_device.c b/drivers/target/target_core_device.c
> > index c754ae33bf7b..d2f089cfa9ae 100644
> > --- a/drivers/target/target_core_device.c
> > +++ b/drivers/target/target_core_device.c
> > @@ -851,7 +851,7 @@ bool target_configure_unmap_from_queue(struct se_dev_attrib *attrib,
> >  	attrib->unmap_granularity = q->limits.discard_granularity / block_size;
> >  	attrib->unmap_granularity_alignment = q->limits.discard_alignment /
> >  								block_size;
> > -	attrib->unmap_zeroes_data = q->limits.discard_zeroes_data;
> > +	attrib->unmap_zeroes_data = 0;
> >  	return true;
> >  }
> >  EXPORT_SYMBOL(target_configure_unmap_from_queue);
> 
> Hello Christoph,
> 
> Sorry that I hadn't noticed this before but I think that this patch
> introduces a significant performance regressions for LIO users. Before
> this patch the LBPRZ flag was reported correctly to initiator systems
> through the thin provisioning VPD. With this patch applied that flag
> will always be reported as zero, forcing initiators to submit WRITE
> commands with zeroed data buffers instead of submitting the SCSI UNMAP
> command to block devices for which discard_zeroes_data was set. From
> target_core_spc.c:
> 
> /* Thin Provisioning VPD */
> static sense_reason_t spc_emulate_evpd_b2(struct se_cmd *cmd, unsigned char *buf)
> {
> 	[ ... ]
> 	/*
> 	 * The unmap_zeroes_data set means that the underlying device supports
> 	 * REQ_DISCARD and has the discard_zeroes_data bit set. This satisfies
> 	 * the SBC requirements for LBPRZ, meaning that a subsequent read
> 	 * will return zeroes after an UNMAP or WRITE SAME (16) to an LBA
> 	 * See sbc4r36 6.6.4.
> 	 */
> 	if (((dev->dev_attrib.emulate_tpu != 0) ||
> 	     (dev->dev_attrib.emulate_tpws != 0)) &&
> 	     (dev->dev_attrib.unmap_zeroes_data != 0))
> 		buf[5] |= 0x04;
> 	[ ... ]
> }
> 

According to sd_config_discard(), it's SD_LBP_WS16, SD_LBP_WS10 and
SD_LBP_ZERO that where ever setting unmap_zeros_data = 1 to begin with.
For UNMAP, q->limits.discard_zeroes_data was never set.

That said, it's pretty much implied that supporting DISCARD means
subsequent READs return zeros, so target_configure_unmap_from_queue()
should be setting attrib->unmap_zeroes_data = 1, or just dropping it
all-together.

Post -rc1, I'll push a patch to do the latter.

