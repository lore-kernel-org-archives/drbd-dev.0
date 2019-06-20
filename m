Return-Path: <axboe@kernel.dk>
Received: from mail-yw1-f65.google.com (mail-yw1-f65.google.com
	[209.85.161.65])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 734BF1019AC6
	for <drbd-dev@lists.linbit.com>; Thu, 20 Jun 2019 11:33:58 +0200 (CEST)
Received: by mail-yw1-f65.google.com with SMTP id s5so886728ywd.9
	for <drbd-dev@lists.linbit.com>; Thu, 20 Jun 2019 02:33:57 -0700 (PDT)
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>
References: <20190618154549.GA15265@kroah.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <db5d81da-c373-21c2-b213-38e46ceaf722@kernel.dk>
Date: Thu, 20 Jun 2019 03:28:36 -0600
MIME-Version: 1.0
In-Reply-To: <20190618154549.GA15265@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] block: drbd: no need to check return value
 of debugfs_create functions
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

On 6/18/19 9:45 AM, Greg Kroah-Hartman wrote:
> When calling debugfs functions, there is no need to ever check the
> return value.  The function can work or not, but the code logic should
> never do something different based on this.

Applied, thanks.

-- 
Jens Axboe

