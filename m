Return-Path: <hch@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id A7A541019AC6
	for <drbd-dev@lists.linbit.com>; Thu, 15 Nov 2018 10:11:18 +0100 (CET)
Date: Thu, 15 Nov 2018 10:02:22 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ulf Hansson <ulf.hansson@linaro.org>
Message-ID: <20181115090222.GA14284@lst.de>
References: <20181114160219.28328-1-hch@lst.de>
	<20181114160219.28328-14-hch@lst.de>
	<CAPDyKFqq=MiiM7h_GGb3S=+TSD=LayLTefigovuPJAsqMJgOEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFqq=MiiM7h_GGb3S=+TSD=LayLTefigovuPJAsqMJgOEg@mail.gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block <linux-block@vger.kernel.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	Christoph Hellwig <hch@lst.de>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 13/16] mmc: simplify queue initialization
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

On Wed, Nov 14, 2018 at 06:31:45PM +0100, Ulf Hansson wrote:
> > + * @subname: partition subname
> 
> Drop subname :-)

Fixed.
