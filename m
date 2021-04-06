Return-Path: <lee.jones@linaro.org>
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com
	[209.85.218.52])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id A06CE4205D5
	for <drbd-dev@lists.linbit.com>; Tue,  6 Apr 2021 17:32:46 +0200 (CEST)
Received: by mail-ej1-f52.google.com with SMTP id hq27so22590618ejc.9
	for <drbd-dev@lists.linbit.com>; Tue, 06 Apr 2021 08:32:46 -0700 (PDT)
Date: Tue, 6 Apr 2021 16:32:43 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Jens Axboe <axboe@kernel.dk>
Message-ID: <20210406153243.GV2916463@dell>
References: <20210312105530.2219008-1-lee.jones@linaro.org>
	<33a06c9d-58b6-c9bf-a119-6d2a3e37b955@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <33a06c9d-58b6-c9bf-a119-6d2a3e37b955@kernel.dk>
Cc: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	linux-kernel@vger.kernel.org, Philipp Reisner <philipp.reisner@linbit.com>,
	linux-block@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>,
	xen-devel@lists.xenproject.org, Philip Kelleher <pjk1939@linux.ibm.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>,
	Joshua Morris <josh.h.morris@us.ibm.com>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 00/11] Rid W=1 warnings from Block
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

On Tue, 06 Apr 2021, Jens Axboe wrote:

> On 3/12/21 3:55 AM, Lee Jones wrote:
> > This set is part of a larger effort attempting to clean-up W=1
> > kernel builds, which are currently overwhelmingly riddled with
> > niggly little warnings.
> 
> Applied 2-11, 1 is already in the my tree.

Superstar, thanks Jens.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
