Return-Path: <hch@lst.de>
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 7B55742018F
	for <drbd-dev@lists.linbit.com>; Tue, 29 Mar 2022 09:32:57 +0200 (CEST)
Date: Tue, 29 Mar 2022 09:32:54 +0200
From: Christoph Hellwig <hch@lst.de>
To: Philipp Reisner <philipp.reisner@linbit.com>
Message-ID: <20220329073254.GA20691@lst.de>
References: <20220329070618.GA20396@lst.de>
	<CADGDV=UgjZAbmAN-2bO1nyDvA=XCC9Lf2dxWHZ0BwxF12nnztQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADGDV=UgjZAbmAN-2bO1nyDvA=XCC9Lf2dxWHZ0BwxF12nnztQ@mail.gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>,
	Christoph Hellwig <hch@lst.de>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] state of drbd in mainline
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <https://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <https://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Tue, Mar 29, 2022 at 09:22:26AM +0200, Philipp Reisner wrote:
> Hi Christoph,
> 
> what do you expect for the DRBD changes? Usually, they fall into the
> category: yes, obviously. When you are changing the block layer in this
> way, then that is necessary for the in-tree DRBD code.
> 
> Regarding users: Yes, there are users of the in-tree DRBD code. Very big
> corporations. And, yes, we see pressure building up that we get our act
> together and re-sync the in-tree DRBD with the out-of tree DRBD.

The complete lack of bug reports and maintainer interaction usually
suggests low to no use and heavy bitrot.  If that is not the case
here that's fine, just asking..

