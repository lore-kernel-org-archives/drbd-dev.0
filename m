Return-Path: <axboe@kernel.dk>
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com
	[209.85.166.177])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id B94BE420A75
	for <drbd-dev@lists.linbit.com>; Mon,  5 Oct 2020 18:40:04 +0200 (CEST)
Received: by mail-il1-f177.google.com with SMTP id t7so3170140ilf.10
	for <drbd-dev@lists.linbit.com>; Mon, 05 Oct 2020 09:40:04 -0700 (PDT)
To: Christoph Hellwig <hch@lst.de>
References: <20200925160618.1481450-1-hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <20798679-80af-50a7-64f7-0af1af78ab16@kernel.dk>
Date: Mon, 5 Oct 2020 10:40:02 -0600
MIME-Version: 1.0
In-Reply-To: <20200925160618.1481450-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: linux-block@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>,
	drbd-dev@lists.linbit.com, Philipp Reisner <philipp.reisner@linbit.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [Drbd-dev] remove bdget() as a public API
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

On 9/25/20 10:06 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series first cleans up the somewhat odd size handling in
> drbd, and then kill off bdget() as a public API.

Applied, thanks.

-- 
Jens Axboe

