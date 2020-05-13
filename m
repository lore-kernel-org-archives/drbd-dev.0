Return-Path: <hch@lst.de>
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 265CD4202F0
	for <drbd-dev@lists.linbit.com>; Wed, 13 May 2020 20:33:38 +0200 (CEST)
Date: Wed, 13 May 2020 20:33:04 +0200
From: Christoph Hellwig <hch@lst.de>
To: Song Liu <song@kernel.org>
Message-ID: <20200513183304.GA29895@lst.de>
References: <20200508161517.252308-1-hch@lst.de>
	<20200508161517.252308-13-hch@lst.de>
	<CAPhsuW6_Y53_XLFeVxhTDpTi_PKNLqqnrXLn+M2fJW268eE6_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPhsuW6_Y53_XLFeVxhTDpTi_PKNLqqnrXLn+M2fJW268eE6_w@mail.gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-xtensa@linux-xtensa.org,
	linux-raid <linux-raid@vger.kernel.org>,
	Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
	linux-nvdimm@lists.01.org, Geoff Levand <geoff@infradead.org>,
	open list <linux-kernel@vger.kernel.org>, Jim Paris <jim@jtan.com>,
	Joshua Morris <josh.h.morris@us.ibm.com>,
	linux-block@vger.kernel.org, Minchan Kim <minchan@kernel.org>,
	linux-m68k@lists.linux-m68k.org, Philip Kelleher <pjk1939@linux.ibm.com>,
	linux-bcache@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Christoph Hellwig <hch@lst.de>, Nitin Gupta <ngupta@vflare.org>,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 12/15] md: stop using ->queuedata
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

On Wed, May 13, 2020 at 11:29:17AM -0700, Song Liu wrote:
> On Fri, May 8, 2020 at 9:17 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Thanks for the cleanup. IIUC, you want this go through md tree?

Yes, please pick it up though the md tree.
