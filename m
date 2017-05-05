Return-Path: <nab@linux-iscsi.org>
Received: from linux-iscsi.org (mail.linux-iscsi.org [67.23.28.174])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 59F56105633D
	for <drbd-dev@lists.linbit.com>; Fri,  5 May 2017 05:10:25 +0200 (CEST)
Message-ID: <1493953822.23202.91.camel@haakon3.risingtidesystems.com>
From: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
To: Mike Snitzer <snitzer@redhat.com>
Date: Thu, 04 May 2017 20:10:22 -0700
In-Reply-To: <20170503143338.GA24111@redhat.com>
References: <20170405172125.22600-1-hch@lst.de>
	<20170405172125.22600-26-hch@lst.de>
	<1493671519.2665.15.camel@sandisk.com>
	<1493707425.23202.77.camel@haakon3.risingtidesystems.com>
	<1493709373.23202.79.camel@haakon3.risingtidesystems.com>
	<20170502072328.GA11522@lst.de>
	<1493782395.23202.84.camel@haakon3.risingtidesystems.com>
	<20170503143338.GA24111@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Cc: "axboe@kernel.dk" <axboe@kernel.dk>,
	"linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>,
	"philipp.reisner@linbit.com" <philipp.reisner@linbit.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"dm-devel@redhat.com" <dm-devel@redhat.com>,
	"target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
	Bart Van Assche <Bart.VanAssche@sandisk.com>,
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

On Wed, 2017-05-03 at 10:33 -0400, Mike Snitzer wrote:
> On Tue, May 02 2017 at 11:33pm -0400,
> Nicholas A. Bellinger <nab@linux-iscsi.org> wrote:
> 
> > On Tue, 2017-05-02 at 09:23 +0200, hch@lst.de wrote:
> > > On Tue, May 02, 2017 at 12:16:13AM -0700, Nicholas A. Bellinger wrote:
> > > > Or, another options is use bdev_write_zeroes_sectors() to determine when
> > > > dev_attrib->unmap_zeroes_data should be set.
> > > 
> > > Yes, that in combination with your patch to use bdev_write_zeroes_sectors
> > > for zeroing from write same seems like the right fix.
> > 
> > The larger target/iblock conversion patch looks like post v4.12 material
> > at this point, so to avoid breakage wrt to existing LBPRZ behavior, I'll
> > plan to push the following patch post -rc1.
> > 
> > diff --git a/drivers/target/target_core_device.c b/drivers/target/target_core_device.c
> > index d2f089c..e7caf78 100644
> > --- a/drivers/target/target_core_device.c
> > +++ b/drivers/target/target_core_device.c
> > @@ -851,7 +851,7 @@ bool target_configure_unmap_from_queue(struct se_dev_attrib *attrib,
> >         attrib->unmap_granularity = q->limits.discard_granularity / block_size;
> >         attrib->unmap_granularity_alignment = q->limits.discard_alignment /
> >                                                                 block_size;
> > -       attrib->unmap_zeroes_data = 0;
> > +       attrib->unmap_zeroes_data = (q->limits.max_write_zeroes_sectors);
> >         return true;
> >  }
> >  EXPORT_SYMBOL(target_configure_unmap_from_queue);
> > 
> 
> Completely a nit but: why the extra parenthesis?

dev_attrib->unmap_zeros_data is only compared as a bool.

