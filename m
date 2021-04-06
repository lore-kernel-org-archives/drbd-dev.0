Return-Path: <axboe@kernel.dk>
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
	[209.85.216.54])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 979724205D5
	for <drbd-dev@lists.linbit.com>; Tue,  6 Apr 2021 17:22:17 +0200 (CEST)
Received: by mail-pj1-f54.google.com with SMTP id bg21so5063174pjb.0
	for <drbd-dev@lists.linbit.com>; Tue, 06 Apr 2021 08:22:17 -0700 (PDT)
To: Lee Jones <lee.jones@linaro.org>
References: <20210312105530.2219008-1-lee.jones@linaro.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <33a06c9d-58b6-c9bf-a119-6d2a3e37b955@kernel.dk>
Date: Tue, 6 Apr 2021 09:22:16 -0600
MIME-Version: 1.0
In-Reply-To: <20210312105530.2219008-1-lee.jones@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	linux-kernel@vger.kernel.org, Philipp Reisner <philipp.reisner@linbit.com>,
	linux-block@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>,
	xen-devel@lists.xenproject.org, Philip Kelleher <pjk1939@linux.ibm.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	=?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>,
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

On 3/12/21 3:55 AM, Lee Jones wrote:
> This set is part of a larger effort attempting to clean-up W=1
> kernel builds, which are currently overwhelmingly riddled with
> niggly little warnings.

Applied 2-11, 1 is already in the my tree.

-- 
Jens Axboe

